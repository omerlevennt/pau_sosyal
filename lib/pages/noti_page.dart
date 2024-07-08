import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pau_sosyal/language/locale_keys.g.dart';
import 'package:pau_sosyal/services/firestore_services.dart';

@RoutePage()
class NotiPage extends StatefulWidget {
  const NotiPage({super.key});

  @override
  State<NotiPage> createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  List<RemoteMessage> _messages = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      setState(() {
        _messages = [..._messages, message];
      });

      try {
        await _addMessageToFirestore(message);
      } catch (error) {
        if (kDebugMode) {
          print('Error adding message to Firestore: $error');
        }
      }
    });
  }

  Future<void> _addMessageToFirestore(RemoteMessage message) async {
    final notificationData = {
      'title': message.notification?.title ?? "",
      'body': message.notification?.body ?? "",
      'sentTime': message.sentTime?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
    };

    final collectionRef = _firestore.collection('notifications');
    await collectionRef.add(notificationData);
  }

  @override
  Widget build(BuildContext context) {
    final FirestoreServices firestoreServices = FirestoreServices();
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.notifications_title).tr(),
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
        stream: firestoreServices.getNoti(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notisList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: notisList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = notisList[index];
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                int timeStamp = data["sentTime"];
                DateTime dateTime =
                    DateTime.fromMillisecondsSinceEpoch(timeStamp);
                String formattedDate =
                    DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 1.5,
                      ),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/icons/ic_badge.png',
                        color: const Color(0xff2952E4),
                      ),
                      title: Text(
                        data["title"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            data["body"],
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                formattedDate,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
