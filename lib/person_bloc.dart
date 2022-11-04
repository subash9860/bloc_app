import 'dart:developer' as devtools show log;

import 'dart:developer';

import 'package:bloc_app/bloc_action.dart';
import 'package:bloc_app/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension Log on Object {
  void log() => devtools.log(
        toString(),
      );
}

extension IsEqualToIgnoringOrdering<T> on Iterable<T> {
  bool isEqualToIgnoringOrdering(Iterable<T> other) =>
      length == other.length && {...other}.length == length;
}

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
      'FetchResult (isRetrievedFromCache =$isRetrievedFromCache  , person = $persons)';

  // @override
  // bool operator ==(covariant FetchResult other) =>
  //     persons.isEqualToIgnoringOrdering(other.persons) &&
  //     isRetrievedFromCache == other.isRetrievedFromCache;

  // @override
  // int get hashCode => Object.hash(
  //       persons,
  //       isRetrievedFromCache,
  //     );
}

//Note:  here LoadAction is the event and FetchResult is the state
// because bloc take event and state
class PersonBloc extends Bloc<LoadPersonAction, FetchResult?> {
  // we need a cache in the bloc
  final Map<String, Iterable<Person>> _cache = {};

  // initially their is not state, null in  bloc constructor.
  PersonBloc() : super(null) {
    // handle the event
    on<LoadPersonAction>(
      // event is the input to the bloc and emit is the output of the bloc.
      (event, emit) async {
        log(event.url.toString(), name: "bloc event");

        log(emit.toString(), name: "emit");

        final url = event.url;
        if (_cache.containsKey(url)) {
          //   log(
          //     _cache.toString(),
          //     name: "print log",
          //   );
          final cachePersons = _cache[url]!;
          final result = FetchResult(
            persons: cachePersons,
            isRetrievedFromCache: true,
          );
          
          emit(result);
        } else {
          final loader = event.loader;
          final persons = await loader(url);
          _cache[url] = persons;
          final result = FetchResult(
            persons: persons,
            isRetrievedFromCache: false,
          );
          emit(result);
        }
      },
    );
  }
}
