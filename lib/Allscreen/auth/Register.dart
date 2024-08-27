import 'package:flutter/material.dart';
import 'package:gamestopup/AllimagesLocation.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:gamestopup/Controller/Provider/Profile_Provider.dart';
import 'package:gamestopup/Controller/registerSubmitBtnController.dart';
import 'package:gamestopup/Widget/login_register_textfield.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      body: Provider.of<HomeScreenProvider>(context, listen: false)
          .allItems
          .isEmpty
          ? Center(
        child: Image.asset(
          ImagesLocation.logo,
          height: 150,
          width: 150,
        ),
      )
          : Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 15.0 : 20.0,
              ),
              child: Consumer<ProfileProvider>(
                builder: (context, value, child) => SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.app_registration,color: Colors.green,size: 80,),
                      const Text("রেজিস্ট্রেশন করুন"),
                      loginRegiField(value.nameController, 'Your Name',
                          TextInputType.text,Icons.person),
                      const SizedBox(height: 10),
                      loginRegiField(value.phoneController,
                          'Mobile Number', TextInputType.number,Icons.phone),
                      const SizedBox(height: 10),
                      loginRegiField(value.passController, 'Create a new Password',
                          TextInputType.text,Icons.lock),
                      const SizedBox(height: 25),
                      value.loading
                          ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () async {
                          clickRegisterBtnLogic(context, value,
                              "Provide correct number and name");
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                          : const Center(
                        child: CircularProgressIndicator(),
                      ),
                      const SizedBox(height: 25),
                      FittedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                              style: TextStyle(fontSize: 17),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 17),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}

