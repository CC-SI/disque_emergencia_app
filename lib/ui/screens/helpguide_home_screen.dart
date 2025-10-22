import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/helpguide_model.dart';
import '../../data/repositories/helpguide_repository.dart';
import '../components/help_guide_card.dart';

class HelpGuidesHomeScreen extends StatefulWidget {
  final Function(String title, String contentPath, Color color) onOpenDetail;

  const HelpGuidesHomeScreen({super.key, required this.onOpenDetail});

  @override
  State<HelpGuidesHomeScreen> createState() => _HelpGuidesHomeScreenState();
}

class _HelpGuidesHomeScreenState extends State<HelpGuidesHomeScreen> {
  late Future<List<HelpGuide>> guidesFuture;

  @override
  void initState() {
    super.initState();
    guidesFuture = HelpGuideRepository().loadGuides();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        toolbarHeight: 90,
        titleSpacing: 0,
        title: Text(
          "informações",
          style: GoogleFonts.luckiestGuy(
            fontSize: 38,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<HelpGuide>>(
        future: guidesFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final guides = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              children: [
                for (int i = 0; i < guides.length; i++) ...[
                  HelpGuideCard(
                    title: guides[i].title,
                    icon: guides[i].icon,
                    color: guides[i].color,
                    alignLeft: i.isEven,
                    onTap: () => widget.onOpenDetail(
                      guides[i].title,
                      guides[i].content,
                      guides[i].color,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
