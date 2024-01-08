import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud/app/create/bloc/create_bloc.dart';
import 'package:flutter_crud/app/create/create_screen.dart';
import 'package:flutter_crud/app/search/bloc/search_bloc.dart';

import '../search/search_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TelePhone Contact'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            child: SizedBox(
              height: 60,
              width: 200,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider<CreateBloc>(
                      create: (context) => CreateBloc(),
                      child: const CreateScreen(),
                    ),
                  ),
                ),
                child: const Text('Create contact'),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 60,
            width: 200,
            child: ElevatedButton(
              onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider<SearchBloc>(
                    create: (context) => SearchBloc()..add(GetItems()),
                    child: const SearchScreen(),
                  ),
                ),
              ),
              child: const Text('Saved Search contact'),
            ),
          ),
        ],
      ),
    );
  }
}
