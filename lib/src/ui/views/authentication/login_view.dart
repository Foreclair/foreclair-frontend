import 'package:blues/assets/colors/snsm_colors.dart';
import 'package:blues/assets/fonts/text_utils.dart';
import 'package:blues/src/data/models/authentication/auth_result_model.dart';
import 'package:blues/src/data/services/authentication/auth_service.dart';
import 'package:blues/src/ui/components/buttons/primary_action_button_widget.dart';
import 'package:blues/src/ui/components/container/topography_background.dart';
import 'package:blues/src/ui/components/container/wave_container.dart';
import 'package:blues/src/ui/components/extensions/snack_bar_extension.dart';
import 'package:blues/src/ui/components/inputs/login_form_field_widget.dart';
import 'package:blues/src/ui/views/layout/layout_views.dart';
import 'package:blues/utils/units/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final result = await _authService.login(_emailController.text.trim(), _passwordController.text);

      if (!mounted) return;

      if (result.isSuccess) {
        context.showSuccessSnackBar('Connexion réussie !');
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LayoutViews()));
      } else {
        context.showErrorSnackBar(result.errorMessage!);

        if (result.errorType == AuthErrorType.invalidCredentials) {
          _passwordController.clear();
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: TopographyBackground(
        child: WaveContainer(
          height: context.height(55),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: context.height(55) - context.height(13)),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsetsGeometry.only(
                    top: context.height(10),
                    left: context.width(10),
                    right: context.width(10),
                    bottom: context.height(3),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Se connecter", style: titleLarge.copyWith(color: Theme.of(context).colorScheme.primary)),
                      Divider(
                        color: Theme.of(context).colorScheme.primary,
                        height: context.height(2),
                        thickness: 4,
                        endIndent: context.width(50),
                        radius: BorderRadius.circular(10),
                      ),
                      const Spacer(),

                      // Formulaire de connexion
                      Flexible(
                        child: AutofillGroup(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LoginFormField(
                                  key: const Key('emailField'),
                                  controller: _emailController,
                                  hint: "Identifiant",
                                  color: Theme.of(context).colorScheme.primary,
                                  icon: CupertinoIcons.profile_circled,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Veuillez saisir votre identifiant';
                                    }
                                    return null;
                                  },
                                  autofillHints: const [AutofillHints.username],
                                ),
                                SizedBox(height: context.height(1)),
                                LoginFormField(
                                  key: const Key('passwordField'),
                                  controller: _passwordController,
                                  color: Theme.of(context).colorScheme.primary,
                                  hint: "Mot de passe",
                                  password: true,
                                  icon: CupertinoIcons.lock,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Veuillez saisir votre mot de passe';
                                    }
                                    return null;
                                  },
                                  autofillHints: const [AutofillHints.password],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const Spacer(),

                      // Boutons en bas
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PrimaryActionButtonWidget(
                            key: const Key('validateLoginButton'),
                            text: _isLoading ? 'Connexion...' : 'Valider',
                            onPressed: _isLoading ? null : _handleLogin,
                          ),
                          SizedBox(height: context.height(1)),
                          Center(
                            child: RichText(
                              key: const Key('identifyLaterText'),
                              text: TextSpan(
                                text: "M'identifier plus tard",
                                style: label.copyWith(decoration: TextDecoration.underline, color: SNSMColors.gris),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LayoutViews()));
                                  },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
