import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dto/dust_dto.dart';

import 'package:flutter/material.dart';

import 'dto/item_dto.dart';
import 'dto/metal_service_dto.dart';

void main() {
  runApp(const DustApp());
}

class DustApp extends StatefulWidget {
  const DustApp({Key? key}) : super(key: key);

  @override
  _DustAppState createState() => _DustAppState();
}

class _DustAppState extends State<DustApp> {
  Future<MetalServiceDTO>? _dustDTO;

  Future<MetalServiceDTO> getData() async {
    var now = DateTime.now();
    var dateFormat = 'yyyyMMdd';
    // String serviceKey = 'k%2FnvUukcVq9w7HLnHS03TEXra7Jomzfb%2BLjl3tdirxE887d9CKnYeLL4VXIvyF6m1LFZl%2FSjcGElC955tRUuDQ%3D%3D';
    // int stationcode = 8;
    // String itemcode = '90303';
    // String timecode = 'RH24';
    String date = DateFormat(dateFormat).format(now);
    var url = Uri.parse(
        'http://apis.data.go.kr/1480523/MetalMeasuringResultService/MetalService?serviceKey=k%2FnvUukcVq9w7HLnHS03TEXra7Jomzfb%2BLjl3tdirxE887d9CKnYeLL4VXIvyF6m1LFZl%2FSjcGElC955tRUuDQ%3D%3D&pageNo=1&numOfRows=12&resultType=JSON&date=$date&stationcode=8&itemcode=90303&timecode=RH24');
    final response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    DustDTO dustDTO = DustDTO.fromJson(json.decode(response.body));
    MetalServiceDTO serviceDTO =
        dustDTO.metalService!; //DustDTO 안의 MetalServiceDTO에 접근하기 위해
    return serviceDTO;
  }

  @override
  void initState() {
    super.initState();
    _dustDTO = getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '미세먼지',
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              '미세먼지',
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Center(
            child: FutureBuilder<MetalServiceDTO>(
                future: _dustDTO,
                builder: (context, snapshot) {
                  ItemDTO dto = ItemDTO(); //현재 비어있음
                  int temp = 0;
                  if (snapshot.hasData) {
                    for (var element in snapshot.data!.item!) {
                      if (temp == 0) {
                        dto = ItemDTO(
                            sdate: element.sdate,
                            stationcode: element.stationcode,
                            itemcode: element.itemcode,
                            timecode: element.timecode,
                            value: element.value);
                        temp++;
                      } else {
                        if (num.parse(dto.sdate!) < num.parse(element.sdate!)) {  //date가 가장 큰 값 찾는 과정
                          dto = ItemDTO(
                              sdate: element.sdate,
                              stationcode: element.stationcode,
                              itemcode: element.itemcode,
                              timecode: element.timecode,
                              value: element.value);
                          temp++;
                        }
                      }
                    }
                    String text(ItemDTO dto) {
                      if (dto.value! < 5) {
                        return '아주 좋음';
                      } else if (dto.value! < 10) {
                        return '좋음';
                      } else if (dto.value! < 15) {
                        return '보통';
                      } else if (dto.value! < 20) {
                        return '나쁨';
                      } else if (dto.value! < 30) {
                        return '매우 나쁨';
                      } else
                        return '최악';
                    }

                    String icon(ItemDTO dto) {
                      if (dto.value! < 5) {
                        return 'assets/happy.png';
                      } else if (dto.value! < 10) {
                        return 'assets/smile.png';
                      } else if (dto.value! < 15) {
                        return 'assets/normal.png';
                      } else if (dto.value! < 20) {
                        return 'assets/bad.png';
                      } else if (dto.value! < 30) {
                        return 'assets/very_bad.png';
                      } else
                        return 'assets/worst.png';
                    }

                    Color backgroundColor(ItemDTO dto) {
                      if (dto.value! < 5) {
                        return Colors.tealAccent;
                      } else if (dto.value! < 10) {
                        return Colors.lightGreenAccent;
                      } else if (dto.value! < 15) {
                        return Colors.white70;
                      } else if (dto.value! < 20) {
                        return Colors.yellowAccent;
                      } else if (dto.value! < 30) {
                        return Colors.orangeAccent;
                      } else
                        return Colors.redAccent;
                    }

                    var now = DateTime.now();
                    var dateFormat = 'yyyy년 MM월 dd일';
                    var timeFormat = 'HH시 mm분';

                    return Container(
                      width: double.infinity,
                      color: backgroundColor(dto),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(padding: EdgeInsets.all(50)),
                          Text(
                            DateFormat(dateFormat).format(now),   //날짜
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            DateFormat(timeFormat).format(now),   //시간
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${dto.value?.floor()}',    //미세먼지 수치
                            style: const TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // const Image(image: AssetImage('assets/happy.png')),
                          Image.asset(icon(dto), height: 100),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            text(dto),
                            style: const TextStyle(fontSize: 40),
                          )
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                }),
          ),
        ));
  }
}
