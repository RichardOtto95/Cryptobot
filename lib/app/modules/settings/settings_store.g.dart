// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsStore on _SettingsStoreBase, Store {
  final _$editTitledAtom = Atom(name: '_SettingsStoreBase.editTitled');

  @override
  ObservableMap<String, dynamic> get editTitled {
    _$editTitledAtom.reportRead();
    return super.editTitled;
  }

  @override
  set editTitled(ObservableMap<String, dynamic> value) {
    _$editTitledAtom.reportWrite(value, super.editTitled, () {
      super.editTitled = value;
    });
  }

  final _$updateTitledAsyncAction =
      AsyncAction('_SettingsStoreBase.updateTitled');

  @override
  Future<dynamic> updateTitled(dynamic context) {
    return _$updateTitledAsyncAction.run(() => super.updateTitled(context));
  }

  @override
  String toString() {
    return '''
editTitled: ${editTitled}
    ''';
  }
}
