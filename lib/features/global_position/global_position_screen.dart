import 'package:flutter/material.dart';
import 'package:niu_part2/features/global_position/screens/account_screen.dart';
import 'package:niu_part2/features/global_position/screens/alert_screen.dart';
import 'package:niu_part2/features/global_position/screens/contract_screen.dart';
import 'package:niu_part2/features/global_position/screens/mailbox_screen.dart';
import 'package:niu_part2/features/global_position/screens/propertie_screen.dart';
import 'package:niu_part2/features/global_position/widgets/custom_card.dart';

class GlobalPositionScreen extends StatelessWidget {
  const GlobalPositionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          CustomCard(
            title: 'Properties',
            description: 'Here you can find your appartments',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PropertieScreen(),
                ),
              );
            },
            imagePath: 'assets/images/vivendes.png',
          ),
          CustomCard(
            title: 'Alerts',
            description: 'Here you can manage your daily life as owner',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AlertScreen(),
                ),
              );
            },
            imagePath: 'assets/images/alert.png',
          ),
          CustomCard(
            title: 'Accounting',
            description: 'Here you can manage your creditors and debtors ',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountScreen(),
                ),
              );
            },
            imagePath: 'assets/images/conta.png',
          ),
          CustomCard(
            title: 'Contracts',
            description: 'Sign contracts and find all documents here',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContractScreen(),
                ),
              );
            },
            imagePath: 'assets/images/agreement.png',
          ),
          CustomCard(
            title: 'Mailbox',
            description: 'here you can chat with other contracting parties',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MailboxScreen(),
                ),
              );
            },
            imagePath: 'assets/images/misatge.png',
          )
        ],
      ),
    );
  }
}
