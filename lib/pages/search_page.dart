import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pau_sosyal/language/locale_keys.g.dart';
import 'package:pau_sosyal/navigation/app_router.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List _allResult = [];

  List _resultList = [];
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    searchResultList();
  }

  searchResultList() {
    var showResults = [];
    if (_searchController.text != "") {
      for (var clientSnapShot in _allResult) {
        var name = clientSnapShot["name"].toString().toLowerCase();
        if (name.contains(_searchController.text.toLowerCase())) {
          showResults.add(clientSnapShot);
        }
      }
    } else {
      showResults = List.from(_allResult);
    }
    setState(() {
      _resultList = showResults;
    });
  }

  getClientStearm() async {
    var data = await FirebaseFirestore.instance
        .collection("Events")
        .orderBy("name")
        .get();
    setState(() {
      _allResult = data.docs;
    });
    searchResultList();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getClientStearm();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.search_title).tr(),
        leading: IconButton(
          onPressed: () {
            context.router.back();
          },
          icon: Image.asset(
            'assets/icons/ic_back.png',
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Image.asset(
                  'assets/icons/ic_search.png',
                  color: Theme.of(context).colorScheme.primary,
                ),
                hintText: LocaleKeys.search_searchHint.tr(),
                contentPadding: EdgeInsets.zero,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _resultList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = _resultList[index];
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  return GestureDetector(
                    onTap: () {
                      context.router.push(EventDetailRoute(data: data));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 1.5,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            _resultList[index]["name"],
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
