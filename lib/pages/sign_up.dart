import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SignUpPage extends StatefulWidget {
  final void Function()? onTap;
  SignUpPage({super.key, required this.onTap});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _pwController = TextEditingController();

  final TextEditingController _consfirmpwController = TextEditingController();

  // login function
  void register(BuildContext context) async {
    // get the auth service
    final auth = AuthService();
    if (_pwController.text.trim() == _consfirmpwController.text.trim()) {
      try {
        await auth.signUpWithEmailandPassword(_emailController.text.trim(),
            _pwController.text.trim(), _nameController.text.trim());
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Passwords donot match."),
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
                    "Let's create an account for you!",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  // name text field
                  CustomTextInput(
                    hintText: "Full Name",
                    icon: Iconsax.user,
                    obscureText: false,
                    controller: _nameController,
                  ),
                  const SizedBox(
                    height: 10,
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
                    height: 10,
                  ),

                  // confirm password text field
                  CustomTextInput(
                    hintText: "Confirm Password",
                    obscureText: _obsecureText,
                    icon: Iconsax.password_check,
                    controller: _consfirmpwController,
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
                    btnText: 'S i g n  U p',
                    onTap: () => register(context),
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  // register now

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a member? ',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Login Now',
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
