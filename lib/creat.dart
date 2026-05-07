import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatContent extends StatefulWidget {
  const CreatContent({super.key});

  @override
  State<CreatContent> createState() => _CreatContentState();
}

class _CreatContentState extends State<CreatContent> {
  bool _showDetail = false;
  bool _showSocialPopup = false;
  String? _selectedSocial = 'facebook';

  static const Color _navy = Color(0xFF052859);
  static const Color _white = Color(0xFFFFFFFF);

  static const double cadreLargeur = 364;
  static const double texteLargeur = 318;
  static const double espaceEntreCadres = 50;

  static const List<Map<String, String>> _creations = [
    {
      'image': 'assets/annonce3.png',
      'texte':
          'Créez rapidement des contenus visuels percutants et adaptez vos messages pour chaque campagne.',
    },
    {
      'image': 'assets/annonce3.png',
      'texte':
          'Produisez des visuels cohérents, modernes et optimisés pour attirer davantage d’attention.',
    },
    {
      'image': 'assets/header_image.png',
      'texte':
          'Centralisez vos idées de création et gagnez du temps dans la préparation de vos contenus.',
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
    if (_showDetail) {
      return Stack(
        children: [
          _buildDetailView(),
          if (_showSocialPopup)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {},
                child: const SizedBox.expand(),
              ),
            ),
          if (_showSocialPopup) _buildEligibilityPopup(),
        ],
      );
    }

    return _buildListView();
  }

  // ─── NOUVELLE POPUP (photo 1) ──────────────────────────────────────────────
  Widget _buildEligibilityPopup() {
    return Positioned.fill(
      child: Material(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Transform.translate(
            offset: const Offset(0, 60),
            child: Container(
              width: 340,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Ajouter des informations",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1DA858),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Justifiant votre éligibilité\npour cette offre",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 1.3,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade800, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sélectionner un fichier',
                          style: GoogleFonts.poppins(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        const Icon(Icons.attach_file, color: Color(0xFF052859)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => setState(() => _showSocialPopup = false),
                        child: const Text(
                          'Annuler',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() => _showSocialPopup = false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Demande envoyée avec succès !')),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC107),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Center(
                            child: Text(
                              'Envoyer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── VUE LISTE ──────────────────────────────────────────────────────────────
  Widget _buildListView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 29, bottom: 29),
      child: Column(
        children: List.generate(_creations.length, (index) {
          final creation = _creations[index];
          final bool isFirst = index == 0;
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < _creations.length - 1 ? espaceEntreCadres : 0,
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
                          creation['image']!,
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
                            creation['texte']!,
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

  // ─── VUE DÉTAIL ─────────────────────────────────────────────────────────────
  Widget _buildDetailView() {
    return SingleChildScrollView(
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
            Padding(
              padding: const EdgeInsets.only(left: 21),
              child: GestureDetector(
                onTap: _closeDetail,
                child: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF052859),
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Image.asset(
                'assets/annonce3.png',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Text(
                'Créez des contenus adaptés à votre image de marque et facilitez la diffusion de vos messages sur tous vos canaux. '
                'Cette section vous aide à produire des supports clairs, cohérents et efficaces pour vos campagnes.',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Text(
                'Informations supplémentaires :',
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
            _buildDetailLine('• Type de création', 'Visuels et contenus'),
            _buildDetailLine('• Date de lancement', '12 mai 2024'),
            _buildDetailLine('• Durée', 'Flexible'),
            _buildDetailLine('• Budget alloué', '300.000'),
            const SizedBox(height: 75),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showSocialPopup = true;
                  });
                },
                child: Container(
                  width: 214,
                  height: 46,
                  decoration: BoxDecoration(
                    color: _navy,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Soumettre ma candidature',
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
            const SizedBox(height: 40),
          ],
        ),
      ),
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
              text: '$label : ',
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