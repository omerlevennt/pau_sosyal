import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pau_sosyal/language/locale_keys.g.dart';
import 'package:pau_sosyal/navigation/app_router.dart';
import 'package:pau_sosyal/services/firestore_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final FirestoreServices firestoreServices = FirestoreServices();
  List<String> favoriteEventIds = [];

  @override
  void initState() {
    super.initState();
    _getFavoriteEvents();
  }

  _getFavoriteEvents() async {
    final prefs = await SharedPreferences.getInstance();
    favoriteEventIds = prefs.getStringList('favoriteEvents') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.favorite_favorite).tr(),
        leading: IconButton(
            onPressed: () {
              context.router.back();
            },
            icon: Image.asset(
              'assets/icons/ic_back.png',
              color: Theme.of(context).colorScheme.primary,
            )),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: firestoreServices.getEvents(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final eventsList = snapshot.data!.docs;
              final filteredEvents = eventsList
                  .where((event) => favoriteEventIds.contains(event.id))
                  .toList();

              if (filteredEvents.isEmpty) {
                return Center(
                  child: const Text(LocaleKeys.favorite_noFavorites).tr(),
                );
              }

              return ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Theme.of(context).colorScheme.secondary,
                    );
                  },
                  itemCount: filteredEvents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = filteredEvents[index];
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
    );
  }
}
