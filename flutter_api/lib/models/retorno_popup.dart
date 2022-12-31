import 'dart:developer';

class RetornoPopup {
  String? zip;
  String? codret;
  String? msgret;

  RetornoPopup({this.zip, this.codret, this.msgret});

  factory RetornoPopup.fromJson(Map<String, dynamic> json) {
    return RetornoPopup(
      zip: json['mtb']['retornapopupteste'].isEmpty
          ? ''
          : json['mtb']['retornapopupteste'][0]['POPUP'],
      codret: json['mtb']['codret'],
      msgret: json['mtb']['msgret'],
    );
  }
}
