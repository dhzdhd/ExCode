import 'package:excode/src/cloud/models/auth_model.dart';
import 'package:excode/src/factory.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'auth_provider.g.dart';

// final authStateProvider =
//     StateNotifierProvider<_AuthNotifier, AuthModel>((ref) => _AuthNotifier());

// class _AuthNotifier extends StateNotifier<AuthModel> {
//   _AuthNotifier() : super(AuthModel(user: supabase.auth.currentUser));

//   void setUser(User? user) {
//     state = state.copyWith(user: user);
//   }
// }

@riverpod
class Auth extends _$Auth {
  @override
  AuthModel build() {
    return AuthModel(user: supabase.auth.currentUser);
  }

  void setUser(User? user) {
    state = state.copyWith(user: user);
  }
}
