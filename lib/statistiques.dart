import 'dart:math';
import 'package:flutter/material.dart';

class StatistiquesScreen extends StatelessWidget {
  const StatistiquesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBC02D),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Statistiques des Performances',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Carte bleue (Progrès hebdomadaire) ---
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF0E2051),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.card_giftcard_outlined,
                    color: Colors.white,
                    size: 34,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Progrès hebdomadaire',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'On dirait que vous êtes sur la bonne voie.\nVeuillez continuer à suivre votre plan quotidien',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // --- Titre Engagement Mensuel ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Engagement Mensuel',
                  style: TextStyle(
                    color: Color(0xFF1E285D),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF789EFB),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF789EFB),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF789EFB),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- Graphique Engagement Mensuel ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Arc multi-couleurs
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CustomPaint(
                      painter: MultiArcPainter(),
                      child: const Center(
                        child: Text(
                          '20\nMai',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF1E285D),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Légende
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Activités',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF1E285D),
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildLegendItem(
                          const Color(0xFFFBC02D),
                          '70 Collaborations',
                        ),
                        _buildLegendItem(
                          const Color(0xFFEF5350),
                          '23 Promotions',
                        ),
                        _buildLegendItem(
                          const Color(0xFF26A69A),
                          '56 Créations de contenus',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // --- Suivi Par mois (Barres) ---
            const Text(
              'Spendings',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 4),
            const Text(
              'Suivi Par mois',
              style: TextStyle(
                color: Color(0xFF1E285D),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Axes Y
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$1000',
                        style: TextStyle(fontSize: 9, color: Colors.grey),
                      ),
                      Text(
                        '\$500',
                        style: TextStyle(fontSize: 9, color: Colors.grey),
                      ),
                      Text(
                        '\$200',
                        style: TextStyle(fontSize: 9, color: Colors.grey),
                      ),
                      Text(
                        '\$0',
                        style: TextStyle(fontSize: 9, color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Builder(builder: (context) {
                      const double maxBarHeight = 92.65037536621094;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildBarItem(totalH: maxBarHeight, filledH: maxBarHeight * 0.38),
                          _buildBarItem(totalH: maxBarHeight, filledH: maxBarHeight * 0.55),
                          _buildBarItem(totalH: maxBarHeight, filledH: maxBarHeight * 0.28),
                          _buildBarItem(totalH: maxBarHeight, filledH: maxBarHeight * 0.75),
                          _buildBarItem(totalH: maxBarHeight, filledH: maxBarHeight * 0.48),
                          _buildBarItem(totalH: maxBarHeight, filledH: maxBarHeight * 0.65),
                          _buildBarItem(totalH: maxBarHeight, filledH: maxBarHeight * 0.42),
                          _buildBarItem(totalH: maxBarHeight, filledH: maxBarHeight * 0.58),
                          _buildBarItem(totalH: maxBarHeight, filledH: maxBarHeight * 0.35),
                          _buildBarItem(totalH: maxBarHeight, filledH: maxBarHeight * 0.70),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Current margin: April Spendings',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
                Text(
                  '\$350.00 / \$',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // --- Croissance des Abonnées (Graphique ligne) ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Croissance des Abonnées',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '128,7K',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E285D),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 110,
                    child: Stack(
                      children: [
                        // Lignes verticales fond
                        CustomPaint(
                          size: const Size(double.infinity, 110),
                          painter: GridLinesPainter(),
                        ),
                        // Courbe principale
                        CustomPaint(
                          size: const Size(double.infinity, 110),
                          painter: LineChartPainter(),
                        ),
                        // Tooltip
                        Positioned(
                          top: 8,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                '29 July 00:00',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    '220,342.76',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E285D),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4CAF50),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      '+3.4%',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Axes Y droite
                        const Positioned(
                          top: 0,
                          right: 0,
                          bottom: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '1000',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '500',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '200',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '100',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // --- Totaux de mon revenus ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Totaux de mon revenus',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: CustomPaint(
                      painter: RevenueGaugePainter(),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '660 K',
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E285D),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Depuis la création du compte',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Accéder au portefeuille',
                      style: TextStyle(color: Colors.grey[700], fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // --- Évaluation de la performance (Barres empilées) ---
            const Text(
              'Evaluation de la performance de mes  plateformes d\'activités',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Grande valeur + barres à gauche
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '12,3K',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E285D),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildStackedBar(55, 40, 25),
                          const SizedBox(width: 5),
                          _buildStackedBar(35, 75, 20),
                          const SizedBox(width: 5),
                          _buildStackedBar(45, 50, 15),
                          const SizedBox(width: 5),
                          _buildStackedBar(25, 35, 45),
                          const SizedBox(width: 5),
                          _buildStackedBar(60, 45, 50),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                // Légende à droite avec badges
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    _PlatformLegendItem(
                      dot: Color(0xFF7986CB),
                      platform: 'Facebook',
                      value: '2,3K',
                      badge: '+15.4%',
                    ),
                    SizedBox(height: 10),
                    _PlatformLegendItem(
                      dot: Color(0xFFEC407A),
                      platform: 'Tik Tok',
                      value: '1,6K',
                      badge: '+4.0%',
                    ),
                    SizedBox(height: 10),
                    _PlatformLegendItem(
                      dot: Color(0xFFFFA726),
                      platform: 'Youtube',
                      value: '1,1K',
                      badge: '+7.0%',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 13, color: Color(0xFF6B6B6B)),
          ),
        ],
      ),
    );
  }

  Widget _buildBarItem({
    required double totalH,
    required double filledH,
  }) {
    const double barWidth = 23.599624633789062;
    return SizedBox(
      width: barWidth,
      height: totalH,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Background
          Container(
            width: barWidth,
            height: totalH,
            decoration: BoxDecoration(
              color: const Color(0xFFF6F4FE),
              borderRadius: BorderRadius.circular(5.24),
            ),
          ),

          // Filled part (gradient)
          Container(
            width: barWidth,
            height: filledH,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x618061DB),
                  Color(0xF08061DB),
                ],
              ),
              borderRadius: BorderRadius.circular(3.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStackedBar(double h1, double h2, double h3) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 18,
          height: h1 * 0.5,
          decoration: const BoxDecoration(
            color: Color(0xFF7986CB),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        ),
        Container(width: 18, height: h2 * 0.5, color: const Color(0xFFEC407A)),
        Container(
          width: 18,
          height: h3 * 0.5,
          decoration: const BoxDecoration(
            color: Color(0xFFFFA726),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}

// --- Widget légende plateforme avec badge ---
class _PlatformLegendItem extends StatelessWidget {
  final Color dot;
  final String platform;
  final String value;
  final String badge;

  const _PlatformLegendItem({
    required this.dot,
    required this.platform,
    required this.value,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              platform,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E285D),
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 1,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      fontSize: 9,
                      color: Color(0xFF388E3C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// --- Painter arc multi-couleurs Engagement ---
class MultiArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    const strokeWidth = 10.0;

    final bgPaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    void drawArc(Color color, double startAngle, double sweepAngle) {
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }

    // Yellow arc (70 collabs) ≈ 46%
    drawArc(const Color(0xFFFBC02D), -pi / 2, 2 * pi * 0.46);
    // Red arc (23 promo) ≈ 15%
    drawArc(const Color(0xFFEF5350), -pi / 2 + 2 * pi * 0.46, 2 * pi * 0.15);
    // Green arc (56 créations) ≈ 37%
    drawArc(const Color(0xFF26A69A), -pi / 2 + 2 * pi * 0.61, 2 * pi * 0.37);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// --- Painter lignes grille verticales ---
class GridLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.15)
      ..strokeWidth = 1;

    const int lines = 12;
    for (int i = 0; i <= lines; i++) {
      final x = size.width * i / lines;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// --- Painter courbe ligne + zone ---
class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF789EFB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF789EFB).withOpacity(0.3),
          const Color(0xFF789EFB).withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.85);
    path.lineTo(size.width * 0.08, size.height * 0.75);
    path.lineTo(size.width * 0.15, size.height * 0.80);
    path.lineTo(size.width * 0.22, size.height * 0.72);
    path.lineTo(size.width * 0.30, size.height * 0.65);
    path.lineTo(size.width * 0.38, size.height * 0.55);
    path.lineTo(size.width * 0.45, size.height * 0.50);
    path.lineTo(size.width * 0.52, size.height * 0.45);
    path.lineTo(size.width * 0.60, size.height * 0.35);
    path.lineTo(size.width * 0.68, size.height * 0.28);
    path.lineTo(size.width * 0.75, size.height * 0.22);
    path.lineTo(size.width * 0.82, size.height * 0.30);
    path.lineTo(size.width * 0.90, size.height * 0.18);
    path.lineTo(size.width, size.height * 0.12);

    // Zone de remplissage
    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);

    // Courbe
    canvas.drawPath(path, linePaint);

    // Point sur la courbe (tooltip anchor)
    final dotPaint = Paint()
      ..color = const Color(0xFF789EFB)
      ..style = PaintingStyle.fill;
    final dotBorder = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.22),
      5,
      dotBorder,
    );
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.22),
      3,
      dotPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// --- Painter jauge revenus (arc violet + magenta) ---
class RevenueGaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    const strokeWidth = 14.0;

    // Fond gris
    final bgPaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * 0.75,
      pi * 1.5,
      false,
      bgPaint,
    );

    // Arc violet
    final purplePaint = Paint()
      ..color = const Color(0xFF7986CB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * 0.75,
      pi * 0.85,
      false,
      purplePaint,
    );

    // Arc magenta/rose
    final pinkPaint = Paint()
      ..color = const Color(0xFFEC407A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi * 0.75 + pi * 0.85,
      pi * 0.55,
      false,
      pinkPaint,
    );

    // Petit cercle bleu à la jonction
    final angle = pi * 0.75 + pi * 0.85;
    final dotX = center.dx + radius * cos(angle);
    final dotY = center.dy + radius * sin(angle);
    final dotPaint = Paint()..color = const Color(0xFF3F51B5);
    canvas.drawCircle(Offset(dotX, dotY), 7, dotPaint);
    final innerDot = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(dotX, dotY), 3, innerDot);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
