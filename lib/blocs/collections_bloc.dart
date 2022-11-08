import 'dart:async';

import 'package:trade_quotes/models/ativo.dart';
import 'package:trade_quotes/network/api_reques.dart' as API;

class CollectionsBloc {
  final API.ApiReques _iexApiProxy;
  final String _sector;
  Stream<List<Ativo>> _collectionStream = Stream.empty();
  Stream<List<Ativo>> get collectionStream => _collectionStream;

  CollectionsBloc(this._iexApiProxy, this._sector) {
    _collectionStream = _iexApiProxy
        .fetchCollectionsFor(_sector)
        .asStream()
        .asBroadcastStream();
  }

  void refresh() {
    _collectionStream = Stream.empty();
    _collectionStream = _iexApiProxy.fetchCollectionsFor(_sector).asStream();
  }
}
