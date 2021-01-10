import 'package:flutter/material.dart';
import 'package:flutter_project_intellij/database_connection.dart';
import 'package:flutter_project_intellij/models/textModel.dart';

TextEditingController _controller = new TextEditingController();


class MyTextField extends StatelessWidget {
   String text;
   int _maxLength = 20;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[350],
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        maxLength: _maxLength,
        controller: _controller,
        autocorrect: false,
        textCapitalization: TextCapitalization.characters, //not working
        onChanged: (String text) {
          if (text.length <= _maxLength)
            this.text = text;
          else{
            _controller.text = text;
            print(_controller.text);
          }
        },

        onSubmitted: (value) async{
         if(value.isNotEmpty)
           {
             DatabaseConnection _dbConnector = DatabaseConnection();
             TextModel _txt = new TextModel(
               title: value
             );
            await _dbConnector.insertTextModel(_txt);
             print("title added to db.");
           }
         else
           print("not able to connect database.//todo myTextField line 39.");
        },
        style:
            TextStyle(color: Colors.black, fontSize: 25, fontFamily: 'Roboto'),

        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "Başlık",
          contentPadding: EdgeInsets.fromLTRB(
              0,
              AppBar().preferredSize.height / 2,
              0,
              AppBar().preferredSize.height / 2),
          hintStyle: TextStyle(
            fontSize: 17,
            fontFamily: 'Roboto',
            color: Colors.black,
            letterSpacing: 2,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}

List appBarColors = [
  Color(0xffA8C686),
  Color(0xfff3f896),
  Color(0xff7699e0),
  Color(0xffcc6b73),
  Color(0xffe57c6c),
  Color(0xff674e4c),
];

Widget widgetTexts(String title, int colorIndex) {
  return Card(
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        Text(
          title ?? " No title",
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              letterSpacing: 2,
              fontFamily: 'Roboto'),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              color: Colors.redAccent,
              icon: Icon(
                Icons.delete_forever_rounded,
                size: 28,
                color: Colors.white,
              )),
        ),
      ],
    ),
    color: appBarColors[colorIndex ?? 3],
  );
}
