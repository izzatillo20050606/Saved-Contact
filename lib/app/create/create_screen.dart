import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_crud/app/dashboard/dashboard_screen.dart';
import 'package:flutter_crud/components/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/item.dart';
import 'bloc/create_bloc.dart';

class CreateScreen extends StatelessWidget {
  final bool isEdit;
  final int? id;
  const CreateScreen({this.isEdit = false, this.id, super.key});

  @override
  Widget build(BuildContext context) {
    CreateBloc bloc = BlocProvider.of<CreateBloc>(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Save information')),
      body: SingleChildScrollView(
        child: BlocListener<CreateBloc, CreateState>(
          listener: (context, state) {
            if (state is CreateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(milliseconds: 700),
                  backgroundColor: Colors.green,
                  content: Text(' Successfully'),
                ),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Container(
                  height: 450,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Name : '),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 200,
                              child: BlocBuilder<CreateBloc, CreateState>(
                                builder: (context, state) {
                                  return CustomTextField(
                                    hintText: "Name",
                                    controller: bloc.itemNameTEC,
                                    errorText: state is CreateError
                                        ? state.itemNameError
                                        : null,
                                    prefixIcon: SvgPicture.asset(
                                      "assets/icons/item.svg",
                                      height: 22,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Phone Number : '),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 200,
                              child: BlocBuilder<CreateBloc, CreateState>(
                                builder: (context, state) {
                                  return CustomTextField(
                                    hintText: "Number",
                                    controller: bloc.itemIdTEC,
                                    errorText: state is CreateError
                                        ? state.itemIdError
                                        : null,
                                    keyboardType: TextInputType.number,
                                    prefixIcon: SvgPicture.asset(
                                      "assets/icons/number.svg",
                                      height: 22,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Commentary : '),
                            SizedBox(width: 10),
                          ],
                        ),SizedBox(height: 20,),
                        SizedBox(
                          width: 450,height: 150,
                          child: BlocBuilder<CreateBloc, CreateState>(
                            builder: (context, state) {
                              return CustomTextField(
                                hintText: "info",
                                controller: bloc.barcodeTEC,
                                errorText: state is CreateError
                                    ? state.barcodeError
                                    : null,
                                prefixIcon: SvgPicture.asset(
                                  "assets/icons/barcode.svg",
                                  height: 22,
                                  width: 100,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 60,
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () => bloc.add(
                        OnSave(
                            id: id,
                            itemId: bloc.itemIdTEC.text,
                            itemName: bloc.itemNameTEC.text,
                            barcode: bloc.barcodeTEC.text),
                      ),
                      child: Text(
                        isEdit ? 'Update' : 'Saved',
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 60,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "New Saved Contact",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
