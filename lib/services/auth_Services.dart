

import 'package:zoodtime_admin/services/req.dart';

import '../utils/helpers/configs.dart';

class AuthServices {
  var req = Req();

  //Login
  Future<dynamic> login(data) async {
    return await req.post('${Configs.baseUrl}/api/admin/adminLogin', data);
  }


}
