 import 'package:shared_preferences/shared_preferences.dart';

abstract class CashHelper{
  static SharedPreferences? sharedPreferences;
 static  init()async{
   sharedPreferences=await SharedPreferences.getInstance() ;
 }
  static dynamic GetData({
    required String key,
  })
   {

    return  sharedPreferences!.get(key);
  }
  static bool? GetBoolData({
    required String key,
  })
   {

    return  sharedPreferences!.getBool(key);
  }


  static Future<bool> RemoveData({
    required String key,
  })
   {

    return  sharedPreferences!.remove(key);
  }
 static Future<bool>SaveData({
  required String key,
  required dynamic value,
})
async {
   if(value is String)return await sharedPreferences!.setString(key, value);
   if(value is int)return await sharedPreferences!.setInt(key, value);
   if(value is bool)return await sharedPreferences!.setBool(key, value);

return await sharedPreferences!.setDouble(key, value);
 }
}