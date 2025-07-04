
import 'package:intl/intl.dart';

class HumanFormats {

  static String number( double number ) {

    final formattedNumber = NumberFormat.compactCurrency(
        locale: 'en',
        decimalDigits: 0,
        symbol: '',
      ).format(number);

    return formattedNumber;

  }

}
