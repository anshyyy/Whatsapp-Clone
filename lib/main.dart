import 'package:whatsapp/auth/controller/auth_controller.dart';
import 'package:whatsapp/core/routes/router.dart';
import 'package:whatsapp/features/landing/presentation/landing_screen.dart';

import 'core/common/widgets/loader.dart';
import 'exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );

  const bool USE_EMULATOR = false;
  if (USE_EMULATOR) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: tabColor,
          scaffoldBackgroundColor: backgroundColor,
          appBarTheme: const AppBarTheme(color: appBarColor),
          useMaterial3: true,
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: ref.watch(userDataAuthProvider).when(
            data: (user) {
              return (user == null)
                  ? const LandingScreen()
                  : const MobileScreen();
            },
            error: ((err, stackTrace) {
              return ErrorScreen(error: err.toString());
            }),
            loading: () => const Loader()));
  }
}
