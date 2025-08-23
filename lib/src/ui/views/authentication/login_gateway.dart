import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foreclair/src/data/services/authentication/auth_service.dart';

import '../layout/layout_view.dart';
import 'login_view.dart';

class LoginGateway extends StatelessWidget {
  const LoginGateway({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: AuthService.instance.isAuthenticated(), builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else if (snapshot.hasData && snapshot.data == true) {
        return const LayoutView();
      } else {
        return const LoginView();
      }
    });
  }
}
