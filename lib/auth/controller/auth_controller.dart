import 'package:whatsapp/exports.dart';

import '../../core/model/user_model.dart';

final authControllerProvider = Provider((ref) {
  return AuthController(
      ref: ref, authRepository: ref.read(authRepositoryProvider));
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.ref, required this.authRepository});

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

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
