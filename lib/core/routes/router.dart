import 'package:whatsapp/auth/presentation/otp_screen.dart';
import 'package:whatsapp/exports.dart';

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