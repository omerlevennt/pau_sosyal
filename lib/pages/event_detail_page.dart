import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:pau_sosyal/components/my_button.dart';
import 'package:pau_sosyal/language/locale_keys.g.dart';

@RoutePage()
class EventDetailPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const EventDetailPage({super.key, required this.data});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  void _shareEventDetails() {
    final eventDetails = '''
    **${widget.data["name"]}**

    ${LocaleKeys.events_description.tr()}: ${widget.data["detail"]}

    ${LocaleKeys.events_place.tr()}: ${widget.data["place"]}

    ${LocaleKeys.events_date.tr()}: ${widget.data["date"]}

    **#PAUSosyal #Etkinlik**
  ''';

    final message = 'Hey! Bu harika etkinliği keşfettim: $eventDetails';
    message.ext.share();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.router.back();
            },
            icon: Image.asset(
              'assets/icons/ic_back.png',
              color: Theme.of(context).colorScheme.primary,
            )),
        actions: [
          IconButton(
            onPressed: () => _shareEventDetails(),
            icon: Icon(
              Icons.share,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.data["image"],
                fit: BoxFit.cover,
                height: 172,
                width: double.infinity,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.data["name"],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                LocaleKeys.events_description,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.data["detail"],
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                LocaleKeys.events_place,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.data["place"],
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                LocaleKeys.events_date,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.data["date"],
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 1.5,
                  ),
                ),
                child: MyButton(
                  textColor: Theme.of(context).colorScheme.primary,
                  color: Colors.transparent,
                  text: "Yol Tarifi Al",
                  onTap: () async {
                    final String place = widget.data["place"];
                    place.ext.launchMaps();
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
