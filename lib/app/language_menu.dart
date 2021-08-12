import 'package:event_app/app/top_level_providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum LocaleCode {
  en,
  tr,
  de,
}

class LanguageMenu extends StatefulWidget {
  const LanguageMenu({Key? key}) : super(key: key);

  @override
  _LanguageMenuState createState() => _LanguageMenuState();
}

class _LanguageMenuState extends State<LanguageMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<LocaleCode>(
      onSelected: (LocaleCode locale) {
        int len = locale.toString().length;
        String code = locale.toString().substring(len - 2, len);
        context.read<LocaleProvider>().setLocale(Locale(code));
      },
      icon: Icon(Icons.language),
      itemBuilder: (context) => <PopupMenuEntry<LocaleCode>>[
        PopupMenuItem(
          child: PopupMenuItem(
            value: LocaleCode.en,
            child: Text(AppLocalizations.of(context)!.english),
          ),
        ),
        PopupMenuItem(
          child: PopupMenuItem(
            value: LocaleCode.tr,
            child: Text(AppLocalizations.of(context)!.turkish),
          ),
        ),
        PopupMenuItem(
          child: PopupMenuItem(
            value: LocaleCode.de,
            child: Text(AppLocalizations.of(context)!.german),
          ),
        ),
      ],
    );
  }
}
