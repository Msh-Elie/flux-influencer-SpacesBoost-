import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PromotionContent extends StatefulWidget {
  final Function(bool)? onDetailViewChanged;

  const PromotionContent({super.key, this.onDetailViewChanged});

  @override
  State<PromotionContent> createState() => _PromotionContentState();
}

class _PromotionContentState extends State<PromotionContent> {
  bool _showDetail = false;
  bool _showSocialPopup = false;
  String? _selectedSocial = 'facebook';

  static const Color _navy = Color(0xFF052859);
  static const Color _white = Color(0xFFFFFFFF);

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
    widget.onDetailViewChanged?.call(true);
  }

  void _closeDetail() {
    setState(() => _showDetail = false);
    widget.onDetailViewChanged?.call(false);
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

  // ─────────────────────────────────────────────
  // POPUP RÉSEAUX SOCIAUX
  // ─────────────────────────────────────────────

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

  // ─────────────────────────────────────────────
  // VUE LISTE
  // ─────────────────────────────────────────────

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

  // ─────────────────────────────────────────────
  // VUE DÉTAIL
  // ─────────────────────────────────────────────

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

            // ── Bouton retour ──
            Padding(
              padding: const EdgeInsets.only(left: 21),
              child: GestureDetector(
                onTap: _closeDetail,
                child: const Icon(Icons.arrow_back, color: Color(0xFF052859), size: 24),
              ),
            ),
            const SizedBox(height: 12),

            // ── Image principale ──
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

            // ── Bandeau contact vert ──
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

            // ── Stats : vues · partager · lectures ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Vues
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
                  // Partager
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
                  // Lectures
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

            // ── Divider ──
            const Divider(height: 1, thickness: 1, color: Color(0xFFE8E8E8)),
            const SizedBox(height: 16),

            // ── Titre ──
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

            // ── Description ──
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

            // ── Bullet points ──
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

            // ── Bouton Soumettre ──
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() => _showSocialPopup = true);
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

  // ─────────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────────

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