import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc_app/person.dart';

Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((req) => req.close())
    .then((resp) => resp.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then(
      (list) => list.map((e) {

        log(e.toString(), name: "Respond");

        return Person.fromJson(e);
      }),
    );
