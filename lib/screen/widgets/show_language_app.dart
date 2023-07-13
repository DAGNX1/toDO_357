import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../provider/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ShowLanguageApp extends StatelessWidget {
  const ShowLanguageApp({super.key});

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyProvider>(context);
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    prov.changeLang("en");
                  },
                  child: Text(AppLocalizations.of(context)!.english,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                          color:prov.langcode=="en" ?Colors.orange:Colors.white)),
                ),
                Spacer(),
                Icon(Icons.done, color:prov.langcode=="en" ?Colors.orange:Colors.white),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                prov.changeLang("ar");
              },
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.arabic,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge?.copyWith(color:prov.langcode=="ar" ?Colors.orange:Colors.white),
                  ),
                  const Spacer(),
                  Icon(Icons.done,color:prov.langcode=="ar" ?Colors.orange:Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
