import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStogareService {
  Reference _firebaseStorageRef = FirebaseStorage.instance.ref();
  var uuid = Uuid();

  Future<String> profilResmiYukle(File resimDosyasi) async {
    try {
      UploadTask yukleme =
          _firebaseStorageRef.child("profilResimleri/${uuid.v4()}").putFile(resimDosyasi);
      TaskSnapshot snapshot = await yukleme;
      String yuklenenResimUrl = await snapshot.ref.getDownloadURL();
      return yuklenenResimUrl;
    } catch (e) {
      print("Resim Yüklemede Hata oluştu : " + e.toString());
      return null;
    }
  }
}
