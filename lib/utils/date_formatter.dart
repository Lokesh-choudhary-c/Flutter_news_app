import 'package:intl/intl.dart';

String formatDate(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return '';
  try {
    final dateTime = DateTime.parse(dateStr);
    return DateFormat('d MMMM, y').format(dateTime);
  } catch (e) {
    return '';
  }
}
