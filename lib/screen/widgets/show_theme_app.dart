import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../provider/my_provider.dart';

class ShowThemeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    prov.changeTheme(ThemeMode.light);
                  },
                  child: Text(    AppLocalizations.of(context)!.light,
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                          color: prov.themeMode == ThemeMode.light ?Colors.orange:Colors.white)),
                ),
                Spacer(),
                Icon(Icons.done,color: prov.themeMode == ThemeMode.light ?Colors.orange:Colors.white),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                prov.changeTheme(ThemeMode.dark);
              },
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.dark,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge?.copyWith(color: prov.themeMode == ThemeMode.light ?Colors.black:Colors.orange),
                  ),
                  const Spacer(),
                  Icon(Icons.done,color: prov.themeMode == ThemeMode.light ?Colors.black:Colors.orange),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
