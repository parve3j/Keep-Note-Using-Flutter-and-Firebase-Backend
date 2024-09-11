import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:keep_note/model/note_model.dart';

import '../../utils/style/app_style.dart';

class NoteController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  RxList<Note> note = <Note>[].obs;
  RxBool isLoading = true.obs;
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
    isLoading(true);
    try {
      var querySnapshot = await firestore.collection('note').where(
          'userId', isEqualTo: userId).get();
      note.clear();
      for (var doc in querySnapshot.docs) {
        note.add(Note.fromMap(doc.data()));
      }
    }catch(e) {
      Get.showSnackbar(AppStyles().failedSnacBar('Failed to fetch notes: $e'));
    }finally{
      isLoading(false);
    }
  }
  Future<void> deleteNote(String id) async{
    await firestore.collection('note').doc(id).delete();
    note.removeWhere((note)=>note.id==id);
  }
}
