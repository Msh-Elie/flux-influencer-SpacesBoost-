import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

import 'acceuil.dart';
import 'profil.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const Color _yellow = Color(0xFFFCBC1E);
  static const Color _navy = Color(0xFF052859);
  static const Color _white = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Conteneur blanc avec border radius
          Center(
            child: Container(
              width: 428,
              height: 926,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),

          // Rectangle jaune en haut
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
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),

          // Flèche retour (use Icon fallback if SVG doesn't render)
          Positioned(
            top: 43,
            left: 18,
            child: SizedBox(
              width: 35,
              height: 35,
              child: Builder(
                builder: (ctx) {
                  try {
                    return SvgPicture.asset(
                      'assets/arrow.svg',
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        _navy,
                        BlendMode.srcIn,
                      ),
                      fit: BoxFit.contain,
                    );
                  } catch (_) {
                    return Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                      color: _navy,
                    );
                  }
                },
              ),
            ),
          ),

          // Texte "Bienvenue"
          Positioned(
            top: 50,
            left: 68,
            child: SizedBox(
              width: 106,
              height: 30,
              child: Text(
                'Bienvenue',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: _navy,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),

          // Icône SpaBoost
          Positioned(
            top: 42,
            left: 377,
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
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.spa, color: _navy, size: 33);
                },
              ),
            ),
          ),

          // Texte "Bienvenue sur"
          Positioned(
            top: 148,
            left: 75,
            child: SizedBox(
              width: 264,
              height: 54,
              child: Text(
                'Bienvenue sur',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: _navy,
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),

          // Logo SpaBoost
          Positioned(
            top: 202,
            left: 28,
            child: SizedBox(
              width: 359,
              height: 92,
              child: Image.asset(
                'assets/logoSpaBoost.png',
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.image, color: _navy, size: 92);
                },
              ),
            ),
          ),

          // Texte descriptif
          Positioned(
            top: 303,
            left: 50,
            child: SizedBox(
              width: 321,
              height: 106,
              child: Text(
                'La clé de la croissance exponentielle de votre entreprise grâce à des collaborations innovantes avec des influenceurs.',
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                  color: _navy,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),

          // Image boyPage1
          Positioned(
            top: 409,
            left: -35,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Image.asset(
                'assets/boyPage1.png',
                width: 530,
                height: 530,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.person, color: _navy, size: 100);
                },
              ),
            ),
          ),

          // Cercle jaune avec flèche blanche
          Positioned(
            top: 409,
            left: 274,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const SpaBoostSecondPage()),
                );
              },
              child: Container(
                width: 54,
                height: 54,
                decoration: const BoxDecoration(
                  color: _yellow,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SizedBox(
                    width: 22,
                    height: 12,
                    child: CustomPaint(painter: ArrowWhitePainter()),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArrowWhitePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = WelcomePage._white
      ..style = PaintingStyle.fill;

    // Trait horizontal
    canvas.drawRect(
      Rect.fromLTWH(0, (size.height / 2) - 1, size.width - 4, 2),
      paint,
    );

    // Triangle équilatéral à droite
    final triangleHeight = 10.0; // Hauteur du triangle
    final triangleWidth =
        triangleHeight * sqrt(3) / 2; // Largeur pour triangle équilatéral

    final path = Path();
    path.moveTo(size.width, size.height / 2); // Pointe droite
    path.lineTo(size.width - triangleWidth, 0); // Coin haut
    path.lineTo(size.width - triangleWidth, size.height); // Coin bas
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
