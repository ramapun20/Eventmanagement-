import 'dart:convert';
import 'dart:developer';
import 'package:event_buddy/models/all_events_response.dart';
import 'package:event_buddy/models/user_response_model.dart';
import 'package:event_buddy/network/locator.dart';
import 'package:event_buddy/presentation/add_event/add_event_page.dart';
import 'package:event_buddy/presentation/cubit/all_event_cubit.dart';
import 'package:event_buddy/presentation/event_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAdmin = false;
  String companyId = "";

  @override
  void initState() {
    loadUser();
    super.initState();
  }

  loadUser() async {
    var userData = await kPref.getUser();
    log(userData!);
    var user = UserResponse.fromJson(json.decode(userData));
    isAdmin = user.user!.type == "Company";
    if (user.company != null) {
      companyId = "${user.company!.id}";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: isAdmin
          ? Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Text(
                      'Welcome to Event Buddy',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Create Event'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddEventPage(companyID: companyId),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          : Container(),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Events'),
      ),
      body: BlocBuilder<AllEventCubit, AllEventState>(
        builder: (context, state) {
          if (state is AllEventLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is AllEventFailure) {
            return Center(child: Text(state.msg));
          } else if (state is AllEventSuccess) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 8);
                  },
                  itemBuilder: (context, index) {
                    var events = state.data.data;
                    return EventCard(event: events![index]);
                  },
                  itemCount: state.data.data == null || state.data.data!.isEmpty
                      ? 0
                      : state.data.data!.length),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventForm(event: event),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Card(
          color: Colors.white,
          child: Column(
            children: [
              Text(
                event.title.toString(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              // Image.network(event.bannerImage),
              Text(
                event.description.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 40),
              Text(
                "Open Date: ${event.openDate}",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.green),
              ),
              Text(
                "Close Date: ${event.closeDate}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.red,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
