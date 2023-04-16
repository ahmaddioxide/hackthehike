import 'package:flutter/material.dart';
import 'package:get/get.dart';


class QRcontroller extends GetxController{
   var questionBoxEnabled = false.obs;
    var result;



   getQuestion(){
     questionBoxEnabled.value = true;
     return Text("${result!.code}",style: const TextStyle(color: Colors.green,fontSize: 20));

   }

}