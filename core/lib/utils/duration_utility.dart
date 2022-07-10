// class DateTimeUtility {
//   static const String _locale = 'en.json';
//
//   static DateFormat timeFormat = DateFormat('K:mm a', _locale);
//
//   static String durationFormat(
//       Duration duration, {
//         bool withHours = true,
//       }) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
//     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
//     List<String> values = <String>[twoDigitSeconds, twoDigitMinutes];
//
//     if (withHours) values.add(twoDigits(duration.inHours));
//
//     return values.reversed.join(':');
//   }
// }