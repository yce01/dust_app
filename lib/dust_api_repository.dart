import 'dart:convert';

import 'package:dust_app/dto/dust_dto.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'dto/item_dto.dart';

class DustApiRepository{
  // Future<DustDTO> getData() async{
  //   String serviceKey = 'k%2FnvUukcVq9w7HLnHS03TEXra7Jomzfb%2BLjl3tdirxE887d9CKnYeLL4VXIvyF6m1LFZl%2FSjcGElC955tRUuDQ%3D%3D';
  //    int stationcode = 8;
  //   String itemcode = '90303';
  //   String timecode = 'RH24';
  //   // date = DateFormat.yMMMd('ko_KR').format(DateTime.now());
  //   var url = Uri.parse(
  //       'http://apis.data.go.kr/1480523/MetalMeasuringResultService/MetalService?serviceKey=$serviceKey&pageNo=1&numOfRows=12&resultType=JSON&date=20220323100000&stationcode=$stationcode&itemcode=$itemcode&timecode=$timecode');
  //   http.Response response;
  //   response = await http.get(url);
  //   var rootData = json.decode(response.body) as Map<String, dynamic>;
  //   DustDTO data = DustDTO.fromJson(rootData);
  //   return data;
  // }
}