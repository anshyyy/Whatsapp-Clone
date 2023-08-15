import 'package:whatsapp/auth/presentation/otp_screen.dart';
import 'package:whatsapp/auth/presentation/user_info.dart';
import 'package:whatsapp/exports.dart';
import 'package:whatsapp/features/chatList/mobile/mobile_chat_screen.dart';
import 'package:whatsapp/features/select_contacts/presentation/selectContact_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return PageTransition(
        child: LoginScreen(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    case OtpScreen.routeName:
      final verificationId = settings.arguments as String;
      return PageTransition(
        child: OtpScreen(verificationId: verificationId),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    case UserInfomation.routeName:
      // final verificationId = settings.arguments as String;
      return PageTransition(
        child: const UserInfomation(),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
    case SelectContactsScreen.routeName:
      return PageTransition(
          child: const SelectContactsScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings);
    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final String name = arguments['name'];
      final String uid = arguments['uid'];
      return PageTransition(
          child: MobileChatScreen(name: name, uid: uid),
          type: PageTransitionType.rightToLeft,
          settings: settings);
    default:
      return PageTransition(
        child: Scaffold(
          body: ErrorScreen(error: "Something went wrong"),
        ),
        type: PageTransitionType.rightToLeft,
        settings: settings,
      );
  }
}
