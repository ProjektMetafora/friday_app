import 'package:credit_card_slider/card_background.dart';
import 'package:credit_card_slider/card_company.dart';
import 'package:credit_card_slider/card_network_type.dart';
import 'package:credit_card_slider/credit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:friday_app/contrauikit/login/contra_text.dart';
import 'package:friday_app/contrauikit/utils/colors.dart';
import 'package:friday_app/ui/navigation_drawer/collapsible_navigation_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(left: 70),
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    color: white,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 24,
                        ),
                        ContraText(
                          text: 'Friday',
                          alignment: Alignment.centerLeft,
                          size: 35,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        FittedBox(
                          child: CreditCard(
                            cardBackground: SolidColorCardBackground(
                                Colors.black.withOpacity(0.6)),
                            cardNetworkType: CardNetworkType.visaBasic,
                            cardHolderName: 'The boring developer',
                            cardNumber: '1234 **** **** ****',
                            company: CardCompany.hdfc,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        ContraText(
                          text: 'Transactions',
                          alignment: Alignment.centerLeft,
                          size: 35,
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Column(
                          children: [
                            Card(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: ListTile(
                                  title: Text('Reliance Fresh'),
                                  leading: Text('-\$300.20'),
                                  subtitle: Text('TXN ID: 23412389712387'),
                                  tileColor: flamingo.withOpacity(0.8),
                                ),
                              ),
                              elevation: 0,
                            ),
                            Card(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: ListTile(
                                  title: Text('Amazon'),
                                  leading: Text('+\$120.10'),
                                  subtitle: Text('TXN ID: 23482734234098'),
                                  tileColor: carribean_green.withOpacity(0.8),
                                ),
                              ),
                              elevation: 0,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    height: constraints.maxHeight,
                    child: CollapsibleNavigationDrawer(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
