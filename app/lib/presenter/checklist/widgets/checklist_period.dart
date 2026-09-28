enum ChecklistPeriod { morning, afternoon, evening }

ChecklistPeriod periodForHour(int hour) {
  if (hour < 12) return ChecklistPeriod.morning;
  if (hour < 18) return ChecklistPeriod.afternoon;
  return ChecklistPeriod.evening;
}

String periodLabel(ChecklistPeriod period) {
  switch (period) {
    case ChecklistPeriod.morning:
      return 'Manhã';
    case ChecklistPeriod.afternoon:
      return 'Tarde';
    case ChecklistPeriod.evening:
      return 'Noite';
  }
}
