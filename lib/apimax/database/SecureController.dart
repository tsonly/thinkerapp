import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureController{

  FlutterSecureStorage secureDatabase;

  SecureController(){
    secureDatabase = new FlutterSecureStorage();
  }

  save(key, data)async{
    return await secureDatabase.write(key: key, value: data);
    
  }

  read(key)async {
    return await secureDatabase.read(key: key);
  }
}