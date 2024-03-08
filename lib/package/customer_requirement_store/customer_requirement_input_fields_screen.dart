import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_font_screen.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/package/customer_requirement_store/customer_required_textFild.dart';
import 'package:pilot_bazar_admin/profile/profile.dart';

class CustomerRequirementInputFilds extends StatefulWidget {
  const CustomerRequirementInputFilds({super.key});

  @override
  State<CustomerRequirementInputFilds> createState() =>
      _CustomerRequirementInputFildsState();
}

class _CustomerRequirementInputFildsState
    extends State<CustomerRequirementInputFilds> {
      TextEditingController customerNameController = TextEditingController();
      TextEditingController customerNameController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomerProfileBar(
              profileImagePath: 'assets/images/small_profile.png',
              NotificationIconPath: 'assets/icons/message_notification.png',
              onTapFunction: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              notificationTap: () {
                print("notificaiton tap");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatFontScreen()));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25,top: 5),
              child: Container(
                alignment: Alignment.center,
                height: 26,
                width: 144,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  border: Border.all(color: Color(0xFFFDF2F2)),
                ),
                child: Text('Customer Requirement',style: small10Stylew500,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25,top: 5),
              child: Text("Customer Personal info ->",style: small12Style,),
            ),
            CustmerRequiredTextFild(
              customerNameController: customerNameController,
              hintTextForCustomerNameController: 'Enter Customer Name',
            ),
            CustmerRequiredTextFild(
              function: (dynamic value) {
                print(value);
              },
              
              customerNameController: customerNameController2,
              hintTextForCustomerNameController: 'Enter Customer Name 2',
            ),
            TextFormField(
              controller: customerNameController,
              onChanged: filter
            ),


            IconButton(onPressed: (){
              print(customerNameController.text);
              print(customerNameController2.text);
            }, icon: Icon(Icons.add))
          ],
        ),
      ),
    ));
  }
  filter(String name){}
}
