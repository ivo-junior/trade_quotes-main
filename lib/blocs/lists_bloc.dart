import 'dart:async';

import 'package:trade_quotes/models/lists.dart' as Lists;
import 'package:trade_quotes/network/api_reques.dart' as Api;

//ou tb gainers
class ListsBloc {
  final Api.ApiReques _apiProxy;
  Stream<List<Lists.MarketList>> _gainersListStream = Stream.empty();
  Stream<List<Lists.MarketList>> get gainersListStream => _gainersListStream;

  ListsBloc(this._apiProxy) {
    _gainersListStream =
        _apiProxy.fetchAList(Lists.MarketListType.GAINERS).asStream();
  }

  void refresh() {
    _gainersListStream = Stream.empty();
    _gainersListStream =
        _apiProxy.fetchAList(Lists.MarketListType.GAINERS).asStream();
  }
}

class StocksListBloc {
  final Api.ApiReques _aiProxy;
  Stream<List<Lists.MarketList>> _infocusListStream = Stream.empty();
  Stream<List<Lists.MarketList>> get infocusListStream => _infocusListStream;

  StocksListBloc(this._aiProxy) {
    _infocusListStream =
        _aiProxy.fetchAList(Lists.MarketListType.STOCKS).asStream();
  }

  void refresh() {
    _infocusListStream = Stream.empty();
    _infocusListStream =
        _aiProxy.fetchAList(Lists.MarketListType.STOCKS).asStream();
  }
}

class LosersListBloc {
  final Api.ApiReques _iexApiProxy;
  Stream<List<Lists.MarketList>> _losersListStream = Stream.empty();
  Stream<List<Lists.MarketList>> get losersListStream => _losersListStream;
  LosersListBloc(this._iexApiProxy) {
    _losersListStream =
        _iexApiProxy.fetchAList(Lists.MarketListType.LOSERS).asStream();
  }

  void refresh() {
    _losersListStream = Stream.empty();
    _losersListStream =
        _iexApiProxy.fetchAList(Lists.MarketListType.LOSERS).asStream();
  }
}
