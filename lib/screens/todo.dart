import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_intellij/widgets/myTextField.dart';
import 'package:flutter_project_intellij/database_connection.dart';
import 'package:flutter_project_intellij/models/textModel.dart';

//TODO: When body clicked the keyboard must pop. Right now, it's popping when the top line clicked.
class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List scaffoldColors = [
    Color(0xffb9cba4),
    Color(0xfff8fbbc),
    Color(0xffb0c4ed),
    Color(0xffeca7ad),
    Color(0xfff0b6ad),
    Color(0xffb19895),
  ];
  List appBarColors = [
    Color(0xffA8C686),
    Color(0xfff3f896),
    Color(0xff7699e0),
    Color(0xffcc6b73),
    Color(0xffe57c6c),
    Color(0xff674e4c),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColors[index], //colors[index],
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: appBarColors[index],
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            iconSize: 50,
            icon: Image.asset('assets/colorize.png', fit: BoxFit.fill),
            tooltip: 'Change theme color',
            onPressed: () {
              setState(() {
                if (index < appBarColors.length) index++;
                if (index == appBarColors.length) index = 0;
              });
            },
          ),
        ],
        title: MyTextField(),
      ),
      body: SingleChildScrollView(
        //TODO: When the page filled the text hide behind the keyboard
        reverse: true,
        child: Column(
          children: [
            // SizedBox(height: 10,),
            TextField(
              //TODO: This text not supporting Tr chars from keyboard
              style: TextStyle(
                  color: Colors.black, fontFamily: 'Roboto', fontSize: 22),
              maxLines: null,
              onChanged:(value) async{
                if(value.isNotEmpty){
                  DatabaseConnection _db = DatabaseConnection();
                  TextModel _text = new TextModel(
                    article: value,
                    colorIndex: index,

                  );
                  await _db.insertTextModel(_text);
                  print("Article and colorIndex added to db.");
                }
              },
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
      //  floatingActionButton: I
    );
  }
}
