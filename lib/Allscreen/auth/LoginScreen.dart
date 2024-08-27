import 'package:flutter/material.dart';
import 'package:gamestopup/Allscreen/auth/Register.dart';
import 'package:gamestopup/Controller/Provider/Profile_Provider.dart';
import 'package:gamestopup/Controller/registerSubmitBtnController.dart';
import 'package:gamestopup/Widget/login_register_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 15.0 : 20.0,
      ),
      child: Consumer<ProfileProvider>(
        builder: (context, value, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.lock,size: 70,color: Colors.green,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Text("লাপনার একাউন্ট থাকলে লগইন করুন",style: TextStyle(fontSize: 16),),
            ),
            const SizedBox(height: 10),
            loginRegiField(value.phoneController, 'Phone Number',
                TextInputType.number,Icons.phone),
            const SizedBox(height: 10),
            loginRegiField(value.passController, 'Password:',
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
                clickLoginBtnLogic(
                    context, value, "সঠিক ফোন এবং পাসওয়ার্ড দিন");
              },
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            )
                : const Center(
              child: CircularProgressIndicator(),
            ),
            const SizedBox(height: 35),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "নতুন একাউন্ট করুন ",
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      )),
                  child: const Text(
                    "Create an Account",
                    style: TextStyle(color: Colors.red, fontSize: 17),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15,),
          ],
        ),
      ),
    );
  }
}
