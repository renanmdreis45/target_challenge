import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:validators2/validators2.dart';

part 'login_store.g.dart';

class CustomColor extends Color {
  CustomColor(int value) : super(value);
}

// ignore: library_private_types_in_public_api
class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final LoginErrorState error = LoginErrorState();

  @observable
  CustomColor color = CustomColor(0);

  @observable
  String username = '';

  @observable
  String password = '';

  @observable
  ObservableFuture<bool> usernameCheck = ObservableFuture.value(true);

  @computed
  bool get isUserCheckPending => usernameCheck.status == FutureStatus.pending;

  @computed
  bool get canLogin => !error.hasErrors;

  late List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => username, validateUsername),
      reaction((_) => password, validatePassword)
    ];
  }

  @action
  Future validateUsername(String value) async {
    if (isNull(value) || value.isEmpty) {
      error.username = 'Esse campo é obrigatório';
      return;
    } else if (value.length > 20) {
      error.username = 'Limite de 20 caracteres excedido';
      return;
    }

    try {
      usernameCheck = ObservableFuture(checkValidUsername(value));

      error.username = null;

      final isValid = await usernameCheck;
      if (!isValid) {
        error.username = 'Username cannot be "admin"';
        return;
      }
    } on Object catch (_) {
      error.username = null;
    }

    error.username = null;
  }

  @action
  void validatePassword(String value) {
    final exp = RegExp(r'^[a-zA-Z0-9]+$');

    if (isNull(value) || value.isEmpty) {
      error.password = 'Esse campo é obrigatório';
      return;
    } else if (!exp.hasMatch(value)) {
      error.password = "Esse campo não aceita caracteres especiais";
      return;
    } else if (value.length < 2) {
      error.password = "Esse campo não pode ter menos que 2 caracteres";
      return;
    } else if (value.length > 20) {
      error.password = "Esse campo não pode ter mais que 20 caracteres";
      return;
    } else {
      error.password = null;
    }
  }

  Future<bool> checkValidUsername(String value) async {
    await Future.delayed(const Duration(seconds: 1));

    return value != 'admin';
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateUsername(username);
  }
}

// ignore: library_private_types_in_public_api
class LoginErrorState = _LoginErrorState with _$LoginErrorState;

abstract class _LoginErrorState with Store {
  @observable
  String? username;

  @observable
  String? email;

  @observable
  String? password;

  @computed
  bool get hasErrors => username != null || email != null || password != null;
}
