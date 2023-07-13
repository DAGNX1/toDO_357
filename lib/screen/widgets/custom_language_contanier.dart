import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/style/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../provider/my_provider.dart';

class CustomLanguageContainer extends StatelessWidget {
  const CustomLanguageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primaryColor,
          )),
      child: Text(
      pro.langcode=="en"?AppLocalizations.of(context)!.english:AppLocalizations.of(context)!.arabic,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColors.primaryColor),
      ),
    );
  }
}
