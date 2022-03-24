import 'package:intl/intl.dart';

class ItemDTO {
  final String? sdate;
  final int? stationcode;
  final String? itemcode;
  final String? timecode;
  final double? value;

  ItemDTO(
      {this.sdate, this.stationcode, this.itemcode, this.timecode, this.value});

  factory ItemDTO.fromJson(Map<String, dynamic> json) {
    // DateTime dateTime = DateTime.parse(json['SDATE']);
    // String dateTimeString = DateFormat.yMd('ko_KR').format(dateTime);
    return ItemDTO(
      sdate: json['SDATE'],
      stationcode: json['STATIONCODE'],
      itemcode: json['ITEMCODE'],
      timecode: json['TIMECODE'],
      value: json['VALUE'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SDATE'] = this.sdate;
    data['STATIONCODE'] = this.stationcode;
    data['ITEMCODE'] = this.itemcode;
    data['TIMECODE'] = this.timecode;
    data['VALUE'] = this.value;
    return data;
  }
}
