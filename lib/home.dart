import 'package:flutter/material.dart';
import './MainPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 20),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 0.5 - _controller.value / 3;
    TextEditingController myController = TextEditingController(text: "Hello from ESP");
    //   _scale = 1 - _controller.value;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return MainPage();
              },
            ),
          );
        },
        child: Icon(Icons.settings),
        backgroundColor: Colors.green[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                enabled: false,
                controller: myController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'Response Text',
                  labelStyle: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF999999), width: 0.7),
                  ),
                ),
              ),
            ),
            SizedBox(height: 100.0),
            GestureDetector(
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              child: Transform.scale(
                scale: _scale,
                child: _HomeUI,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _HomeUI => Container(
        height: 100,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Color(0x80000000),
              blurRadius: 30.0,
              offset: Offset(30.0, 30.0),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFA7BFE8),
              Color(0xFF6190E8),
            ],
          ),
        ),
        child: Center(
          child: Icon(
            Icons.adjust,
            size: 50,
          ),
        ),
      );
}
