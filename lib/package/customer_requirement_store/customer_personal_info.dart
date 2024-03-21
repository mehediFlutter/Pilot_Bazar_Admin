import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/notification/notification_page.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_font_screen.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/package/customer_requirement_store/customer_budget_info.dart';
import 'package:pilot_bazar_admin/package/customer_requirement_store/input_fild.dart';
import 'package:pilot_bazar_admin/profile/profile.dart';
import 'package:pilot_bazar_admin/re_usable_widget/re_usable_mother_widget.dart';
import 'package:pilot_bazar_admin/widget/confirm_next_button.dart';
import 'package:pilot_bazar_admin/widget/divider_with_circle.dart';

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
  TextEditingController mileageFormController = TextEditingController();
  TextEditingController mileageToController = TextEditingController();
  TextEditingController enginesFromController = TextEditingController();
  TextEditingController enginesToController = TextEditingController();
  String? _selectedItem;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ReUsableMotherWidget(isSingleChildScrollView: true, children: [
      CustomerProfileBar(
        profileImagePath: 'assets/images/small_profile.png',
        message_icon_path: 'assets/icons/message_notification.png',
        drawer_icon_path: 'assets/icons/beside_message.png',
        onTapFunction: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage()));
        },
        chatTap: () {
          print("notificaiton tap");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChatFontScreen()));
        },
      ),

      Align(
        alignment: Alignment.topRight,
        child: Container(
          alignment: Alignment.center,
          height: 38,
          width: 144,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            border: Border.all(color: searchBarBorderColor),
          ),
          child: Text(
            'Customer Requirement',
            style: small12Stylew500,
          ),
        ),
      ),
      Text(
        "Customer Personal info ->",
        style: small14StyleW500,
      ),
      height10,
      CustomerRequiredTextFild(
        textFildController: customerNameController,
        hintText: 'Enter Customer Name...',
      ),

      Row(
        children: [
          Expanded(
            child: CustomerRequiredTextFild(
              function: (dynamic value) {
                print(value);
              },
              textFildController: customerNameController2,
              hintText: 'Enter Customer Mobile...',
            ),
          ),
          width10,
          Expanded(
            child: CustomerRequiredTextFild(
              function: (dynamic value) {
                print(value);
              },
              textFildController: customerNameController2,
              hintText: 'Enter Customer email...',
            ),
          ),
        ],
      ),
      height5,
      height10,
      Text('Vehicle Info ->', style: small14StyleW500),
      height5,

      // TextFormField(
      //   controller: customerNameController,
      //   onChanged: filter
      // ),

      Row(
        children: [
          Expanded(child: customDropdown('--Select Brand--')),
          width10,
          width5,
          Expanded(child: customDropdown('--Select Body--')),
        ],
      ),
      height10,
      Row(
        children: [
          Expanded(child: customDropdown('--Select Model--')),
          width10,
          width5,
          Expanded(child: customDropdown('--Select Transmission--')),
        ],
      ),
      height10,
      Row(
        children: [
          Expanded(child: customDropdown('--Model Year--')),
          width10,
          width5,
          Expanded(child: customDropdown('--Select Availavle--')),
        ],
      ),
      height10,
      Row(
        children: [
          Expanded(child: customDropdown('--Select Edition--')),
          width10,
          width5,
          Expanded(child: customDropdown('--Select Fuel--')),
        ],
      ),
      height10,
      Row(
        children: [
          Expanded(child: customDropdown('--Select Condition--')),
          width10,
          width5,
          Expanded(child: customDropdown('--Select Registration--')),
        ],
      ),
      height10,
      Row(
        children: [
          Expanded(child: customDropdown('--Select Color--')),
          width10,
          width5,
          Expanded(child: customDropdown('--Select Grade--')),
        ],
      ),
      height10,
      Padding(
        padding: EdgeInsets.only(right: size.width / 2.15),
        child: customDropdown('--Select Color--'),
      ),
      height10,

      DividerWithCircle(),
      height10,
      Row(
        children: [
          Expanded(
              child: CustomerRequiredTextFild(
            function: (dynamic value) {
              print(value);
            },
            textFildController: mileageFormController,
            hintText: 'enter mileage form',
            keyboardType: TextInputType.number,
          )),
          syncIconMethode(),
          Expanded(
              child: CustomerRequiredTextFild(
            function: (dynamic value) {
              print(value);
            },
            textFildController: mileageToController,
            hintText: 'enter mileage to',
            keyboardType: TextInputType.number,
          )),
        ],
      ),
      Row(
        children: [
          Expanded(
              child: CustomerRequiredTextFild(
            function: (dynamic value) {
              print(value);
            },
            textFildController: enginesFromController,
            hintText: 'enter engines form',
            keyboardType: TextInputType.number,
          )),
          syncIconMethode(),
          Expanded(
              child: CustomerRequiredTextFild(
            function: (dynamic value) {
              print(value);
            },
            textFildController: enginesToController,
            hintText: 'enter engines to',
            keyboardType: TextInputType.number,
          )),
        ],
      ),
      const SizedBox(
        height: 30,
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CustomerBudgetInfo()));
        },
        child: ConfirmAndNextButton(
          width: 175,
          text: 'Confirm & Next',
          arrowOrPlus: '->',
        ),
      ),


    ]);
  }



  DropdownButtonFormField<String> customDropdown(String hintText) {
    return DropdownButtonFormField<String>(
      style: small12Stylew500,
      value: _selectedItem,
      decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
          hintText: hintText,
          hintStyle: small12Stylew400,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color(0xFFEEEEEE))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey))),
      onChanged: (String? value) {
        setState(() {
          _selectedItem = value;
        });
      },
      items:
          <String>['Item 1', 'Item 2', 'Item 3', 'Item 4'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      icon: Transform.rotate(
        angle: 90 * 3.1415927 / 180, // Convert degrees to radians
        child: Icon(
          Icons.arrow_forward_ios,
          size: 11,
          color: dropdownIconColor,
        ),
      ),
    );
  }

  filter(String name) {}
}
