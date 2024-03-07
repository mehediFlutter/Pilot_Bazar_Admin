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
            height: 138,
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
                          Text("+8801969944400",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(height: 0),  overflow: TextOverflow.ellipsis,),
                          Text("Brand : Toyota",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(height: 0),  overflow: TextOverflow.ellipsis,),
                          Text("Budget : 850000 tk",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(height: 0),  overflow: TextOverflow.ellipsis,),
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
                          Text("Seriousness : 60%",
                              style: Theme.of(context).textTheme.bodySmall,  overflow: TextOverflow.ellipsis,),
                          Text("Level : VVIP",
                              style: Theme.of(context).textTheme.bodySmall,  overflow: TextOverflow.ellipsis,),
                          Text("Profession : Business Man",
                              style: Theme.of(context).textTheme.bodySmall,  overflow: TextOverflow.ellipsis,),
                          Text("Budget : 850000 tk",
                              style: Theme.of(context).textTheme.bodySmall,  overflow: TextOverflow.ellipsis,),
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
                        Text('Edition: Mode Premier',
                            style: small10Style),
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
}
