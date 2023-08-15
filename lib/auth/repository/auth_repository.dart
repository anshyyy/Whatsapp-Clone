import 'package:whatsapp/auth/presentation/otp_screen.dart';
import 'package:whatsapp/auth/presentation/user_info.dart';
import 'package:whatsapp/core/common/repository/firebase_storage.dart';
import 'package:whatsapp/core/model/user_model.dart';
import 'package:whatsapp/exports.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({required this.auth, required this.firestore});

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection("users").doc(auth.currentUser?.uid).get();
    print("here is the data $userData");

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          throw Exception(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.pushNamed(context, OtpScreen.routeName,
              arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: tabColor,
      ));
    }
  }

  void verifyOTP(
      {required BuildContext context,
      required String verificationId,
      required String userOTP}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOTP);
      await auth.signInWithCredential(credential);
      Navigator.pushNamedAndRemoveUntil(
          context, UserInfomation.routeName, (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "SomeThing Went Wrong!!",
          style: TextStyle(color: blackColor),
        ),
        backgroundColor: tabColor,
      ));
    }
  }

  void saveUserDataToFirebase({
    required String name,
    required File? profileImage,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
      if (profileImage != null) {
        photoUrl = await ref
            .read(firebaseStorageProvider)
            .storeFileToFirebase("profile-pic/$uid", profileImage);
      }
      // print(photoUrl);
      // print(auth.currentUser!.uid);

      var user = UserModel(
          name: name,
          uid: uid,
          profilePic: photoUrl,
          isOnline: true,
          phoneNumber: auth.currentUser!.phoneNumber!,
          groupId: []);

      await firestore.collection("users").doc(uid).set(user.toMap());
      print("hello this is after saving collection");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MobileScreen()),
          (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          "SomeThing Went Wrong!!",
          style: TextStyle(color: blackColor),
        ),
        backgroundColor: tabColor,
      ));
    }
  }

  userData(String userId) {
    //return firestore.collection("users").doc(userId).snapshots()
  }
}
