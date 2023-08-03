import 'package:whatsapp/exports.dart';

final authControllerProvider = Provider((ref) {
  return AuthController(
      ref: ref, authRepository: ref.read(authRepositoryProvider));
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.ref, required this.authRepository});

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(context, phoneNumber);
  }

  void verifyOTP(BuildContext context, String userOTP, String verificationID) {
    authRepository.verifyOTP(
        context: context, verificationId: verificationID, userOTP: userOTP);
  }

  void saveUserDataToFireBase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirebase(
        name: name, profileImage: profilePic, ref: ref, context: context);
  }
}
