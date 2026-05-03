import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'annonce.dart';

class CampagneContent extends StatefulWidget {
  const CampagneContent({super.key});

  @override
  State<CampagneContent> createState() => _CampagneContentState();
}

class _CampagneContentState extends State<CampagneContent> {
  static const Color _yellow = Color(0xFFFCBC1E);
  static const Color _white  = Color(0xFFFFFFFF);
  static const Color _navy   = Color(0xFF052859);

  int _activeTabIndex = 0;

  final List<Map<String, dynamic>> _tabs = [
    {
      'label': 'Annonce',
      'assetPath': 'assets/annonce.png',
      'fallbackIcon': Icons.campaign,
    },
    {
      'label': 'Promotion',
      'assetPath': 'assets/promotion.png',
      'fallbackIcon': Icons.local_offer,
    },
    {
      'label': 'Création',
      'assetPath': 'assets/creaction.png',
      'fallbackIcon': Icons.edit,
    },
  ];

  Widget _buildTabContent() {
    switch (_activeTabIndex) {
      case 0:
        return const AnnonceContent();
      case 1:
        return const SizedBox.shrink(); // Promotion (à implémenter)
      case 2:
        return const SizedBox.shrink(); // Création (à implémenter)
      default:
        return const AnnonceContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    const double subLeft  = 73.0;
    const double subTop   = 17.0;
    const double subW     = 282.0;
    const double subH     = 48.0;
    const double indTop   = 21.0;
    const double indLeft0 = 82.0;
    const double indW     = 73.0;
    const double indH     = 40.0;
    const double tabW     = subW / 3;

    return Column(
      children: [
        // ── Sous-barre jaune FIXE (ne scroll pas) ──
        Container(
          width: double.infinity,
          height: 82,
          color: _yellow,
          child: Stack(
            children: [
              // Fond semi-transparent des onglets
              Positioned(
                top: subTop,
                left: subLeft,
                child: Container(
                  width: subW,
                  height: subH,
                  decoration: BoxDecoration(
                    color: const Color(0x40FFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              // Indicateur animé de l'onglet actif
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                top: indTop,
                left: indLeft0 + (_activeTabIndex * tabW),
                child: Container(
                  width: indW,
                  height: indH,
                  decoration: BoxDecoration(
                    color: _yellow,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),

              // Labels et icônes des onglets
              Positioned(
                top: subTop,
                left: subLeft,
                child: SizedBox(
                  width: subW,
                  height: subH,
                  child: Row(
                    children: List.generate(_tabs.length, (index) {
                      final tab = _tabs[index];
                      final bool isActive = _activeTabIndex == index;
                      final Color itemColor = isActive ? _white : _navy;

                      return GestureDetector(
                        onTap: () =>
                            setState(() => _activeTabIndex = index),
                        child: SizedBox(
                          width: tabW,
                          height: subH,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 18,
                                height: 18,
                                child: Image.asset(
                                  tab['assetPath'] as String,
                                  width: 18,
                                  height: 18,
                                  fit: BoxFit.contain,
                                  color: itemColor,
                                  colorBlendMode: BlendMode.srcIn,
                                  errorBuilder: (ctx, e, st) => Icon(
                                    tab['fallbackIcon'] as IconData,
                                    color: itemColor,
                                    size: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                tab['label'] as String,
                                style: GoogleFonts.poppins(
                                  color: itemColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: 1.0,
                                  letterSpacing: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── Zone scrollable (prend tout l'espace restant) ──
        Expanded(
          child: SingleChildScrollView(
            child: _buildTabContent(),
          ),
        ),
      ],
    );
  }
}