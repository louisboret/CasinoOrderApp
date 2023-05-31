import 'package:camera/camera.dart';
import 'package:casino_app/view/widgets/big_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/profile_view_model.dart';
import 'camera_screen.dart';
import 'package:badges/badges.dart' as badges;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void openCamera() async {
    await availableCameras().then((value) async {
      var result = await Navigator.push(context,
          MaterialPageRoute(builder: (context) => CameraPage(cameras: value)));
        Provider.of<ProfileViewModel>(context, listen: false)
            .ChangeProfileImage(result);
      
    });
  }
  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileViewModel>(context, listen: false);
      Provider.of<ProfileViewModel>(context, listen: false).checkprofileImage();
    });
  }

  @override
  Widget build(BuildContext context) {
     var profimg = Provider.of<ProfileViewModel>(context, listen: true).profileImage;
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Center(child: Text('Profile')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            badges.Badge(
              position: badges.BadgePosition.bottomEnd(bottom: 0, end: -2),
              showBadge: true,
              ignorePointer: false,
              onTap: () {
                openCamera();
                },
              badgeContent: const Icon(Icons.edit),
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.circle,
                badgeColor: Colors.blue,
                padding: const EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.white, width: 1),
                badgeGradient: const badges.BadgeGradient.linear(
                  colors: [Colors.orange, Color.fromARGB(255, 255, 98, 0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                elevation: 0,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: profimg,
                ),
              ),
            ),
            const SizedBox(height: 10),
            BigCard(
              text: "Archie Nemesis",
              icon: const Icon(Icons.person),
              pos: 'top',
            ),
            BigCard(
              text: 'gamba.forever@stake.com',
              icon: const Icon(Icons.email),
              pos: 'middle',
            ),
            BigCard(
              text: 'Qite',
              icon: const Icon(Icons.house_rounded),
              pos: 'bottom',
            ),
          ]),
        ),
      ),
    );
  }
}
