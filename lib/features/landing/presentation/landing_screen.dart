import 'package:whatsapp/exports.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Text(
                "Welcome to WhatsApp",
                style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height / 9,
              ),
              Image.asset(
                "assets/images/bg.png",
                height: 340,
                width: 340,
                color: tabColor,
              ),
              SizedBox(
                height: size.height / 9,
              ),
              const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Read Our Privacy Policy. Tap "Agree" and "continue" to accept the Terms of Service.',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: size.width * 0.75,
                  child: CustomButton(
                      text: "AGREE AND CONINUE",
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.routeName);
                      }))
            ],
          ),
        )),
      ),
    );
  }
}
