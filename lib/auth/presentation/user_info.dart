import 'package:whatsapp/auth/controller/auth_controller.dart';
import 'package:whatsapp/exports.dart';

class UserInfomation extends ConsumerStatefulWidget {
  static const String routeName = "/userInformation-screen";
  const UserInfomation({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfomationState();
}

class _UserInfomationState extends ConsumerState<UserInfomation> {
  final TextEditingController nameController = TextEditingController();
  File? image;

  void selectFromGallery() async {
    image = await pickImageFromGallery(context);
    setState(() {
      print(image);
    });
  }

  void storeUserData() {
    String name = nameController.text.trim();
    if (name.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .saveUserDataToFireBase(context, name, image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 50),
            Stack(
              children: [
                image == null
                    ? const CircleAvatar(
                        radius: 54,
                        backgroundImage:
                            AssetImage("assets/images/profile_default.png"),
                      )
                    : CircleAvatar(
                        radius: 54,
                        backgroundImage: FileImage(image!),
                      ),
                Positioned(
                    bottom: -10,
                    right: -10,
                    child: IconButton(
                        onPressed: () {
                          selectFromGallery();
                        },
                        icon: const Icon(Icons.add_a_photo))),
              ],
            ),
            Row(
              children: [
                Container(
                  width: size.width * 0.85,
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Enter your name",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: tabColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: tabColor),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: tabColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100),
            SizedBox(
                width: size.width * 0.45,
                child: CustomButton(text: "Done", onPressed: storeUserData)),
          ],
        )),
      ),
    );
  }
}
