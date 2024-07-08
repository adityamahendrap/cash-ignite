import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_log/color_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  static Future<void> createUserMobileApiOauth(
    UserCredential credential,
  ) async {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('oauth_mobile_api');

    await usersRef
        .doc(credential.user!.uid)
        .set({
          'uid': credential.user?.uid,
          'email': credential.user?.email,
          'name': credential.user?.displayName,
          'photo_url': credential.user?.photoURL,
          'provider': credential.credential?.providerId,
          'created_at': FieldValue.serverTimestamp(),
        })
        .then((_) => clog.info("user added"))
        .catchError((error) {
          clog.error("failed to add user: $error");
          throw error;
        });
  }

  static Future<Map<String, dynamic>?> getUserMobileApiOauth(
    String email,
    String provider,
  ) async {
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('oauth_mobile_api');

    QuerySnapshot snapshot;
    try {
      snapshot = await usersRef
          .where('email', isEqualTo: email)
          .where('provider', isEqualTo: provider)
          .get();
    } catch (e) {
      clog.error('Failed to get user: $e');
      throw e;
    }

    if (snapshot.docs.isNotEmpty) {
      Map<String, dynamic> user =
          snapshot.docs.first.data() as Map<String, dynamic>;
      clog.info('User found: $user');
      return user;
    }

    clog.info('User not found');
    return null;
  }

  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<UserCredential> signInWithGitHub(BuildContext context) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: "97082719470317a25684",
      clientSecret: "83e9938608ddf74f678aecb210d95e4d61fb38a2",
      redirectUrl: 'https://waterloo-5ec9e.firebaseapp.com/__/auth/handler',
    );
    final result = await gitHubSignIn.signIn(context);

    final githubAuthCredential = GithubAuthProvider.credential(result.token!);
    clog.info('github credential: ${githubAuthCredential}');

    // TODO: separate UI things from service layer
    EasyLoading.show();

    return await FirebaseAuth.instance
        .signInWithCredential(githubAuthCredential);
  }
}
