import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../my_theme.dart';
import '../provider/app_config_provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {
            provider.changeTheme(ThemeMode.dark);
          },
          child: provider.isDarkMode()
              ? getSelectedItem(AppLocalizations.of(context)!.darkMode)
              : getUnselectedItem(AppLocalizations.of(context)!.darkMode),
        ),
        InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.light);
            },
            child: provider.isDarkMode()
                ? getUnselectedItem(AppLocalizations.of(context)!.lightMode)
                : getSelectedItem(AppLocalizations.of(context)!.lightMode)),
      ],
    );
  }

  Widget getSelectedItem(String text) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: Theme
                .of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: MyTheme.primaryLight),
          ),
          Icon(
            Icons.check,
            size: 25,
            color: MyTheme.primaryLight,
          )
        ],
      ),
    );
  }

  Widget getUnselectedItem(String text) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: Theme
            .of(context)
            .textTheme
            .titleMedium,
      ),
    );
  }
}
