import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/firebase/fb_auth_controller.dart';
import 'package:news_app/utils/helpers.dart';
import 'package:news_app/widgets/app_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'LOGIN',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back...',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
            Text(
              'Enter Email and Password...',
              style: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            AppTextField(
              hint: 'Email',
              controller: _emailTextController,
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
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                await performSignIn();
              },
              child: const Text('LOGIN'),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/create_account_screen'),
                    child: const Text('CREATE ACCOUNT'),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    color: Colors.grey.shade500,
                    width: 1,
                    indent: 8,
                    endIndent: 8,
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/forgetPassword_screen'),
                    child: const Text('FORGET PASSWORD ?'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performSignIn() async {
    if (checkData()) {
      await signIn();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context: context, content: 'Enter required data');
    return false;
  }

  Future<void> signIn() async {
    bool status = await FbAuthController().signIn(context,
        email: _emailTextController.text,
        password: _passwordTextController.text);
    if (status) {
      Navigator.pushReplacementNamed(context, '/main_screen');
    }
  }
}
