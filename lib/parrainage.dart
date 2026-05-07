import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParrainagePage extends StatelessWidget {
  const ParrainagePage({super.key});

  static const Color _yellow = Color(0xFFFCBC1E);
  static const Color _navy = Color(0xFF052859);
  static const Color _white = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              width: 275,
              height: 30,
              child: Text(
                'Votre code Parrainage',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: _navy,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Utiliser votre code de parrainage pour atteindre\nun public un peu plus large',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: const Color(0xFF455A64),
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/parrainage_img.png',
              height: 240,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 240,
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                child: Icon(Icons.image, color: _navy, size: 80),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Container(
            decoration: BoxDecoration(
              color: _white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _navy, width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'AETUETUA3447449hdhhfhhfuzav',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: _navy,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.copy, color: Colors.grey),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _yellow,
                foregroundColor: _white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: Text(
                'Partager',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Vos canaux',
            style: GoogleFonts.poppins(
              color: _navy,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSocialIcon('assets/logos_whatsapp.png', 'whatsapp'),
              _buildSocialIcon('assets/logos_facebook.png', 'facebook'),
              _buildSocialIcon('assets/logos_tiktok.png', 'tiktok'),
              _buildSocialIcon('assets/logos_instagram.png', 'instagram'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(String assetPath, String id) {
    return Container(
      width: 54,
      height: 54,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E6E6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Image.asset(
        assetPath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          _fallbackIconFor(id),
          color: _navy,
          size: 26,
        ),
      ),
    );
  }

  IconData _fallbackIconFor(String id) {
    switch (id) {
      case 'whatsapp':
        return Icons.chat_bubble;
      case 'facebook':
        return Icons.facebook;
      case 'tiktok':
        return Icons.music_note;
      case 'instagram':
        return Icons.camera_alt;
      default:
        return Icons.link;
    }
  }
}