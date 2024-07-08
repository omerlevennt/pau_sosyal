import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pau_sosyal/components/my_button.dart';
import 'package:pau_sosyal/language/locale_keys.g.dart';
import 'package:pau_sosyal/model/onboard_model.dart';
import 'package:pau_sosyal/navigation/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  List<OnBoardModel> onBoardItems = [];

  int currentIndex = 0;

  void changeCurrentIndex(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  @override
  void initState() {
    super.initState();
    onBoardItems
      ..add(
        OnBoardModel(
          title: LocaleKeys.onboard_first_title,
          desc: LocaleKeys.onboard_first_desc,
          image: Image.asset("assets/icons/img_first_onboard.png"),
        ),
      )
      ..add(
        OnBoardModel(
          title: LocaleKeys.onboard_second_title,
          desc: LocaleKeys.onboard_second_desc,
          image: Image.asset("assets/icons/img_second_onboard.png"),
        ),
      )
      ..add(
        OnBoardModel(
          title: LocaleKeys.onboard_third_title,
          desc: LocaleKeys.onboard_third_desc,
          image: Image.asset("assets/icons/img_third_onboard.png"),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            Expanded(flex: 5, child: _buildPageView()),
            Expanded(
              flex: 2,
              child: _RowFooter(currentIndex: currentIndex),
            ),
            const Expanded(
              flex: 1,
              child: SizedBox(),
            )
          ],
        ),
      ),
    );
  }

  PageView _buildPageView() {
    return PageView.builder(
      itemCount: onBoardItems.length,
      onPageChanged: changeCurrentIndex,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Expanded(flex: 5, child: onBoardItems[index].image),
            _ColumnDescription(model: onBoardItems[index]),
          ],
        );
      },
    );
  }
}

class _ColumnDescription extends StatelessWidget {
  const _ColumnDescription({
    required this.model,
  });

  final OnBoardModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
            child: Text(
          model.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ).tr()),
        const SizedBox(
          height: 10,
        ),
        Text(
          model.desc,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.primary,
          ),
        ).tr(),
      ],
    );
  }
}

class _RowFooter extends StatelessWidget {
  Future<void> _saveIntroductionSeen() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('hasSeenIntroduction', true);
  }

  const _RowFooter({
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _IndicatorCircle(currentIndex: currentIndex),
        ),
        MyButton(
          onTap: () {
            _saveIntroductionSeen();
            context.router.replace(const AuthRoute());
          },
          text: LocaleKeys.onboard_navigation_start,
          color: Colors.blue,
          textColor: Colors.white,
        ),
      ],
    );
  }
}

class _IndicatorCircle extends StatelessWidget {
  const _IndicatorCircle({
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return _OnBoardCircle(
          isSelected: currentIndex == index,
        );
      },
    );
  }
}

class _OnBoardCircle extends StatelessWidget {
  const _OnBoardCircle({
    required this.isSelected,
  });
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: CircleAvatar(
        backgroundColor: Theme.of(context)
            .colorScheme
            .primary
            .withOpacity(isSelected ? 1 : 0.2),
        radius: isSelected ? 7 : 5,
      ),
    );
  }
}
