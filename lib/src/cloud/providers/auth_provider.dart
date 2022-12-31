import 'package:excode/src/cloud/models/auth_model.dart';
import 'package:excode/src/factory.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authStateProvider =
    StateNotifierProvider<_AuthNotifier, AuthModel>((ref) => _AuthNotifier());

class _AuthNotifier extends StateNotifier<AuthModel> {
  _AuthNotifier()
      : super(AuthModel(
            // ! Probably should remove isLoginInfoSaved?
            user: supabase.auth.currentUser,
            isLoginInfoSaved: false));

  void setUser(User? user) {
    state = state.copyWith(user: user);
  }
}
