import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'my_textfield.dart';
import 'my_button.dart';
import 'squarebutton.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
//controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  //method to connect
  void signUpUser() async {
    try {
      if (passwordController.text == confirmpasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        showErrorMessage("Your passwords do not match!");
      }
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green,
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ), // Text
          ), // Center
        ); // AlertDialog
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // éviter le débordement souvent provoqué par le clavier
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Icon(
                  Icons.lock,
                  size: 80,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Sign up',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),
                //Email
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscuredText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                //mot de passe
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscuredText: true,
                ),
//Confirmer le mot de passe
                MyTextField(
                  controller: confirmpasswordController,
                  hintText: 'Confirm password',
                  obscuredText: true,
                ),
                // forgot password

                SizedBox(
                  height: 25,
                ),
                MyButton(
                  onTap: signUpUser,
                  text: 'Enter',
                ),
                SizedBox(
                  height: 25,
                ),
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or connect with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google
                    SquareTile(onTap: () {}, imagePath: 'images/google.png'),
                    SizedBox(
                      width: 25,
                    ),
                    SquareTile(onTap: () => {}, imagePath: 'images/apple.png'),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already signed up?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Back to login page',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
