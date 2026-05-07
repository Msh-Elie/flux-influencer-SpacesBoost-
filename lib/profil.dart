import 'package:flutter/material.dart';

// Importez vos écrans (assurez-vous que les fichiers existent à la racine de lib)
import 'statistiques.dart';
import 'Uprofil.dart';
import 'password.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: ProfileScreen()),
  );
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double headerHeight = 226;
    final double avatarSize = 155;
    final double avatarTop = 161;
    final double contentTop = avatarTop + avatarSize + 20;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ─────────────────────────────────────────
          // 1. IMAGE DE FOND HEADER (PLEIN ÉCRAN HAUT)
          // ─────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: headerHeight,
            child: SizedBox(
              width: double.infinity,
              height: headerHeight,
              child: Image.asset('assets/header_image.png', fit: BoxFit.cover),
            ),
          ),

          // ─────────────────────────────────────────
          // 2. CONTENU SCROLLABLE (commence après le header)
          // ─────────────────────────────────────────
          Positioned.fill(
            top: contentTop,
            child: Column(
              children: [
                const SizedBox(height: 10),

                // --- NOM ---
                const Text(
                  'Melissa Peters',
                  style: TextStyle(
                    color: Color(0xFF1E285D),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // --- PROFESSION ---
                const Text(
                  'Architecte d\'intérieur',
                  style: TextStyle(color: Color(0xFF6B6B6B), fontSize: 15),
                ),
                const SizedBox(height: 4),

                // --- LOCALISATION ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.location_on, color: Color(0xFF333333), size: 18),
                    SizedBox(width: 4),
                    Text(
                      'Lagos, Nigéria',
                      style: TextStyle(color: Color(0xFF4A4A4A), fontSize: 14),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                // --- STATISTIQUES ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('122', 'abonnés'),
                      _buildStatItem('67', 'suivant'),
                      _buildStatItem('37K', 'goûts'),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // --- BOUTON JAUNE (NAVIGATION VERS STATISTIQUES) ---
                SizedBox(
                  width: 200,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StatistiquesScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFBC02D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Voir mes performances',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // --- ONGLETS ---
                _buildTabs(),

                const SizedBox(height: 16),

                // --- CONTENU DYNAMIQUE SCROLLABLE ---
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 90),
                    child: _selectedIndex == 0
                        ? _buildPhotosGrid()
                        : _buildSettings(),
                  ),
                ),
              ],
            ),
          ),

          // ─────────────────────────────────────────
          // 3. AVATAR CENTRÉ (en stack, par-dessus tout)
          // ─────────────────────────────────────────
          Positioned(
            top: avatarTop,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFBC02D), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/profil.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),

          // ─────────────────────────────────────────
          // 4. BOUTON RETOUR ET TITRE "PROFIL"
          // ─────────────────────────────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 4,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
              onPressed: () {},
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 14,
            left: 54,
            child: const Text(
              'Profil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(blurRadius: 4, color: Colors.black38)],
              ),
            ),
          ),

          // ─────────────────────────────────────────
          // 5. COUCHE BLANCHE FIXE EN BAS (FOOTER)
          // ─────────────────────────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: Container(height: 70, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // ─── ONGLETS ────────────────────────────────────────────────────────────────
  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [_buildTabItem('Photos', 0), _buildTabItem('Paramètres', 1)],
      ),
    );
  }

  Widget _buildTabItem(String label, int index) {
    final bool isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[500]!, width: 0.6),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF1E285D) : Colors.grey,
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ─── GRILLE PHOTOS ──────────────────────────────────────────────────────────
  Widget _buildPhotosGrid() {
    const imagePaths = [
      'assets/Rectangle1.png',
      'assets/Rectangle2.png',
      'assets/Rectangle3.png',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 110 / 160, // width:110, height:160
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 110,
            height: 160,
            child: Opacity(
              opacity: 1.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePaths[index % imagePaths.length],
                  width: 110,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      Container(color: Colors.grey[200]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ─── PARAMÈTRES ─────────────────────────────────────────────────────────────
  Widget _buildSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Compte'),
          const SizedBox(height: 10),
          _buildSettingsCard([
            // NAVIGATION VERS MODIFIER PROFIL
            _buildSettingsItem(
              Icons.person_outline,
              'Modifier le profil',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ModifierProfilScreen(),
                  ),
                );
              },
            ),
            _buildSettingsItem(
              Icons.shield_outlined,
              'Sécurité',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResetPasswordPage(),
                  ),
                );
              },
            ),
            _buildSettingsItem(Icons.notifications_none, 'Notifications'),
            _buildSettingsItem(Icons.lock_outline, 'Confidentialité'),
          ]),
          const SizedBox(height: 20),
          _buildSectionHeader('Soutien et à propos'),
          const SizedBox(height: 10),
          _buildSettingsCard([
            _buildSettingsItem(Icons.wallet_outlined, 'Mon Portefeuille'),
            _buildSettingsItem(Icons.help_outline, 'Aide et soutien'),
            _buildSettingsItem(Icons.info_outline, 'Termes et politiques'),
          ]),
          const SizedBox(height: 20),
          _buildSectionHeader('Actes'),
          const SizedBox(height: 10),
          _buildSettingsCard([
            _buildSettingsItem(Icons.flag_outlined, 'Signaler un problème'),
            _buildSettingsItem(
              Icons.person_add_alt_1_outlined,
              'Ajouter un compte',
            ),
            _buildSettingsItem(Icons.logout, 'Déconnecter'),
          ]),
        ],
      ),
    );
  }

  // ─── HELPERS ────────────────────────────────────────────────────────────────
  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            color: Color(0xFF1E285D),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF6B6B6B), fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF000000),
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 0.88,
        letterSpacing: 0,
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> items) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: items.map((item) {
          final isLast = item == items.last;
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
            child: item,
          );
        }).toList(),
      ),
    );
  }

  // NOUVELLE FONCTION: _buildSettingsItem avec onTap et InkWell
  Widget _buildSettingsItem(IconData icon, String title, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF333333), size: 28),
            const SizedBox(width: 14),
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF000000),
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 0.88,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}