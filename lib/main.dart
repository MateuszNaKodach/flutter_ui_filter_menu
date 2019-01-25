import 'package:flutter/material.dart';
import 'package:flutter_ui_filter_menu/diagonal_clipper.dart';

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
  double _imageHeight = 256.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildImage(),
          _buildTopHeader(),
          _buildProfileRow(),
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
}
