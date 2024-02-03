import 'package:flutternotepadgetx/Model/note_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class NoteController extends GetxController{

  final Box box = Hive.box("notes");

  void createNote(NoteModel note){
     box.add(note);


  }

  void UpdateNote(NoteModel note ,int index){
      box.putAt(index, note);
  }

  void deleteNote(int index){
    box.deleteAt(index);

  }

}