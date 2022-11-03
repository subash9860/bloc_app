import 'package:bloc_app/person.dart';
import 'package:flutter/widgets.dart';

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;

  const FetchResult({
    required this.persons,
    required this.isRetrievedFromCache,
  });

  @override
  String toString() =>
      'FetchResult (isRetrievedFromCache =$isRetrievedFromCache)';
}
