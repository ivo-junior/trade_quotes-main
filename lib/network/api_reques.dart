import 'dart:async';
import 'dart:convert' as Convert;
import 'dart:io';
import 'package:finance_quote/finance_quote.dart';
import 'package:http/http.dart' as Http;
import 'package:trade_quotes/data/repository.dart';

import 'package:trade_quotes/models/lists.dart' as MarketLists;
import 'package:trade_quotes/models/ativo.dart';
import 'package:trade_quotes/models/charts.dart' as Charts;
import 'package:trade_quotes/models/lists.dart';

class ApiReques {
  static ApiReques _sIexApiProxyInstance;
  // final Http.Client httpClient = Http.Client();

  Repository _repository;

  ApiReques() {
    print('Instantiating instance!!');
    _repository = Repository();
  }

  static getInstance() {
    if (_sIexApiProxyInstance == null) {
      _sIexApiProxyInstance = ApiReques();
    }
    return _sIexApiProxyInstance;
  }

  Future<List<MarketLists.MarketList>> fetchAList(
      MarketLists.MarketListType marketListType) async {
    var list;
    switch (marketListType) {
      case MarketLists.MarketListType.GAINERS:
        list =
            await lists(await _repository.findAllEtfReduc(20), marketListType);
        break;
      case MarketLists.MarketListType.LOSERS:
        list = await lists(
            await _repository.findAllIndexReduc(20), marketListType);
        break;
      case MarketLists.MarketListType.STOCKS:
        list = await lists(
            await _repository.findAllCurrencyReduc(20), marketListType);
        // await _repository.findAllStocksReduc(50), marketListType);
        break;
      // case MarketLists.MarketListType.CRIPTO:
      //   list = await lists(
      //       await _repository.findAllCurrencyReduc(15), marketListType);
      //   break;

      // case MarketLists.MarketListType.FUTURE:
      //   list = await lists(
      //       await _repository.findAllFutureReduc(15), marketListType);
      //   break;

      // case MarketLists.MarketListType.INDEX:
      //   list = await lists(
      //       await _repository.findAllIndexReduc(15), marketListType);
      //   break;

      // case MarketLists.MarketListType.MUTUAL_FUND:
      //   list = await lists(
      //       await _repository.findAllMutualFundReduc(15), marketListType);
      //   break;

      // case MarketLists.MarketListType.ETF:
      //   list =
      //       await lists(await _repository.findAllEtfReduc(15), marketListType);
      //   break;
    }

    return list;
  }

  Future<List<MarketLists.MarketList>> lists(
      Map symbols, MarketLists.MarketListType marketListType) async {
    MarketList _marketList;
    Ativo _ativo;
    var list1;

    List list;

    List<MarketLists.MarketList> lsMarket = [];

    list1 = fetchAtivos(symbols);

    List list2 = list1;

    if (list2.length > 10) {
      switch (marketListType) {
        case MarketLists.MarketListType.GAINERS:
          // list2.sort((a, b) => double.parse(b.changePercent)
          //     .compareTo(double.parse(a.changePercent)));
          list = list2;

          break;
        case MarketLists.MarketListType.LOSERS:
          // list2.sort((a, b) => double.parse(a.changePercent)
          //     .compareTo(double.parse(b.changePercent)));
          list = list2;

          break;
        case MarketLists.MarketListType.STOCKS:
          list = list1;
          break;
        case MarketLists.MarketListType.CRIPTO:
          list = list1;
          break;
        case MarketLists.MarketListType.FUTURE:
          list = list1;
          break;
        case MarketLists.MarketListType.ETF:
          list = list1;
          break;
        case MarketLists.MarketListType.INDEX:
          list = list1;
          break;
        case MarketLists.MarketListType.MUTUAL_FUND:
          list = list1;
          break;
      }

      for (var i = 0; i < list.length; i++) {
        _ativo = await list.elementAt(i);
        _marketList = MarketLists.MarketList(marketListType, _ativo);

        lsMarket.add(_marketList);
      }

      return lsMarket;
    } else {
      return fetchAList(marketListType);
    }
  }

  Future<List<Ativo>> fetchCollectionsFor(String sector) async {
    print("Fetching $sector!");
    List<Ativo> list = [];

    List<MarketLists.MarketList> lsMarket;
    print('object');
    switch (sector) {
      case "STOCKS":
        list = await fetchAtivos(await _repository.findAllStocksReduc(10));
        break;
      case "CRIPTO":
        list = await fetchAtivos(await _repository.findAllCurrencyReduc(10));
        break;
      case "FUTURE":
        list = await fetchAtivos(await _repository.findAllFutureReduc(10));
        break;
      case "ETF":
        list = await fetchAtivos(await _repository.findAllEtfReduc(10));
        break;
      case "INDEX":
        list = await fetchAtivos(await _repository.findAllIndexReduc(10));
        break;
      case "MUTUAL_FUND":
        list = await fetchAtivos(await _repository.findAllMutualFundReduc(10));
        break;
    }

    return list;
  }

  Future<Charts.ChartModel> fetchChartData(
      String symbol, Charts.ChartDurations duration,
      [int interval]) async {
    Charts.ChartModel chartModel;
    // await httpClient
    //     .get(Uri.parse(
    //         '$_sEndpointStable${Charts.ChartModel.constructEndpoint(symbol, duration, interval)}${
    //         interval != null ? '&' : '?'
    //         }$_sToken')

    // )
    //     .then((response){
    //   return response.body;
    // })
    //     .then(Convert.json.decode)
    //     .then((chartData) {
    //   chartModel = Charts.ChartModel(symbol, duration, interval, chartData);
    // });

    return chartModel;
  }

  dispose() {
    _sIexApiProxyInstance = null;
  }

  List fetchAtivos(Map symbols) {
    Future<Ativo> _ativo;
    // Ativo _ativo;
    var list = [];

    int tamSymbols = symbols.length;

    symbols.forEach((key, value) {
      _ativo = fetchSingleAtivo(value['symbol']);

      if (_ativo != null) {
        list.add(_ativo);
      } else {
        print('object null');
        tamSymbols--;
      }
    });

    if (list.length == tamSymbols) {
      // print('123 ${list.length}');
      return list;
    }
  }

  Future<Ativo> fetchSingleAtivo(String symbol) async {
    Ativo ativo;

    try {
      final Map<String, Map<String, dynamic>> quotePrice =
          await FinanceQuote.getRawData(
              quoteProvider: QuoteProvider.yahoo, symbols: <String>[symbol]);

      if (quotePrice != null) {
        ativo = Ativo();
        ativo.symbol = symbol;

        ativo.open = quotePrice[symbol]['regularMarketOpen'].toString();
        ativo.low = quotePrice[symbol]['regularMarketDayLow'].toString();
        ativo.high = quotePrice[symbol]['regularMarketDayHigh'].toString();
        ativo.price = quotePrice[symbol]['regularMarketPrice'].toString();
        ativo.change = quotePrice[symbol]['regularMarketChange'].toString();
        ativo.changePercent =
            quotePrice[symbol]['regularMarketChangePercent'].toString();
        ativo.avgTotalVolume =
            quotePrice[symbol]['regularMarketVolume'].toString();
        ativo.companyName = quotePrice[symbol]['longName'].toString();
        ativo.currency = quotePrice[symbol]['currency'].toString();
        ativo.latestTime = quotePrice[symbol]['regularMarketTime'].toString();
        ativo.delayedPrice =
            quotePrice[symbol]['exangeDataDelayadBy'].toString();
        ativo.peRatio = quotePrice[symbol].keys.length.toString();
        ativo.primaryExchange =
            quotePrice[symbol]['fullExchangeName'].toString();

        return ativo;
      }
    } catch (e) {
      return null;
    }
  }
}
