import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> imagePicker()
async {
  try{
    final xFile=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(xFile!=null) {

      return File(xFile.path);
    }
    print('\n\n\nobject\n\n');
    return null;
  }
      catch(e){
        print("\n\nasa\n"+e.toString());
    return null;
      }
}