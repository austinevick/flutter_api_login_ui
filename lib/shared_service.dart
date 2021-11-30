import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';

import 'login_model.dart';

class SharedService {
  isLoggedIn() async {
    return await APICacheManager().isAPICacheKeyExist('login_details');
  }

  loginDetails() async {
    var isKeyExist =
        await APICacheManager().isAPICacheKeyExist('login_details');
    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData('login_details');
      return loginModel(cacheData.syncData);
    }
  }

  setLoginDetails(LoginModel model) async {
    APICacheDBModel apiCacheDBModel = APICacheDBModel(
        key: 'login_details', syncData: jsonEncode(model.toMap()));
    await APICacheManager().addCacheData(apiCacheDBModel);
  }
}
