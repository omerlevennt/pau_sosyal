import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pau_sosyal/language/locale_keys.g.dart';
import 'package:pau_sosyal/navigation/app_router.dart';

@RoutePage()
class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      physics: const NeverScrollableScrollPhysics(),
      routes: const [EventRoute(), ProjectRoute(), JobRoute(), SettingsRoute()],
      builder: (context, child, tabController) {
        return Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                          image: AssetImage('assets/icons/ic_app.png')),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    LocaleKeys.App_name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ).tr(),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    context.router.push(const SearchRoute());
                  },
                  icon: Image.asset(
                    'assets/icons/ic_search.png',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.router.push(const FavoritesRoute());
                  },
                  icon: Image.asset(
                    'assets/icons/ic_heart.png',
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      context.router.push(const NotiRoute());
                    },
                    icon: Image.asset(
                      'assets/icons/ic_bell.png',
                      color: Theme.of(context).colorScheme.primary,
                    )),
              ],
            ),
            body: child,
            bottomNavigationBar: BottomAppBar(
              color: Colors.transparent,
              elevation: 0,
              child: TabBar(
                  padding: EdgeInsets.zero,
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: tabController,
                  labelColor: Colors.black,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  splashFactory: InkSplash.splashFactory,
                  unselectedLabelColor: Colors.black,
                  tabAlignment: TabAlignment.fill,
                  splashBorderRadius: BorderRadius.circular(12),
                  tabs: [
                    Tab(
                        icon: Image.asset(
                      'assets/icons/ic_megaphone.png',
                      color: Theme.of(context).colorScheme.primary,
                    )),
                    Tab(
                        icon: Image.asset(
                      'assets/icons/ic_rocket.png',
                      color: Theme.of(context).colorScheme.primary,
                    )),
                    Tab(
                        icon: Image.asset(
                      'assets/icons/ic_briefcase.png',
                      color: Theme.of(context).colorScheme.primary,
                    )),
                    Tab(
                        icon: Image.asset(
                      'assets/icons/ic_flower.png',
                      color: Theme.of(context).colorScheme.primary,
                    )),
                  ]),
            ));
      },
    );
  }
}
