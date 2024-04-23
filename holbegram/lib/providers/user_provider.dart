import 'package:flutter/material.dart';
import '../methods/auth_methods.dart';
import '../models/user.dart'; // Import the Users model

class UserProvider with ChangeNotifier {
  final AuthMethod _authMethod = AuthMethod();
  Users? _user; // Change User to Users

  Users? get user => _user;

  Future<void> refreshUser() async {
    try {
      Users? userDetails = await _authMethod.getUserDetails();
      _user = userDetails; // No need to cast as Users, since it's already Users type
      notifyListeners();
    } catch (e) {
      logger.e('Error refreshing user: $e');
    }
  }
}
