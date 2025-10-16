import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Números de emergência',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

// ====================================================================
//  Contact Model (Modelo de Dados para Contato)
// ====================================================================

class Contact {
  final String id;
  final String name;
  final String number;

  Contact({required this.id, required this.name, required this.number});

  // Converte um objeto Contact para um Map (útil para salvar no JSON)
  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'number': number};

  // Cria um objeto Contact a partir de um Map (útil para carregar do JSON)
  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json['id'] as String,
    name: json['name'] as String,
    number: json['number'] as String,
  );
}

// ====================================================================
//  Contact Service (Lógica de Persistência com shared_preferences)
// ====================================================================

class ContactService {
  static const _key = 'personal_contacts';

  // Carrega todos os contatos
  Future<List<Contact>> loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsString = prefs.getStringList(_key) ?? [];

    // Converte a lista de strings JSON para uma lista de objetos Contact
    return contactsString.map((jsonString) {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return Contact.fromJson(jsonMap);
    }).toList();
  }

  // Salva a lista de contatos
  Future<void> saveContacts(List<Contact> contacts) async {
    final prefs = await SharedPreferences.getInstance();

    // Converte a lista de objetos Contact para uma lista de strings JSON
    final contactsString = contacts
        .map((contact) => json.encode(contact.toJson()))
        .toList();
    await prefs.setStringList(_key, contactsString);
  }
}

// ====================================================================
//  MainScreen: Navegação
// ====================================================================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const EmergencyScreen(),
    PersonalContactsScreen(service: ContactService()), // Passa o serviço
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disque Emergência'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Emergência'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Pessoal'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}

// ====================================================================
//  ContactCard: Widget auxiliar (agora usando ícones)
// ====================================================================

class ContactCard extends StatelessWidget {
  final String title;
  final String description;
  final String number;
  final String imagePath; // Mantido para futuras implementações de imagem
  final IconData icon;

  const ContactCard({
    required this.title,
    required this.description,
    required this.number,
    required this.imagePath,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // SUBSTITUÍDO: Imagem por Ícone
                Icon(
                  icon,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '($number)',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () => _makePhoneCall(number, context),
                icon: const Icon(Icons.phone),
                label: const Text('Tocar para LIGAR'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ====================================================================
//  EmergencyScreen: Lista de Contatos com Ícones pq eu não consegui colocar imagens
// ====================================================================

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          // SAMU (192)
          ContactCard(
            title: 'SAMU',
            description:
                'Para acidentes de trânsito, mal súbito, infarto ou outras emergências médicas.',
            number: '192',
            imagePath: 'assets/samu.png', // Caminho mantido
            icon: Icons.local_hospital,
          ),
          // Corpo de Bombeiros (193)
          ContactCard(
            title: 'Corpo de Bombeiros',
            description:
                'Para incêndios, vazamento de gás, resgate em acidentes, afogamentos e salvamentos.',
            number: '193',
            imagePath: 'assets/bombeiros.png', // Caminho mantido
            icon: Icons.fire_extinguisher,
          ),
          // Polícia Militar (190)
          ContactCard(
            title: 'Polícia Militar',
            description:
                'Para violência, furto, assalto, sequestro ou qualquer situação de crime em andamento.',
            number: '190',
            imagePath: 'assets/policia.png', // Caminho mantido
            icon: Icons.local_police_outlined,
          ),
          // Defesa Civil (199)
          ContactCard(
            title: 'Defesa Civil',
            description:
                'Alagamentos, inundações, deslizamentos de terra, quedas de árvores e desastres estruturais.',
            number: '199',
            imagePath: 'assets/defesa_civil.png', // Caminho mantido
            icon: Icons.warning,
          ),
          // Contato de Emergência
          ContactCard(
            title: 'Contato de Emergência',
            description:
                'Ligar para um contato pessoal importante (ex: familiar, vizinho).',
            number: '911112222',
            imagePath: 'assets/contato_pessoal.png', // Caminho mantido
            icon: Icons.contact_phone,
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

// ====================================================================
//  PersonalContactsScreen: Implementação CRUD
// ====================================================================

class PersonalContactsScreen extends StatefulWidget {
  final ContactService service;
  const PersonalContactsScreen({required this.service, super.key});

  @override
  State<PersonalContactsScreen> createState() => _PersonalContactsScreenState();
}

class _PersonalContactsScreenState extends State<PersonalContactsScreen> {
  List<Contact> _contacts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final loadedContacts = await widget.service.loadContacts();
    setState(() {
      _contacts = loadedContacts;
      _isLoading = false;
    });
  }

  Future<void> _saveAndRefresh(List<Contact> newContacts) async {
    await widget.service.saveContacts(newContacts);
    _loadContacts();
  }

  // Abre o formulário de adição/edição
  void _openContactForm({Contact? contactToEdit}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: ContactForm(
            onSave: (name, number) {
              if (contactToEdit == null) {
                // ADD NOVO
                _contacts.add(
                  Contact(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: name,
                    number: number,
                  ),
                );
              } else {
                // EDITAR EXISTENTE
                final index = _contacts.indexWhere(
                  (c) => c.id == contactToEdit.id,
                );
                if (index != -1) {
                  _contacts[index] = Contact(
                    id: contactToEdit.id,
                    name: name,
                    number: number,
                  );
                }
              }
              Navigator.pop(ctx);
              _saveAndRefresh(_contacts);
            },
            contactToEdit: contactToEdit,
          ),
        );
      },
    );
  }

  // Exclui um contato
  void _deleteContact(Contact contact) {
    setState(() {
      _contacts.removeWhere((c) => c.id == contact.id);
      _saveAndRefresh(_contacts);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: _contacts.isEmpty
          ? Center(
              child: Text(
                'Nenhum contato pessoal salvo. Adicione um para começar!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (ctx, index) {
                final contact = _contacts[index];
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(contact.name),
                  subtitle: Text(contact.number),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () =>
                            _openContactForm(contactToEdit: contact),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteContact(contact),
                      ),
                      IconButton(
                        icon: const Icon(Icons.phone),
                        onPressed: () =>
                            _makePhoneCall(contact.number, context),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openContactForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ====================================================================
//  ContactForm: Formulário de Adição/Edição
// ====================================================================

class ContactForm extends StatefulWidget {
  final Function(String name, String number) onSave;
  final Contact? contactToEdit;

  const ContactForm({required this.onSave, this.contactToEdit, super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.contactToEdit != null) {
      _nameController.text = widget.contactToEdit!.name;
      _numberController.text = widget.contactToEdit!.number;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSave(_nameController.text, _numberController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.contactToEdit == null
                ? 'Adicionar Novo Contato'
                : 'Editar Contato',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Nome'),
            validator: (value) =>
                value!.isEmpty ? 'O nome não pode ser vazio.' : null,
          ),
          TextFormField(
            controller: _numberController,
            decoration: const InputDecoration(
              labelText: 'Número (Apenas dígitos)',
            ),
            keyboardType: TextInputType.phone,
            validator: (value) =>
                value!.isEmpty || !RegExp(r'^\d+$').hasMatch(value)
                ? 'Insira um número de telefone válido (apenas dígitos).'
                : null,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _submitForm,
              child: Text(
                widget.contactToEdit == null ? 'Salvar' : 'Atualizar',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }
}

// ====================================================================
//  Função de Chamada (Lógica Otimizada e Corrigida)
// ====================================================================

Future<void> _makePhoneCall(String phoneNumber, BuildContext context) async {
  final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    //  Verifica se o widget ainda está montado
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'ERRO: Falha ao iniciar o aplicativo de telefone para $phoneNumber. Verifique as permissões.',
        ),
      ),
    );
  }
}
