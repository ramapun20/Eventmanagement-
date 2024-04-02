import 'package:event_buddy/presentation/home_page.dart';
import 'package:event_buddy/presentation/recommended/cubit/recommendation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendedPage extends StatefulWidget {
  const RecommendedPage({super.key});

  @override
  State<RecommendedPage> createState() => _RecommendedPageState();
}

class _RecommendedPageState extends State<RecommendedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        title: const Text("Recommended"),
      ),
      body: BlocBuilder<RecommendationCubit, RecommendationState>(
        builder: (context, state) {
          if (state is RecommendationLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is RecommendationFailure) {
            return Center(child: Text(state.msg));
          } else if (state is RecommendationSuccess) {
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final events = state.response.data![index];
                return EventCard(event: events.job!);
              },
              itemCount:
                  state.response.data == null ? 0 : state.response.data!.length,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
