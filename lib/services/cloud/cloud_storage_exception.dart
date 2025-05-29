import 'package:flutter/foundation.dart';

@immutable
class CloudStorageException implements Exception{
  const CloudStorageException();
}

class CloudNotCreateNoteException extends CloudStorageException {}
class CloudNotGetAllNoteException extends CloudStorageException {}
class CloudNotUpdateNoteException extends CloudStorageException {}
class CloudNotDeleteNoteException extends CloudStorageException {}
