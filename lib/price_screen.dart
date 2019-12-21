//import 'package:bitcoin_ticker/data_gatherer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // 2.1(b)
import 'dart:io' show Platform; // 3.6(a)
import 'coin_data.dart';
//import 'data_gatherer.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD'; // 1.3(a) with starting value of USD // AUD per 5.1

  // 3.1
  DropdownButton<String> androidDropdown() {
    // 3.2
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      dropDownItems.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }
    return DropdownButton<String>(
        value: selectedCurrency, // 1.2 & 1.3 (b) & 1.4(c)
        items: dropDownItems, // 3.2 !! (expects list of items to display)
        onChanged: (value) {
          setState(() {
            selectedCurrency = value; // 1.3(c)
            getData(); // 5.2
          });
        });
  }

  // 3.3
  CupertinoPicker iOSPicker() {
    // 3.5 or before 2.2 (a)
    List<Text> pickerItems = []; // or List<Widget>
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    // 3.4
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex]; // 2.2 (b)  // update 5.3
        getData();
      },
      children: pickerItems, // 2.2 (b) and 3.5!!
    );
  }

  /*
  // 3.6 (b) - obsolete with ternary operator in containter child!
  Widget selectButton() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return androidDropdown();
    }
  }
  */

  // -----
  //String bitCoinValueInUSD = '?'; // 4.4 obsolete
  String bitCoinValue = '?';

  /* my version
  void updateUI(String currency) async {
    var priceData = await priceModel.getPrice(currency);
    setState(() {
      price = priceData['last'].toInt();
    });
  }
  */
  // 4.5
  void getData() async {
    try {
      double data = await CoinData().getCoinData(selectedCurrency); // 5.5
      setState(() {
        bitCoinValue = data.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  // 4.6
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $bitCoinValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            // 1.1 add dropdown Button & 2.1(c) Cupertino Picker
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

/*

 */
