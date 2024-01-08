import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud/app/create/bloc/create_bloc.dart';
import 'package:flutter_crud/app/create/create_screen.dart';
import 'package:flutter_crud/components/custom_text_field.dart';
import 'package:flutter_crud/components/item_card.dart';
import 'package:flutter_crud/consts/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../dashboard/dashboard_screen.dart';
import 'bloc/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SearchBloc bloc = BlocProvider.of<SearchBloc>(context);
    return Scaffold(
      backgroundColor: scaffoldBackground,
      appBar: AppBar(
        title: const Text('Search Data'),
        leading: IconButton(
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const DashboardScreen())),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 700),
                backgroundColor: Colors.green,
                content: Text('Data Deleted'),
              ),
            );
          } else if (state is SearchDeleteFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 700),
                backgroundColor: Colors.redAccent,
                content: Text('Data Failed to Delete'),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: "Search...",
                    controller: TextEditingController(),
                    prefixIcon: SvgPicture.asset(
                      "assets/icons/search.svg",
                      height: 22,
                    ),
                    onChanged: (keyword) =>
                        bloc.add(SearchItem(keyword: keyword)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
                child: RefreshIndicator(
              onRefresh: () async => bloc.add(GetItems()),
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return state is SearchLoaded
                      ? ListView.builder(
                          itemCount: state.items.length,
                          itemBuilder: (context, index) {
                            return ItemCard(
                              itemId: state.items[index].itemId.toString(),
                              itemName: state.items[index].itemName,
                              barcode: state.items[index].barcode,
                              onEdit: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider<CreateBloc>(
                                            create: (context) => CreateBloc()
                                              ..edit(state.items[index]),
                                            child: CreateScreen(
                                                id: state.items[index].id,
                                                isEdit: true),
                                          ))).then(
                                  (value) => bloc.add(GetItems())),
                              onDelete: () => bloc
                                  .add(DeleteItem(id: state.items[index].id!)),
                            );
                          })
                      : const Center(child: CircularProgressIndicator());
                },
              ),
            ))
          ]),
        ),
      ),
    );
  }
}
