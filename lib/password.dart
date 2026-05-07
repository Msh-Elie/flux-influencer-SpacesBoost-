import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reset Password UI',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ResetPasswordPage(),
    );
  }
}

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  // 0 = Email, 1 = OTP, 2 = New Password, 3 = Success
  int _currentStep = 0;

  // Contrôleurs pour Email
  final TextEditingController _emailController = TextEditingController();

  // Contrôleurs pour OTP
  final List<TextEditingController> _otpControllers = List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(5, (_) => FocusNode());

  // Contrôleurs pour New Password
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  
  // États
  final String _emailDisplay = "";
  bool _isEmailValid = false;
  bool _isOtpComplete = false;
  bool _isPasswordStrong = false;
  
  // Visibilité des mots de passe
  bool _isNewPassVisible = false;
  bool _isConfirmPassVisible = false;

  // Couleurs
  final Color _brandYellow = const Color(0xFFFFC107);
  final Color _brandYellowLight = const Color(0xFFFFE082);

  @override
  void dispose() {
    _emailController.dispose();
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _otpFocusNodes) {
      f.dispose();
    }
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  // --- Navigation ---
  void _goToStep(int step) {
    setState(() => _currentStep = step);
  }

  // --- Validations ---
  void _checkEmailValidity(String value) {
    setState(() => _isEmailValid = value.isNotEmpty);
  }

  void _checkOtpValidity() {
    bool allFilled = true;
    for (var c in _otpControllers) {
      if (c.text.isEmpty) allFilled = false;
    }
    setState(() => _isOtpComplete = allFilled);
  }

  void _checkPasswordValidity() {
    // Vérifie simplement si les deux champs contiennent qqchose. 
    // Vous pouvez ajouter une vraie logique de validation ici (ex: longueur min, complexité)
    setState(() {
      _isPasswordStrong = _newPassController.text.isNotEmpty && _confirmPassController.text.isNotEmpty;
    });
  }

  // --- OTP Logic ---
  void _onOtpChanged(int index, String value) {
    if (value.length == 1 && index < 4) {
      _otpFocusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _otpFocusNodes[index - 1].requestFocus();
    }
    _checkOtpValidity();
  }

  // --- UI Build ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _brandYellow,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (_currentStep > 0) {
              _goToStep(_currentStep - 1);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          _currentStep <= 1 ? "Mot de passe oublié" : 
          _currentStep == 2 ? "Définir un nouveau mot de passe" : "Mot de passe oublié",
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getContentForStep(_currentStep),
        ),
      ),
    );
  }

  List<Widget> _getContentForStep(int step) {
    switch (step) {
      case 0: return _buildEmailContent();
      case 1: return _buildOtpContent();
      case 2: return _buildNewPassContent();
      case 3: return _buildSuccessContent();
      default: return [];
    }
  }

  // --- STEP 0 : EMAIL ---
  List<Widget> _buildEmailContent() {
    return [
      const SizedBox(height: 20),
      const Text("Mot de passe oublié", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      const Text("Veuillez saisir votre e-mail pour réinitialiser le mot de passe", style: TextStyle(color: Colors.grey, fontSize: 16)),
      const SizedBox(height: 30),
      const Text("Votre e-mail", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      TextField(
        controller: _emailController,
        decoration: InputDecoration(
          hintText: "Entrez votre e-mail",
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.grey)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
        ),
        onChanged: _checkEmailValidity,
      ),
      const SizedBox(height: 40),
      SizedBox(
        width: double.infinity, height: 50,
        child: ElevatedButton(
          onPressed: _isEmailValid ? () => _goToStep(1) : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isEmailValid ? _brandYellow : _brandYellowLight,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
          ),
          child: const Text("Réinitialiser le mot de passe", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ),
    ];
  }

  // --- STEP 1 : OTP ---
  List<Widget> _buildOtpContent() {
    return [
      const SizedBox(height: 20),
      const Text("Vérifiez votre e-mail", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 15),
      Text("Nous avons envoyé un lien de réinitialisation pour $_emailDisplay", style: const TextStyle(color: Colors.grey, fontSize: 15)),
      const SizedBox(height: 5),
      const Text("Entrez le code à 5 chiffres mentionné dans l'e-mail", style: TextStyle(color: Colors.grey, fontSize: 15)),
      const SizedBox(height: 30),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          return SizedBox(
            width: 55, height: 55,
            child: TextField(
              controller: _otpControllers[index],
              focusNode: _otpFocusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.blue, width: 2)),
              ),
              onChanged: (value) => _onOtpChanged(index, value),
            ),
          );
        }),
      ),
      const SizedBox(height: 40),
      SizedBox(
        width: double.infinity, height: 50,
        child: ElevatedButton(
          onPressed: _isOtpComplete ? () => _goToStep(2) : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isOtpComplete ? _brandYellow : _brandYellowLight,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
          ),
          child: const Text("Vérifier le code", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ),
      const SizedBox(height: 20),
      Center(
        child: GestureDetector(
          onTap: () {}, // Renvoyer l'email
          child: const Text("Vous n'avez pas encore l'e-mail? Revoir le courrier électronique", style: TextStyle(color: Colors.grey, fontSize: 12), textAlign: TextAlign.center),
        ),
      ),
    ];
  }

  // --- STEP 2 : NEW PASSWORD ---
  List<Widget> _buildNewPassContent() {
    return [
      const SizedBox(height: 20),
      const Text("Définir un nouveau mot de passe", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      const Text("Créer un nouveau mot de passe. S'assurer qu'il diffère de les précédents pour la sécurité", style: TextStyle(color: Colors.grey, fontSize: 15)),
      
      const SizedBox(height: 30),
      const Text("Mot de passe", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      TextField(
        controller: _newPassController,
        obscureText: !_isNewPassVisible,
        decoration: InputDecoration(
          hintText: "Entrez votre nouveau mot de passe",
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.grey)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
          suffixIcon: IconButton(
            icon: Icon(_isNewPassVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
            onPressed: () => setState(() => _isNewPassVisible = !_isNewPassVisible),
          ),
        ),
        onChanged: (val) => _checkPasswordValidity(),
      ),
      
      const SizedBox(height: 20),
      const Text("Confirmez le mot de passe", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      const SizedBox(height: 8),
      TextField(
        controller: _confirmPassController,
        obscureText: !_isConfirmPassVisible,
        decoration: InputDecoration(
          hintText: "Entrez à nouveau le mot de passe",
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.grey)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300)),
          suffixIcon: IconButton(
            icon: Icon(_isConfirmPassVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey),
            onPressed: () => setState(() => _isConfirmPassVisible = !_isConfirmPassVisible),
          ),
        ),
        onChanged: (val) => _checkPasswordValidity(),
      ),

      const SizedBox(height: 40),
      SizedBox(
        width: double.infinity, height: 50,
        child: ElevatedButton(
          // Condition : Les deux champs doivent être non vides ici.
          onPressed: _isPasswordStrong ? () => _goToStep(3) : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _isPasswordStrong ? _brandYellow : _brandYellowLight,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
          ),
          child: const Text("Mettre à jour le mot de passe", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ),
    ];
  }

  // --- STEP 3 : SUCCESS ---
  List<Widget> _buildSuccessContent() {
    return [
      const SizedBox(height: 30),
      const Text("Réinitialisation du mot de passe", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 15),
      const Text(
        "Votre mot de passe a été réinitialisé avec succès. faire un clic\nConfirmer pour définir un nouveau mot de passe",
        style: TextStyle(color: Colors.grey, fontSize: 15),
      ),
      const SizedBox(height: 80),
      SizedBox(
        width: double.infinity, height: 50,
        child: ElevatedButton(
          onPressed: () {
            // Logique pour aller à la page de connexion ou réinitialiser l'app
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Redirection vers la connexion...")),
            );
            // Reset pour tester
            setState(() => _currentStep = 0);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _brandYellow,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 0,
          ),
          child: const Text("Confirmer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      ),
    ];
  }
}