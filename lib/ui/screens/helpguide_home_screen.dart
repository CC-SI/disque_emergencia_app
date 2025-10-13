import 'package:flutter/material.dart';
import '../../data/models/helpguide_model.dart';
import '../../data/repositories/helpguide_repository.dart';
import '../components/emergency_guide_card.dart';
import '../components/first_aid_guide_card.dart';

class HelpGuidesHomeScreen extends StatefulWidget {
  const HelpGuidesHomeScreen({super.key});

  @override
  State<HelpGuidesHomeScreen> createState() => _HelpGuidesHomeScreenState();
}

class _HelpGuidesHomeScreenState extends State<HelpGuidesHomeScreen> {
  late Future<List<HelpGuide>> guidesFuture;

  final List<Color> aidColors = const [
    Color(0xFF4CAF50), // Verde
    Color(0xFFF44336), // Vermelho
    Color(0xFF2196F3), // Azul
    Color(0xFFFF9800), // Laranja
    Color(0xFF009688), // Verde-água
  ];

  @override
  void initState() {
    super.initState();
    guidesFuture = HelpGuideRepository().loadGuides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3F3),
      appBar: AppBar(
        title: const Text("Guias de Ajuda"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: FutureBuilder<List<HelpGuide>>(
        future: guidesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final guides = snapshot.data!;
          final emergencyGuides = guides
              .where((g) => g.category == 'emergency_contacts')
              .toList();
          final firstAidGuides =
              guides.where((g) => g.category == 'first_aid').toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tipos de emergência",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Column(
                  children: emergencyGuides.map((g) {
                    return EmergencyGuideCard(
                      title: g.title,
                      subtitle: g.subtitle,
                      coverImage: g.coverImage,
                      onTap: () {},
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Primeiros socorros básicos",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: firstAidGuides.asMap().entries.map((entry) {
                    final index = entry.key;
                    final g = entry.value;
                    final color = aidColors[index % aidColors.length];
                    return FirstAidGuideCard(
                      title: g.title,
                      subtitle: g.subtitle,
                      coverImage: g.coverImage,
                      color: color,
                      onTap: () {},
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Essas orientações não substituem ajuda profissional.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}