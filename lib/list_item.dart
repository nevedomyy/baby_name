import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ListItem extends StatefulWidget{
  final String _text;
  final String _index;
  final String _gender;
  bool _selected;

  ListItem(this._text, this._selected, this._gender, this._index);

  @override
  _ListItem createState() => _ListItem(_text, _selected, _gender, _index);
}

class _ListItem extends State<ListItem>{
  final String _text;
  final String _index;
  final String _gender;
  bool _selected;

  _ListItem(this._text, this._selected, this._gender, this._index);

  _pref() async{
    String prefKey = _gender == 'Мальчик' ? 'boy' : 'girl';
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList(prefKey + 'Favorite') ?? List();
    List<String> listIndex = pref.getStringList(prefKey + 'Index') ?? List();
    if(_selected) {
      list.add(_text);
      listIndex.add(_index);
    }
    else {
      list.remove(_text);
      listIndex.remove(_index);
    }
    pref.setStringList(prefKey + 'Favorite', list);
    pref.setStringList(prefKey + 'Index', listIndex);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AnimatedCrossFade(
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
        crossFadeState: !_selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
      title: Text(
        _text,
        style: TextStyle(color: Colors.white, fontSize: 23.0, fontFamily: 'Pacifico-Regular'),
      ),
      onTap: (){
        setState(() {
          _selected = !_selected;
          _pref();
        });
      },
    );
  }
}