import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pau_sosyal/navigation/app_router.dart';
import 'package:pau_sosyal/services/firestore_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final FirestoreServices firestoreServices = FirestoreServices();
  bool isFavorite = false;
  final _prefs = SharedPreferences.getInstance();
  List<String> favoriteEventIds = [];

  @override
  void initState() {
    super.initState();
    _getFavoriteEvents();
  }

  _getFavoriteEvents() async {
    final prefs = await _prefs;
    favoriteEventIds = prefs.getStringList('favoriteEvents') ?? [];
  }

  _toggleFavorite(String eventId) async {
    final prefs = await _prefs;
    if (favoriteEventIds.contains(eventId)) {
      favoriteEventIds.remove(eventId);
    } else {
      favoriteEventIds.add(eventId);
    }
    prefs.setStringList('favoriteEvents', favoriteEventIds);
    setState(() {
      isFavorite = favoriteEventIds.contains(eventId);
    });
  }

  Future<void> _refreshEvents() async {
    await Future.delayed(const Duration(seconds: 1));
    isFavorite = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshEvents,
        child: StreamBuilder<QuerySnapshot>(
            stream: firestoreServices.getEvents(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List eventsList = snapshot.data!.docs;

                return ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Theme.of(context).colorScheme.secondary,
                      );
                    },
                    itemCount: eventsList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = eventsList[index];
                      String eventId = document.id;
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            context.router.push(EventDetailRoute(data: data));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Image.network(
                                    data["image"],
                                    fit: BoxFit.cover,
                                    height: 172,
                                    width: double.infinity,
                                  ),
                                  Positioned(
                                    right: 10.0,
                                    top: 10.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        borderRadius: BorderRadius.circular(90),
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          favoriteEventIds.contains(eventId)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        onPressed: () =>
                                            _toggleFavorite(eventId),
                                      ),
                                    ),
                                  ),
                                ],
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
