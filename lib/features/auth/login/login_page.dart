// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/helpers.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LoginPage extends StatefulWidget with HasPresenter<LoginPresenter> {
  const LoginPage({
    required this.presenter,
    super.key,
  });

  @override
  final LoginPresenter presenter;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with PresenterStateMixin<LoginViewModel, LoginPresenter, LoginPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: appLocalizations.usernameHint,
                ),
                onChanged: (text) => presenter.setUsername(text), 
              ),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: appLocalizations.passwordHint,
                ),
                onChanged: (text) => presenter.setPassword(text),
              ),
              const SizedBox(height: 16),
              stateObserver(
                buildWhen: (previous, current) => previous.isLoginEnabled != current.isLoginEnabled || previous.isLoading != current.isLoading,
                builder: (context, state) => 
                state.isLoading?
                const Center(
                  child: CircularProgressIndicator(),
                )
                :
                ElevatedButton(
                  onPressed: !state.isLoginEnabled? null: () => presenter.onLogin(),
                  child: Text(appLocalizations.logInAction),
                ),
              ),
            ],
          ),
        ),
      );
}
