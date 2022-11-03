import 'package:bloc_app/fetch_result.dart';
import 'package:bloc_app/load_action.dart';
import 'package:bloc_app/person_bloc.dart';
import 'package:bloc_app/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'subscript_extension.dart';

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
              context.read<PersonBloc>().add(
                    const LoadPersonAction(
                      url: PersonUrl.person1,
                    ),
                  );
            },
            child: const Text("Load json #1"),
          ),
          TextButton(
            onPressed: () {
              context.read<PersonBloc>().add(
                    const LoadPersonAction(
                      url: PersonUrl.person2,
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
              fetchResult?.log();

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
