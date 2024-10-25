import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickandmorty/app/colors.dart';

import 'package:rickandmorty/features/auth/presentation/providers/auth_provider.dart';
import 'package:rickandmorty/features/characters/presentation/screens/characters_screen.dart';
import 'package:rickandmorty/features/shared/presentation/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const LoginScreen(),
    );
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AuthProvider _authProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _authProvider.addListener(_handleAuthStateChange);
  }

  @override
  void dispose() {
    _authProvider.removeListener(_handleAuthStateChange);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleAuthStateChange() {
    if (!mounted) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      switch (_authProvider.status) {
        case AuthStatus.authenticated:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const CharactersScreen(),
            ),
          );
          break;
        case AuthStatus.invalidCredentials:
          _showErrorSnackBar('Credenciales inválidas');
          break;
        case AuthStatus.tooManyRequests:
          _showErrorSnackBar(
            'Has hecho demasiadas solicitudes. Espera 5 minutos antes de intentarlo de nuevo.',
          );
          break;
        case AuthStatus.error:
          _showErrorSnackBar('Error al iniciar sesión');
          break;
        default:
          // No action needed for other states
          break;
      }
    });
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 32),
                          CustomTextField(
                            label: 'Correo',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: 'ejemplo@correo.com',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'El correo es requerido';
                              }
                              if (!RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                  .hasMatch(value)) {
                                return 'El correo no es válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),
                          CustomTextField(
                            label: 'Contraseña',
                            controller: _passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: '********',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'La contraseña es requerida';
                              }
                              if (value.length < 6) {
                                return 'La contraseña debe tener al menos 6 caracteres';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 48),
                          Consumer<AuthProvider>(
                            builder: (context, authProvider, child) {
                              return authProvider.status == AuthStatus.loading
                                  ? const CircularProgressIndicator(
                                      color: AppColors.mediumSpringGreen,
                                    )
                                  : GradientButton(
                                      text: 'Ingresar',
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          authProvider
                                              .signInWithEmailAndPassword(
                                            _emailController.text,
                                            _passwordController.text,
                                          );
                                        }
                                      },
                                    );
                            },
                          ),
                        ],
                      ),
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
