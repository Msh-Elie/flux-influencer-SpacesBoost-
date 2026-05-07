import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'annonce.dart';
import 'creat.dart';
import 'promotion.dart'; // RESTE IMPORTÉ pour les autres onglets

// ─── CONSTANTES DE COULEUR ────────────────────────────────────────────────────
const Color _yellow = Color(0xFFFCBC1E);
const Color _white = Color(0xFFFFFFFF);
const Color _navy = Color(0xFF052859);

class ProofPage extends StatelessWidget {
  const ProofPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CampagneContent(),
      ),
    );
  }
}

class CampagneContent extends StatefulWidget {
  final Function(bool)? onDetailViewChanged;

  const CampagneContent({super.key, this.onDetailViewChanged});

  @override
  State<CampagneContent> createState() => _CampagneContentState();
}

class _CampagneContentState extends State<CampagneContent> {
  int _activeTabIndex = 0;

  final List<Map<String, dynamic>> _tabs = [
    {
      'label': 'En cours',
      'assetPath': 'assets/annonce.png',
      'fallbackIcon': Icons.campaign,
    },
    {
      'label': 'Rejeter',
      'assetPath': 'assets/annonce.png',
      'fallbackIcon': Icons.local_offer,
    },
    {
      'label': 'Valider',
      'assetPath': 'assets/valider.png',
      'fallbackIcon': Icons.edit,
    },
  ];

  Widget _buildTabContent() {
    switch (_activeTabIndex) {
      case 0:
        return const EnCoursContent(); // ← NOUVEAU WIDGET SPÉCIFIQUE
      case 1:
        return _buildRejectedList();
      case 2:
        return _buildValidatedList();
      default:
        return const PromotionContent();
    }
  }

  // ─── Carte de preuve ──────────────────────────────────────────────────────
  Widget _buildProofCard({
    required String statusText,
    required Color statusColor,
    required IconData statusIcon,
    String? assetPath,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.only(
          top: 20, bottom: 20, left: 22, right: 22),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9FF),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.20),
            offset: const Offset(0, 2),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fridaos Towé wè',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: const Color(0xFF000000),
              height: 1.0,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Artiste chanteuse compositrice',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: const Color(0xFF000000),
              height: 1.0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: const Color(0xFF001C57),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Lien',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: const Color(0xFF000000),
              height: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Fridaos towe we/trefshdbvkaoioqjha.com',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: const Color(0xFF3771C8),
              decoration: TextDecoration.underline,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Fichiers',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: const Color(0xFF000000),
              height: 1.0,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Fichier1 preuve.png',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: const Color(0xFF000000),
              decoration: TextDecoration.underline,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Fichier2 preuve.png',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 10,
              color: const Color(0xFF000000),
              decoration: TextDecoration.underline,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              assetPath != null
                  ? SizedBox(
                      width: 28,
                      height: 28,
                      child: Image.asset(
                        assetPath,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            Icon(statusIcon, color: statusColor, size: 28),
                      ),
                    )
                  : Icon(statusIcon, color: statusColor, size: 28),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  statusText,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: statusColor,
                    height: 1.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRejectedList() {
    return ListView(
      padding: const EdgeInsets.only(top: 20, bottom: 40),
      children: [
        _buildProofCard(
          statusText: 'Votre preuve a été Rejétée',
          statusColor: const Color(0xFFFF1744),
          statusIcon: Icons.cancel_outlined,
        ),
        _buildProofCard(
          statusText: 'Votre preuve a été Rejétée',
          statusColor: const Color(0xFFFF1744),
          statusIcon: Icons.cancel_outlined,
        ),
      ],
    );
  }

  Widget _buildValidatedList() {
    return ListView(
      padding: const EdgeInsets.only(top: 20, bottom: 40),
      children: [
        _buildProofCard(
          statusText: 'Félicitations ! Votre preuve a été Validée',
          statusColor: const Color(0xFF06BC64),
          statusIcon: Icons.check_circle_outline,
          assetPath: 'assets/Vector_valider.png',
        ),
        _buildProofCard(
          statusText: 'Félicitations ! Votre preuve a été Validée',
          statusColor: const Color(0xFF06BC64),
          statusIcon: Icons.check_circle_outline,
          assetPath: 'assets/Vector_valider.png',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const double subLeft = 73.0;
    const double subTop = 17.0;
    const double subW = 282.0;
    const double subH = 48.0;
    const double indTop = 21.0;
    const double indLeft0 = 82.0;
    const double indW = 73.0;
    const double indH = 40.0;
    const double tabW = subW / 3;

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
                        onTap: () => setState(() => _activeTabIndex = index),
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
          child: _buildTabContent(),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// NOUVEAU WIDGET : ONGLET "EN COURS" (indépendant de PromotionContent)
// ──────────────────────────────────────────────────────────────────────────────
class EnCoursContent extends StatefulWidget {
  const EnCoursContent({super.key});

  @override
  State<EnCoursContent> createState() => _EnCoursContentState();
}

class _EnCoursContentState extends State<EnCoursContent> {
  bool _showDetail = false;
  bool _showSocialPopup = false;
  String? _selectedSocial = 'facebook';

  static const double cadreLargeur = 364;
  static const double texteLargeur = 318;
  static const double espaceEntreCadres = 50;

  static const List<Map<String, String>> _promotions = [
    {
      'image': 'assets/annonce4.png',
      'texte':
          'Boostez vos ventes avec notre offre promotionnelle et profitez de remises exclusives sur vos campagnes en cours.',
    },
    {
      'image': 'assets/annonce3.png',
      'texte':
          'Mettez en avant vos produits grâce à une visibilité premium et des formats adaptés à votre audience.',
    },
    {
      'image': 'assets/annonce2.png',
      'texte':
          'Combinez performance et simplicité avec des outils promotionnels pensés pour convertir plus rapidement.',
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
          if (_showSocialPopup) _buildSocialPopup(),
        ],
      );
    }

    return _buildListView();
  }

  Widget _buildSocialPopup() {
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
                    'Choisissez vos réseaux\nsociaux',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1DA858),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 170),
                    child: const Text(
                      'Vos canaux',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1.0,
                        color: Color(0xFF052859),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSocialIcon('assets/logos_whatsapp.png', 'whatsapp'),
                      _buildSocialIcon('assets/logos_facebook.png', 'facebook'),
                      _buildSocialIcon('assets/logos_tiktok.png', 'tiktok'),
                      _buildSocialIcon('assets/logos_instagram.png', 'instagram'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() => _showSocialPopup = false);
                        },
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
                            const SnackBar(
                              content: Text('Demande promotion envoyée (simulation)'),
                            ),
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
                              'Valider',
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

  Widget _buildSocialIcon(String assetPath, String id) {
    final bool selected = _selectedSocial == id;
    return InkWell(
      onTap: () => setState(() => _selectedSocial = id),
      child: Container(
        width: 54,
        height: 54,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: selected ? Border.all(color: const Color(0xFF052859), width: 2) : null,
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Image.asset(
          assetPath,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.broken_image,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 29, bottom: 29),
      child: Column(
        children: List.generate(_promotions.length, (index) {
          final promo = _promotions[index];
          final bool isFirst = index == 0;
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < _promotions.length - 1 ? espaceEntreCadres : 0,
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
                          promo['image']!,
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
                            promo['texte']!,
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

  // ── VUE DÉTAIL AVEC BOUTON "SOUMETTRE" QUI OUVRE PROOFFORM ─────────────
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

            // Bouton retour
            Padding(
              padding: const EdgeInsets.only(left: 21),
              child: GestureDetector(
                onTap: _closeDetail,
                child: const Icon(Icons.arrow_back, color: Color(0xFF052859), size: 24),
              ),
            ),
            const SizedBox(height: 12),

            // Image principale
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/annonce4.png',
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
            ),
            const SizedBox(height: 12),

            // Bandeau contact vert
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1DA858),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Colors.white, size: 14),
                        const SizedBox(width: 5),
                        Text(
                          '(+229) 01 65 09 45 87 / 01 09 56 43 27',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.language, color: Colors.white, size: 14),
                        const SizedBox(width: 5),
                        Text(
                          'rizdemontagne.com',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Stats : vues · partager · lectures
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.remove_red_eye_outlined,
                          color: Color(0xFF052859), size: 20),
                      const SizedBox(width: 6),
                      Text(
                        '1,34M',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF052859),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.reply, color: Color(0xFF052859), size: 20),
                      const SizedBox(width: 6),
                      Text(
                        'Partager',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF052859),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.format_list_bulleted,
                          color: Color(0xFF052859), size: 20),
                      const SizedBox(width: 6),
                      Text(
                        '34k',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF052859),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Divider
            const Divider(height: 1, thickness: 1, color: Color(0xFFE8E8E8)),
            const SizedBox(height: 16),

            // Titre
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Text(
                'Riz de Montagne',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF052859),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Text(
                'Le riz de montagne, cultivé dans des conditions uniques, offre une qualité exceptionnelle et un goût authentique. '
                'Soutenez cette agriculture durable qui préserve les traditions locales et valorise les terroirs.\n'
                'Découvrez le riz de montagne, un trésor culinaire qui allie saveurs authentiques et respect de l\'environnement.',
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF000000),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                  letterSpacing: 0,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Bullet points
            _buildDetailBullet(
              'Qualité supérieure :',
              'Cultivé en altitude, ce riz bénéficie d\'un climat pur et d\'une terre riche, '
                  'garantissant des grains savoureux et nutritifs.',
            ),
            _buildDetailBullet(
              'Soutien aux agriculteurs locaux :',
              'En exploitant le riz de montagne, vous contribuez à l\'économie locale et à la '
                  'préservation des savoir-faire traditionnels.',
            ),
            _buildDetailBullet(
              'Agriculture durable :',
              'Cette culture respecte l\'écosystème, favorisant la biodiversité et entraînant '
                  'l\'impact environnemental.',
            ),
            _buildDetailBullet(
              'Un goût inégalé :',
              'Appréciez la texture et le goût distinctifs de ce riz, parfait pour accompagner '
                  'vos plats préférés ou pour être dégusté seul.',
            ),

            const SizedBox(height: 36),

            // ─── BOUTON SOUMETTRE (NAVY) QUI OUVRE PROOFFORM ──────────────
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ProofForm()),
                  );
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
                      'Soumettre',
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
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailBullet(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: GoogleFonts.poppins(
              color: const Color(0xFF000000),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 1.6,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  color: const Color(0xFF000000),
                  fontSize: 12,
                  height: 1.6,
                  letterSpacing: 0,
                ),
                children: [
                  TextSpan(
                    text: '$label ',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// VUE "SOUMETTRE UNE PREUVE" (photo 2) – INCHANGÉE
// ──────────────────────────────────────────────────────────────────────────────
class ProofForm extends StatelessWidget {
  const ProofForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _yellow,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _navy, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Promotion',
          style: GoogleFonts.poppins(
            color: _navy,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: _navy),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // Titre du contenu
            TextField(
              decoration: InputDecoration(
                hintText: 'Titre du contenu',
                hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF052859)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF052859)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF052859), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Contenu
            TextField(
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Contenu',
                hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF052859)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF052859)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF052859), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Lien
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF052859)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.link, color: Colors.grey),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Lien',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Aucun fichier sélectionné
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFF052859)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.attach_file, color: Color(0xFF052859)),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Aucun fichier sélectionné',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Bouton Soumettre une Preuve
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preuve soumise avec succès !')),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFBC02D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Soumettre une Preuve',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}