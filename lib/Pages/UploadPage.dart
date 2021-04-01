import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class UploadPage extends StatefulWidget {
  @override
  _MyUploadPageState createState() => new _MyUploadPageState();
}

class _MyUploadPageState extends State<UploadPage> {
  String _filePath;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //Functions
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value, textScaleFactor: 1),
    ));
  }
  Future<void> _handleSubmitted() async
  {
    var bytes = File(_filePath).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    int i = 0;
    List<dynamic> keys = new List<dynamic>();
    List<Map<String, dynamic>> json = new List<Map<String, dynamic>>();
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table].rows) {
        if (i == 0) {
          keys = row;
          i++;
        } else {
          Map<String, dynamic> temp = Map<String, dynamic>();
          int j = 0;
          String tk = '';
          for (var key in keys) {
            tk = key;
            temp[tk] = (row[j].runtimeType==String)?row[j].toString():row[j];
            j++;
          }
          json.add(temp);
        }
      }
    }
    int keyLength=keys.length;
    List<String> rollNos=new List();
    for (Map<String, dynamic> jsonItem in json)
    {
      if(rollNos.contains(jsonItem['Roll No'].toString())) continue;
      try {
        rollNos.add(jsonItem['Roll No'].toString());
        List<Map<String, dynamic>> recordForThisRollNo= json.where((element) => element['Roll No']==jsonItem['Roll No']).toList();
        int recordForThisRollNoLength=recordForThisRollNo.length;
        List<int> totals=new List(recordForThisRollNoLength);
        for(int i=0;i<recordForThisRollNoLength;i++)
          {
            totals[i]=0;
            for(var keyItems in keys.getRange(4,keyLength-1))
            {
              totals[i]=totals[i]+int.parse(recordForThisRollNo[i][keyItems].toString());
            }
          }
        String number = "+91${jsonItem[keys[0]]}";
        String url =
            "https://wa.me/$number?text=Dear Parents, The performance of your ward is as follows:\n\n"
            "${keys[1]}: *${jsonItem[keys[1]]}*\n"
            "${keys[2]}: *${jsonItem[keys[2]]}*\n\n";
        for(int i=0;i<recordForThisRollNoLength;i++)
          {
            String outOffValue=(recordForThisRollNo[i][keys.last]/(keyLength-5)).toString();
            url=url+" *${recordForThisRollNo[i]['Exam Name']}*\n\n";
            for(var keyItems in keys.getRange(4,keyLength-1))
            {
              url=url+"$keyItems : *${recordForThisRollNo[i][keyItems]}/$outOffValue*\n\n";
            }
            url=url+"Total : *${totals[i]}/${recordForThisRollNo[i][keys.last]}*\n\n";
          }
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      } catch (E) {
        showInSnackBar("Some Error has Occurred $E");
      }
    }
  }
  void getFilePath() async {
    try {
      FilePickerResult filePickerResult = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['xlsx', 'csv', 'xls']);
      String filePath=filePickerResult.paths[0];
      if (filePath == '') {
        return;
      }
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
      key: _scaffoldKey,
      body: new Center(
        child: new ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              new ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(primary: Colors.blue,
                  padding: EdgeInsets.all(12.0),),
                child: _filePath == null
                    ? new Text('No file selected.')
                    : new Text('Path' + _filePath),
              ), // Replace with a Row for horizontal icon + text
              new ElevatedButton(
                onPressed: getFilePath,
                child: new Icon(Icons.sd_storage),
                style: ElevatedButton.styleFrom(primary: Colors.blue,),
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