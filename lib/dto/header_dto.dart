class HeaderDTO {
  final String? code;
  final String? message;

  HeaderDTO({this.code, this.message});

  factory HeaderDTO.fromJson(Map<String, dynamic> json) {
    return HeaderDTO(
        code : json['code'],
        message : json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}