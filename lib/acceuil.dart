import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'campagne.dart';
import 'profil.dart';

class SpaBoostSecondPage extends StatefulWidget {
  const SpaBoostSecondPage({super.key});

  @override
  State<SpaBoostSecondPage> createState() => _SpaBoostSecondPageState();
}

class _SpaBoostSecondPageState extends State<SpaBoostSecondPage> {
  bool _isBalanceVisible = false;
  int _activeNavIndex = 2;

  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  static const Color _yellow = Color(0xFFFCBC1E);
  static const Color _navy = Color(0xFF052859);
  static const Color _white = Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), _autoScroll);
  }

  void _autoScroll() {
    if (!mounted) return;
    final nextIndex = (_currentImageIndex + 1) % 2;
    _pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() => _currentImageIndex = nextIndex);
    Future.delayed(const Duration(seconds: 3), _autoScroll);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildAccueilContent() {
    return Column(
      children: [
        const SizedBox(height: 46),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SizedBox(
            width: 360,
            height: 60,
            child: Text(
              'Faites vos campagnes publicitaires\net gagnez de l\'argent facilement !',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: _navy,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                height: 1.3,
              ),
            ),
          ),
        ),
        const SizedBox(height: 3),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: SizedBox(
            width: 353,
            height: 352,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) =>
                  setState(() => _currentImageIndex = index),
              children: [
                Image.asset(
                  'assets/Reseaux 1.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.image, color: _navy, size: 100),
                ),
                Image.asset(
                  'assets/Reseaux2.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.image, color: _navy, size: 100),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 11),
        Center(
          child: GestureDetector(
            onTap: () => setState(() => _isBalanceVisible = !_isBalanceVisible),
            child: Container(
              width: 351,
              height: 60,
              decoration: BoxDecoration(
                color: _yellow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Afficher solde',
                    style: GoogleFonts.poppins(
                      color: _white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                    color: _white,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34),
          child: Row(
            children: [
              Image.asset(
                'assets/campagnes.png',
                width: 169,
                height: 170,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) =>
                    Icon(Icons.image, color: _navy, size: 100),
              ),
              const SizedBox(width: 16),
              Image.asset(
                'assets/preuves.png',
                width: 173,
                height: 173,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) =>
                    Icon(Icons.image, color: _navy, size: 100),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 33),
          child: Row(
            children: [
              Image.asset(
                'assets/taxiboost.png',
                width: 169,
                height: 170,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) =>
                    Icon(Icons.image, color: _navy, size: 100),
              ),
              const SizedBox(width: 19),
              Image.asset(
                'assets/parrainage.png',
                width: 173,
                height: 173,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) =>
                    Icon(Icons.image, color: _navy, size: 100),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> navItems = [
      {
        'assetPath': 'assets/campagne.png',
        'fallbackIcon': Icons.campaign,
        'label': 'Campagne',
      },
      {
        'assetPath': 'assets/preuve.png',
        'fallbackIcon': Icons.verified,
        'label': 'Preuve',
      },
      {
        'assetPath': 'assets/acceuil.png',
        'fallbackIcon': Icons.home,
        'label': 'Accueil',
      },
      {
        'assetPath': 'assets/retrait.png',
        'fallbackIcon': Icons.account_balance_wallet,
        'label': 'Retrait',
      },
      {
        'assetPath': 'assets/parrainageIcône.png',
        'fallbackIcon': Icons.people,
        'label': 'Parrainage',
      },
    ];

    // CampagneContent gère son propre scroll via Column + Expanded.
    // Les autres onglets utilisent un SingleChildScrollView classique.
    final bool isCampagne = _activeNavIndex == 0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── Zone de contenu ──
          Positioned(
            top: 103,
            left: 0,
            right: 0,
            bottom: 110,
            child: isCampagne
                // Campagne : occupe directement le Positioned (gère son propre scroll)
                ? const CampagneContent()
                // Autres onglets : scroll classique
                : SingleChildScrollView(child: _buildOtherContent()),
          ),

          // ── Rectangle jaune FIXE en haut ──
          Positioned(
            top: -27,
            left: -8,
            child: Container(
              width: 454,
              height: 130,
              decoration: BoxDecoration(
                color: _yellow,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.25),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),

          // ── Rectangle jaune FIXE en bas ──
          Positioned(
            bottom: 0,
            left: -23,
            child: Container(
              width: 467,
              height: 110,
              decoration: BoxDecoration(
                color: _yellow,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.25),
                    offset: const Offset(0, -4),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),

          // ── Navbar du bas ──
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 110,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(navItems.length, (index) {
                  final item = navItems[index];
                  final bool isActive = _activeNavIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _activeNavIndex = index),
                    child: _NavItem(
                      assetPath: item['assetPath'] as String,
                      fallbackIcon: item['fallbackIcon'] as IconData,
                      label: item['label'] as String,
                      isActive: isActive,
                      navy: _navy,
                      iconColor: isActive ? _white : _navy,
                      textColor: isActive ? _white : _navy,
                    ),
                  );
                }),
              ),
            ),
          ),

          // ── Icône SpaBoost ──
          Positioned(
            top: 45,
            left: 35,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
              child: Image.asset(
                'assets/icôneSpaBoost.png',
                width: 33,
                height: 33,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) =>
                    Icon(Icons.spa, color: _navy, size: 33),
              ),
            ),
          ),

          // ── Titre centré ──
          Positioned(
            top: 52,
            left: 162,
            child: SizedBox(
              width: 110,
              height: 30,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Annonce',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: _navy,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),

          // ── Icône menu ──
          Positioned(
            top: 52,
            left: 382,
            child: Icon(Icons.menu, color: _navy, size: 24),
          ),
        ],
      ),
    );
  }

  // Contenu des onglets autres que Campagne (scroll classique)
  Widget _buildOtherContent() {
    switch (_activeNavIndex) {
      case 1:
        return const SizedBox.shrink(); // Preuve
      case 2:
        return _buildAccueilContent();
      case 3:
        return const SizedBox.shrink(); // Retrait
      case 4:
        return const SizedBox.shrink(); // Parrainage
      default:
        return _buildAccueilContent();
    }
  }
}

class _NavItem extends StatelessWidget {
  final String assetPath;
  final IconData fallbackIcon;
  final String label;
  final bool isActive;
  final Color navy;
  final Color iconColor;
  final Color? textColor;

  const _NavItem({
    required this.assetPath,
    required this.fallbackIcon,
    required this.label,
    required this.isActive,
    required this.navy,
    required this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: Image.asset(
            assetPath,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
            color: isActive ? Colors.white : null,
            colorBlendMode: BlendMode.srcIn,
            errorBuilder: (context, error, stackTrace) =>
                Icon(fallbackIcon, color: iconColor, size: 30),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: textColor ?? navy,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}
