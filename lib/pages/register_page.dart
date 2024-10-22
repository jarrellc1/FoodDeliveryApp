import "package:flutter/material.dart";
import "package:fooddeliveryapp/components/my_button.dart";
import "package:fooddeliveryapp/components/my_textfield.dart";


class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_open_rounded,
            size: 100,
            color: Theme.of(context).colorScheme.inversePrimary,
            ),

            const SizedBox(height: 25),

            Text(
              "Create an account", 
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.inversePrimary,
               )
            ),

            const SizedBox(height: 25),

            MyTextField(
              controller : emailController,
              hintText : "Email",
              obscureText: false,
            ),

            MyTextField(
              controller: passwordController, 
              hintText: "Password", 
              obscureText: true
            ),

            MyTextField(
              controller: confirmPasswordController, 
              hintText: "Confirm password", 
              obscureText: true
              ),

            const SizedBox(height: 25,),

            MyButton(onTap: () {}, 
            text: "Sign Up",
            ),

            const SizedBox(height: 25,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(width: 4,),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                  "Login now",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary),
                ),)
                
              ],
            )


        ],
        )

      ),
    );
  }
}
