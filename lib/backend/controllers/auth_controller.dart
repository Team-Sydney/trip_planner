import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum LoginProvider {
  google,
  apple,
}

class AuthController {
  Future<void> authenticate(LoginProvider loginProvider) async {
    String accessToken;

    switch (loginProvider) {
      case LoginProvider.apple:
        await _signInWithApple();
        break;
      case LoginProvider.google:
        await signInWithGoogle();
        break;
    }
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) throw Exception('GoogleUser was NULL');

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    if (googleAuth.accessToken == null) {
      throw Exception('GoogleAuth.accessToken was NULL');
    }

    return {
      'email': googleUser.email,
      'name': googleUser.displayName,
    };
  }

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> _signInWithApple() async {
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
  }
}
