import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? usuario;
  bool isLoading = true;

  AuthService() {
    _auth.authStateChanges().listen((User? user) {
      usuario = user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    usuario = _auth.currentUser;
    isLoading = false;
    notifyListeners();
  }

  Future<String?> registrar(String email, String senha) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('A senha fornecida é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        return ('A conta já existe para este e-mail.');
      }
    } catch (e) {
      return (e.toString());
    }

    return null;
  }

  Future<String?> login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        return ('Senha incorreta. Tente novamente.');
      }
    } catch (e) {
      return (e.toString());
    }

    return null;
  }

  Future<String?> loginGoogle() async {
    try {
      isLoading = true;
      await _auth.signInWithProvider(GoogleAuthProvider());
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-disabled') {
        return ('Usuário Bloqueado. Contate o administrador.');
      }
      return ('Erro ao logar com o Google.');
    } catch (e) {
      return (e.toString());
    }

    return null;
  }

  logout() async {
    await _auth.signOut();
    _getUser();
  }
}
