import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foreclair/src/data/services/authentication/auth_service.dart';
import 'package:foreclair/src/ui/components/buttons/primary_action_button_widget.dart';
import 'package:foreclair/src/ui/views/authentication/login_view.dart';

class FetchingErrorView extends StatelessWidget {
  const FetchingErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.xmark_seal, color: Theme.of(context).colorScheme.secondary, size: 64),
            const SizedBox(height: 16),
            Text(
              "There was a problem while fetching data.",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            PrimaryActionButtonWidget(
              text: "Retry",
              onPressed: () async {
                await AuthService.instance.disconnect();
                if (!context.mounted) return;
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginView()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
