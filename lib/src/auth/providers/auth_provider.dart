import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authProvider =
    StateNotifierProvider<_AuthNotifier, User?>((ref) => _AuthNotifier());

class _AuthNotifier extends StateNotifier<User?> {
  _AuthNotifier() : super(null);

  void setUser(User? user) {
    state = user;
  }
}
