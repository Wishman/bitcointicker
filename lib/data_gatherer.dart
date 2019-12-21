import 'package:http/http.dart' as http;
import 'dart:convert';

const bitCoinAverageURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class DataGatherer {
  final String url;

  DataGatherer(this.url);

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}

class PriceModel {
  Future<dynamic> getPrice(String currency) async {
    DataGatherer dataGatherer = DataGatherer('$bitCoinAverageURL/BTC$currency');
    return await dataGatherer.getData();
  }
}
