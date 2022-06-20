import 'package:flutter/material.dart';
import 'account_transactions.dart';
import 'package:intl/intl.dart';

import 'accounts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.keyboard_backspace_outlined),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.ios_share),
            )
          ],
        ),
        body: AccountStatus(
          account: accounts[0],
        ),
      ),
    );
  }
}

class AccountStatus extends StatefulWidget {
  late final Account mainAccount;
  late final String currentCurrency;
  AccountStatus({Key? key, required Account account}) : super(key: key) {
    mainAccount = account;
    currentCurrency = account.balances.keys.first;
  }

  @override
  State<AccountStatus> createState() => _AccountStatusState();
}

class _AccountStatusState extends State<AccountStatus> {
  String getCurrencySum(double sum) {
    if (widget.currentCurrency == 'USD') {
      return ((sum.sign == -1.0) ? '- ' : '+ ') +
          r'$' +
          sum.abs().toString() +
          ' ' +
          widget.currentCurrency;
    } else {
      return ((sum.sign == -1.0) ? '- ' : '+ ') +
          sum.abs().toString() +
          currenciesSigns[widget.currentCurrency]!;
    }
  }

  CircleAvatar avatar(String? image, bool isNotPos) {
    return image != null
        ? CircleAvatar(
            backgroundImage: AssetImage(
              image,
            ),
            backgroundColor: Theme.of(context).listTileTheme.tileColor,
          )
        : CircleAvatar(
            backgroundColor: Theme.of(context).backgroundColor,
            child: CircleAvatar(
              child: Icon(
                (isNotPos) ? Icons.arrow_forward_outlined : Icons.arrow_back_outlined,
                color: Theme.of(context).listTileTheme.iconColor,
              ),
              backgroundColor: Theme.of(context).listTileTheme.tileColor,
            ),
          );
  }

  Widget accountTransactions() {

    bool isYesterday(DateTime dt) {
      var now = DateTime.now();
      return (DateTime(dt.year, dt.month, dt.day).difference(DateTime(now.year, now.month, now.day)).inDays == -1);
    }

    bool isSameDate(DateTime first, DateTime second) {
      return first.year == second.year && first.month == second.month && first.day == second.day;
    }

    bool printDate(int tmp) {
      if (tmp >= widget.mainAccount.transactions.length - 1) {
        return false;
      } else {
        if (isSameDate(widget.mainAccount.transactions[tmp].dateTime,
            widget.mainAccount.transactions[tmp + 1].dateTime)) {
          return false;
        } else {
          return true;
        }
      }
    }

    return Expanded(
      child: Container(
        color: Theme.of(context).listTileTheme.tileColor,
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.mainAccount.transactions.length + 1,
          itemBuilder: (BuildContext context, int index) {
            return (index == 0)
                ? Container(
                    height: 47,
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    color: Theme.of(context).canvasColor,
                    child: Text(
                      isYesterday(widget.mainAccount.transactions[0].dateTime)
                          ? 'Yesterday'
                          : DateFormat('EEE, MMM d')
                              .format(widget.mainAccount.transactions[0].dateTime)
                              .toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                    tileColor: Theme.of(context).listTileTheme.tileColor,
                    leading: Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: avatar(
                        widget.mainAccount.transactions[index - 1].person.image,
                        widget.mainAccount.transactions[index - 1].sum.isNegative,
                      ),
                    ),
                    title: Text(
                      widget.mainAccount.transactions[index - 1].person.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        getCurrencySum(widget.mainAccount.transactions[index - 1].sum),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.Hm().format(
                        widget.mainAccount.transactions[index - 1].dateTime,
                      ),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  );
          },
          separatorBuilder: (BuildContext context, int index) => (index == 0)
              ? const SizedBox()
              : (printDate(index - 1)
                  ? Container(
                      height: 47,
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 10,
                        bottom: 10,
                      ),
                      color: Theme.of(context).canvasColor,
                      child: Text(
                        DateFormat('EEE, MMM d')
                            .format(widget.mainAccount.transactions[index].dateTime)
                            .toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  : const Divider()),
        ),
      ),
    );
  }

  Widget accountBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      color: Theme.of(context).backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            minRadius: 30,
            maxRadius: 50,
            backgroundImage: NetworkImage(currenciesImage[widget.currentCurrency]!),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                height: 40,
                width: 70,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  widget.currentCurrency + ' Account',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Theme.of(context).shadowColor,
                    width: 0.3,
                  ),
                ),
                height: 40,
                width: 70,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Hide',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              widget.mainAccount.bill(widget.currentCurrency),
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget transactionsMenu() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Container(
            child: Text(
              'Transactions History',
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.start,
            ),
            margin: const EdgeInsets.only(
              left: 4,
            ),
            padding: const EdgeInsets.only(left: 12, top: 12),
            alignment: Alignment.centerLeft,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 9,
            ),
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              border: Border.all(
                color: Theme.of(context).shadowColor,
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    'USD Dollar',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  padding: const EdgeInsets.only(left: 6),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 9,
                  ),
                  margin: const EdgeInsets.only(right: 12, left: 12, bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      color: Theme.of(context).shadowColor,
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          'All',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 9,
                    horizontal: 9,
                  ),
                  margin: const EdgeInsets.only(right: 12, bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(
                      color: Theme.of(context).shadowColor,
                      width: 0.5,
                    ),
                  ),
                  child: const Icon(Icons.calendar_today_outlined)),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                accountBar(),
                transactionsMenu(),
                accountTransactions(),
                Container(
                  height: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
