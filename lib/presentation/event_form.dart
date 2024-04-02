import 'package:event_buddy/models/all_events_response.dart';
import 'package:event_buddy/presentation/apply_event/cubit/apply_event_cubit.dart';
import 'package:event_buddy/utils/loading_dialog.dart';
import 'package:event_buddy/utils/popup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventForm extends StatefulWidget {
  const EventForm({super.key, required this.event});

  final EventModel event;

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocListener<ApplyEventCubit, ApplyEventState>(
            listener: (context, state) {
              if (state is ApplyEventLoading) {
                buildLoadingDialog(context: context);
              }
              if (state is ApplyEventFailure) {
                Navigator.of(context, rootNavigator: true).pop();
                PopUpProvider.showSnackBarMessage(context, state.msg,
                    isError: true);
              }
              if (state is ApplyEventSuccess) {
                Navigator.of(context, rootNavigator: true).pop();
                PopUpProvider.showSnackBarMessage(context, state.msg,
                    isError: false);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image.network(widget.event.bannerImage),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.event.title!,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                // const SizedBox(height: ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDetailedWidget(
                        context,
                        "Description: ",
                        widget.event.description!,
                      ),
                      buildDetailedWidget(
                        context,
                        "About: ",
                        widget.event.about!,
                      ),
                      buildDetailedWidget(
                        context,
                        "Interests: ",
                        "${widget.event.skills!}",
                      ),
                      buildDetailedWidget(
                        context,
                        "Open Date: ",
                        "${widget.event.openDate!}",
                      ),
                      buildDetailedWidget(
                        context,
                        "Close Date: ",
                        "${widget.event.closeDate!}",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<ApplyEventCubit>()
                          .applyEvent(widget.event.id!);
                    },
                    child: const Text("Apply"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildDetailedWidget(BuildContext context, String title, content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ],
    );
  }
}
