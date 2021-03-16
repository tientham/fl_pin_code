import 'package:fl_pin_code/fl_pin_code.dart';
import 'package:fl_pin_code/styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fl_pin_code demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _passwordObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Builder(
          builder: (context) {
            return Form(
              key: UniqueKey(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      readOnly: true,
                      showCursor: false,
                      obscureText: _passwordObscureText,
                      initialValue: 'A_asdw[jd%_*klmdn',
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_passwordObscureText) {
                                showModalPinBottomSheet();
                              } else {
                                _passwordObscureText = true;
                              }
                            });
                          },
                          icon: Icon(
                            _passwordObscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          iconSize: 18.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  showModalPinBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        context: context,
        builder: (_) {
          return Container(
            padding: EdgeInsets.only(bottom: 5),
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  PinCode(
                    numberOfFields: 5,
                    fieldWidth: 40.0,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    fieldStyle: PinCodeStyle.box,
                    onCompleted: (text) {
                      if (text.trim() == "11111") {
                        setState(() {
                          _passwordObscureText = false;
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please insert 11111 to unlock')));
                      }
                      Navigator.of(context).pop();
                    },
                    // onChanged: (_) {},
                  )
                ],
              ),
            ),
          );
        });
  }
}
