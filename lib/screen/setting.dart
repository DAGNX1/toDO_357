import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/screen/widgets/custom_container_setting.dart';
import 'package:to_do/screen/widgets/custom_language_contanier.dart';
import 'package:to_do/screen/widgets/show_language_app.dart';
import 'package:to_do/screen/widgets/show_theme_app.dart';
import '../provider/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
                AppLocalizations.of(context)!.settings,
            style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 30,color:pro.themeMode==ThemeMode.light?Colors.black:Colors.white ),
          )),
          const SizedBox(
            height: 50,
          ),
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color:pro.themeMode==ThemeMode.light?Colors.black:Colors.white ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () {
                showLanguageApp(context);
              },
              child: CustomLanguageContainer()),
          const SizedBox(
            height: 30,
          ),
          Text(
            AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color:pro.themeMode==ThemeMode.light?Colors.black:Colors.white ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () {
                showThemeApp(context);
              },
              child: CustomThemeContainer()),
        ],
      ),
    );
  }

  void showLanguageApp(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return const ShowLanguageApp();
      },
    );
  }

  void showThemeApp(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      builder: (context) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ShowThemeApp());
      },
    );
  }
}
