import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = '공통코드 관리';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: new ThemeData(
          primaryColor: Colors.blueGrey,
      ),
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyStatefulWidget> {
  // width 전역 변수
  double _width;
  int _counter = 0;
  String test;
  SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (_prefs.getInt('counter') ?? 0);
    });
  }

  _incrementCounter() async {
    setState(() {
      _counter = (_prefs.getInt('counter') ?? 0) + 1;
      print('카운터 : ' + _counter.toString());
      _prefs.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: txtStyle_13('공통코드 관리')),
      body: Column(
        children: <Widget>[
          dbInfoArea(),
          buttonArea(),
          itemHeaderArea(),
          itemListArea(context)
        ],
      ),
    );
  }


  dbInfoArea() {
    customRow(String head, String body) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              width: _width * 0.2,
              child:
                txtStyle_13(head),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                height: 30.0,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[400],
                    ),
                    borderRadius: BorderRadius.circular(3)
                ),
                child:
                TextFormField(
                  onSaved: (String value) {
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                  ),
                    style: new TextStyle(
                        fontSize: 13.0,
                    )
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration:
      BoxDecoration(border: Border.all(color: Colors.grey[400], width: 1)),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            color: Colors.grey[200],
            alignment: Alignment(-1, 0),
            child:
              txtStyle_13('검색 그룹 $_counter'),
          ),
          Container(
            height: 1,
            color: Colors.grey[400],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: <Widget>[
                customRow("그룹명", ''),
                customRow("날짜", ''),
              ],
            ),
          )
        ],
      ),
    );
  }

  itemHeaderArea() {
    TextStyle ts = TextStyle(fontWeight: FontWeight.bold, fontSize: 13);
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 5, right: 10),
      //color: Colors.grey[200],
      height: 35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(height: 1, color: Colors.grey[300]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: _width * 0.1,
                alignment: Alignment(0, 0),
                child: Text(
                  "코드",
                  style: ts,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment(0, 0),
                  child: Text(
                    "품명",
                    style: ts,
                  ),
                ),
              ),
              Container(
                width: _width * 0.2,
                alignment: Alignment(0, 0),
                child: Text(
                  "사용여부",
                  style: ts,
                ),
              ),
              Container(
                width: _width * 0.15,
                alignment: Alignment(0, 0),
                child: Text(
                  "상태",
                  style: ts,
                ),
              ),
            ],
          ),
          Container(height: 1.5, color: Colors.grey[300])
        ],
      ),
    );
  }

  itemListArea(BuildContext context) {
    TextStyle ts = TextStyle(fontSize: 13);
    return Expanded(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    // 탭 시 상세보기 이동
                  },
                  child: Container(
                    height: 30,
                    color: (index % 2 == 0) ? Colors.grey[100] : Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: _width * 0.1,
                          alignment: Alignment(0, 0),
                          child: Text('1', style: ts),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment(0, 0),
                            child: Text('2', style: ts),
                          ),
                        ),
                        Container(
                          width: _width * 0.2,
                          alignment: Alignment(0, 0),
                          child: Text('3', style: ts),
                        ),
                        Container(
                          width: _width * 0.15,
                          alignment: Alignment(0, 0),
                          child: InkWell(
                            child: Icon(Icons.delete, color: Colors.blueGrey),
                            onTap: () {
                              // 상태 수정
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(height: 1, color: Colors.grey[300])
              ],
            ),
          );
        },
      ),
    );
  }

  updateItemArea() {
    TextStyle ts = TextStyle(fontSize: 13, fontWeight: FontWeight.w500);
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: <Widget>[
          Divider(
            color: Colors.grey,
            indent: 5,
            endIndent: 5,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, top: 5),
            alignment: Alignment(-1, 0),
            child: Text(
              "* Update List Item (Select an item to update from the list)",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          itemHeaderArea(),
          Container(
            //color: Colors.grey[200],
            height: 35,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: <Widget>[
                Container(
                  width: _width * 0.1,
                  alignment: Alignment(0, 0),
                  child:Text('asd', style: ts)
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: ts,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: _width * 0.2,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    textAlign: TextAlign.center,
                    style: ts,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: _width * 0.15,
                  child: InkWell(
                    child: Icon(Icons.sync),
                    onTap: () {
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  buttonArea() {
    return Container(
      padding: EdgeInsets.only(top: 5.0, right: 5.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          customButton("조회", () {_incrementCounter();}),
          SizedBox(width: 5),
          customButton("추가", () {}),
          SizedBox(width: 5),
          customButton("삭제", () {})
        ],
      ),
    );
  }

  customButton(String text, Null Function() onPressed) {
    return SizedBox(
      height: 25,
      //width: 60,
      child: FlatButton(
        color: Colors.blueGrey,
        disabledColor: Colors.grey,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            Icon(
//              Icons.search,
//              size: 15,
//              color: Colors.white,
//            ),
            txtStyle_13(text)
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}

// 스타일 함수
txtStyle_13(String content){
  return Text(
    content,
    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
  );
}
