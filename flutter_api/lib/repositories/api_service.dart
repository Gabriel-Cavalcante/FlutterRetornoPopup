import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_api/components/api_components.dart';
import 'package:flutter_api/models/retorno_popup.dart';

class ApiService {
  Future<RetornoPopup?> getZip({required String parameter1}) async {
    try {
      String nome = 'CANDIDATO';
      String senha = 'DEV_TESTE@587';
      String basicAuth = 'Basic ' + base64Encode(utf8.encode('$nome:$senha'));

      var response = await Dio().get(
        ApiConstants.urlBase(parameter1),
        options: Options(
          headers: <String, String>{'authorization': basicAuth},
        ),
      );

      if (response.statusCode == 200) {
        return RetornoPopup.fromJson(response.data);
      }
    } catch (e) {
      log(e.toString());
    }

    return null;
  }
}
