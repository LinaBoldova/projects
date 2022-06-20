import 'account_transactions.dart';
import 'companies.dart';

List<Account> accounts = [
  Account(
    1,
    {
      'USD': '180,970.83',
      'RUB': '0.00',
      'JPY': '0.00',
      'EUR': '0.00',
      'CNY': '0.00',
    },
    [
      Transaction(
        -55.31,
        'USD',
        DateTime(2022, 06, 20, 12, 23),
        companies[0],
      ),
      Transaction(
        -55.31,
        'USD',
        DateTime(2022, 06, 20, 12, 23),
        companies[1],
      ),
      Transaction(
        -55.31,
        'USD',
        DateTime(2022, 06, 20, 12, 23),
        companies[4],
      ),
      Transaction(
        -300.00,
        'USD',
        DateTime(2022, 06, 20, 12, 23),
        companies[7],
      ),
      Transaction(
        131.31,
        'USD',
        DateTime(2022, 06, 20, 12, 23),
        companies[8],
      ),
      Transaction(
        -500.31,
        'USD',
        DateTime(2022, 12, 11, 12, 23),
        companies[6],
      ),
      Transaction(
        -500.31,
        'USD',
        DateTime(2022, 12, 11, 12, 23),
        companies[2],
      ),
      Transaction(
        -500.31,
        'USD',
        DateTime(2022, 12, 9, 12, 23),
        companies[3],
      ),
      Transaction(
        -500.31,
        'USD',
        DateTime(2022, 12, 9, 12, 23),
        companies[5],
      ),
    ],
  ),
];
