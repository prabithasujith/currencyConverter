import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String user = '';
  bool isSignedIn = false;
  String contactText;
  GoogleSignInAccount currentUser;

  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Auth() {
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      currentUser = account;

      handleGetContact();
    });
    googleSignIn.signInSilently();
    notifyListeners();
  }
//signin

  Future<void> handleSignIn(BuildContext context) async {
    try {
      await googleSignIn.signIn();
      if (await googleSignIn.isSignedIn()) {
        user = googleSignIn.currentUser.email;
        isSignedIn = true;
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }

//sign out
  Future<void> handleSignOut() => googleSignIn.disconnect();
  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  Future<void> handleGetContact() async {
    contactText = "Loading contact info...";

    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
      '?requestMask.includeField=person.names',
      headers: await currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
      contactText = "People API gave a ${response.statusCode} "
          "response. Check logs for details.";

      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);

    if (namedContact != null) {
      contactText = "I see you know $namedContact!";
    } else {
      contactText = "No contacts to display.";
    }
  }
}
