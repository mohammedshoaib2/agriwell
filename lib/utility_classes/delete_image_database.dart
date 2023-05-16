import 'package:firebase_storage/firebase_storage.dart';

class DeleteImageFromDataBase {
  final _fireCloud = FirebaseStorage.instance;

  Future<void> deleteImageFromDB(String url) async {
    Reference refrence = _fireCloud.refFromURL(url);

    try {
      await refrence.delete();
    } catch (e) {
      //
    }
  }
}
