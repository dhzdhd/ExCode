import 'package:excode/src/cloud/providers/auth_provider.dart';
import 'package:excode/src/cloud/services/supabase_auth.dart';
import 'package:excode/src/helpers.dart';
import 'package:excode/src/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum AuthType {
  login,
  signUp,
}

class AuthView extends StatefulHookConsumerWidget {
  const AuthView({Key? key}) : super(key: key);

  static const routeName = '/auth';

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  var _isLoading = false;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  void _setLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = useState(AuthType.signUp);
    final globalTheme = ref.watch(themeStateProvider);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !_isLoading,
        title: const Text('Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          onChanged: () => _formKey.currentState!.validate(),
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  state.value == AuthType.login ? 'Login' : 'Signup',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const Divider(color: Colors.transparent),
              Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, top: 8, bottom: 8),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text('Email'),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: globalTheme.accentColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, top: 8, bottom: 8),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 7) {
                      return 'Please enter a stronger password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text('Password'),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: globalTheme.accentColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, top: 8, bottom: 8),
                child: Visibility(
                  visible: state.value == AuthType.signUp,
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the password';
                      } else if (value != _passwordController.text) {
                        return 'Passwords entered don\'t match!';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      label: const Text('Confirm password'),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: globalTheme.accentColor),
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(color: Colors.transparent),
              SwitchListTile(
                title: const Text('Save login information?'),
                hoverColor: Colors.transparent,
                value: ref.watch(authProvider).isLoginInfoSaved,
                onChanged: (value) =>
                    ref.watch(authProvider.notifier).setLoginInfoSaved(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, top: 8, bottom: 8),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (state.value == AuthType.signUp) {
                        // TODO: Find alternative to set loading state
                        _setLoading();
                        final response = await Auth.register(
                            _emailController.text, _passwordController.text);
                        _setLoading();
                        response.match(
                          (l) => context.showErrorSnackBar(l),
                          (r) {
                            ref.watch(authProvider.notifier).setUser(r);
                            Navigator.pop(context);
                            context.showSuccessSnackBar(
                                'Successfully registered! Please check your email to verify!');
                          },
                        );
                      } else {
                        _setLoading();
                        final response = await Auth.signIn(
                            _emailController.text, _passwordController.text);
                        _setLoading();

                        response.match(
                          (l) => context.showErrorSnackBar(l),
                          (r) {
                            ref.watch(authProvider.notifier).setUser(r);
                            Navigator.pop(context);
                            context
                                .showSuccessSnackBar('Successfully logged in!');
                          },
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromHeight(50),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Submit',
                          style: TextStyle(fontSize: 17),
                        ),
                ),
              ),
              // TODO: Convert to OutlinedButton
              Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, top: 8, bottom: 8),
                child: TextButton(
                  onPressed: () {
                    state.value = state.value == AuthType.login
                        ? AuthType.signUp
                        : AuthType.login;
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    fixedSize: const Size.fromHeight(50),
                  ),
                  child: Text(
                    state.value == AuthType.login
                        ? 'Go to Signup'
                        : 'Go to Login',
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    right: 15, left: 15, top: 8, bottom: 8),
                child: TextButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    fixedSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    'Reset password',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
