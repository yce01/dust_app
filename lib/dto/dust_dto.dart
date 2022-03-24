import 'metal_service_dto.dart';

class DustDTO {
  final MetalServiceDTO? metalService;

  DustDTO({this.metalService});

  factory DustDTO.fromJson(Map<String, dynamic> json) {
    return DustDTO(
        metalService : json['MetalService'] != null
            ? new MetalServiceDTO.fromJson(json['MetalService'])
            : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.metalService != null) {
      data['MetalService'] = this.metalService!.toJson();
    }
    return data;
  }
}