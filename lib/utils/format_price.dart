import 'package:intl/intl.dart';

extension CurrencyFormatting on num {
  String toCurrency({String locale = 'vi_VN'}) {
    var formatter = NumberFormat.simpleCurrency(locale: locale);
    return formatter.format(this);
  }
}
