import 'package:event_buddy/models/all_events_response.dart';
import 'package:event_buddy/models/user_response_model.dart';
import 'package:event_buddy/network/locator.dart';
import 'package:event_buddy/presentation/login/login_page.dart';
import 'package:event_buddy/presentation/profile/cubit/profile_cubit.dart';
import 'package:event_buddy/utils/popup_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is ProfileFailure) {
              return Center(
                child: Text(state.msg),
              );
            } else if (state is ProfileSuccess) {
              final user = state.user.user!;
              final appliedEvents = state.user.user!.appliedJobs;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      children: [
                        Center(
                          child: Text(
                            "${user.username}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Center(
                            child: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatarImage ?? ""),
                          minRadius: 30,
                        )),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          user.type == "company"
                              ? "[ Event Manager ]"
                              : "[ Basic User ]",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    Column(
                      children: [
                        _titleWithBgColor("Basic Profile"),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            bottom: 5,
                          ),
                          child: Column(
                            children: [
                              _textWithIcon("${user.username}", Icons.person),
                              _textWithIcon(user.username ?? "", Icons.info),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        _titleWithBgColor("Private Information"),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            bottom: 5,
                          ),
                          child: Column(
                            children: [
                              _textWithIcon("${user.email}", Icons.email),
                              // _textWithIcon("${user.phone}", Icons.phone),
                              _textWithIcon("Male", Icons.male),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        _titleWithBgColor("Applied Events"),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            bottom: 5,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final event = appliedEvents![index];
                              return _buildAppliedEventCard(event);
                            },
                            itemCount: appliedEvents == null
                                ? 0
                                : appliedEvents.length,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        kPref.clear();
                        PopUpProvider.showSnackBarMessage(
                            context, "You are logged out!!",
                            isError: false);
                        setState(() {});
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginWidget()),
                            (route) => false);
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text("Sign Out"),
                    )
                  ],
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

Widget _titleWithBgColor(String title) => Container(
      height: 35,
      padding: const EdgeInsets.only(left: 20),
      width: double.infinity,
      color: Colors.grey,
      child: Center(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );

Widget _textWithIcon(String title, IconData icon) => Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 5),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );

Widget _buildAppliedEventCard(AppliedJob event) => Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Card(
        elevation: 3,
        child: ListTile(
          title: Text(
            "Event ID: ${event.job}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Applied Date: ${event.appliedDate}",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "Status: ${event.status}",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
