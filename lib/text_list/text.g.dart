part of 'text.dart';

mixin _$Text on _Text, Store {
  late final _$descriptionAtom =
      Atom(name: '_Text.description', context: context);

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  @override
  String toString() {
    return 'description: $description';
  }
}
