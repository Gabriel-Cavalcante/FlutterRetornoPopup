import 'dart:convert';
import 'dart:developer';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/models/retorno_popup.dart';
import 'package:flutter_api/repositories/api_service.dart';

class HomeController extends ChangeNotifier {
  ApiService apiService = ApiService();

  ValueNotifier<RetornoPopup?> retorno = ValueNotifier(null);
  ValueNotifier<String?> imagem = ValueNotifier(null);
  ValueNotifier<String?> msgret = ValueNotifier(null);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> procurarZip({required String parameter1}) async {
    isLoading.value = true;
    imagem.value = null;
    msgret.value = null;
    notifyListeners();

    RetornoPopup? retornoPopup =
        await apiService.getZip(parameter1: parameter1);

    if (retornoPopup != null) {
      if (retornoPopup.codret == '1') {
        retorno.value = retornoPopup;
        imagem.value = await descompactarArquivo(retornoPopup.zip!);
        isLoading.value = false;
        notifyListeners();
      } else {
        msgret.value = retornoPopup.msgret;
        isLoading.value = false;
        notifyListeners();
      }
    } else {
      retorno.value = null;
      isLoading.value = false;
      notifyListeners();
    }
  }

  Future<String?> descompactarArquivo(String arquivoCompactadoBase64) async {
    final bytes = base64Decode(arquivoCompactadoBase64);
    final imagemZip = ZipDecoder().decodeBytes(bytes);

    for (final file in imagemZip) {
      final imagem = file.content;
      return base64Encode(imagem);
    }

    return '';
  }
}
