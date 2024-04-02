import 'package:event_buddy/presentation/cubit/all_event_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text("Event Calendar"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              BlocBuilder<AllEventCubit, AllEventState>(
                builder: (context, state) {
                  if (state is AllEventSuccess) {
                    return EventCalendar(
                      calendarType: CalendarType.GREGORIAN,
                      calendarLanguage: 'en',
                      events: [
                        ...state.data.data!.map((event) {
                          DateTime parsedDateTime =
                              DateTime.parse(event.closeDate.toString());
                          return Event(
                            child: _eventChild(
                              "${event.title}",
                              "${event.description}",
                            ),
                            dateTime: CalendarDateTime(
                              year: parsedDateTime.year,
                              month: parsedDateTime.month,
                              day: parsedDateTime.day,
                              calendarType: CalendarType.GREGORIAN,
                            ),
                          );
                        }),
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text("No Events Found"),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _eventChild(String title, content) => Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              content,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
