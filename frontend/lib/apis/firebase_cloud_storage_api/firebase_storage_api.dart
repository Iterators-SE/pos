import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class CloudApi {
  Future<String> uploadPhoto(PickedFile imageFile) async {
    var url;

    if (imageFile != null) {
      var dateNow = DateTime.now().millisecondsSinceEpoch.toString();
      var ref = firebase_storage.FirebaseStorage.instance
          .refFromURL('gs://iterators-pos-photo-storage.appspot.com')
          .child('images')
          .child('/$dateNow.jpg');

      final metadata =
          firebase_storage.SettableMetadata(contentType: 'image/jpeg');

      var uploadTask =
          await ref.putData(await imageFile.readAsBytes(), metadata);
      url = await uploadTask.ref.getDownloadURL();
    } else {
      url =
          "https://region4.uaw.org/sites/default/files/styles/large_square/public/bio/10546i3dac5a5993c8bc8c_6.jpg?itok=Iv9bC2vD&c=2e7651912d133fd4368c0dce602cd839";
    }

    return url;
  }

  Future<String> uploadPdf(File pdfFile) async {
    var url;

    if (pdfFile != null) {
      var dateNow = DateTime.now().millisecondsSinceEpoch.toString();
      var ref = firebase_storage.FirebaseStorage.instance
          .refFromURL('gs://iterators-pos-photo-storage.appspot.com')
          .child('pdfs')
          .child('/$dateNow.jpg');

      final metadata =
          firebase_storage.SettableMetadata(contentType: 'application/pdf');

      var uploadTask = await ref.putData(await pdfFile.readAsBytes(), metadata);
      url = await uploadTask.ref.getDownloadURL();
    } else {
      throw "PDF didnt upload as expected";
      // url =
      //     "https://region4.uaw.org/sites/default/files/styles/large_square/public/bio/10546i3dac5a5993c8bc8c_6.jpg?itok=Iv9bC2vD&c=2e7651912d133fd4368c0dce602cd839";
    }

    return url;
  }
}
