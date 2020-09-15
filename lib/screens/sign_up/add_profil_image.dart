import 'dart:io';
import 'package:aptus/screens/player/home.dart';
import 'package:image/image.dart' as Im;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:aptus/services/current_user_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

///we need to add permission for IOS

class ImageCapture extends StatefulWidget {
  createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  /// Active image file
  File _imageFile;

  /// Cropper plugin

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
      androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.blueAccent,
          toolbarWidgetColor: Colors.white,
          toolbarTitle: 'Crop It'),
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.photo_camera,
              size: 30,
            ),
            onPressed: () => _pickImage(ImageSource.camera),
            color: Colors.blue,
          ),
          IconButton(
            icon: Icon(
              Icons.photo_library,
              size: 30,
            ),
            onPressed: () => _pickImage(ImageSource.gallery),
            color: Colors.pink,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[/// I need to put a text Widget with the instruction
            Container(
                padding: EdgeInsets.all(32), child: Image.file(_imageFile)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  color: Colors.blueGrey,
                  child: Icon(Icons.crop),
                  onPressed: _cropImage,
                ),
                FlatButton(
                  color: Colors.blueGrey,
                  child: Icon(Icons.refresh),
                  onPressed: _clear,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Uploader(
                file: _imageFile,
              ),
            )
          ]
        ],
      ),
    );
  }
}

/// Widget used to handle the management of
class Uploader extends StatefulWidget {

  File file;

  Uploader({Key key, this.file}) : super(key: key);

  createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  bool isUploading = false;
  final StorageReference storageRef = FirebaseStorage.instance.ref().child('Profile Pictures');

/// to delete if useless
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://aptus-77433.appspot.com');

  StorageUploadTask _uploadTask;

  final usersRef = Firestore.instance.collection('users');

  // compressImage() async {final tempDir = await getTemporaryDirectory();final path = tempDir.path;Im.Image imageFile = Im.decodeImage(widget.file.readAsBytesSync());final compressedImageFile = File('$path/images/${DateTime.now()}.png')..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));setState(() {widget.file = compressedImageFile;});}

  // createPostInFirestore({String photoUrl})  async {final uid = await Provider.of<CurrentUser>(context, listen: false).getCurrentUID();usersRef.document(uid).setData({"photoUrl": widget.file,});}

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(widget.file.readAsBytesSync());
    final compressedImageFile = File('$path/images/${DateTime.now()}.png')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      widget.file = compressedImageFile;
    });
  }

  Future<String> uploadImage(imageFile) async {
    StorageUploadTask uploadTask =
    storageRef.child('images/${DateTime.now()}.png').putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
  }

  createPostInFirestore(
      {String mediaUrl}) async {
    final uid =
        await Provider.of<CurrentUser>(context, listen: false).getCurrentUID();
    usersRef.document(uid).updateData({
      "photoUrl": mediaUrl,
    });
  }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });

    String mediaUrl = await uploadImage(widget.file);
    createPostInFirestore(
      mediaUrl: mediaUrl,
    );

    setState(() {
      widget.file = null;
      isUploading = false;
      Navigator.pushNamed(context, Home.id);
    });
  }

  @override
  Widget build(BuildContext context) {

    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (context, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_uploadTask.isComplete)
                    Text('🎉🎉🎉',
                        style: TextStyle(
                            color: Colors.greenAccent,
                            height: 2,
                            fontSize: 30)),
                  if (_uploadTask.isPaused)
                    FlatButton(
                      child: Icon(Icons.play_arrow, size: 50),
                      onPressed: _uploadTask.resume,
                    ),
                  if (_uploadTask.isInProgress)
                    FlatButton(
                      child: Icon(Icons.pause, size: 50),
                      onPressed: _uploadTask.pause,
                    ),
                  LinearProgressIndicator(value: progressPercent),
                  Text(
                    '${(progressPercent * 100).toStringAsFixed(2)} % ',
                    style: TextStyle(fontSize: 50),
                  ),
                ]);
          });
    } else {
      return FlatButton.icon(
          color: Colors.blue,
          label: Text('set profile'),
          icon: Icon(Icons.cloud_upload),
          onPressed: handleSubmit);
    }
  }
}

//_startUpload()  async {String photoUrl = 'images/${DateTime.now()}.png';await compressImage();setState(() {isUploading = true;_uploadTask = _storage.ref().child(photoUrl).putFile(widget.file);createPostInFirestore(photoUrl: photoUrl,);setState(() {isUploading = true;widget.file = null;});}); /*compress the file and upload to fireStore*/}
//_startUpload() {String filePath = 'images/${DateTime.now()}.png';createPostInFirestore();setState(() {_uploadTask = _storage.ref().child(filePath).putFile(widget.file);});}
