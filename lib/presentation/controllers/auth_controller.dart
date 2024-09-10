import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keep_note/presentation/screens/auth/login_screen.dart';
import 'package:keep_note/presentation/screens/home_screen.dart';

import '../../utils/style/app_style.dart';


class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final box = GetStorage();

  signUp(name, email, password, context) async {
    AppStyles().progressDialog(context);
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user!.uid.isNotEmpty) {
        CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
        await collectionReference
            .doc(email)
            .set({'uid': credential.user?.uid, 'email': email, 'name': name});

        Map user = {'uid': credential.user?.uid, 'email': email, 'name': name};
        box.write('user', user);
        Get.back();
        Get.to(const HomeScreen());
        Get.showSnackbar(AppStyles().successSnacBar('SignUp successful'));
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      if (e.code == 'weak-password') {
        Get.showSnackbar(
            AppStyles().failedSnacBar('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        Get.showSnackbar(AppStyles()
            .failedSnacBar('The account already exists for that email.'));
      } else {
        Get.showSnackbar(AppStyles().failedSnacBar(e.message ?? 'Unknown error'));
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(AppStyles().failedSnacBar(e.toString()));
    }
  }
  login(email, password, context) async {
    AppStyles().progressDialog(context);
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user!.uid.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> doc) {
          if (doc.exists) {
            var data = doc.data();
            Map user = {
              'uid': data!['uid'],
              'email': data['email'],
              'name': data['name']
            };
            box.write('user', user);
            Get.back();
            Get.to(const HomeScreen());
            Get.showSnackbar(AppStyles().successSnacBar('Login successful'));
          } else {
            Get.back();
            Get.showSnackbar(AppStyles()
                .failedSnacBar('Document does not exist in the database.'));
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      Get.back();
      if (e.code == 'user-not-found') {
        Get.showSnackbar(
            AppStyles().failedSnacBar('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        Get.showSnackbar(AppStyles()
            .failedSnacBar('Wrong password provided for that user.'));
      } else {
        Get.showSnackbar(AppStyles().failedSnacBar(e.message ?? 'Unknown error'));
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(AppStyles().failedSnacBar(e.toString()));
    }
  }
  logout() async {
    await _auth.signOut();
    box.remove('user');
    Get.to(()=>LoginScreen());
  }
  var obscureText = true.obs;
  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }
}