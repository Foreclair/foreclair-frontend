// login_gateway.dart
import 'package:flutter/material.dart';
import 'package:foreclair/src/data/services/authentication/auth_service.dart';
import 'package:foreclair/src/data/services/http/api_service.dart';
import 'package:foreclair/src/ui/views/errors/fetching_error_view.dart';

import '../layout/layout_view.dart';
import 'login_view.dart';

enum _RouteTarget { login, layout, error }

class LoginGateway extends StatelessWidget {
  const LoginGateway({super.key});

  Future<_RouteTarget> _bootstrap() async {
    final isAuth = await AuthService.instance.isAuthenticated();
    if (!isAuth) return _RouteTarget.login;
    
    final ok = await ApiService.instance.initializeUserInformation();
    return ok ? _RouteTarget.layout : _RouteTarget.error;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<_RouteTarget>(
      future: _bootstrap(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        switch (snapshot.data!) {
          case _RouteTarget.layout:
            return const LayoutView();
          case _RouteTarget.error:
            return const FetchingErrorView();
          case _RouteTarget.login:
            return const LoginView();
        }
      },
    );
  }
}
