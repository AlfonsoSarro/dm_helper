import 'dart:convert';

import 'package:dm_helper/control/authentication.dart';
import 'package:dm_helper/data/map-data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class CloudStorage {
  static const int ok = 0;
  static const int err = -1;

  static final storageRef = FirebaseStorage.instance.ref("/users");

  static Future<String> getJsonFromUrl(String url) async{
    http.Response response = await http.get(Uri.parse(url));
    return response.body;
  }

  static Future<List<Reference>> getAllFileRefs() async{
    List<Reference> out = [];
    var tmp = await storageRef.child("${AuthManager.currentUser.uid}/").listAll();
    tmp.items.forEach((element) {
      out.add(element);
    });
    return out;
  }

  static Future<List<MapData>> getAllMaps() async {
    List<Reference> refs = await getAllFileRefs();
    List<MapData> out = [];
    for (var i = 0; i < refs.length; i++) {
      String url = await refs[i].getDownloadURL();
      out.add(await getMap(url));
    }
    return out;
  }

  static Future<int> uploadMap(MapData mapData) async{
    var childRef = storageRef.child("${AuthManager.currentUser.uid}/${mapData.id}.json");
    try {
      await childRef.putString(jsonEncode(mapData));
      return ok;
    }
    on FirebaseException catch (e) {
      return err;
    }
  }

  static Future<MapData> getMap(String mapUrl) async{
    String rawData = await getJsonFromUrl(mapUrl);
    var jsonRes = jsonDecode(rawData);
    var out = MapData.fromJson(jsonRes);
    return out;
  }

  static Future<void> deleteMap(MapData mapData) async {
    var childRef = storageRef.child("${AuthManager.currentUser.uid}/${mapData.id}.json");
    await childRef.delete();
  }

}