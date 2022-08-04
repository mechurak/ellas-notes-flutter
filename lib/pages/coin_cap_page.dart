import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../services/http_service.dart';

class CoinCapPage extends StatefulWidget {
  const CoinCapPage({Key? key}) : super(key: key);

  @override
  State<CoinCapPage> createState() => _CoinCapPageState();
}

class _CoinCapPageState extends State<CoinCapPage> {
  double? _deviceHeight, _deviceWidth;
  HttpService? _http;

  @override
  void initState() {
    super.initState();
    _http = GetIt.instance.get<HttpService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _selectedCoinDropDown(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _selectedCoinDropDown() {
    List<String> coins = ["bitcoin"];
    List<DropdownMenuItem<String>> items = coins
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Text(
              e,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
        .toList();
    return DropdownButton(
      value: coins.first,
      items: items,
      onChanged: (value) {},
      dropdownColor: const Color.fromRGBO(83, 88, 206, 1.0),
      iconSize: 30,
      icon: const Icon(Icons.arrow_drop_down_sharp, color: Colors.white),
      underline: Container(),
    );
  }
}
