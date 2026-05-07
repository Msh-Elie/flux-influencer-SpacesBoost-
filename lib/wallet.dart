import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── COULEURS ────────────────────────────────────────────────────────────────
const Color _yellow = Color(0xFFFCBC1E);
const Color _navy = Color(0xFF052859);
const Color _white = Color(0xFFFFFFFF);
const Color _textGrey = Color(0xFF988080);
const Color _blueLink = Color(0xFF007AFF);
const Color _dividerGrey = Color(0xFFE7E7F6);

// ─── MODÈLE DE TRANSACTION ──────────────────────────────────────────────────
class Transaction {
  final String imageAsset;
  final String name;
  final String date;
  final String amount;
  final bool isRetrait;

  Transaction({
    required this.imageAsset,
    required this.name,
    required this.date,
    required this.amount,
    required this.isRetrait,
  });
}

// ─── CONTENU PORTEFEUILLE ──────────────────────────────────────────────────
class PortefeuilleContent extends StatefulWidget {
  const PortefeuilleContent({super.key});

  @override
  State<PortefeuilleContent> createState() => _PortefeuilleContentState();
}

class _PortefeuilleContentState extends State<PortefeuilleContent> {
  late List<Transaction> _allTransactions;
  int _selectedFilter = 1; // 0 = Tout, 1 = Retrait, 2 = Dépôt

  @override
  void initState() {
    super.initState();
    _allTransactions = [
      Transaction(
        imageAsset: 'assets/Amanda.png',
        name: 'Amanda',
        date: '20 Mai, 10h24',
        amount: '-250.000f',
        isRetrait: true,
      ),
      Transaction(
        imageAsset: 'assets/Axo food.png',
        name: 'Axo Food',
        date: '20 Mai, 09h13',
        amount: '+60.000f',
        isRetrait: false,
      ),
      Transaction(
        imageAsset: 'assets/Palmosa.png',
        name: 'Palmosa',
        date: '11 Mai, 17h19',
        amount: '+125.000f',
        isRetrait: false,
      ),
      Transaction(
        imageAsset: 'assets/Reem khaled.png',
        name: 'Reem khaled',
        date: '07 Mai, 19h10',
        amount: '-21.300f',
        isRetrait: true,
      ),
      Transaction(
        imageAsset: 'assets/Hiba Saleh.png',
        name: 'Hiba Saleh',
        date: '28 Avril, 15h45',
        amount: '+480.000f',
        isRetrait: false,
      ),
      Transaction(
        imageAsset: 'assets/Hiba Saleh.png',
        name: 'Hiba Saleh',
        date: '28 Avril, 12h30',
        amount: '+150.000f',
        isRetrait: false,
      ),
      Transaction(
        imageAsset: 'assets/Hiba Saleh.png',
        name: 'Hiba Saleh',
        date: '28 Avril, 10h20',
        amount: '+90.000f',
        isRetrait: false,
      ),
    ];
  }

  List<Transaction> get _displayedTransactions {
    if (_selectedFilter == 0) return _allTransactions;
    return _selectedFilter == 1
        ? _allTransactions.where((t) => t.isRetrait).toList()
        : _allTransactions.where((t) => !t.isRetrait).toList();
  }

  // ── NAVIGATION ─────────────────────────────────────────────────────────────
  void _openRetraitForm() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const RetraitForm()),
    );
  }

  void _openNotifications() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const NotificationList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── RECTANGLE JAUNE AVEC SOLDE ──────────────────────────────────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
            color: _yellow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ligne supérieure : Tableau de bord (gauche) + Avatar (droite)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tableau de bord',
                      style: GoogleFonts.poppins(
                        color: _navy,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2.5)),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/Profile_wallet.png',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(Icons.person, color: _navy, size: 24),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Salut, Amanda!
                Text(
                  'Salut, Amanda!',
                  style: GoogleFonts.poppins(
                    color: _navy,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                // Solde total
                Text(
                  'Solde total',
                  style: GoogleFonts.poppins(
                    color: _navy,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                // Montant (CLIC pour ouvrir le formulaire de retrait) + icône notification (CLIC pour ouvrir les notifs)
                Row(
                  children: [
                    GestureDetector(
                      onTap: _openRetraitForm,
                      child: Text(
                        '860.000 f',
                        style: GoogleFonts.poppins(
                          color: _navy,
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -1.0,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: GestureDetector(
                        onTap: _openNotifications,
                        child: Image.asset(
                          'assets/notifications _icon.jpg',
                          width: 28,
                          height: 28,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Icon(Icons.notifications_outlined, color: _navy, size: 28),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── BOUTONS FILTRES ──────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedFilter = 1),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: _yellow,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_upward_rounded,
                            color: _navy,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Retrait Effectué',
                            style: GoogleFonts.poppins(
                              color: _navy,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedFilter = 2),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: _navy,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_downward_rounded,
                            color: _white,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Dépôt Reçu',
                            style: GoogleFonts.poppins(
                              color: _white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // ── EN-TÊTE TRANSACTIONS ─────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transactions',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _selectedFilter = 0),
                  child: Text(
                    'Afficher tous',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF3B82F6),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ── LISTE DES TRANSACTIONS ──────────────────────────────────────
          ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _displayedTransactions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final tx = _displayedTransactions[index];
              return _buildTransactionItem(tx);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ─── ITEM DE TRANSACTION (AVATAR + BADGE OVALE + ASSETS) ──────────────
  Widget _buildTransactionItem(Transaction tx) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar + badge ovale avec assets
        Stack(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade300,
              ),
              child: ClipOval(
                child: Image.asset(
                  tx.imageAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.person,
                    color: _navy,
                    size: 24,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 26.21,
              left: 27.61,
              child: Container(
                width: 26.5,
                height: 25.17,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.5),
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: Center(
                  child: Image.asset(
                    tx.isRetrait ? 'assets/retrait_icône.png' : 'assets/dépot.png',
                    width: 11.01,
                    height: 11.6,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Icon(
                      tx.isRetrait ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                      color: tx.isRetrait ? _navy : _navy,
                      size: 10,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 14),

        // Nom + Date
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tx.name,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF000000),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                tx.date,
                style: GoogleFonts.poppins(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),

        // Montant
        Text(
          tx.amount,
          style: GoogleFonts.poppins(
            color: const Color(0xFF000000),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// 1. VUE RETRAIT (Formulaire) - Clic sur le solde
// ──────────────────────────────────────────────────────────────────────────────
class RetraitForm extends StatelessWidget {
  const RetraitForm({super.key});

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
          'Portefeuille',
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
            Center(
              child: Text(
                'Retrait',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF000000),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Compte de virement
            Text(
              'Compte de virement',
              style: GoogleFonts.poppins(
                color: const Color(0xFF000000),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 80, // Augmenté pour des icônes plus grandes
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildPaymentIcon('assets/mastercard.png', 'Mastercard', size: 48),
                  _buildPaymentIcon('assets/visa.png', 'VISA', size: 48),
                  _buildPaymentIcon('assets/american_express.png', 'Amex', size: 48),
                  _buildPaymentIcon('assets/discover.png', 'Discover', size: 48),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Nom sur la carte
            Text(
              'Nom sur la carte',
              style: GoogleFonts.poppins(
                color: const Color(0xFF000000),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _buildTextField('Rencontrez Patel'),

            const SizedBox(height: 16),

            // Numéro de carte
            Text(
              'Numéro de carte',
              style: GoogleFonts.poppins(
                color: const Color(0xFF000000),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _buildTextField('0000 0000 0000 0000'),

            const SizedBox(height: 16),

            // Expiration de la carte
            Text(
              'Expiration de la carte',
              style: GoogleFonts.poppins(
                color: const Color(0xFF000000),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildDropdown('Mois'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDropdown('Année'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Code de sécurité de la carte
            Text(
              'Code de sécurité de la carte',
              style: GoogleFonts.poppins(
                color: const Color(0xFF000000),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            _buildTextField('Code', isPassword: true),

            const SizedBox(height: 40),

            // Bouton de retrait
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Demande de retrait envoyée !')),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Demander Un Retrait',
                  style: GoogleFonts.poppins(
                    color: _white,
                    fontSize: 18,
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

  Widget _buildTextField(String hint, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          color: Colors.grey.shade400,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        suffixIcon: isPassword
            ? Icon(Icons.help_outline, color: Colors.grey.shade400)
            : null,
      ),
    );
  }

  Widget _buildDropdown(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.grey.shade400,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  Widget _buildPaymentIcon(String asset, String label, {double size = 40}) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(4),
      child: Image.asset(
        asset,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Container(
          color: Colors.grey.shade200,
          child: Center(
            child: Text(
              label.substring(0, 1),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────────────────────
// 2. VUE NOTIFICATIONS (Historique) - Clic sur la cloche
// ──────────────────────────────────────────────────────────────────────────────
class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'type': 'retrait',
        'title': 'Retrait Effectué',
        'time': 'Il y a 2 min',
        'description':
            'Votre retrait de **250.000 FCFA** a bien été envoyé depuis votre portefeuille Spacesboost vers votre compte mobile au **+2290167000000**. Merci d\'utiliser nos services !',
        'status': 'Confirmé',
      },
      {
        'type': 'depot',
        'title': 'Dépôt Reçu',
        'time': 'Il y a 1 h 11 min',
        'description':
            'Votre portefeuille Spacesboost vient de recevoir un dépôt de **60.000 FCFA** de l\'entreprise AXOFOOD. Votre solde actuel est de **1.110.000 FCFA**. Profitez dès maintenant de toutes nos fonctionnalités de retrait et de gestion !',
        'status': 'Reçu',
      },
    ];

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
          'Portefeuille',
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
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 24),
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return _buildNotificationItem(context, notif);
        },
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, Map<String, dynamic> notif) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // En-tête : icône + titre + heure
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icône de notification (assets/notif.png)
            Container(
              width: 35, // Taille exacte de l'icône
              height: 35,
              decoration: const BoxDecoration(
                color: _yellow,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/notif.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.notifications,
                    color: _white,
                    size: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Titre "Retrait Effectué" ou "Dépôt Reçu"
            Expanded(
              child: Text(
                notif['title'],
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  height: 16 / 14, // line-height: 16px
                  letterSpacing: 0.3 / 100, // 0.3%
                  color: const Color(0xFF2C2C63),
                ),
              ),
            ),
            // Heure "Il y a 2 min"
            Text(
              notif['time'],
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: 1.0,
                color: _textGrey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Ligne de séparation
        Container(
          height: 0.5, // ligne fine
          color: _dividerGrey,
        ),
        const SizedBox(height: 12),
        // Description avec texte en gras
        RichText(
          text: TextSpan(
            style: GoogleFonts.poppins(
              color: Colors.black.withOpacity(0.5), // opacité 0.5
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 21 / 13, // line-height: 21px
              letterSpacing: 0.3 / 100,
            ),
            children: _parseDescription(notif['description']),
          ),
        ),
        const SizedBox(height: 12),
        // Lien "Confirmé" ou "Reçu"
        InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Action : ${notif['status']}')),
            );
          },
          child: Text(
            notif['status'],
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.0,
              color: _blueLink,
            ),
          ),
        ),
      ],
    );
  }

  List<TextSpan> _parseDescription(String text) {
    final List<TextSpan> spans = [];
    final RegExp boldRegex = RegExp(r'\*\*(.*?)\*\*');
    final List<String> parts = text.split(boldRegex);

    int index = 0;
    final matches = boldRegex.allMatches(text);

    for (final match in matches) {
      // Texte avant
      spans.add(TextSpan(text: parts[index]));
      index++;
      // Texte en gras (ExtraBold pour les montants, Bold pour le numéro de téléphone)
      final String boldText = match.group(1) ?? '';
      final bool isPhone = boldText.startsWith('+');
      spans.add(
        TextSpan(
          text: boldText,
          style: GoogleFonts.poppins(
            fontWeight: isPhone ? FontWeight.w700 : FontWeight.w800, // ExtraBold ou Bold
            fontSize: 13,
            height: 21 / 13,
            letterSpacing: 0.3 / 100,
            color: isPhone ? _blueLink : Colors.black, // Le numéro de téléphone en bleu
          ),
        ),
      );
    }
    // Dernier morceau après le dernier match
    if (index < parts.length) {
      spans.add(TextSpan(text: parts[index]));
    }
    return spans;
  }
}