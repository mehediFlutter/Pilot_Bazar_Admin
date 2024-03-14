import 'package:flutter/material.dart';
import 'package:pilot_bazar_admin/const/color.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/product_&_item/item_details.dart';

class ItemClass extends StatefulWidget {
  final Map item;

  const ItemClass({super.key, required this.item});

  @override
  State<ItemClass> createState() => _ItemClassState();
}

class _ItemClassState extends State<ItemClass> {
  var RelativeRectclickPosition1;
  double? left;
  share() {
    print('I am share methode');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 25, top: 4, bottom: 4),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemDetails(item: widget.item)));
        },
        child: Material(
          // elevation: 1,

          borderRadius: BorderRadius.circular(10),
          child: Container(
            // height: 138,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Container(
                        height: 45,
                        width: 45,
                        child: Center(
                            child: Image.asset('assets/images/customer_1.png')),
                      ),
                    ),
                    width5,
                    width5,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item['name'],
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "+8801969944400",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(height: 0),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Brand : Toyota",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(height: 0),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Budget : 850000 tk",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(height: 0),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    width5,
                    width5,
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: horizontalLine,
                    ),
                    width5,
                    width5,
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Seriousness : 60%",
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Level : VVIP",
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Profession : Business Man",
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Budget : 850000 tk",
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 1.5,
                    color: Color(0xFFD9D9D9),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Model: X-Tral', style: small10Style),
                        Text('Model Year: 2017', style: small10Style),
                        Text('Edition: Mode Premier', style: small10Style),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Condition: New', style: small10Style),
                        Text('Fuel: CNG, OCT', style: small10Style),
                        Text(
                          'Color: Red',
                          style: small10Style,
                          overflow: TextOverflow.ellipsis,
                        ),
                        height10,
                        // GestureDetector(
                        //   onTapDown: (details) {
                        //     final RenderBox box =
                        //         context.findRenderObject() as RenderBox;
                        //     final topLeft = box.localToGlobal(Offset.zero);
                        //     final bottomRight = box.localToGlobal(
                        //         box.size.bottomRight(Offset.zero));
                        //     final position = details.localPosition;
                        //     final fromLTRB =
                        //         "${topLeft.dx.toStringAsFixed(2)}, "
                        //         "${topLeft.dy.toStringAsFixed(2)}, "
                        //         "${bottomRight.dx.toStringAsFixed(2)}, "
                        //         "${bottomRight.dy.toStringAsFixed(2)}";
                        //     // Show the position or use it as needed
                        //     print("Clicked Position (fromLTRB): $fromLTRB");
                        //   },
                        //   child: Text('position'),
                        // ),
                        PopupMenuButton(
                            child: Icon(Icons.share),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Send as Visitor',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print("hello im umuk");
                                      },
                                      child: shareButtom(context,
                                          "Taka, Link, Details, Image  "),
                                    ),
                                        SizedBox(width: 10),
                                    height10,
                                    InkWell(
                                      child: shareButtom(context,  "Taka, Link, Details"),
                                      onTap: () {
                                        print("I am  Taka, Link, Details");
                                        Navigator.pop(context);
                                      },
                                    ),
                                    height10,
                                    height10,
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Send as Media (মিডিয়া)',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    InkWell(
                                      child: shareButtom(context,  "All Images (শুধু ছবি)"),
                                      onTap: () {
                                        print("I am  Taka, Link, Details");
                                        Navigator.pop(context);
                                      },
                                    ),
                                    height10,
                                    InkWell(
                                        onTap: ()  {
                                          print("Onli image");
                                        Navigator.pop(context);
                                        },
                                        child:shareButtom(context, "Details (শুধু তথ্য)")),
                                  ],
                                ))
                              ];
                            }),
                        // IconButton(
                        //   onPressed: ()async {
                        //     showMenu(
                        //       context: context,
                        //       position: RelativeRect.fill,
                        //       items: [
                        //         PopupMenuItem(
                        //           child: Column(
                        //             mainAxisSize: MainAxisSize.min,
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: <Widget>[
                        //               Text("Send as Media"),
                        //               TextButton(
                        //                 onPressed: () {
                        //                   // Handle send button tap
                        //                   Navigator.pop(context);
                        //                 },
                        //                 child: Text("Send"),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     );
                        //   },
                        //   icon: Icon(Icons.more_vert),
                        // ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container shareButtom(BuildContext context, String name) {
    return Container(
      height: 25,
      padding: EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
          SizedBox(width: 10),
          green10R
        ],
      ),
    );
  }
  Icon green10R =   Icon(Icons.circle,color: Colors.green,size: 10,);

  name() {
    print("object");
  }
}
