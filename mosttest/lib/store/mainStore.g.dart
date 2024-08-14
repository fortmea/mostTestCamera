// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mainStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainStore on _MainStore, Store {
  late final _$xFileAtom = Atom(name: '_MainStore.xFile', context: context);

  @override
  XFile? get xFile {
    _$xFileAtom.reportRead();
    return super.xFile;
  }

  @override
  set xFile(XFile? value) {
    _$xFileAtom.reportWrite(value, super.xFile, () {
      super.xFile = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_MainStore.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$livenessAtom =
      Atom(name: '_MainStore.liveness', context: context);

  @override
  LivenessDAO? get liveness {
    _$livenessAtom.reportRead();
    return super.liveness;
  }

  @override
  set liveness(LivenessDAO? value) {
    _$livenessAtom.reportWrite(value, super.liveness, () {
      super.liveness = value;
    });
  }

  late final _$bearerAtom = Atom(name: '_MainStore.bearer', context: context);

  @override
  String? get bearer {
    _$bearerAtom.reportRead();
    return super.bearer;
  }

  @override
  set bearer(String? value) {
    _$bearerAtom.reportWrite(value, super.bearer, () {
      super.bearer = value;
    });
  }

  late final _$validarLivelinessActionAsyncAction =
      AsyncAction('_MainStore.validarLivelinessAction', context: context);

  @override
  Future<void> validarLivelinessAction() {
    return _$validarLivelinessActionAsyncAction
        .run(() => super.validarLivelinessAction());
  }

  late final _$authActionAsyncAction =
      AsyncAction('_MainStore.authAction', context: context);

  @override
  Future<void> authAction(String token) {
    return _$authActionAsyncAction.run(() => super.authAction(token));
  }

  late final _$_MainStoreActionController =
      ActionController(name: '_MainStore', context: context);

  @override
  void setXFile(XFile? file) {
    final _$actionInfo =
        _$_MainStoreActionController.startAction(name: '_MainStore.setXFile');
    try {
      return super.setXFile(file);
    } finally {
      _$_MainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
xFile: ${xFile},
errorMessage: ${errorMessage},
liveness: ${liveness},
bearer: ${bearer}
    ''';
  }
}
