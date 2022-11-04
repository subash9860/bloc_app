import 'package:bloc_app/api_call.dart';
import 'package:bloc_app/bloc_action.dart';
import 'package:bloc_app/person_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'subscript_extension.dart';

import 'dart:developer';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc app"),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              log("Get person 1", name: "on pressed 1");
              context.read<PersonBloc>().add(
                    const LoadPersonAction(
                      url: person1Url,
                      loader: getPersons,
                    ),
                  );
            },
            child: const Text("Load json #1"),
          ),
          TextButton(
            onPressed: () {
              log("Get person 2", name: "on pressed 2");

              context.read<PersonBloc>().add(
                    const LoadPersonAction(
                      url: person2Url,
                      loader: getPersons,
                    ),
                  );
            },
            child: const Text("Load json #2"),
          ),
          BlocBuilder<PersonBloc, FetchResult?>(
            buildWhen: (previousResult, currentResult) {
              return previousResult?.persons != currentResult?.persons;
            },
            builder: (context, fetchResult) {
              log(fetchResult?.persons.toString() ?? "not fetch",
                  name: "fetch form screen");
              final persons = fetchResult?.persons;
              if (persons == null) {
                return const SizedBox();
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: persons.length,
                  itemBuilder: (context, index) {
                    final person = persons[index]!;
                    return ListTile(
                      title: Text(person.name),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
