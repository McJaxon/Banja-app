main() {
  print(calculateAmount(400000, 2.75, 4, 2));
}

calculateAmount(var principal, var rate, var time, var remittanceSchedule) {
  double interest = (principal * rate * time) / 100;
  double amount = interest + principal;
  double payable = (amount / time);

  var variable = (time == 4 && remittanceSchedule == 1) ||
          (time == 3 && remittanceSchedule == 2)
      ? 1
      : time == 3 && remittanceSchedule == 1
          ? 2
          : 3;

  switch (variable) {
    case 1:
      return {
        'interest': interest.round(),
        'total_amount': amount.round(),
        'total_payback': payable.round(),
        'payback_breakdown': payable.round()
      };

    case 2:
      return {
        'interest': interest.round(),
        'total_amount': amount.round(),
        'payback': payable.round(),
        'payback_breakdown': (payable / 4).round()
      };
    case 3:
      return {
        'interest': interest.round(),
        'total_amount': amount.round(),
        'payback': payable.round(),
        'payback_breakdown': (payable * 4).round()
      };

    default:
  }
}
