import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternotepadgetx/Model/note_model.dart';
import 'package:flutternotepadgetx/Screens/note_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox("notes");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NoteScreen()
    );


  }

}

// class HomeActivity extends StatelessWidget{
//   const HomeActivity({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//     );
//
//   }
//
// }
