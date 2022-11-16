import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_page.dart';
import 'fan_data.dart';

class NameForm extends StatefulWidget {
  const NameForm({Key? key}) : super(key: key);

  @override
  State<NameForm> createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  final _formkey = GlobalKey<FormState>();
  late SharedPreferences sharedPreferences;
  late List<String> fanNameList = [];
  late List<String> fanIDList = [];

  TextEditingController _fanName = TextEditingController();
  TextEditingController _fanID = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialiseSP();
  }

  void initialiseSP() async {
    sharedPreferences = await SharedPreferences.getInstance();
    fanNameList = sharedPreferences.getStringList('fanNameList')!;
    fanIDList = sharedPreferences.getStringList('fanIDList')!;
  }

  void StoreData() {
    FanData data = FanData(fanName: _fanName.text, fanID: _fanID.text);
    String fanNameData = jsonEncode(data.fanName);
    String fanIdData = jsonEncode(data.fanID);
    fanNameList.insert(fanNameList.length, fanNameData);
    fanIDList.insert(fanIDList.length, fanIdData);
    sharedPreferences.setStringList('fanNameList', fanNameList);
    sharedPreferences.setStringList('fanIDList', fanIDList);
  }

  Future<void> _submit() async {
    if (!_formkey.currentState!.validate()) {
      return;
    }
    _formkey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: _fanName,
                  onSaved: (value) {},
                  decoration: InputDecoration(
                    hintText: 'Fan Name',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _fanID,
                  keyboardType: TextInputType.text,
                  onSaved: (value) {},
                  decoration: InputDecoration(
                    hintText: 'Fan ID',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.maxFinite,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                        elevation: 0,
                      ),
                      onPressed: () {
                        _submit();
                        StoreData();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.black),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
