import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'list_item.dart';


class GetFromDB extends StatefulWidget{
  final String _gender;

  GetFromDB(this._gender);

  @override
  _GetFromDB createState() => _GetFromDB(_gender);
}

class _GetFromDB extends State<GetFromDB>{
  final String _gender;
  List<ListItem> _list;
  double _indicatorValue;
  Firestore _firestore;

  _GetFromDB(this._gender);

  @override
  initState() {
    super.initState();
    _firestore = Firestore();
    _list = List();
    _getFromDB();
  }

  _snackBar(String text){
    Scaffold.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.white,
            content: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(color:Colors.black54, fontSize: 20.0, fontFamily: 'Pacifico-Regular'),
            )
        )
    );
  }

  _getFromDB() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      _snackBar('Нет подключения к сети');
      return;
    }
    _indicatorValue = 1.0;
    String questKey = _gender == 'Мальчик' ? 'boy' : 'girl';
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> listIndex = pref.getStringList(questKey + 'Index') ?? List();
    List<int> listIndexInt = listIndex.map(int.parse).toList();
    listIndexInt.sort();
    int iter = -1;
    int iterIndex = 0;
    try{
      _firestore.collection(questKey).snapshots()
          .handleError((e){
            _snackBar(e.toString());
            return;})
          .listen((data){
            data.documents.forEach((doc){
              iter++;
              bool selected = false;
              if(listIndexInt.length > iterIndex){
                if(iter == listIndexInt[iterIndex]){
                  iterIndex++;
                  selected = true;
                }
              }
              _list.add(ListItem(doc['name'], selected, _gender, iter.toString()));
            });
            _list = List.from(_list);
            _indicatorValue = 0.0;
            setState((){});}
          );
    }catch(e){
      _snackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: CircularProgressIndicator(
            value: _indicatorValue,
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
        ScrollConfiguration(
          behavior: Behavior(),
          child: ListView(
            children: _list,
          ),
        )
      ],
    );
  }
}

class Behavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection){
    return child;
  }
}