class Time {
  Time(this.date);

  DateTime date;

  List<String> weekDays = [
    "domingo",
    "segunda",
    "terça",
    "quarta",
    "quinta",
    "sexta",
    "sábado",
  ];

  List<String> completeWeekDays = [
    "domingo",
    "segunda-feira",
    "terça-feira",
    "quarta-feira",
    "quinta-feira",
    "sexta-feira",
    "sábado",
  ];

  List<String> months = [
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro",
  ];

  String weekDay({
    bool upperCase = false,
    bool completeWeekDay = false,
    bool capitalize = false,
  }) {
    String weekDay = completeWeekDay
        ? completeWeekDays[date.weekday]
        : weekDays[date.weekday];

    if (capitalize) {
      weekDay = weekDay[0].toUpperCase() + weekDay.substring(1);
    }

    if (upperCase) {
      weekDay = weekDay.toUpperCase();
    }
    return weekDay;
  }

  String month({
    bool upperCase = false,
    bool capitalize = false,
  }) {
    String month = months[date.month - 1];

    if (capitalize) {
      month = month[0].toUpperCase() + month.substring(1);
    }

    if (upperCase) {
      month = month.toUpperCase();
    }
    return month;
  }

  String dayDate({bool dotted = false}) {
    String _date =
        "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}";
    if (dotted) {
      _date.replaceAll("/", ".");
    }
    return _date;
  }

  String hour() =>
      "${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}";

  String completeDate({
    bool upperCase = false,
    bool completeWeekDay = false,
    bool capitalize = false,
    bool dotted = false,
  }) =>
      "${day(capitalize: capitalize, completeWeekDay: completeWeekDay, upperCase: upperCase)} ${dayDate(dotted: dotted)} ${hour()}";

  String day({
    bool capitalize = false,
    bool completeWeekDay = false,
    bool upperCase = false,
  }) {
    final now = DateTime.now();
    // print("date: $date");
    if (date.toString().substring(0, 10) == now.toString().substring(0, 10)) {
      return upperCase
          ? "HOJE"
          : capitalize
              ? "Hoje"
              : "hoje";
    }
    if (date.toString().substring(0, 6) == now.toString().substring(0, 6)) {
      if (date.day == now.day - 1) {
        return upperCase
            ? "ONTEM"
            : capitalize
                ? "Ontem"
                : "ontem";
      }
      if (date.day == now.day - 2) {
        return upperCase
            ? "ANTEONTEM"
            : capitalize
                ? "Antentem"
                : "anteontem";
      }
    }
    return weekDay(
      capitalize: capitalize,
      completeWeekDay: completeWeekDay,
      upperCase: upperCase,
    );
  }

  String dayHour({
    bool capitalize = false,
    bool completeWeekDay = false,
    bool upperCase = false,
  }) =>
      "${day(capitalize: capitalize, completeWeekDay: completeWeekDay, upperCase: upperCase)} ${hour()}";
}
