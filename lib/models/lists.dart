import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:trade_quotes/models/ativo.dart' as Ativo;

const int kColorMin = 127;

enum MarketListType {
  GAINERS,
  LOSERS,
  STOCKS,
  CRIPTO,
  FUTURE,
  ETF,
  INDEX,
  MUTUAL_FUND
}

class MarketList {
  final MarketListType _marketListType;
  final Ativo.Ativo _ativo;
  final Color kColora = Color.fromRGBO(
      kColorMin + Math.Random().nextInt(255 - kColorMin),
      kColorMin + Math.Random().nextInt(255 - kColorMin),
      kColorMin + Math.Random().nextInt(255 - kColorMin),
      1.0);
  final Color kColorb = Color.fromRGBO(
      kColorMin + Math.Random().nextInt(255 - kColorMin),
      kColorMin + Math.Random().nextInt(255 - kColorMin),
      kColorMin + Math.Random().nextInt(255 - kColorMin),
      1.0);

  MarketList(this._marketListType, this._ativo);

  MarketList.fromJson(Map marketListJson, MarketListType marketListType)
      : _marketListType = marketListType,
        _ativo = Ativo.Ativo.fromJson(marketListJson);
  get ativo => this._ativo;
  get marketListType => this._marketListType;
}
