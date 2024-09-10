import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_note/presentation/controllers/note_controller.dart';

import '../../../const/app_colors.dart';
import '../../widgets/custom_button_widget.dart';
import '../../widgets/custom_text_field_widget.dart';

class AddNoteScreen extends StatelessWidget {
  final NoteController _noteController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            customFormField(TextInputType.text, _noteController.titleController,
                count: 2,
                context, 'Title', (value) {
                  if (value.isEmpty) {
                    return 'This field can\'t be empty';
                  }
                },
            ),
            customFormField(TextInputType.text, _noteController.descriptionController,
                count: 2,
                maxLine: 6,
                context, 'Description', (value) {
                  if (value.isEmpty) {
                    return 'This field can\'t be empty';
                  }
                },
            ),
            const SizedBox(height: 20),
            customButton('Add Note', () {
              String title = _noteController.titleController.text;
              String description = _noteController.descriptionController.text;

              if (title.isNotEmpty && description.isNotEmpty) {
                _noteController.addNote(title, description);
                Get.back();
                context.go('/home');
                Get.snackbar('Success', 'Note added successfully!');
              } else {
                Get.snackbar('Error', 'Field can\'t be empty');
              }
              _noteController.titleController.clear();
              _noteController.descriptionController.clear();
            })
          ],
        ),
      ),
    );
  }

  AppBar get buildAppBar {
    return AppBar(
      title: const Text('Add Note'),
      backgroundColor: AppColors.appColor,
      foregroundColor: Colors.white,
      elevation: 3,
    );
  }
}