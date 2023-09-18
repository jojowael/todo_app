import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:project2/home/settings/theme_bottom_sheet.dart';
import 'package:project2/my_theme.dart';
import 'package:provider/provider.dart';

import '../../providers/app_config_provider.dart';
import 'language_bottom_sheet.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: provider.isDarkMode()
                ? Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: MyTheme.whiteColor)
                : Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showLanguageBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: MyTheme.whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appLanguage == 'en'
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: MyTheme.primaryLight),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: MyTheme.primaryLight,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            AppLocalizations.of(context)!.theme,
            style: provider.isDarkMode()
                ? Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: MyTheme.whiteColor)
                : Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showThemeBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: MyTheme.whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.isDarkMode()
                        ? AppLocalizations.of(context)!.dark
                        : AppLocalizations.of(context)!.light,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: MyTheme.primaryLight),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: MyTheme.primaryLight,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showThemeBottomSheet() {
    showModalBottomSheet(
        context: context, builder: ((context) => ThemeBottomSheet()));
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => LanguageBottomSheet());
  }
}
