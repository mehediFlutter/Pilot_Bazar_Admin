import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pilot_bazar_admin/const/const_radious.dart';
import 'package:pilot_bazar_admin/package/chatting/select_send_documents/upload_image.dart';
import 'package:pilot_bazar_admin/widget/urls.dart';

class DocumentsAddIcon extends StatefulWidget {
 final Function(XFile?) onImageSelected;

  const DocumentsAddIcon({
    super.key, required this.onImageSelected,
   
  });

  @override
  State<DocumentsAddIcon> createState() => _DocumentsAddIconState();
}

class _DocumentsAddIconState extends State<DocumentsAddIcon> {
  @override
  Widget build(BuildContext context) {
    InkWell accessoriesPick(Function() onTap, String path, name) {
      return InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Image.asset(
                path,
                width: 40,
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ));
    }

    return PopupMenuButton(
      child: Container(
        margin: EdgeInsets.only(left: 20),
        height: 20,
        width: 20,
        decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 17,
        ),
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  accessoriesPick(() async {
                    pickImageFromGallery();
                    if (selectedImage != null) {
                      Uint8List bytes = await selectedImage!.readAsBytes();
                      UploadApiImage()
                          .uploadImage(bytes, selectedImage!.name)
                          .then((value) {
                        setState(() {
                          print("Upload successfully ${value.toString()}");
                        });
                      }).onError((error, StackTrace) {
                        print(error.toString());
                      });
                    }
                    Navigator.pop(context);
                  }, '$iconsPath/image.png', 'Image'),
                  width10,
                  accessoriesPick(() {}, '$iconsPath/camera.jpg', 'Camera'),
                ],
              ),
              height20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  accessoriesPick(() {}, '$iconsPath/video.png', 'Video'),
                  width10,
                  accessoriesPick(() {}, '$iconsPath/file.png', 'File'),
                ],
              ),
              height20,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  width10,

                  accessoriesPick(() {
                    print("Audio pressed ");
                  }, '$iconsPath/audio.jpg', 'Audio'),

                  //  accessoriesPick(() {}, '$iconsPath/file.png','file'),
                ],
              ),
            ],
          ))
        ];
      },
    );
  }

  XFile? selectedImage;
  Future pickImageFromGallery() async {
    XFile? returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedImage = returnedImage;
    });
    // widget.onImagesSelected(selectedImage);
  }
}
