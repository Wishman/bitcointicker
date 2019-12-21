import 'package:http/http.dart' as http; //4.1
import 'dart:convert'; // 4.1

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const bitCoinAverageURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker'; //4.2

class CoinData {
  Future getCoinData() async {
    String requestURL = '$bitCoinAverageURL/BTCUSD';
    http.Response response = await http.get(requestURL);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['last'];
    } else {
      print(response.statusCode);
      throw 'Problem with get request!';
    }
  }
}
