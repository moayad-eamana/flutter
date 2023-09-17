class convertDaysAndMonthToAR {
  static convertDayToAR(String day) {
    switch (day) {
      case "Sunday":
        {
          day = "الأحد";
        }
        break;
      case "Monday":
        {
          day = "الإثنين";
        }
        break;
      case "Tuesday":
        {
          day = "الثلاثاء";
        }
        break;
      case "Wednesday":
        {
          day = "الأربعاء";
        }
        break;
      case "Thursday":
        {
          day = "الخميس";
        }
        break;
      case "Saturday":
        {
          day = "السبت";
        }
        break;
      case "Friday":
        {
          day = "السبت";
        }
        break;
    }
    return day;
  }

  static getmonthname(String month) {
    switch (month) {
      case "01":
        {
          month = "يناير";
        }
        break;
      case "02":
        {
          month = "فبراير";
        }
        break;
      case "03":
        {
          month = "مارس";
        }
        break;
      case "04":
        {
          month = "أبريل";
        }
        break;
      case "05":
        {
          month = "مايو";
        }
        break;
      case "06":
        {
          month = "يونيو";
        }
        break;
      case "07":
        {
          month = "يوليو";
        }
        break;
      case "08":
        {
          month = "أغسطس";
        }
        break;
      case "09":
        {
          month = "سبتمبر";
        }
        break;
      case "10":
        {
          month = "اكتوبر";
        }
        break;
      case "11":
        {
          month = "نوفمبر";
        }
        break;
      case "12":
        {
          month = "ديسمبر";
        }
        break;
    }
    return month;
  }
}
