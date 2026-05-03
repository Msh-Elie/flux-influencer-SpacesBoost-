import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfileScreen(),
  ));
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- 1. IMAGE DE FOND (EN TÊTE) ---
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250, // Hauteur de la partie image du haut
            child: Container(
              decoration: BoxDecoration(
                // REMPLACER 'assets/header_image.jpg' PAR VOTRE IMAGE
                image: const DecorationImage(
                  image: AssetImage('assets/header_image.png'), // Image temporaire
                  fit: BoxFit.cover,
                ),
                // Si vous voulez juste un placeholder gris, décommentez ceci et commentez l'image
                // color: Colors.grey[300],
              ),
            ),
          ),

          // --- 2. BOUTON RETOUR ET TITRE "PROFIL" ---
          Positioned(
            top: MediaQuery.of(context).padding.top + 10, // Gère la barre de statut
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () {
                // Navigator.pop(context); // Action de retour
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 60,
            child: const Text(
              "Profil",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // --- 3. FOND BLANC (DÉCOLLE PLUS BAS POUR CRÉER LE CHEVAUCHEMENT) ---
          Positioned.fill(
            top: 160, // Commence à 160px du haut pour faire chevaucher l'avatar
            child: Container(
              color: Colors.white,
            ),
          ),

          // --- 4. CONTENU SCROLLABLE (NOM, STATS, BOUTON, PHOTOS) ---
          Positioned.fill(
            top: 160,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 50), // Espace pour placer l'avatar

                  // --- CERCLE DE L'AVATAR ---
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFFBC02D), width: 4), // Bordure jaune
                    ),
                    child: ClipOval(
                      // REMPLACER 'assets/avatar.jpg' PAR LA PHOTO DE MELISSA
                      child: Image.asset(
                        'assets/profil.png', // Image temporaire
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Placeholder si l'image n'est pas trouvée
                          return Container(color: Colors.grey[300]);
                        },
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 15),

                  // --- NOM ET PROFESSION ---
                  const Text(
                    'Melissa Peters',
                    style: TextStyle(
                      color: Color(0xFF1E285D), // Bleu foncé
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Architecte d’intérieur',
                    style: TextStyle(
                      color: Color(0xFF6B6B6B),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // --- LOCALISATION ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFF4A4A4A), size: 18),
                      const SizedBox(width: 5),
                      const Text(
                        'Lagos, Nigéria',
                        style: TextStyle(
                          color: Color(0xFF4A4A4A),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 25),

                  // --- STATISTIQUES (122 Entreprises, 67 j, 37K j) ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('122', 'Entreprises'),
                        _buildStatItem('67', 'j'),
                        _buildStatItem('37K', 'j'), // 'j' comme das le design
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // --- BOUTON "VOIR MES PERFORMANCES" ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFBC02D), // Jaune
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Voir mes performances',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // --- ONGLETS PHOTOS / PARAMÈTRES ---
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        // Onglet sélectionné "Photos"
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 12),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFF1E285D), // Ligne bleue
                                  width: 2.5,
                                ),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Photos',
                                style: TextStyle(
                                  color: Color(0xFF1E285D),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Onglet non-sélectionné "Paramètres"
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: const Center(
                              child: Text(
                                'Paramètres',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  // --- GRILLE DE PHOTOS ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.85, // Ajustez l'aspect ici pour les photos rectangulaires
                      ),
                      itemCount: 6, // Nombre d'images à afficher
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            // REMPLACER 'assets/photo_$index.jpg' PAR VOS IMAGES
                            image: const DecorationImage(
                              image: AssetImage('assets/photo_placeholder.jpg'), 
                              fit: BoxFit.cover,
                            ),
                            // Ajout d'une couleur grise temporaire si l'image manque
                            color: Colors.grey[300], 
                          ),
                          // Petit plus: pour afficher un texte si l'image est absente
                          child: const Center(
                            child: Text(
                              "Photo",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  // Un peu d'espace en bas
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget réutilisable pour les stats
  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            color: Color(0xFF1E285D), // Bleu foncé
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6B6B6B),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}