import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_styles.dart';

class MovieTypeTabBar extends StatefulWidget {
  const MovieTypeTabBar({super.key});

  @override
  State<MovieTypeTabBar> createState() => _MovieTypeTabBarState();
}

class _MovieTypeTabBarState extends State<MovieTypeTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      AppLocalizations.of(context)!.action,
      AppLocalizations.of(context)!.adventure,
      AppLocalizations.of(context)!.comedy,
      AppLocalizations.of(context)!.horror,
      AppLocalizations.of(context)!.fantasy,
      AppLocalizations.of(context)!.drama,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TabBar(
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        tabAlignment: TabAlignment.start,
        controller: _tabController,
        isScrollable: true,
        indicator: BoxDecoration(
          color: AppColors.yellowColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.yellowColor),
        ),
        dividerColor: AppColors.transparentColor,
        labelColor: AppColors.blackBgColor,
        unselectedLabelColor: AppColors.yellowColor,
        labelStyle: AppStyles.bold20Black,
        unselectedLabelStyle: AppStyles.bold20Yellow,
        tabs: categories.map((text) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.yellowColor),
            ),
            alignment: Alignment.center,
            child: Text(text),
          );
        }).toList(),
      ),
    );
  }
}
