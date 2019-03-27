import 'package:flutter/material.dart';
import 'from_favorite.dart';
import 'from_db.dart';


class BoyGirl extends StatefulWidget{
  final String _gender;
  final Color _bgrColor;
  final Color _splashColor;

  BoyGirl(this._gender, this._bgrColor, this._splashColor);

  @override
  _BoyGirl createState() => _BoyGirl(_gender, _bgrColor, _splashColor);
}

class _BoyGirl extends State<BoyGirl>{
  final String _gender;
  final Color _bgrColor;
  final Color _splashColor;
  bool _favorite = false;

  _BoyGirl(this._gender, this._bgrColor, this._splashColor);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: _bgrColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: _bgrColor,
            body: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      iconSize: 25.0,
                      color: Colors.white,
                      splashColor: _splashColor,
                      icon: Icon(Icons.menu),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          _gender,
                          style: TextStyle(color: Colors.white, fontSize: 35.0, fontFamily: 'Pacifico-Regular'),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        setState(() {
                          _favorite = !_favorite;
                        });
                      },
                      splashColor: _splashColor,
                      icon: AnimatedCrossFade(
                        duration: Duration(milliseconds: 500),
                        firstChild: Icon(
                          Icons.favorite_border,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        secondChild: Icon(
                          Icons.favorite,
                          size: 25.0,
                          color: Colors.white,
                        ),
                        crossFadeState: !_favorite ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: _favorite ? GetFavorite(_gender): GetFromDB(_gender)
                      ),
                    ),
                  )
                )
              ],
            ),
          ),
        )
    );
  }
}