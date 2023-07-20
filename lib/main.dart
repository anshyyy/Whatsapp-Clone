import 'exports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
          useMaterial3: true,
        ),
        home: ResponsiveLayout(
          mobileScreenLayout: MobileScreen(),
          webScreenLayout: WebScreen(),
        ));
  }
}
