import 'package:whatsapp/auth/controller/auth_controller.dart';
import 'package:whatsapp/exports.dart';

class OtpScreen extends ConsumerStatefulWidget {
  static const String routeName = "/otp-screen";
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  void verifyOTP(String userOTP, BuildContext context) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, userOTP, widget.verificationId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verifying your Mobile Number"),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text("We have sent an SMS with a code"),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                onChanged: (val) {
                  if (val.length == 6) {
                    verifyOTP(val.trim(), context);
                  }
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "- - - - - -",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: tabColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: tabColor),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: tabColor),
                    ),
                    hintStyle: TextStyle(fontSize: 30)),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
