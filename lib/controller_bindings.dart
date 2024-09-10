import 'package:get/get.dart';
import 'package:keep_note/presentation/controllers/auth_controller.dart';
import 'package:keep_note/presentation/controllers/note_controller.dart';


class ControllerBindings implements Bindings{
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(NoteController());
  }

}