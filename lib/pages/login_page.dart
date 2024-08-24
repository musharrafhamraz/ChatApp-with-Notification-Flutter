import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  // login function

  login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // try login

    try {
      await authService.signInWithEmailandPassword(
          _emailController.text, _pwController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Icon(
                  Icons.message,
                  size: 60,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  height: 50,
                ),

                // Welcome Back text

                Text(
                  "Welcome back you've been missed!",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),

                // email text field
                CustomTextInput(
                  hintText: "Email",
                  obscureText: false,
                  controller: _emailController,
                ),
                const SizedBox(
                  height: 10,
                ),

                // password text field
                CustomTextInput(
                  hintText: "Password",
                  obscureText: true,
                  controller: _pwController,
                ),

                const SizedBox(
                  height: 25,
                ),

                // button

                CustomButton(
                  btnText: 'Login',
                  onTap: () => login(context),
                ),
                const SizedBox(
                  height: 25,
                ),

                // register now

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member? ',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
