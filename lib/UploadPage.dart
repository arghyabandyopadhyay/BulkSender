import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UploadPage extends StatefulWidget {
  @override
  _MyUploadPageState createState() => new _MyUploadPageState();
}

class _MyUploadPageState extends State<UploadPage> {
  String _filePath;
  Future<void> _handleSubmitted() async
  {

  }
  void getFilePath() async {
    try {
      String filePath = await FilePicker.platform.getDirectoryPath();
      if (filePath == '') {
        return;
      }
      print("File path: " + filePath);
      setState(() {
        this._filePath = filePath;
      });
    } on PlatformException catch (e) {
      print("Error while picking the file: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              new RaisedButton(
                onPressed: () => {},
                color: Colors.blue,
                padding: EdgeInsets.all(12.0),
                child: _filePath == null
                    ? new Text('No file selected.')
                    : new Text('Path' + _filePath),
              ), // Replace with a Row for horizontal icon + text
              new RaisedButton(
                onPressed: getFilePath,
                child: new Icon(Icons.sd_storage),
                color: Colors.blue,
              )
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleSubmitted,
        tooltip: 'Send',
        child: Icon(Icons.send),
      ),
    );
  }
}