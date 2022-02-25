extension StringConvert on int {
  String get stringify {
    String ret = '';
    int quot = this ~/ 10;
    int rem = this % 10;
    if (quot > 0) {
      ret += (quot * 10).toParse;
    }
    if (rem > 0) {
      ret += rem.toParse;
    }
    return ret;
  }

  String get toParse {
    String ret = '';
    switch (this) {
      case 0:
        ret = '零';
        break;
      case 1:
        ret = '一';
        break;
      case 2:
        ret = '二';
        break;
      case 3:
        ret = '三';
        break;
      case 4:
        ret = '四';
        break;
      case 5:
        ret = '五';
        break;
      case 6:
        ret = '六';
        break;
      case 7:
        ret = '七';
        break;
      case 8:
        ret = '八';
        break;
      case 9:
        ret = '九';
        break;
      case 10:
        ret = '十';
        break;
      case 20:
        ret = '二十';
        break;
      default:
    }
    return ret;
  }
}
