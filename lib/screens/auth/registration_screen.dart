import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTextFromFild(
                myController: nameController,
                hintText: "Enter Name",
                validatorText: "Please Emter Name",
              ),
              height10,
              MyTextFromFild(
                myController: phoneNumberController,
                hintText: "Enter Phone Number",
                validatorText: "Please Enter Phone Number",
              ),
              height10,
              MyTextFromFild(
                  myController: companyNameController,
                  hintText: "Company Name",
                  validatorText: "Please Company Name"),
              height10,
              height10,
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          return null;
                        }
                      },
                      child: const Text("Register")))
            ],
          ),
        ),
      ),
    ));
  }
}

class MyTextFromFild extends StatelessWidget {
  final TextEditingController myController;
  final String hintText;
  final String validatorText;
  const MyTextFromFild({
    super.key,
    required this.hintText,
    required this.validatorText,
    required this.myController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      cursorColor: Colors.black,
      cursorWidth: 1,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return validatorText;
        }
        return null;
      },
    );
  }
}
