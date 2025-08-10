import 'dart:typed_data';

import 'package:zoodtime_admin/services/req.dart';
import '../../utils/helpers/configs.dart';

class UserServices {
  var req = Req();

  //Edit Admin Profile
  Future<dynamic> editProfile(Map<String, dynamic> data, [Uint8List? imageBytes]) async {
    return await req.multipartPost(
      '${Configs.baseUrl}/api/auth/edit-profile',
      data,
      imageBytes,
    );
  }

  //Get all Stats
  Future<dynamic> getUserStats() async {
    return await req.get('${Configs.baseUrl}/api/admin/getUserStats');
  }

  // Get revenue Stats
  Future<dynamic> getRevenueStats() async {
    return await req.get('${Configs.baseUrl}/api/admin/getRevenueStats');
  }

  //Add Company
  Future<dynamic> addCompany(data) async {
    return await req.post(
      '${Configs.baseUrl}/api/admin/addCompany',data
    );
  }

  Future<dynamic> getCompanies({int page = 1}) async {
    return await req.get(
      '${Configs.baseUrl}/api/admin/getAllCompanies?page=$page',
    );
  }

  //Delete Entity
  Future<dynamic> deleteEntity(data) async {
    return await req.post(
      '${Configs.baseUrl}/api/admin/deleteEntity',data
    );
  }

  //Toggle Status
  Future<dynamic> toggleStatus(data) async {
    return await req.post(
      '${Configs.baseUrl}/api/admin/toggleStaus',data
    );
  }

  Future<dynamic> addCourier(data) async {
    return await req.post(
        '${Configs.baseUrl}/api/admin/addCourier',data
    );
  }

  Future<dynamic> getAllCouriers({int page = 1}) async {
    return await req.get(
      '${Configs.baseUrl}/api/admin/getAllCourier?page=$page',
    );
  }

  Future<dynamic> addStore(data) async {
    return await req.post(
        '${Configs.baseUrl}/api/admin/addStore',data
    );
  }

  Future<dynamic> getAllStore({int page = 1}) async {
    return await req.get(
      '${Configs.baseUrl}/api/admin/getAllStores?page=$page',
    );
  }

  Future<dynamic> resetCourierSalaries() async {
    return await req.postReq(
        '${Configs.baseUrl}/api/admin/resetCourierSalaries'
    );
  }

  Future<dynamic> updateCourierSalaryStatus(data) async {
    return await req.post(
        '${Configs.baseUrl}/api/admin/updateCourierSalaryStatus',data
    );
  }

  Future<dynamic> getAllCouriersName({int page = 1}) async {
    return await req.get(
      '${Configs.baseUrl}/api/admin/getAllCouriersName?page=$page',
    );
  }

  Future<dynamic> assignCourier(data) async {
    return await req.post(
      '${Configs.baseUrl}/api/admin/assignCourier',data
    );
  }

  Future<dynamic> getAllOrders({int page = 1}) async {
    return await req.get(
      '${Configs.baseUrl}/api/admin/getAllOrders?page=$page',
    );
  }

  Future<dynamic> getReturnOrders({int page = 1}) async {
    return await req.get(
      '${Configs.baseUrl}/api/admin/getReturnOrders?page=$page',
    );
  }

}
