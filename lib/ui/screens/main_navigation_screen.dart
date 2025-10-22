import 'package:flutter/material.dart';
import 'call_screen.dart';
import 'helpguide_home_screen.dart';
import 'help_guide_detail_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;
  Widget? _detailPage;

  void _onItemTapped(int index) {
    setState(() {
      _detailPage = null; // fecha detalhe se trocar de aba
      _currentIndex = index;
    });
  }

  void _openGuideDetail(String title, String contentPath, Color color) {
    setState(() {
      _detailPage = HelpGuideDetailScreen(
        title: title,
        contentPath: contentPath,
        color: color,
        onBack: _closeDetail,
      );
    });
  }

  void _closeDetail() {
    setState(() {
      _detailPage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const CallScreen(),
      HelpGuidesHomeScreen(onOpenDetail: _openGuideDetail),
    ];

    final Widget currentPage = _detailPage ?? pages[_currentIndex];

    return Scaffold(
      body: currentPage,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFEEEEEE),
          border: Border(
            top: BorderSide(color: Colors.black, width: 3), // listra preta
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFFEEEEEE),
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.black,
          iconSize: 38, // ícones grandes
          selectedFontSize: 22, // texto maior
          unselectedFontSize: 20,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.phone_in_talk),
              label: 'DISCAGEM',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: 'GUIAS',
            ),
          ],
        ),
      ),
    );
  }
}
