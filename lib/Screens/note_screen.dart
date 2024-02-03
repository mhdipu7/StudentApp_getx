import 'package:flutter/material.dart';
import 'package:flutternotepadgetx/Controllers/note_controller.dart';
import 'package:flutternotepadgetx/Model/note_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteScreen extends StatelessWidget {
   NoteScreen({super.key});

Color browncolor = Colors.brown;
TextEditingController idclt = TextEditingController();
  TextEditingController nameclt = TextEditingController();
  TextEditingController depclt = TextEditingController();

   NoteController noteController = Get.put(NoteController());

   final Box box = Hive.box("notes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List App"),
        backgroundColor:Colors.blueAccent,
        elevation: 2.0,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showDialogue(context);
        },

        child: Icon(Icons.add),
        backgroundColor: browncolor,

      ),
      body: GetBuilder<NoteController>(builder: (_){
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ValueListenableBuilder(
            valueListenable:box.listenable(),
            builder: (context, box, child) {
              return ListView.builder(
                shrinkWrap: true,
                  itemCount: box.keys.length,
                  itemBuilder: (context,index){
                  NoteModel note = box.getAt(index);

                    return Card(
                      child: ListTile(
                        leading: Text(
                          note.id
                        ),
                        title: Text(note.name),
                        subtitle: Text(note.department),

                        trailing: Container(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){
                                  _showupdateDialogue(context, index);
                                },
                                child: Icon(Icons.edit),
                              ),
                              InkWell(
                                onTap: (){
                                  noteController.deleteNote(index);

                                },
                                child: Icon(Icons.delete, color: Colors.black,),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          ),
        );
      },),

    );
  }

   _showupdateDialogue(BuildContext context,int index){
     return showDialog(context: context, builder: (_){

       return Center(
         child: SingleChildScrollView(
           child: AlertDialog(
             content: Column(
               children: [
                 TextField(
                   controller: idclt,
                   decoration: InputDecoration(
                       hintText: 'Student Id'
                   ),
                 ),
                 SizedBox(height: 10,),
                 TextField(
                   controller: nameclt,
                   decoration: InputDecoration(
                       hintText: 'Student Name'
                   ),
                 ),
                 SizedBox(height: 10,),
                 TextField(
                   controller: depclt,
                   decoration: InputDecoration(
                       hintText: 'Student Depepartment'
                   ),
                 )
               ],
             ),
             actions: [
               ElevatedButton(onPressed: (){
                 Navigator.pop(context);
               }, child: Text("cancel",style:TextStyle(
                 color: Colors.white,
               ),
               ),
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.deepOrange,
                 ),),
               ElevatedButton(onPressed: (){
                 noteController.UpdateNote(NoteModel(idclt.text, nameclt.text, depclt.text),index);
                 Navigator.pop(context);
               }, child: Text("Update",style: TextStyle(
                 color: Colors.white,
               ),
               ),
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.deepOrange,
                 ),
               ),
             ],
           ),
         ),
       );
     }
     );

   }






  _showDialogue(BuildContext context){
    return showDialog(context: context, builder: (_){

       return Center(
         child: SingleChildScrollView(
           child: AlertDialog(
             content: Column(
               children: [
                 TextField(
                   controller: idclt,
                   decoration: InputDecoration(
                     hintText: 'Student Id'
                   ),
                 ),
                 SizedBox(height: 10,),
                 TextField(
                   controller: nameclt,
                   decoration: InputDecoration(
                       hintText: 'Student Name'
                   ),
                 ),
                 SizedBox(height: 10,),
                 TextField(
                   controller: depclt,
                   decoration: InputDecoration(
                       hintText: 'Student Depepartment'
                   ),
                 )
               ],
             ),
             actions: [
               ElevatedButton(onPressed: (){
                 Navigator.pop(context);
               }, child: Text("cancel",style:TextStyle(
                 color: Colors.white,
               ),
               ),
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.deepOrange,
                 ),),
               ElevatedButton(onPressed: (){
                noteController.createNote(NoteModel(idclt.text, nameclt.text, depclt.text));
                Navigator.pop(context);
               }, child: Text("Submit",style: TextStyle(
                 color: Colors.white,
               ),
                 ),
                 style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.deepOrange,
               ),
               ),
             ],
           ),
         ),
       );
    }
    );

  }

}



