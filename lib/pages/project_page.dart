import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pau_sosyal/navigation/app_router.dart';
import 'package:pau_sosyal/services/firestore_services.dart';

@RoutePage()
class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
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
            stream: firestoreServices.getProject(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List projectsList = snapshot.data!.docs;
                return ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Theme.of(context).colorScheme.secondary,
                      );
                    },
                    itemCount: projectsList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = projectsList[index];
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            context.router.push(ProjectDetailRoute(data: data));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                data["image"],
                                fit: BoxFit.cover,
                                height: 172,
                                width: double.infinity,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                data["name"],
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
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
