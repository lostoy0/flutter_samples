extension StringExt on String {
  String formatZero({required int minZeroCount}) {
    // 检查字符串是否包含小数点
    if (!contains('.')) {
      return this;
    }

    // 分割整数部分和小数部分
    var parts = split('.');
    var integerPart = parts[0];
    var decimalPart = parts[1];

    // 计算小数部分中连续的零的数量
    var zeroCount = 0;
    while (zeroCount < decimalPart.length && decimalPart[zeroCount] == '0') {
      zeroCount++;
    }

    // 如果零的数量大于等于 minZeroCount，则格式化输出
    if (zeroCount >= minZeroCount) {
      return '$integerPart.0{${zeroCount-1}}${decimalPart.substring(zeroCount)}';
    } else {
      // 否则直接返回原字符串
      return this;
    }
  }
}
