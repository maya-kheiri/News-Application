import 'package:flutter/material.dart';
import 'package:news_app/firebase/fb_auth_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      children: [
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('logout'),
          subtitle: const Text('Waiting your return'),
          onTap: () async {
            await sigOut();
          },
        ),
      ],
    );
  }

  Future<void> sigOut() async {
    await FbAuthController().signOut();
    Navigator.pushReplacementNamed(context, '/login_screen');
  }
}
