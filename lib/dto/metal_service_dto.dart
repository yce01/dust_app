import 'header_dto.dart';
import 'item_dto.dart';

class MetalServiceDTO {
  final HeaderDTO? header;
  final List<ItemDTO>? item;
  final String? rows;
  final int? numOfRows;
  final int? pageNo;
  final int? totalCount;

  MetalServiceDTO(
      {this.header,
      this.item,
      this.rows,
      this.numOfRows,
      this.pageNo,
      this.totalCount});

  factory MetalServiceDTO.fromJson(Map<String, dynamic> json) {
    List<ItemDTO> itemsValue = <ItemDTO>[];
    if (json['item'] != null) {
      itemsValue = <ItemDTO>[];
      json['item'].forEach((v) {
        itemsValue.add(new ItemDTO.fromJson(v));
      });
    }
    return MetalServiceDTO(
      header: json['header'] != null
          ? new HeaderDTO.fromJson(json['header'])
          : null,
      item: itemsValue,
      rows: json['rows'],
      numOfRows: json['numOfRows'],
      pageNo: json['pageNo'],
      totalCount: json['totalCount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header!.toJson();
    }
    if (this.item != null) {
      data['item'] = this.item!.map((v) => v.toJson()).toList();
    }
    data['rows'] = this.rows;
    data['numOfRows'] = this.numOfRows;
    data['pageNo'] = this.pageNo;
    data['totalCount'] = this.totalCount;
    return data;
  }
}
