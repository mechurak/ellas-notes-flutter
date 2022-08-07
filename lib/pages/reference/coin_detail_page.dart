import 'package:flutter/material.dart';

class CoinDetailPage extends StatelessWidget {
  final Map rates;

  const CoinDetailPage({required this.rates});

  @override
  Widget build(BuildContext context) {
    List currencies = rates.keys.toList();
    List exchangeRates = rates.values.toList();

    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: currencies.length,
          itemBuilder: (context, index) {
            String currency = currencies[index].toString().toUpperCase();
            String exchagneRage = exchangeRates[index].toString();
            return ListTile(
              title: Text(
                "$currency: $exchagneRage",
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
