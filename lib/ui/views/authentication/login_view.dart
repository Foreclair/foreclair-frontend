import 'package:blues/assets/colors/snsm_colors.dart';
import 'package:blues/assets/fonts/text_utils.dart';
import 'package:blues/ui/components/buttons/primary_action_button_widget.dart';
import 'package:blues/ui/components/inputs/login_form_field_widget.dart';
import 'package:blues/utils/topography_background.dart';
import 'package:blues/utils/units/size_utils.dart';
import 'package:blues/utils/wave_container.dart';
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
  final String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: TopographyBackground(
        child: WaveContainer(
          height: context.height(55),
          child: Padding(
            padding: EdgeInsetsGeometry.only(
              top: context.height(10),
              left: context.width(10),
              right: context.width(10),
              bottom: context.height(3),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Se connecter", style: titleLarge),
                Divider(
                  color: SNSMColors.bleuMarin,
                  height: context.height(2),
                  thickness: 4,
                  endIndent: context.width(50),
                  radius: BorderRadius.circular(10),
                ),
                Spacer(),
                AutofillGroup(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        LoginFormField(
                          key: const Key('emailField'),
                          controller: _emailController,
                          hint: "Identifiant",
                          icon: CupertinoIcons.profile_circled,
                          validator: (p0) {
                            return null;
                          },
                          autofillHints: const [AutofillHints.username],
                        ),
                        SizedBox(height: context.height(1)),
                        LoginFormField(
                          key: const Key('passwordField'),
                          controller: _passwordController,
                          hint: "Mot de passe",
                          password: true,
                          icon: CupertinoIcons.lock,
                          validator: (p0) {
                            return null;
                          },
                          autofillHints: const [AutofillHints.password],
                        ),
                        if (_errorMessage.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          Text(_errorMessage, style: const TextStyle(color: Colors.deepOrangeAccent)),
                        ],
                      ],
                    ),
                  ),
                ),

                // A voir si Mot de passe oublié est nécessaire

                // RichText(
                //   key: const Key('forgotPasswordText'),
                //   text: TextSpan(
                //     text: "J'ai oublié mon mot de passe",
                //     style: label.copyWith(decoration: TextDecoration.underline, color: SNSMColors.orange),
                //     recognizer: TapGestureRecognizer()
                //       ..onTap = () {
                //         showDialog(
                //           context: context,
                //           builder: (context) {
                //             print("Forgot password tapped");
                //             return Text("Mot de passe oublié dialog");
                //           },
                //         );
                //       },
                //   ),
                // ),
                Spacer(),
                PrimaryActionButtonWidget(key: const Key('validateLoginButton'), text: 'Valider'),
                Center(
                  child: RichText(
                    key: const Key('identifyLaterText'),
                    text: TextSpan(
                      text: "M'identifier plus tard",
                      style: label.copyWith(decoration: TextDecoration.underline, color: SNSMColors.bleuClair),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(child: Text("Connexion guest"));
                            },
                          );
                        },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
