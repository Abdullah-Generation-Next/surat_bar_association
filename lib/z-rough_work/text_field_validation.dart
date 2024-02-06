import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {
    return new MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  final _text = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('TextField Validation'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text('Error Showed if Field is Empty on Submit button Pressed'),
                Container(
                  height: 75,
                  width: 250,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 1.5,
                          )
                        ]
                    ),
                    child: TextField(
                      controller: _text,
                      decoration: InputDecoration(
                          hintText: 'Enter the Value',
                          labelStyle: TextStyle(color: Colors.black),
                          // errorText: _validate ? "Value Can't Be Empty" : null,
                        contentPadding: EdgeInsets.all(15),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(
                              Radius.circular(7)),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(_validate ? "Value Can't Be Empty" : "".toString()),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _text.text.isEmpty ? _validate = true : _validate = false;
                    });
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          ),
        ),
    );
  }
}
