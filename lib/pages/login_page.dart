import 'package:flutter/material.dart';
import 'package:linkup/services/auth/auth_service.dart';
import 'package:linkup/components/my_button.dart';
import 'package:linkup/components/my_textfield.dart';


//Login page
class LoginPage extends StatelessWidget{

  // username and password controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // tap to go to register page --> login_or_register.dart
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  // login method
  void login(context) async {
    // auth service
    final authService = AuthService();

    // try login
    try {
      await authService.signInWithEmailPassword(_emailController.text, _passwordController.text,);
    }

    // catch and display errors
    catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          )
      );
    }
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(Icons.double_arrow_sharp, size: 60, color: Theme.of(context).colorScheme.primary,),
            const SizedBox(height: 10,),

            // welcome back message
            Text(
              "Welcome back to LinkUp!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                // fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 50,),

            // email textfield
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),

            const SizedBox(height: 15,),

            // p/w textfield
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
            ),

            const SizedBox(height: 25,),

            // login button
            MyButton(text: "Login", onTap: () => login(context),),

            const SizedBox(height: 18,),

            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            )
        
          ],
        ),
      ),
    );
  }
}