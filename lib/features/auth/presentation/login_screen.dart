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
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              transform: Matrix4.translationValues(0.0, -24.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 52),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: Text(
                      'Hoola 🖖',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
