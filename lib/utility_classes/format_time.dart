class TimeFormatter {
  static String formatDate(DateTime time) {
    String tempMonth = '';
    List<String> listOfMonths = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    switch (time.month) {
      case 1:
        tempMonth = listOfMonths[0];
        break;
      case 2:
        tempMonth = listOfMonths[1];
        break;
      case 3:
        tempMonth = listOfMonths[2];
        break;
      case 4:
        tempMonth = listOfMonths[3];
        break;
      case 5:
        tempMonth = listOfMonths[4];
        break;
      case 6:
        tempMonth = listOfMonths[5];
        break;
      case 7:
        tempMonth = listOfMonths[6];
        break;
      case 8:
        tempMonth = listOfMonths[7];
        break;
      case 9:
        tempMonth = listOfMonths[8];
        break;
      case 10:
        tempMonth = listOfMonths[9];
        break;
      case 11:
        tempMonth = listOfMonths[9];
        break;
      case 12:
        tempMonth = listOfMonths[10];
        break;
    }

    return '${time.day} $tempMonth ${time.year}';
  }
}
