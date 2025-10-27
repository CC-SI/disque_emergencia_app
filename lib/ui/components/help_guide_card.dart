import 'package:flutter/material.dart';

class HelpGuideCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool alignLeft;
  final VoidCallback onTap;

  const HelpGuideCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.alignLeft,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Bordas arredondadas apenas no lado "livre"
    final BorderRadius borderRadius = alignLeft
        ? const BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          );

    return Align(
      alignment: alignLeft ? Alignment.centerLeft : Alignment.centerRight,
      child: FractionallySizedBox(
        widthFactor: 0.85, // ✅ ocupa 85% da tela
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius,
            child: Container(
              decoration: BoxDecoration(
                color: color, // ✅ usa a cor original
                borderRadius: borderRadius,
              ),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: alignLeft
                    ? [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFEEEEEE),
                            ),
                          ),
                        ),
                        Icon(icon, size: 60, color: Color(0xFFEEEEEE)),
                      ]
                    : [
                        Icon(icon, size: 60, color: Color(0xFFEEEEEE)),
                        Expanded(
                          child: Text(
                            title,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFEEEEEE),
                            ),
                          ),
                        ),
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
