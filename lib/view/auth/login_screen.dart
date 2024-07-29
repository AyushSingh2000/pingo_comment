import 'package:flutter/material.dart';
import 'package:pingo_comment/view/auth/register_screen.dart';
import 'package:provider/provider.dart';

import '../../view_model/auth_viewmodel.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../home_screen.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: Color(0xFFF5F9FD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Login',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF0C54BE))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Spacer(),
            CustomTextField(
              controller: _emailController,
              labelText: 'Email',
            ),
            SizedBox(
              height: 4,
            ),
            CustomTextField(
              controller: _passwordController,
              labelText: 'Password',
              obscureText: true,
            ),
            Spacer(),
            CustomButton(
              text: 'Login',
              onPressed: () async {
                await authViewModel.login(
                  _emailController.text,
                  _passwordController.text,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text(
                'Don\'t have an account? Sign up',
                style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
