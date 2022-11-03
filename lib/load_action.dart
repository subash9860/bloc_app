import 'package:bloc_app/url.dart';
import 'package:flutter/widgets.dart';

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonAction implements LoadAction {
  final PersonUrl url;
  const LoadPersonAction({
    required this.url,
  }) : super();
}
