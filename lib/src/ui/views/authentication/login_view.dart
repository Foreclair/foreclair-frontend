import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foreclair/src/ui/components/extensions/snack_bar_extension.dart';
import 'package:foreclair/utils/units/size_utils.dart';

import '../../../../assets/colors/snsm_colors.dart';
import '../../../../assets/fonts/text_utils.dart';
import '../../../data/models/authentication/auth_result_model.dart';
import '../../../data/services/authentication/auth_service.dart';
import '../../components/buttons/primary_action_button_widget.dart';
import '../../components/container/topography_background.dart';
import '../../components/container/wave_container.dart';
import '../../components/inputs/login_form_field_widget.dart';
import '../layout/layout_views.dart';

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
        backgroundColors: [Theme.of(context).colorScheme.surfaceContainerHighest],
        child: WaveContainer(
          height: context.height(55),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableHeight = constraints.maxHeight;
              final padding = EdgeInsetsGeometry.only(
                top: context.height(10),
                left: context.width(10),
                right: context.width(10),
                bottom: context.height(3),
              );
              final contentHeight = availableHeight - context.height(13);

              final titleSpacing = (contentHeight * 0.02).clamp(2.0, 8.0);
              final formSpacing = (contentHeight * 0.02).clamp(2.0, 8.0);
              final buttonSpacing = (contentHeight * 0.02).clamp(2.0, 8.0);

              return Padding(
                padding: padding,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              "Se connecter",
                              style: titleLarge.copyWith(color: Theme.of(context).colorScheme.primary),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: titleSpacing),
                          Flexible(
                            child: Divider(
                              color: Theme.of(context).colorScheme.primary,
                              thickness: 4,
                              endIndent: context.width(50),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /**
                     * FORM SECTION
                     */
                    Expanded(
                      flex: 4,
                      child: AutofillGroup(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: LoginFormField(
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
                              ),
                              SizedBox(height: formSpacing),
                              Flexible(
                                child: LoginFormField(
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /**
                     * BUTTON SECTION
                     */
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: PrimaryActionButtonWidget(
                              key: const Key('validateLoginButton'),
                              text: _isLoading ? 'Connexion...' : 'Valider',
                              onPressed: _isLoading ? null : _handleLogin,
                            ),
                          ),
                          SizedBox(height: buttonSpacing),
                          Flexible(
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
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
