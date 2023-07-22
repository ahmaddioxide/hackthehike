import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {

  //image picker
  final _picker = ImagePicker();
  File? _imageFile;

  bool showspinner = false;
  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if(pickedFile != null){
      _imageFile = File(pickedFile.path);
      setState(() {

      });

    }else{
      print("No Image Selected");
    }
  }

  //upload image
  Future<void> uploadImage() async {
    setState(() {
      showspinner = true;
    });
    var stream = new http.ByteStream(_imageFile!.openRead());
    stream.cast();
    var length = await _imageFile!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = new http.MultipartRequest("POST", uri);
    request.fields['title'] ="Static Title";
    var multipartFile = new http.MultipartFile('image', stream, length,);
    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
      setState(() {
        showspinner = false;
      });
    } else {
      print("Upload Failed");
      setState(() {
        showspinner = false;
      });
    }


  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload Image'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: _imageFile == null
                    ? const Text('Pick an image')
                    : Container(child: Image.file(
                  File(_imageFile!.path),
                  fit: BoxFit.cover,
                  height: 300,
                  width: 300,

                )),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  _pickImage();
                },
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 30,),
              ElevatedButton(
                onPressed: () {
                  uploadImage();
                },
                child: const Text('Upload Image'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
