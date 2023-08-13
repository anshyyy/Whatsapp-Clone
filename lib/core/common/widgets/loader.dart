import 'package:whatsapp/exports.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: tabColor,
      ),
    );
  }
}
