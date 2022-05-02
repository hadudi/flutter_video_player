class ResponseModel {
  String? code;
  String? msg;
  final dynamic _data;

  ///data数据是对象，字典，map类型
  Map<String, dynamic> get map {
    if (_data is Map) {
      return _data;
    } else {
      return {};
    }
  }

  ///data数据是数组，list类型
  List get list {
    if (_data is List) {
      return _data;
    } else {
      return [];
    }
  }

  ///data数据是字符串类型
  String get string {
    if (_data is String) {
      return _data;
    }
    return '';
  }

  ResponseModel(this.code, this.msg, this._data);
  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel('${json['code']}', json['msg'], json['data']);
  }
}
