import 'dart:math';

import 'package:dio/dio.dart';
import 'package:trade_quotes/util/urls.dart';

class Repository {
  Dio _dio;

  Response _response;

  Repository() {
    this._dio = Dio();
  }

  Future<Map> findAll() async {
    List list = await findAllCurrency();

    await findAllIndex().then((value) => value.forEach((element) {
          list.add(element);
        }));
    await findAllStocks().then((value) => value.forEach((element) {
          list.add(element);
        }));
    await findAllEtf().then((value) => value.forEach((element) {
          list.add(element);
        }));
    await findAllFuture().then((value) => value.forEach((element) {
          list.add(element);
        }));
    await findAllMutualFund().then((value) => value.forEach((element) {
          list.add(element);
        }));

    return list.asMap();
  }

  Future<List> findAllCurrency() async {
    List list = [];

    this._response = await this._dio.get(Urls.FIND_ALL_CURRENCY);

    list = this._response.data['currency'];

    return list;
  }

  Future<List> findAllStocks() async {
    List list = [];

    this._response = await this._dio.get(Urls.FIND_ALL_STOCKS);

    list = this._response.data['stocks'];

    return list;
  }

  Future<List> findAllIndex() async {
    List list = [];

    this._response = await this._dio.get(Urls.FIND_ALL_INDEX);

    list = this._response.data['index'];

    return list;
  }

  Future<List> findAllFuture() async {
    List list = [];

    this._response = await this._dio.get(Urls.FIND_ALL_FUTURE);

    list = this._response.data['future'];

    return list;
  }

  Future<List> findAllMutualFund() async {
    List list = [];

    this._response = await this._dio.get(Urls.FIND_ALL_MUTUAL_FUND);

    list = this._response.data['mutualFund'];

    return list;
  }

  Future<List> findAllEtf() async {
    List list = [];

    this._response = await this._dio.get(Urls.FIND_ALL_ETF);

    list = this._response.data['etf'];

    return list;
  }

  Future<Map> findAllReduc(int tamList) async {
    List list = [];

    var numAle = new Random();

    for (var i = 0; i < tamList; i++) {
      await findAllCurrency().then((value) => value.forEach((element) {
            if (double.parse(element['id'].toString()) ==
                numAle.nextInt(value.length)) {
              list.add(element);
            }
          }));

      await findAllIndex().then((value) => value.forEach((element) {
            if (double.parse(element['id'].toString()) ==
                numAle.nextInt(value.length)) {
              list.add(element);
            }
          }));
      await findAllStocks().then((value) => value.forEach((element) {
            if (double.parse(element['id'].toString()) ==
                numAle.nextInt(value.length)) {
              print(value.length);
              list.add(element);
            }
          }));
      await findAllEtf().then((value) => value.forEach((element) {
            if (double.parse(element['id'].toString()) ==
                numAle.nextInt(value.length)) {
              list.add(element);
            }
          }));
      await findAllFuture().then((value) => value.forEach((element) {
            if (double.parse(element['id'].toString()) ==
                numAle.nextInt(value.length)) {
              list.add(element);
            }
          }));
      await findAllMutualFund().then((value) => value.forEach((element) {
            if (double.parse(element['id'].toString()) ==
                numAle.nextInt(value.length)) {
              list.add(element);
            }
          }));
    }

    return list.asMap();
  }

  Future<Map> findAllCurrencyReduc(int tamList) async {
    List list = [];

    var numAle = new Random();

    for (var i = 0; i < tamList; i++) {
      await findAllCurrency().then((value) => value.forEach((element) {
            if (double.parse(element['id'].toString()) ==
                numAle.nextInt(value.length)) {
              list.add(element);
            }
          }));
    }

    return list.asMap();
  }

  Future<Map> findAllStocksReduc(int tamList) async {
    List list = [];

    var numAle = new Random();

    for (var i = 0; i < tamList; i++) {
      await findAllStocks().then((value) => value.forEach((element) {
            if (double.parse(element['id'].toString()) ==
                numAle.nextInt(value.length)) {
              list.add(element);
            }
          }));
    }

    return list.asMap();
  }

  Future<Map> findAllIndexReduc(int tamList) async {
    List list = [];

    int max = 20000;

    var numAle = new Random();

    for (var i = 0; i < tamList; i++) {
      await findAllIndex().then((value) => value.forEach((element) {
            if (double.parse(element['id'].toString()) ==
                numAle.nextInt(value.length)) {
              list.add(element);
            }
          }));
    }

    return list.asMap();
  }

  Future<Map> findAllFutureReduc(int tamList) async {
    List list = [];

    int max = 20000;

    var numAle = new Random();

    for (var i = 0; i < tamList; i++) {
      await findAllFuture().then((value) => value.forEach((element) {
            if (double.parse(element['id'].toString()) ==
                numAle.nextInt(value.length)) {
              list.add(element);
            }
          }));
    }

    return list.asMap();
  }

  Future<Map> findAllMutualFundReduc(int tamList) async {
    List list = [];

    int max = 20000;

    var numAle = new Random();

    for (var i = 0; i < tamList; i++) {
      await findAllMutualFund().then((value) => value.forEach((element) {
            if (double.parse(element['id'].toString()) ==
                numAle.nextInt(value.length)) {
              list.add(element);
            }
          }));
    }

    return list.asMap();
  }

  Future<Map> findAllEtfReduc(int tamList) async {
    List list = [];

    int max = 20000;

    var numAle = new Random();

    for (var i = 0; i < tamList; i++) {
      await findAllEtf().then((value) => value.forEach((element) {
            if (double.parse(element['id'].toString()) ==
                numAle.nextInt(value.length)) {
              list.add(element);
            }
          }));
    }

    return list.asMap();
  }
}
