import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:keep_note/model/note_model.dart';

class NoteController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  var note = <Note>[].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> addNote(String title, String description) async {
    String? userId = firebaseAuth.currentUser?.uid;
    if (userId == null) return;
    String noteId = firestore.collection('note').doc().id;
    Note newNote = Note(
      id: noteId,
      title: title,
      description: description,
      userId: userId,
    );
    await firestore.collection('note').doc(noteId).set(newNote.toMap());
    note.add(newNote);
  }
  void getNote()async{
    String? userId= firebaseAuth.currentUser?.uid;
    if(userId==null) return;

    var querySnapshot =  await firestore.collection('note').where('userId', isEqualTo: userId).get();
    note.clear();
    querySnapshot.docs.forEach((doc){
      note.add(Note.fromMap(doc.data()));
    });
  }
  Future<void> deleteNote(String id) async{
    await firestore.collection('note').doc(id).delete();
    note.removeWhere((note)=>note.id==id);
  }
}
