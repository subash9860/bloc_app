import 'package:bloc_app/api_call.dart';
import 'package:bloc_app/fetch_result.dart';
import 'package:bloc_app/load_action.dart';
import 'package:bloc_app/person.dart';
import 'package:bloc_app/url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(
        toString(),
      );
}

class PersonBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<PersonUrl, Iterable<Person>> _cache = {};
  PersonBloc() : super(null) {
    on<LoadPersonAction>(
      (event, emit) async {
        final url = event.url;
        if (_cache.containsKey(url)) {
          final cachePersons = _cache[url]!;
          final result = FetchResult(
            persons: cachePersons,
            isRetrievedFromCache: true,
          );
          emit(result);
        } else {
          final persons = await getPersons(url.urlString);
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
