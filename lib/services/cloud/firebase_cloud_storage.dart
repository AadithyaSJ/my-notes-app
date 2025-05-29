import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learningdart/services/cloud/cloud_note.dart';
import 'package:learningdart/services/cloud/cloud_storage_constants.dart';
import 'package:learningdart/services/cloud/cloud_storage_exception.dart';

class FirebaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection("notes");

  Future<void> deleteNote({
    required String documentId
  }) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CloudNotDeleteNoteException();
    }
  }

  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    try {
      await notes.doc(documentId).update({textFieldName: text});
    } catch (e) {
      throw CloudNotUpdateNoteException();
    }
  }

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) => 
  notes.snapshots().map((event) => event.docs.map((doc) => CloudNote.fromSnapshot(doc))
  .where((note) => note.ownerUserId == ownerUserId));

  Future<Iterable<CloudNote>> getNotes({required String ownerUserId}) async {
    try {
      return await notes.where(
        ownerUserIdFieldName,
        isEqualTo: ownerUserId
      ).get()
      .then((value) => value.docs.map(
        (doc) {
          return CloudNote(
            documentId: doc.id,
            ownerUserId: ownerUserId as String,
            text: doc.data()[textFieldName] as String,
          );
        }
      ));
    } catch (error) {
      throw CloudNotGetAllNoteException();
    }
  }

    void createNewNote({required String ownerUserId}) async {
      notes.add({
        ownerUserIdFieldName: ownerUserId,
        textFieldName: '',
      }).catchError((error) {
        throw Exception('Could not create note: $error');
      });
    }

  static final FirebaseCloudStorage _shared = FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
  
}