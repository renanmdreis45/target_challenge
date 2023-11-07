import 'package:mobx/mobx.dart';

part 'text.g.dart';

class Text extends _Text with _$Text {
  Text(String description) : super(description);
}

abstract class _Text with Store {
  _Text(this.description);

  @observable
  String description = '';
  
}