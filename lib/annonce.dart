import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnnonceContent extends StatefulWidget {
  const AnnonceContent({super.key});

  @override
  State<AnnonceContent> createState() => _AnnonceContentState();
}

class _AnnonceContentState extends State<AnnonceContent> {
  bool _showDetail = false;

  static const Color _navy  = Color(0xFF052859);
  static const Color _white = Color(0xFFFFFFFF);

  // ---------- Réglages modifiables (liste) ----------
  static const double cadreLargeur   = 364;
  static const double texteLargeur   = 318;
  static const double espaceEntreCadres = 50;

  static const List<Map<String, String>> _annonces = [
    {
      'image': 'assets/annonce1.png',
      'texte':
          "Devenez agent de liaison avec Harnix Event et tentez de gagner jusqu'à 30 % sur les achats effectués ! .....",
    },
    {
      'image': 'assets/annonce2.png',
      'texte':
          "Découvrez les délices d'Axo Food ! Savourez des repas préparés avec soin, alliant qualité et fraîcheur, pour une expérience culinaire inoubliable.",
    },
    {
      'image': 'assets/annonce3.png',
      'texte':
          "Découvrez les délices d'Axo Food ! Savourez des repas préparés avec soin, alliant qualité et fraîcheur, pour une expérience culinaire inoubliable.",
    },
  ];

  void _openDetail() {
    setState(() => _showDetail = true);
  }

  void _closeDetail() {
    setState(() => _showDetail = false);
  }

  @override
  Widget build(BuildContext context) {
    return _showDetail ? _buildDetailView() : _buildListView();
  }

  // -------- VUE LISTE (tous les cadres) --------
  Widget _buildListView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 29, bottom: 29),
      child: Column(
        children: List.generate(_annonces.length, (index) {
          final annonce = _annonces[index];
          final bool isFirst = index == 0;
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < _annonces.length - 1 ? espaceEntreCadres : 0,
            ),
            child: GestureDetector(
              onTap: isFirst ? _openDetail : null,
              child: Center(
                child: Container(
                  width: cadreLargeur,
                  decoration: BoxDecoration(
                    color: _white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        offset: Offset.zero,
                        blurRadius: 30,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: Image.asset(
                          annonce['image']!,
                          width: cadreLargeur,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: cadreLargeur,
                              height: 200,
                              color: Colors.grey.shade200,
                              child: Icon(Icons.image, color: _navy, size: 80),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          (cadreLargeur - texteLargeur) / 2,
                          12,
                          (cadreLargeur - texteLargeur) / 2,
                          20,
                        ),
                        child: SizedBox(
                          width: texteLargeur,
                          child: Text(
                            annonce['texte']!,
                            textAlign: TextAlign.center,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF000000),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 1.0,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // -------- VUE DÉTAIL (premier cadre cliqué) --------
  Widget _buildDetailView() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            width: 428,
            constraints: const BoxConstraints(minHeight: 1150),
            decoration: BoxDecoration(
              color: _white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 29),

                // Image (388 de large)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Image.asset(
                    'assets/annonce1.png',
                    width: 388,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 388,
                        height: 200,
                        color: Colors.grey.shade200,
                        child: Icon(Icons.image, color: _navy, size: 80),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Texte principal (justifié, Poppins Medium 12)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Text(
                    "Devenez agent de liaison avec Harnix Event et tentez de gagner jusqu'à 30 % sur les achats effectués ! "
                    "Rejoignez notre réseau dynamique et profitez d'opportunités uniques pour développer votre activité. "
                    "En collaborant avec nous, vous aurez accès à des événements exclusifs, des promotions attractives "
                    "et la possibilité de bâtir des relations solides avec des clients et partenaires. "
                    "Ne manquez pas cette chance de maximiser vos revenus tout en offrant à vos contacts des expériences inoubliables. "
                    "Inscrivez-vous dès aujourd'hui et commencez à transformer vos connexions en profits !",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF000000),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Informations supplémentaires (Poppins Bold Italic 12)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21),
                  child: Text(
                    "Informations supplémentaires :",
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF000000),
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      height: 1.0,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Détails (label en Bold, valeur en Medium)
                _buildDetailLine("• Nombre d'influenceurs recherchés", "100"),
                _buildDetailLine("• Date de début de la campagne", "12 mai 2024"),
                _buildDetailLine("• Durée", "60 jours"),
                _buildDetailLine("• Budget alloué", "1.000.000"),

                const SizedBox(height: 75),

                // Bouton Postuler
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Action à définir
                    },
                    child: Container(
                      width: 214,
                      height: 46,
                      decoration: BoxDecoration(
                        color: _navy,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 51,
                          height: 18,
                          child: Text(
                            'Postuler',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: _white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              height: 1.0,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),

        // Bouton retour (flèche)
        Positioned(
          top: 8,
          left: 8,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF052859)),
            onPressed: _closeDetail,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 4),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.poppins(
            color: const Color(0xFF000000),
            fontSize: 12,
            height: 1.0,
            letterSpacing: 0,
          ),
          children: [
            TextSpan(
              text: "$label : ",
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}