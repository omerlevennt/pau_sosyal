import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pau_sosyal/navigation/app_router.dart';
import 'package:pau_sosyal/services/firestore_services.dart';

@RoutePage()
class JobPage extends StatefulWidget {
  const JobPage({super.key});

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  final FirestoreServices firestoreServices = FirestoreServices();
  Future<void> _refreshEvents() async {
    await Future.delayed(const Duration(seconds: 1));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshEvents,
        child: StreamBuilder<QuerySnapshot>(
            stream: firestoreServices.getJobs(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List projectsList = snapshot.data!.docs;
                return ListView.builder(
                    itemCount: projectsList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = projectsList[index];
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            context.router.push(JobDetailRoute(data: data));
                          },
                          child: Card(
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.7),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    data["title"],
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  Text(
                                    data["subtitle"],
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return const SizedBox.shrink();
              }
            }),
      ),
    );
  }
}
