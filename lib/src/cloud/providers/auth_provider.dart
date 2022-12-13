import 'package:excode/src/cloud/models/auth_model.dart';
import 'package:excode/src/factory.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authProvider =
    StateNotifierProvider<_AuthNotifier, AuthModel>((ref) => _AuthNotifier());

class _AuthNotifier extends StateNotifier<AuthModel> {
  _AuthNotifier()
      : super(AuthModel(
            user: supabase.auth.currentUser, isLoginInfoSaved: false));

  // ! supabase.auth.currentUser makes provider obsolete
  void setUser(User? user) {
    final newState = state.copyWith(user: user);
    state = newState;
  }

  void setLoginInfoSaved() {
    final newState = state.copyWith(isLoginInfoSaved: !state.isLoginInfoSaved);
    state = newState;
  }
}
