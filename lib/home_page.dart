import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slider_jr/widgets/form.dart';
import 'package:slider_jr/widgets/slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences sharedPreferences;
  late List<String> fanNameList = [];
  late List<String> fanIDList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialiseSharedPref();
  }

  Future initialiseSharedPref() async {
    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      fanNameList = sharedPreferences.getStringList('fanNameList')!;
      fanIDList = sharedPreferences.getStringList('fanIDList')!;
    });
  }

  Future clearField(int index) async {
    sharedPreferences = await SharedPreferences.getInstance();
    fanNameList.removeAt(index);
    fanIDList.removeAt(index);
    setState(() {
      sharedPreferences.setStringList('fanNameList', fanNameList);
      sharedPreferences.setStringList('fanIDList', fanIDList);
      // sharedPreferences.getStringList('dataList');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            fanNameList.isEmpty
                ? SizedBox(
                    height: 300,
                  )
                : SizedBox(),
            fanNameList.isNotEmpty
                ? GridView.builder(
                    itemCount: fanNameList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                      crossAxisCount: 2,
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => SliderWidget(
                                          fanName: fanNameList[index],
                                          fanID: fanIDList[index],
                                        ))));
                          },
                          child: GridTileBar(
                            backgroundColor: Colors.black12,
                            title: Text(
                              "Fan Name: " + fanNameList[index],
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            subtitle: Text(
                              "Fan ID: " + fanIDList[index],
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                clearField(index);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text("No Devices yet"),
                  ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => NameForm())));
              },
              child: Text(
                "Add new Fan",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
