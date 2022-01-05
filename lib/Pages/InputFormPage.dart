import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InputFormPage extends StatefulWidget {
  InputFormPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _InputFormPageState createState() => _InputFormPageState();
}

class _InputFormPageState extends State<InputFormPage> {
  int _counter = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerState = GlobalKey<ScaffoldMessengerState>();
  TextEditingController studentNameTextField = new TextEditingController();
  TextEditingController rollNoTextField = new TextEditingController();
  TextEditingController phoneNumberTextField = new TextEditingController();
  TextEditingController english1FirstTextField = new TextEditingController();
  TextEditingController english2FirstTextField = new TextEditingController();
  TextEditingController mathematicsFirstTextField = new TextEditingController();
  TextEditingController computerFirstTextField = new TextEditingController();
  TextEditingController hindiFirstTextField = new TextEditingController();
  TextEditingController evsFirstTextField = new TextEditingController();
  TextEditingController english1SecondTextField = new TextEditingController();
  TextEditingController english2SecondTextField = new TextEditingController();
  TextEditingController mathematicsSecondTextField = new TextEditingController();
  TextEditingController computerSecondTextField = new TextEditingController();
  TextEditingController evsSecondTextField = new TextEditingController();
  TextEditingController hindiSecondTextField = new TextEditingController();
  //Functions
  void showInSnackBar(String value) {
    scaffoldMessengerState.currentState.hideCurrentSnackBar();
    scaffoldMessengerState.currentState.showSnackBar(SnackBar(
      content: Text(value, textScaleFactor: 1),
    ));
  }

  Future<void> _handleSubmitted() async {
    final form = _formKey.currentState;
    if (!form.validate()) {
    } else {
      form.save();
      try {
        int totalFirst = (english1FirstTextField.text.isNotEmpty)
            ? int.parse(english1FirstTextField.text) +
                int.parse(english2FirstTextField.text) +
                int.parse(hindiFirstTextField.text) +
                int.parse(mathematicsFirstTextField.text) +
                int.parse(evsFirstTextField.text) +
                int.parse(computerFirstTextField.text)
            : 0;
        int totalSecond = (english1SecondTextField.text.isNotEmpty)
            ? int.parse(english1SecondTextField.text) +
                int.parse(english2SecondTextField.text) +
                int.parse(hindiSecondTextField.text) +
                int.parse(mathematicsSecondTextField.text) +
                int.parse(evsSecondTextField.text) +
                int.parse(computerSecondTextField.text)
            : 0;
        String number = "+91${phoneNumberTextField.text}";
        String url = "https://wa.me/$number?text=Dear Parents, The performance of your ward is as follows:\n\n"
            "Students Name: *${studentNameTextField.text}*\n"
            "Roll No.: *${rollNoTextField.text}*\n\n";
        if (english1FirstTextField.text.isNotEmpty)
          url = url +
              "*First Unit Test*\n\n"
                  "English 1: *${english1FirstTextField.text}*/50\n"
                  "English 2: *${english2FirstTextField.text}*/50\n"
                  "Hindi: *${hindiFirstTextField.text}*/50\n"
                  "Mathematics: *${mathematicsFirstTextField.text}*/50\n"
                  "EVS: *${evsFirstTextField.text}*/50\n"
                  "Computer: *${computerFirstTextField.text}*/50\n"
                  "Total: *$totalFirst*/300\n\n\n";
        if (english1SecondTextField.text.isNotEmpty)
          url = url +
              "*Half Yearly Examination*\n\n"
                  "English 1: *${english1SecondTextField.text}*/100\n"
                  "English 2: *${english2SecondTextField.text}*/100\n"
                  "Hindi: *${hindiSecondTextField.text}*/100\n"
                  "Mathematics: *${mathematicsSecondTextField.text}*/100\n"
                  "EVS: *${evsSecondTextField.text}*/100\n"
                  "Computer: *${computerSecondTextField.text}*/100\n"
                  "Total: *$totalSecond*/600\n\n\n";
        url = url +
            "With Regards,\nContacts Name,\n"
                "Class Teacher Class Name\n";
        if (await canLaunch(url)) {
          await launch(url);
          studentNameTextField.clear();
          rollNoTextField.clear();
          phoneNumberTextField.clear();
          english1FirstTextField.clear();
          english2FirstTextField.clear();
          mathematicsFirstTextField.clear();
          computerFirstTextField.clear();
          hindiFirstTextField.clear();
          evsFirstTextField.clear();
          english1SecondTextField.clear();
          english2SecondTextField.clear();
          mathematicsSecondTextField.clear();
          computerSecondTextField.clear();
          evsSecondTextField.clear();
          hindiSecondTextField.clear();
        } else {
          throw 'Could not launch $url';
        }
      } catch (E) {
        print(E);
        showInSnackBar("Some Error has Occurred $E");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width / 2;
    return ScaffoldMessenger(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 5),
            children: [
              SizedBox(height: 10),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                controller: studentNameTextField,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.blue)),
                  contentPadding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                ),
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 5),
              TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: rollNoTextField,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "RollNo.",
                    hintStyle: TextStyle(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.blue)),
                    contentPadding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number),
              SizedBox(height: 5),
              TextFormField(
                controller: phoneNumberTextField,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Mobile",
                  hintStyle: TextStyle(color: Colors.grey),
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.blue)),
                  contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10),
              // Text("First Unit Test"),
              // SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     Container(
              //       margin: EdgeInsets.only(right: 5),
              //       width: screenWidth - 3,
              //       child: TextFormField(
              //         textCapitalization: TextCapitalization.words,
              //         controller: english1FirstTextField,
              //         decoration: InputDecoration(
              //           border: const OutlineInputBorder(),
              //           labelText: "English 1",
              //           hintStyle: TextStyle(color: Colors.grey),
              //           labelStyle: TextStyle(color: Colors.grey),
              //           focusedBorder: OutlineInputBorder(
              //               borderRadius: BorderRadius.all(Radius.circular(5.0)),
              //               borderSide: BorderSide(color: Colors.blue)),
              //           contentPadding: EdgeInsets.only(
              //               bottom: 10.0, left: 10.0, right: 10.0),
              //         ),
              //         textInputAction: TextInputAction.next,
              //         keyboardType: TextInputType.number,
              //       ),
              //     ),
              //     Expanded(
              //       child: TextFormField(
              //         textCapitalization: TextCapitalization.words,
              //         controller: english2FirstTextField,
              //         decoration: InputDecoration(
              //           border: const OutlineInputBorder(),
              //           labelText: "English 2",
              //           hintStyle: TextStyle(color: Colors.grey),
              //           labelStyle: TextStyle(color: Colors.grey),
              //           focusedBorder: OutlineInputBorder(
              //               borderRadius: BorderRadius.all(Radius.circular(5.0)),
              //               borderSide: BorderSide(color: Colors.blue)),
              //           contentPadding: EdgeInsets.only(
              //               bottom: 10.0, left: 10.0, right: 10.0),
              //         ),
              //         textInputAction: TextInputAction.next,
              //         keyboardType: TextInputType.number,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 10),
              // Row(
              //   children: [
              //     Container(
              //       margin: EdgeInsets.only(right: 5),
              //       width: screenWidth - 3,
              //       child: TextFormField(
              //         textCapitalization: TextCapitalization.words,
              //         controller: hindiFirstTextField,
              //         decoration: InputDecoration(
              //           border: const OutlineInputBorder(),
              //           labelText: "Hindi",
              //           hintStyle: TextStyle(color: Colors.grey),
              //           labelStyle: TextStyle(color: Colors.grey),
              //           focusedBorder: OutlineInputBorder(
              //               borderRadius: BorderRadius.all(Radius.circular(5.0)),
              //               borderSide: BorderSide(color: Colors.blue)),
              //           contentPadding: EdgeInsets.only(
              //               bottom: 10.0, left: 10.0, right: 10.0),
              //         ),
              //         textInputAction: TextInputAction.next,
              //         keyboardType: TextInputType.number,
              //       ),
              //     ),
              //     Expanded(
              //       child: TextFormField(
              //         textCapitalization: TextCapitalization.words,
              //         controller: mathematicsFirstTextField,
              //         decoration: InputDecoration(
              //           border: const OutlineInputBorder(),
              //           labelText: "Mathematics",
              //           hintStyle: TextStyle(color: Colors.grey),
              //           labelStyle: TextStyle(color: Colors.grey),
              //           focusedBorder: OutlineInputBorder(
              //               borderRadius: BorderRadius.all(Radius.circular(5.0)),
              //               borderSide: BorderSide(color: Colors.blue)),
              //           contentPadding: EdgeInsets.only(
              //               bottom: 10.0, left: 10.0, right: 10.0),
              //         ),
              //         textInputAction: TextInputAction.next,
              //         keyboardType: TextInputType.number,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 10),
              // Row(
              //   children: [
              //     Container(
              //       margin: EdgeInsets.only(right: 5),
              //       width: screenWidth - 3,
              //       child: TextFormField(
              //         textCapitalization: TextCapitalization.words,
              //         controller: evsFirstTextField,
              //         decoration: InputDecoration(
              //           border: const OutlineInputBorder(),
              //           labelText: "EVS",
              //           hintStyle: TextStyle(color: Colors.grey),
              //           labelStyle: TextStyle(color: Colors.grey),
              //           focusedBorder: OutlineInputBorder(
              //               borderRadius: BorderRadius.all(Radius.circular(5.0)),
              //               borderSide: BorderSide(color: Colors.blue)),
              //           contentPadding: EdgeInsets.only(
              //               bottom: 10.0, left: 10.0, right: 10.0),
              //         ),
              //         textInputAction: TextInputAction.next,
              //         keyboardType: TextInputType.number,
              //       ),
              //     ),
              //     Expanded(
              //       child: TextFormField(
              //         textCapitalization: TextCapitalization.words,
              //         controller: computerFirstTextField,
              //         decoration: InputDecoration(
              //           border: const OutlineInputBorder(),
              //           labelText: "Computer",
              //           hintStyle: TextStyle(color: Colors.grey),
              //           labelStyle: TextStyle(color: Colors.grey),
              //           focusedBorder: OutlineInputBorder(
              //               borderRadius: BorderRadius.all(Radius.circular(5.0)),
              //               borderSide: BorderSide(color: Colors.blue)),
              //           contentPadding: EdgeInsets.only(
              //               bottom: 10.0, left: 10.0, right: 10.0),
              //         ),
              //         textInputAction: TextInputAction.next,
              //         keyboardType: TextInputType.number,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 10),
              Text("Half Yearly Examination"),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    width: screenWidth - 3,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: english1SecondTextField,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "English 1",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.blue)),
                        contentPadding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: english2SecondTextField,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "English 2",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.blue)),
                        contentPadding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    width: screenWidth - 3,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: hindiSecondTextField,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Hindi",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.blue)),
                        contentPadding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: mathematicsSecondTextField,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Mathematics",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.blue)),
                        contentPadding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    width: screenWidth - 3,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: evsSecondTextField,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "EVS",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.blue)),
                        contentPadding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: computerSecondTextField,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Computer",
                        hintStyle: TextStyle(color: Colors.grey),
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5.0)), borderSide: BorderSide(color: Colors.blue)),
                        contentPadding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(height: 30),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _handleSubmitted,
          tooltip: 'Send',
          child: Icon(Icons.send),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
      key: scaffoldMessengerState,
    );
  }
}
