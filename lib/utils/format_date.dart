import 'package:flutter/cupertino.dart';
import 'package:timeago/timeago.dart' as timeago;

extension TimeAgoFormat on DateTime {
  String toTimeAgo(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return timeago.format(this, locale: locale == 'vi' ? 'vi' : 'en');
  }
}