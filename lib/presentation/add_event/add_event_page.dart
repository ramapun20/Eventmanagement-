import 'dart:developer';

import 'package:event_buddy/presentation/add_event/cubit/add_event_cubit.dart';
import 'package:event_buddy/presentation/cubit/all_event_cubit.dart';
import 'package:event_buddy/utils/constants/color_constants.dart';
import 'package:event_buddy/utils/loading_dialog.dart';
import 'package:event_buddy/utils/popup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key, required this.companyID});
  final String companyID;

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _interestsController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Event')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<AddEventCubit, AddEventState>(
          listener: (context, state) {
            if (state is AddEventLoading) {
              buildLoadingDialog(context: context, title: "Adding Event");
            } else if (state is AddEventFailure) {
              Navigator.of(context, rootNavigator: true).pop();
              PopUpProvider.showSnackBarMessage(context, state.msg);
            } else if (state is AddEventSuccess) {
              PopUpProvider.showSnackBarMessage(context, state.msg,
                  isError: false);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              Navigator.of(context, rootNavigator: true).pop();
              context.read<AllEventCubit>().getEvents();
            }
          },
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    label: const Text("Event Title"),
                    fillColor: ColorConstants.blackColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(
                        color: ColorConstants.hintColor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter event title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    label: const Text("Event Description"),
                    fillColor: ColorConstants.blackColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(
                        color: ColorConstants.hintColor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter event description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ListTile(
                  title: const Text(
                    'Start Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(_startDate.toString()),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                    ).then((date) {
                      if (date != null) {
                        setState(() {
                          _startDate = date;
                        });
                      }
                    });
                  },
                ),
                ListTile(
                  title: const Text(
                    'End Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${_endDate.toString()}'),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: _endDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                    ).then((date) {
                      if (date != null) {
                        setState(() {
                          _endDate = date;
                        });
                      }
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _interestsController,
                  decoration: InputDecoration(
                    label: const Text("Interests: use comma(,) to separate"),
                    fillColor: ColorConstants.blackColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide(
                        color: ColorConstants.hintColor,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter event interests';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final interest = _interestsController.text;
                      var values = interest
                          .split(",")
                          .map((x) => x.trim())
                          .where((element) => element.isNotEmpty)
                          .toList();
                      var data = {
                        "title": _titleController.text,
                        "about": _descriptionController.text,
                        "sallary": 80000,
                        "description": _descriptionController.text,
                        "skills": values,
                        "requirements": [],
                        "responsibilities": [],
                        "openTime": "${_startDate}",
                        "closeTime": "${_endDate}",
                        "company": widget.companyID
                      };
                      context.read<AddEventCubit>().addEvent(data);
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
