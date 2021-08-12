import 'package:event_app/app/authentication-sign_in/widgets/email_form.dart';
import 'package:event_app/app/language_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'sign_in_view_model.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInViewModel>(
      create: (_) => SignInViewModel(context.read),
      builder: (_, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              LanguageMenu(),
            ],
          ),
          body: SignInViewBody(),
        );
      },
    );
  }
}

class SignInViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.select((SignInViewModel viewModel) => viewModel.isLoading);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              AppLocalizations.of(context)!.pleaseSignIn,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          isLoading
              ? _loadingIndicator()
              : Expanded(
                  child: EmailForm(
                    callback: (email, password) {
                      context.read<SignInViewModel>().signWithEmailAndPassword(
                          email,
                          password,
                          (e) => _showErrorDialog(
                              context, 'Failed to sign in', e));
                    },
                  ),
                ),
          // Expanded(
          //   child: isLoading ? _loadingIndicator() : _signInButtons(context),
          // ),
        ],
      ),
    );
  }

  Center _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }

  // Column _signInButtons(BuildContext context) {
  //   return Column(
  //     children: <Widget>[
  //       const Spacer(),
  //       EmailSignInButton(),
  //       // GoogleSignInButton(),
  //       const Spacer(),
  //     ],
  //   );
  // }
}
