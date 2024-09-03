import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _pwController = TextEditingController();

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

  var _obsecureText = true;

  togglePassword() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Icon(
                    Iconsax.message,
                    size: 90,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(
                    height: 30,
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
                    icon: Iconsax.direct,
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // password text field
                  CustomTextInput(
                    hintText: "Password",
                    obscureText: _obsecureText,
                    icon: Iconsax.password_check,
                    controller: _pwController,
                    sufficicon: IconButton(
                      onPressed: () {
                        togglePassword();
                      },
                      icon: _obsecureText
                          ? Icon(
                              Iconsax.eye_slash,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : Icon(
                              Iconsax.eye,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // button

                  CustomButton(
                    btnText: 'L o g i n',
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
                        onTap: widget.onTap,
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
      ),
    );
  }
}
