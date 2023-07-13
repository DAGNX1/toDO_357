
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/provider/my_provider.dart';
import 'package:to_do/screen/login_screen.dart';
import 'package:to_do/screen/setting.dart';
import 'package:to_do/screen/widgets/show_add_bottom_sheet.dart';
import 'package:to_do/style/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'task_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  static const String routeName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
int Index =0;
List<Widget>tabs=[const TaskScreen(),SettingScreen()];
  @override
  Widget build(BuildContext context) {
    var prov=Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
          title: Text(
      "      ${AppLocalizations.of(context)!.appTitle}        ${prov.userModel?.name}",
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.white),
      ),
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          }, icon: Icon(Icons.login_outlined))
        ],
      
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: () {
     ShowAddBootomSheet(context);
      },
      shape: StadiumBorder(side: BorderSide(color: Colors.white)),
      child: const Icon(Icons.add,
          size: 30,
      ),
      ),
      bottomNavigationBar: BottomAppBar(
        color:prov.themeMode==ThemeMode.light?Colors.white:AppColors.DarkColor ,
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex: Index,
            onTap: (value){
              Index=value;
              setState(() {
              });
            },
            iconSize: 30, items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
        ]),
      ),
      body: tabs[Index],
    );
  }
}
void ShowAddBootomSheet(BuildContext context){
   showModalBottomSheet(context: context,
       isScrollControlled: true,
       builder: (context){
   return Padding(
     padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
     child: showAddBootomSheet(),
   );
  });
}