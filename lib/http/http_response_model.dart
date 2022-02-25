class ResponseModel {
  String? msg;
  String? code;
  final dynamic _data;

  Map<String, dynamic> get map {
    if (_data is Map) {
      return _data;
    } else {
      return {};
    }
  }

  List get list {
    if (_data is List) {
      return _data;
    } else {
      return [];
    }
  }

  String get string {
    if (_data is String) {
      return _data;
    }
    return '';
  }

  ResponseModel.fromJson(Map<String, dynamic> map)
      : msg = map['msg'],
        code = map['code'],
        _data = map['data'];
}
