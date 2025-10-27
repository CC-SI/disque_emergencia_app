import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/foundation.dart' show kIsWeb;

class HelpGuideDetailScreen extends StatefulWidget {
  final String title;
  final String contentPath;
  final Color color;
  final VoidCallback onBack;

  const HelpGuideDetailScreen({
    super.key,
    required this.title,
    required this.contentPath,
    required this.color,
    required this.onBack,
  });

  @override
  State<HelpGuideDetailScreen> createState() => _HelpGuideDetailScreenState();
}

class _HelpGuideDetailScreenState extends State<HelpGuideDetailScreen> {
  late Future<String> _markdownFuture;

  @override
  void initState() {
    super.initState();
    // Ajusta o caminho do markdown dependendo da plataforma
    final markdownPath = kIsWeb ? widget.contentPath : "assets/${widget.contentPath}";
    _markdownFuture = rootBundle.loadString(markdownPath);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: widget.color,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFFEEEEEE)),
          onPressed: widget.onBack,
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Color(0xFFEEEEEE),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<String>(
        future: _markdownFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final markdownData = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.9, // 90% da tela
                ),
                child: MarkdownBody(
                  data: markdownData,
                  selectable: true,
                  // Ajusta o caminho da imagem dependendo da plataforma
                  imageBuilder: (uri, title, alt) {
                    final screenWidth = MediaQuery.of(context).size.width;
                    final assetPath = kIsWeb ? uri.path : "assets/${uri.path}";

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            assetPath,
                            width: screenWidth * 0.9,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    );
                  },
                  styleSheet: MarkdownStyleSheet(
                    h1: GoogleFonts.aBeeZee(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                    h2: GoogleFonts.aBeeZee(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    h3: GoogleFonts.aBeeZee(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    p: GoogleFonts.aBeeZee(
                      fontSize: 26,
                      height: 1.8,
                    ),
                    listBullet: GoogleFonts.aBeeZee(
                      fontSize: 0,
                    ),
                    listIndent: 30,
                  ),
                  listItemCrossAxisAlignment: MarkdownListItemCrossAxisAlignment.start,
                  builders: {
                    'li': CustomListItemBuilder(widget.color),
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomListItemBuilder extends MarkdownElementBuilder {
  final Color color;

  CustomListItemBuilder(this.color);

  @override
  Widget visitElementAfter(element, TextStyle? preferredStyle) {
    final text = element.textContent.trim();

    final isOrdered = RegExp(r'^\d+\.').hasMatch(text);
    final label = isOrdered ? text.split(' ').first : '•';
    final content = isOrdered
        ? text.substring(text.indexOf(' ') + 1)
        : text.replaceFirst('•', '').trim();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              label.replaceAll('.', ''),
              style: const TextStyle(
                color: Color(0xFFEEEEEE),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(
                fontSize: 20,
                height: 1.8,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
