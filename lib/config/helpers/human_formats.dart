
import 'package:intl/intl.dart';

class HumanFormats {

  static String number( double number ) {

    final formattedNumber = NumberFormat.compactCurrency(
        locale: 'es',
        decimalDigits: 1,
        symbol: '',
      ).format(number);

    return formattedNumber;

  }

}
