import 'package:flutter/material.dart';
import 'package:flutter_ui_filter_menu/diagonal_clipper.dart';
import 'package:flutter_ui_filter_menu/list_model.dart';
import 'package:flutter_ui_filter_menu/task.dart';
import 'package:flutter_ui_filter_menu/task_row.dart';

final List<Task> tasks = [
  new Task(
      name: "Catch up with Brian",
      category: "Mobile Project",
      time: "5pm",
      color: Colors.orange,
      completed: false),
  new Task(
      name: "Make new icons",
      category: "Web App",
      time: "3pm",
      color: Colors.cyan,
      completed: true),
  new Task(
      name: "Design explorations",
      category: "Company Website",
      time: "2pm",
      color: Colors.pink,
      completed: false),
  new Task(
      name: "Lunch with Mary",
      category: "Grill House",
      time: "12pm",
      color: Colors.cyan,
      completed: true),
  new Task(
      name: "Teem Meeting",
      category: "Hangouts",
      time: "10am",
      color: Colors.cyan,
      completed: true),
];

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel listModel;
  bool showOnlyCompleted = false;

  double _imageHeight = 256.0;

  @override
  void initState() {
    super.initState();
    listModel = ListModel(_listKey, tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildTimeline(),
          _buildImage(),
          _buildTopHeader(),
          _buildProfileRow(),
          _buildBottomPart(),
          _buildFab(),
        ],
      ),
    );
  }

  Widget _buildImage() => new ClipPath(
        clipper: DiagonalClipper(),
        child: Image.asset('images/birds.jpg',
            fit: BoxFit.fitHeight,
            height: _imageHeight,
            colorBlendMode: BlendMode.srcOver,
            color: Color.fromARGB(120, 20, 10, 40)),
      );

  Widget _buildTopHeader() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
        child: Row(
          children: <Widget>[
            Icon(Icons.menu, size: 32.0, color: Colors.white),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Timeline',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Icon(Icons.linear_scale, color: Colors.white)
          ],
        ),
      );

  Widget _buildProfileRow() => Padding(
        padding: EdgeInsets.only(left: 16.0, top: _imageHeight / 2.5),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 28.0,
              backgroundImage: AssetImage('images/avatar.png'),
            ),
            Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Mateusz Nowak',
                      style: TextStyle(
                          fontSize: 26.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Aspiring Software Craftsman',
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ))
          ],
        ),
      );

  Widget _buildBottomPart() => Padding(
      padding: EdgeInsets.only(top: _imageHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_buildMyTasksHeader(), _buildTasksList()],
      ));

  Widget _buildMyTasksHeader() => Padding(
      padding: EdgeInsets.only(left: 64.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('My Tasks', style: TextStyle(fontSize: 34.0)),
          Text(
            DateTime.now().toString(),
            style: TextStyle(fontSize: 12.0, color: Colors.grey),
          )
        ],
      ));

  Widget _buildTasksList() => Expanded(
        child: new AnimatedList(
          key: _listKey,
          initialItemCount: listModel.length,
          itemBuilder: (BuildContext context, int index, Animation animation) =>
              TaskRow(
                task: listModel[index],
                animation: animation,
              ),
        ),
      );

  Widget _buildTimeline() => Positioned(
        top: 0,
        bottom: 0,
        left: 32,
        child: Container(
          width: 1.0,
          color: Colors.grey[300],
        ),
      );

  Widget _buildFab() => Positioned(
        top: _imageHeight - 36.0,
        right: 16.0,
        child: FloatingActionButton(
          onPressed: _changeFilterState,
          backgroundColor: Colors.pink,
          child: Icon(Icons.filter_list),
        ),
      );

  void _changeFilterState() {
    showOnlyCompleted = !showOnlyCompleted;
    tasks.where((task) => !task.completed).forEach((task) {
      if (showOnlyCompleted) {
        listModel.removeAt(listModel.indexOf(task));
      } else {
        listModel.insert(tasks.indexOf(task), task);
      }
    });
  }
}
