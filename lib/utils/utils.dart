  import 'package:flutter/material.dart';
import 'package:greeksinergy_tech_movie_app/views/widgets/auth_gate.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

String customText(int cutoff, String text) {
    return (text.length <= cutoff) ? text : '${text.substring(0, cutoff)}...';
  }

String formatTimestamp(int timestamp) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  String dayWithSuffix = getDayWithSuffix(date.day);
  String month = DateFormat('MMMM').format(date);
  return '$dayWithSuffix $month';
}
  String getDayWithSuffix(int day) {
  if (day >= 11 && day <= 13) {
    return '${day}th';
  }
  switch (day % 10) {
    case 1:
      return '${day}st';
    case 2:
      return '${day}nd';
    case 3:
      return '${day}rd';
    default:
      return '${day}th';
  }
}

void logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('email');
  await prefs.remove('password');
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => AuthGatePage(),
  ));
}