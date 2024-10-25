import 'package:flutter/material.dart';
import 'package:rickandmorty/features/characters/presentation/screens/characters_screen.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/login_header.png',
              fit: BoxFit.fitWidth,
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
            ),
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),
                  Text(
                    'Hoola 🖖',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    label: 'Correo',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'ejemplo@correo.com',
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    label: 'Contraseña',
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    hintText: '********',
                  ),
                  const SizedBox(height: 48),
                  GradientButton(
                    text: 'Ingresar',
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacement(CharactersScreen.route());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
