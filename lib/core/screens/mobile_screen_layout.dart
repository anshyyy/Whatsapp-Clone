import 'package:whatsapp/auth/controller/auth_controller.dart';
import 'package:whatsapp/exports.dart';
import 'package:whatsapp/features/contacts/presentation/contact_list.dart';
import 'package:whatsapp/features/select_contacts/presentation/selectContact_screen.dart';

class MobileScreen extends ConsumerStatefulWidget {
  const MobileScreen({super.key});

  @override
  ConsumerState<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends ConsumerState<MobileScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
      default:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: appBarColor,
            title: const Text("WhatsApp", style: TextStyle(color: textColor)),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt_outlined)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
            ],
            bottom: const TabBar(
                labelColor: tabColor,
                indicatorColor: tabColor,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.grey,
                indicatorWeight: 3,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(text: "Chats"),
                  Tab(text: "Status"),
                  Tab(text: "Calls"),
                ]),
          ),
          body: Contacts(),
          floatingActionButton: FloatingActionButton(
            shape: CircleBorder(),
            onPressed: () {
              Navigator.pushNamed(
                context,
                SelectContactsScreen.routeName,
              );
            },
            backgroundColor: tabColor,
            child: const Icon(
              Icons.comment,
              color: Colors.white,
            ),
          ),
        ));
  }
}
