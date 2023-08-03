import 'package:whatsapp/exports.dart';

final firebaseStorageProvider = Provider((ref) =>
    FirebaseStorageRepository(firebaseStorage: FirebaseStorage.instance));

class FirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;
  FirebaseStorageRepository({
    required this.firebaseStorage,
  });
  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
