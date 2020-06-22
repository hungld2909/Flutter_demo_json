import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.teal),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data; //! khởi tạo 1 list danh sách có tên là data
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Load Json App"),
      ),
      body: new Container(
        child: new Center(
          child: new FutureBuilder( //! sử dụng FutureBuilder để đọc dữ liệu json
            builder: (context, snapshot) {
              //decode json
              var myData = jsonDecode(snapshot.data.toString());
              //! gán myData = với dữ liệu lấy được trong file json
              //! sau khi load được file json thì sẽ sử dụng snapshot đọc từng data trong file json
              return ListView.builder( //! sau đó trả về bằng ListView, truyền dữ liệu tới listView.
                  itemBuilder: (BuildContext context, int index) {
                return new Card(
                  //todo: trong listView sẽ được trả từng dữ liệu về Card
                  child: new Column(
                    //! những dữ liệu sẽ được sắp xếp theo thứ tự Column
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Text("Name: " + myData[index]['name']), //! dữ liệu được gán vào myData[Vị trí dữ liệu][Key]
                      new Text("Age: " + myData[index]['age']),
                      new Text("Height: " + myData[index]['height']),
                      new Text("Hair Color: " + myData[index]['hair_color']),
                      new Text("Gender: " + myData[index]['gender']),
                    ],
                  ),
                );
                
              },
              itemCount: myData == null ? 0 : myData.length,
              //! nếu dữ liệu == null thì hiện thị 0, ngoài ra dữ liệu khác null thì hiện thị số phần tử có trong dữ liệu
              );
            },
            future: DefaultAssetBundle.of(context)
                .loadString('load_json/person.json'), //! giúp load dữ liệu json
          ),
        ),
      ),
    );
  }
}
