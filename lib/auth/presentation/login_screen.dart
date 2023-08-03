import 'package:whatsapp/auth/controller/auth_controller.dart';
import 'package:whatsapp/exports.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "/login-screen";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      print("+${country?.phoneCode}$phoneNumber");
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, "+${country?.phoneCode}$phoneNumber");
    } else {
      showSnackBar(context: context, content: "fill out all things");
    }
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text("Enter your phone number"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("WhatsApp will need to verify your phone number."),
              const SizedBox(height: 10),
              TextButton(
                  onPressed: () => pickCountry(),
                  child: const Text(
                    "Pick Country",
                    style: TextStyle(color: tabColor),
                  )),
              const SizedBox(height: 5),
              Row(
                children: [
                  if (country != null) Text("+${country!.phoneCode}"),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      controller: phoneController,
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: tabColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: tabColor),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: tabColor),
                          ),
                          hintText: "phone number"),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.6,
              ),
              SizedBox(
                width: 100,
                child: CustomButton(
                  onPressed: () => sendPhoneNumber(),
                  text: "NEXT",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
