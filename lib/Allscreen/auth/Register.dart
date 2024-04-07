import 'package:flutter/material.dart';
import 'package:gamestopup/AllimagesLocation.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:gamestopup/Controller/Provider/Profile_Provider.dart';
import 'package:gamestopup/Controller/registerSubmitBtnController.dart';
import 'package:gamestopup/Widget/BackgroundWidget.dart';
import 'package:gamestopup/Widget/login_register_textfield.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<HomeScreenProvider>(context, listen: false)
              .allItems
              .isEmpty
          ? Center(
              child: Image.asset(
              ImagesLocation.logo,
              height: 150,
              width: 150,
            ))
          : BackgroundWidget(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Consumer<ProfileProvider>(
                builder: (context, value, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Image.asset(ImagesLocation.myLogo, height: 130),
                    loginRegiField(value.nameController, 'আপনার নামঃ',
                        TextInputType.text),
                    const SizedBox(
                      height: 10,
                    ),
                    loginRegiField(value.phoneController,
                        'আপনার মোবাইল নাম্বারঃ', TextInputType.number),
                    const SizedBox(
                      height: 10,
                    ),
                    loginRegiField(value.passController, 'Password:',
                        TextInputType.text),
                    const SizedBox(
                      height: 25,
                    ),
                    value.loading
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                backgroundColor: Colors.green,
                                minimumSize: const Size(double.infinity, 50)),
                            onPressed: () async {
                              clickRegisterBtnLogic(
                                  context, value, "সঠিক নাম্বার এবং নাম দিন");
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                    const SizedBox(
                      height: 25,
                    ),
                    FittedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("আপনার আগের একাউন্টে লগইন করুন",
                              style: TextStyle(fontSize: 17)),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 17),
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
    );
  }
}
