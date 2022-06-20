import 'package:test_task/companies.dart';

Map<String, String> currenciesImage = {
  'USD':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_States.svg/1600px-Flag_of_the_United_States.svg.png',
  'RUB':
      'https://upload.wikimedia.org/wikipedia/en/thumb/f/f3/Flag_of_Russia.svg/2560px-Flag_of_Russia.svg.png',
  'JPY':
      'https://upload.wikimedia.org/wikipedia/en/thumb/9/9e/Flag_of_Japan.svg/2560px-Flag_of_Japan.svg.png',
  'EUR':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/Flag_of_Europe.svg/2560px-Flag_of_Europe.svg.png',
  'CNY':
      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_the_People%27s_Republic_of_China.svg/2560px-Flag_of_the_People%27s_Republic_of_China.svg.png',
};

Map<String, String> currenciesSigns = {
  'USD': r'$',
  'RUB': '₽',
  'JPY': '¥',
  'EUR': '€',
  'CNY': '圓',
};

class Transaction {
  late DateTime dateTime;
  late double sum;
  late String currency;
  late Company person;
  Transaction(this.sum, this.currency, this.dateTime, this.person);
}

class Account {
  late int _id;
  late Map<String, String> balances;
  late List<Transaction> transactions;
  Account(id, this.balances, this.transactions) {
    _id = id;
  }

  String bill(String cur) {
    if (balances.containsKey(cur) && currenciesSigns.containsKey(cur)) {
      if (cur == 'USD') {
        return currenciesSigns['USD']! + balances['USD']!;
      } else {
        return currenciesSigns[cur]! + balances[cur]!;
      }
    }
    return '0';
  }


}

