import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/notification/notification_page.dart';
import 'package:pilot_bazar_admin/package/chatting/chat_font_screen.dart';
import 'package:pilot_bazar_admin/package/customer_care_service/customer_profuile_bar.dart';
import 'package:pilot_bazar_admin/package/customer_requirement_store/customer_personal_info.dart';
import 'package:pilot_bazar_admin/package/customer_requirement_store/input_fild.dart';
import 'package:pilot_bazar_admin/package/drawer/drawer_bool.dart';
import 'package:pilot_bazar_admin/profile/profile.dart';
import 'package:pilot_bazar_admin/re_usable_widget/re_usable_mother_widget.dart';
import 'package:pilot_bazar_admin/widget/confirm_next_button.dart';
import 'package:intl/intl.dart';

class CustomerBudgetInfo extends StatefulWidget {
  final ValueNotifier<ThemeMode> notifier;

  const CustomerBudgetInfo({super.key, required this.notifier});

  @override
  State<CustomerBudgetInfo> createState() => _CustomerBudgetInfoState();
}

class _CustomerBudgetInfoState extends State<CustomerBudgetInfo> {
  TextEditingController budgetFromController = TextEditingController();
  TextEditingController budgetToController = TextEditingController();
  TextEditingController readyBudgetFromController = TextEditingController();
  TextEditingController readyBudgetToController = TextEditingController();
  TextEditingController bankLoanAccountController = TextEditingController();
  TextEditingController selfPayAmountController = TextEditingController();
  TextEditingController clientIncomeSourceController = TextEditingController();
  TextEditingController clientCompanyTransactionController =
      TextEditingController();
  TextEditingController clientSeriousnessController = TextEditingController();
  TextEditingController carChangeFrequencyController = TextEditingController();
  TextEditingController purchaseDateController = TextEditingController();
  TextEditingController clientInstructionController = TextEditingController();
  TextEditingController dateAndTimeController = TextEditingController();
  @override
  void initState() {
    setState(() {});
    dateAndTimeController = TextEditingController(text: _getFormattedDate());
  }

  String _getFormattedDate() {
    DateTime now = DateTime.now();
    return DateFormat('dd-MM-yyyy').format(now);
  }

  String? dateTime;

  _printDateAndTime() {
    DateTime now = DateTime.now();
    String selectedDate = dateAndTimeController.text;
    String formattedTime = DateFormat('hh:mm:ss a').format(now);

    print('Selected Date and Present Time: $selectedDate $formattedTime');

    // Store the combined date and time in the 'dateTime' variable
    dateTime = '$selectedDate $formattedTime';
    setState(() {});
    print('date time in a variable');
    print(dateTime);
  }

  String? _selectedItem;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return ReUsableMotherWidget(
        isSingleChildScrollView: true,
        notifier: widget.notifier,
        children: [
          CustomerProfileBar(
            profileImagePath: 'assets/images/small_profile.png',
            message_icon_path: 'assets/icons/message_notification.png',
            drawer_icon_path: 'assets/icons/beside_message.png',
            onTapFunction: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            chatTap: () {
              print("notificaiton tap");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatFontScreen(
                            notifier: widget.notifier,
                          )));
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
              child: const Text(
                'Customer Requirement',
                style: small12Stylew500,
              ),
            ),
          ),
          const Text(
            "Customer Budget info ->",
            style: small14StyleW500,
          ),
          // ElevatedButton(onPressed: (){
          height10,
          Row(
            children: [
              Expanded(
                  child: CustomerRequiredTextFild(
                function: (dynamic value) {
                  print(value);
                },
                //  customerNameController: enginesFromController,
                hintText: 'budget form...',
                keyboardType: TextInputType.number,
                textFildController: budgetFromController,
              )),
              syncIconMethode(),
              Expanded(
                  child: CustomerRequiredTextFild(
                textFildController: budgetToController,
                function: (dynamic value) {
                  print(value);
                },
                //customerNameController: enginesToController,
                hintText: 'budget to...',
                keyboardType: TextInputType.number,
              )),
            ],
          ),
          height10,
          Row(
            children: [
              Expanded(
                  child: CustomerRequiredTextFild(
                function: (dynamic value) {
                  print(value);
                },
                //  customerNameController: enginesFromController,
                hintText: 'ready budget form...',
                keyboardType: TextInputType.number,
                textFildController: readyBudgetFromController,
              )),
              syncIconMethode(),
              Expanded(
                  child: CustomerRequiredTextFild(
                textFildController: readyBudgetToController,
                function: (dynamic value) {
                  print(value);
                },
                hintText: 'ready budget to...',
                keyboardType: TextInputType.number,
              )),
            ],
          ),
          height10,
          const Text(
            "Customer Lone info ->",
            style: small14StyleW500,
          ),
          height10,
          Row(
            children: [
              Expanded(child: customDropdown('--Interested for loan--')),
              width10,
              width5,
              Expanded(
                  child: CustomerRequiredTextFild(
                hintText: 'bank loan amount',
                //   labelText: 'bank loan amount',
                textFildController: bankLoanAccountController,
              )),
            ],
          ),
          height10,
          Row(
            children: [
              Expanded(
                  child: CustomerRequiredTextFild(
                hintText: 'self pay amount',
                //   labelText: 'bank loan amount',
                textFildController: selfPayAmountController,
              )),
              width10,
              Expanded(
                  child: CustomerRequiredTextFild(
                hintText: 'Client Income',
                textFildController: clientIncomeSourceController,
              )),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: size.width / 2.2),
            child: CustomerRequiredTextFild(
              function: (value) {
                print(value);
              },
              hintText: 'client company transaction',
              textFildController: clientCompanyTransactionController,
            ),
          ),
          height10,
          const Text("Performance Info ->", style: small14StyleW500),

          height10,
          Row(
            children: [
              Expanded(child: customDropdown('--client lavel---')),
              width10,
              Expanded(
                  child: CustomerRequiredTextFild(
                hintText: 'Client Seriousness',
                textFildController: clientSeriousnessController,
              )),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: CustomerRequiredTextFild(
                hintText: 'Car Change Frequency',
                textFildController: carChangeFrequencyController,
              )),
              width10,
              Expanded(
                child: TextField(
                  controller: dateAndTimeController,
                  readOnly: true,
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          const EdgeInsets.only(top: 12, bottom: 12, left: 20),
                      hintText: 'Purchase Date',
                      labelText: 'Purchase Date',
                      hintStyle: small12Stylew400,
                      labelStyle: small12Stylew400,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Color(0xFFEEEEEE))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.grey))),
                  style: small14StyleW500,
                  cursorColor: Colors.white,
                  onTap: () async {
                    // Open date picker when the text field is tapped
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );

                    if (selectedDate != null) {
                      setState(() {
                        dateAndTimeController.text =
                            DateFormat('dd-MM-yyyy').format(selectedDate);
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          height10,
          Row(
            children: [
              Expanded(child: customDropdown('--client location---')),
              width10,
              Expanded(
                  child: CustomerRequiredTextFild(
                hintText: 'Client Instruction',
                labelText: 'Client Instruction',
                textFildController: clientInstructionController,
              )),
            ],
          ),
          // CustomerRequiredTextFild(
          //   readOnly: true,
          //   textFildController: dateAndTimeController,
          // onTap: () async {
          //    DateTime? selectedDate = await showDatePicker(
          //       context: context,
          //       initialDate: DateTime.now(),
          //       firstDate: DateTime(2000),
          //       lastDate: DateTime(2101),
          //     );

          //     if (selectedDate != null) {
          //       setState(() {
          //         dateAndTimeController.text =
          //             DateFormat('dd-MM-yyyy').format(selectedDate);
          //       });
          //     }
          // },
          // ),

          SizedBox(
            height: size.height / 12,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerBudgetInfo(
                            notifier: widget.notifier,
                          )));
            },
            child: const Align(
              alignment: Alignment.bottomRight,
              child: ConfirmAndNextButton(
                width: 100,
                text: 'Confirm ',
                arrowOrPlus: '+',
              ),
            ),
          ),

          //   print(budgetFromController.text);
          //   print(budgetToController.text);
          // }, child: Text('Submit'))
        ]);
  }

  DropdownButtonFormField<String> customDropdown(String hintText) {
    return DropdownButtonFormField<String>(
      style: small12Stylew500,
      value: _selectedItem,
      decoration: InputDecoration(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
          hintText: hintText,
          labelText: hintText,
          hintStyle: small12Stylew400,
          labelStyle: small12Stylew400,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color(0xFFEEEEEE))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey))),
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
        child: const Icon(
          Icons.arrow_forward_ios,
          size: 11,
          color: dropdownIconColor,
        ),
      ),
    );
  }
}
