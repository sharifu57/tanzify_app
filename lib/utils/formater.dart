// String formatMoney(dynamic number, {String? currency}) {
//   var num = number.toString();
//   currency = currency == null ? "" : "$currency ";

//   if (num.isEmpty) return "${currency}0";

//   return "$currency${NumberFormat('#,###,###').format(double.parse(num))}";
// }

// String formatDate(
//   dynamic date, {
//   String? format = 'yyyy-MM-dd',
//   String? locale = "en",
// }) {
//   if (date == null) return "";

//   DateTime dateTime;

//   if (date is DateTime) {
//     dateTime = date;
//   } else if (date is String)
//     dateTime = DateTime.parse(date);
//   else
//     return "";

//   if (["dayM", "dayMY"].contains(format)) {
//     var suffix = "th";
//     var digit = dateTime.day % 10;
//     if ((digit > 0 && digit < 4) && (dateTime.day < 11 || dateTime.day > 13)) {
//       suffix = ["st", "nd", "rd"][digit - 1];
//     }

//     // return DateFormat("MMMM d'$suffix'", locale).format(date);
//     var formattedDate = DateFormat("MMMM d'$suffix'").format(dateTime);
//     if (dateTime.year != DateTime.now().year || format == "dayMY")
//       formattedDate += ", ${dateTime.year}";

//     return formattedDate;
//   }

//   return DateFormat(format).format(date);
// }
