import 'package:flutter/material.dart';
import 'package:flutter_project_intellij/widgets/myTextField.dart';
import 'package:flutter_project_intellij/database_connection.dart';
import 'package:flutter_project_intellij/models/textModel.dart';
import 'package:flutter_project_intellij/screens/todo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

//TODO: Font-family not working.
class _HomeState extends State<Home> {
  DatabaseConnection _dbConn = new DatabaseConnection();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('TO DO', style: TextStyle(color: Colors.white)),
        actions: [
          InkWell(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 36,
              ),
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Todo()));
            },
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder<List<TextModel>>(
            future: _dbConn.getTextModels(),
            builder: (context, snapshot) {
              try {
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemCount: snapshot.data.length ?? 0,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,childAspectRatio: 4),
                    itemBuilder: (context, index) {
                      return widgetTexts(snapshot.data[index].title, snapshot.data[index].colorIndex);
                    },
                  );
                } else {
                  return widgetTexts('There is no text created yet.', 2);
                }
              } catch (e) {
                print(e.toString());
                print("Error is here");
                return null;
              }
            }),
      ),
    );
  }
}
