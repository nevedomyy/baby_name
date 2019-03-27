import 'package:flutter/material.dart';
import 'boy_girl.dart';


void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashColor: Colors.white
      ),
      home: Main(),
    );
  }
}

class Main extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BoyGirl('Мальчик', Color.fromRGBO(129, 178, 195, 1.0), Color.fromRGBO(32, 153, 193, 1.0)))
              );
            },
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                Opacity(
                    opacity: 0.4,
                    child: SizedBox(
                        height: _height/2,
                        child: Image.asset('assets/boy.jpg', fit: BoxFit.fitHeight, )
                    )
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Мальчик',
                    style: TextStyle(fontSize: 50.0, color: Colors.blue, fontFamily: 'Pacifico-Regular'),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BoyGirl('Девочка', Color.fromRGBO(233, 190, 183, 1.0), Color.fromRGBO(232, 155, 143, 1.0)))
              );
            },
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                Opacity(
                    opacity: 0.5,
                    child: SizedBox(
                        height: _height/2,
                        child: Image.asset('assets/girl.jpg', fit: BoxFit.fitHeight,)
                    )
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Девочка',
                    style: TextStyle(fontSize: 50.0, color: Colors.pinkAccent, fontFamily: 'Pacifico-Regular'),
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}
