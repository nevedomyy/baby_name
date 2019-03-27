import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'list_item.dart';


class GetFavorite extends StatefulWidget{
  final String _gender;

  GetFavorite(this._gender);

  @override
  _GetFavorite createState() => _GetFavorite(_gender);
}

class _GetFavorite extends State<GetFavorite>{
  final String _gender;
  List<ListItem> _list;

  _GetFavorite(this._gender);

  @override
  initState() {
    super.initState();
    _list = List();
    _getFavorite();
  }

  _getFavorite() async{
    int iter = -1;
    String questKey = _gender == 'Мальчик' ? 'boy' : 'girl';
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> list = pref.getStringList(questKey + 'Favorite') ?? List();
    List<String> listIndex = pref.getStringList(questKey + 'Index') ?? List();
    list.forEach((item){
      iter++;
      _list.add(ListItem(item, true, _gender, listIndex[iter]));
    });
    _list = List.from(_list);
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: Behavior(),
      child: ListView(
        children: _list,
      ),
    );
  }
}

class Behavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection){
    return child;
  }
}