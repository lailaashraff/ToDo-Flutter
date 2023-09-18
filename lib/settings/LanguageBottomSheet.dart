import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../my_theme.dart';
import '../provider/app_config_provider.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
            onTap: () {
              provider.changeLanguage('en');
            },
            child: provider.appLanguage == 'en'
                ? getSelectedItem(AppLocalizations.of(context)!.english)
                : getUnselectedItem(AppLocalizations.of(context)!.english)),
        InkWell(
            onTap: () {
              provider.changeLanguage('ar');
            },
            child: provider.appLanguage == 'ar'
                ? getSelectedItem(AppLocalizations.of(context)!.arabic)
                : getUnselectedItem(AppLocalizations.of(context)!.arabic)),
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
          Icon(Icons.check, size: 25, color: MyTheme.primaryLight),
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
