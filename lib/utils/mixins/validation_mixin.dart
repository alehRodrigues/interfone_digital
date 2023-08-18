mixin ValidationMixin {
  String? isValidEmail(String? email, [String? message]) {
    if (email == null || email.isEmpty) {
      return message ?? 'Por favor, informe o e-mail';
    }

    if (!email.contains('@')) {
      return 'E-mail inválido';
    }

    if (!email.endsWith('.com') || !email.endsWith('.br')) {
      return 'E-mail inválido';
    }

    return null;
  }

  String? isValidPassword(String? password, String? repeatPassword,
      [String? message]) {
    if (password == null || password.isEmpty) {
      return message ?? 'Por favor, informe a senha';
    }

    if (password.length < 6) {
      return 'A senha deve ter no mínimo 6 caracteres';
    }

    if (repeatPassword != null && repeatPassword != password) {
      return 'As senhas não conferem';
    }

    if (password.contains(' ')) {
      return 'A senha não pode conter espaços';
    }

    return null;
  }
}
