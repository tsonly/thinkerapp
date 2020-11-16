import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureController{

  FlutterSecureStorage secureDatabase;

  SecureController(){
    secureDatabase = new FlutterSecureStorage();
  }

  save(key, data)async{
    await secureDatabase.write(key: key, value: data);
    
  }

  read(key)async {
    await secureDatabase.read(key: key);
  }
}