import 'package:whatsapp/exports.dart';

final authControllerProvider = Provider((ref) {
  return AuthController(authRepository: ref.read(authRepositoryProvider));
});

class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(context, phoneNumber);
  }

  void verifyOTP(BuildContext context, String userOTP, String verificationID) {
    authRepository.verifyOTP(
        context: context, verificationId: verificationID, userOTP: userOTP);
  }
}
