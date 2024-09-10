import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:keep_note/const/app_colors.dart';
import 'package:keep_note/presentation/controllers/auth_controller.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton,
      appBar: buildAppBar,
    );
  }

  FloatingActionButton get buildFloatingActionButton {
    return FloatingActionButton(
      onPressed: () {
        context.go('/addnote');
      },
      backgroundColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_add, size: 24, color: Colors.white),
          SizedBox(height: 4),
          Text(
            'Add Note',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  AppBar get buildAppBar {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: const Icon(Icons.note_alt_outlined, color: Colors.white, size: 34),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Tooltip(
            message: 'Logout',
            child: GestureDetector(
              onTap: ()async{
                await _authController.logout();
                Get.snackbar(
                  'Logged out',
                  'You have successfully logged out.',
                  snackPosition: SnackPosition.TOP,
                );
              },
              child: Container(
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.white
                  )
                ),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Center(
                    child: Text('Log Out', style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.appColor,
      elevation: 5.0,
    );
  }
}
