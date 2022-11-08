class Urls {
  static final IP = '192.168.42.80';
  // static final IP = '192.168.0.4';
  // static final IP = '192.168.0.3';

  static final URL = 'http://${IP}:8000/api/';

  static final FIND_ALL_STOCKS = '${URL}find_all_stocks/';
  static final FIND_ALL_CURRENCY = '${URL}find_all_currency/';
  static final FIND_ALL_INDEX = '${URL}find_all_index/';
  static final FIND_ALL_ETF = '${URL}find_all_etf/';
  static final FIND_ALL_MUTUAL_FUND = '${URL}find_all_mutual_fund/';
  static final FIND_ALL_FUTURE = '${URL}find_all_future/';
}
