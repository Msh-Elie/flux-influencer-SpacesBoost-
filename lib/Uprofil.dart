import 'package:flutter/material.dart';

class ModifierProfilScreen extends StatefulWidget {
  const ModifierProfilScreen({super.key});

  @override
  State<ModifierProfilScreen> createState() => _ModifierProfilScreenState();
}

class _ModifierProfilScreenState extends State<ModifierProfilScreen> {
  late TextEditingController _nomController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: 'Melissa Peters');
    _emailController = TextEditingController(text: 'mepeters@gmail.com');
    _passwordController = TextEditingController(text: '*************');
  }

  @override
  void dispose() {
    _nomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBC02D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 26),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Preuves',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- AVATAR + CAMERA BADGE ---
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF1E285D), width: 2),
                    ),
                    child: ClipOval(
                      // Utilisez 'assets/profil.png' ou votre image actuelle
                      child: Image.asset(
                        'assets/profil.png', // Même avatar que le profil
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(color: Colors.grey[200]),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFF1E285D), // Bleu foncé
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- FORMULAIRES ---
            _buildLabel('Nom'),
            _buildTextField(_nomController),
            const SizedBox(height: 16),

            _buildLabel('E-mail'),
            _buildTextField(_emailController),
            const SizedBox(height: 16),

            _buildLabel('Mot de passe'),
            _buildTextField(_passwordController, obscureText: true),
            const SizedBox(height: 16),

            _buildLabel('Date de naissance'),
            _buildDropdown('23/05/1995'),
            const SizedBox(height: 16),

            _buildLabel('Pays / région'),
            _buildDropdown('Nigeria'),

            const SizedBox(height: 30),

            // --- BOUTON CREER/ENREGISTRER ---
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Logique d'enregistrement
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E285D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Enregistrer les modifications',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
      ),
    );
  }

  Widget _buildDropdown(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: const TextStyle(fontSize: 16, color: Color(0xFF333333))),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}