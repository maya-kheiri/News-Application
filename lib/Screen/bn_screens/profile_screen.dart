import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/firebase/fb_auth_controller.dart';
import 'package:news_app/utils/helpers.dart';
import 'package:news_app/widgets/app_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with Helpers {
  late User _user;
  late TextEditingController _emailTextController;
  late TextEditingController _nameTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = FbAuthController().user!;
    _emailTextController = TextEditingController(text: _user.email ?? '');
    _nameTextController = TextEditingController(text: _user.displayName ?? '');
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _nameTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0),
                  color: Colors.black.withOpacity(0.61),
                  blurRadius: 6)
            ]),
            child: const CircleAvatar(
              radius: 50,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            _user.displayName ?? 'NO NAME',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            _user.email ?? 'NO EMAIL',
            style: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const Divider(
            height: 40,
            thickness: 1,
          ),
          AppTextField(
            hint: 'Email',
            controller: _emailTextController,
            keyboardType: TextInputType.emailAddress,
            maxLength: 35,
          ),
          const SizedBox(
            height: 10,
          ),
          AppTextField(
            hint: 'Name',
            controller: _nameTextController,
            maxLength: 30,
          ),
          const SizedBox(
            height: 10,
          ),
          AppTextField(
            hint: 'Password',
            controller: _passwordTextController,
            obscureText: true,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              await performUpdateProfile();
            },
            child: const Text('SAVE'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> performUpdateProfile() async {
    if (checkData()) {
      updateProfile();
    }
  }

  bool checkData() {
    if (_nameTextController.text.isNotEmpty &&
        _emailTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, content: 'Enter required data ');
    return false;
  }

  Future<void> updateProfile() async {
    bool updated = await FbAuthController().updateProfile(context,
        email: _emailTextController.text.trim(),
        name: _nameTextController.text.trimLeft(),
        password: _passwordTextController.text);
    if (updated) {
      showSnackBar(context: context, content: 'Profile updated successfully');
      setState(() {
        _user = FbAuthController().user!;
      });
    }
    String message = updated
        ? 'updated Profile failed , try again'
        : 'updated Profile failed , try again';
    showSnackBar(
        context: context,
        content: message,
        error: !updated);
  }
}
