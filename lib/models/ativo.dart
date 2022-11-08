import 'package:flutter/material.dart';
import 'dart:math' as Math;

const int kColorMin = 127;

class Ativo implements Comparable<Ativo> {
  String symbol;
  String companyName;
  String primaryExchange;
  String change;
  String changePercent;
  String peRatio;
  String price;
  String delayedPrice;
  String avgTotalVolume;
  String open;
  String close;
  String latestTime;
  String high;
  String low;
  String currency;
  // String sector = 'cryptocurrency';
  String sector = 'qualquer';

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

  Ativo.fromJson(Map quoteJsonData)
      : symbol = quoteJsonData['symbol'],
        companyName = quoteJsonData['companyName'],
        price = quoteJsonData['price'],
        delayedPrice = quoteJsonData['delayedPrice'],
        primaryExchange = quoteJsonData['primaryExchange'],
        peRatio = quoteJsonData['peRatio'],
        latestTime = quoteJsonData['latestTime'],
        change = quoteJsonData['change'],
        changePercent = quoteJsonData['changePercent'],
        avgTotalVolume = quoteJsonData['avgTotalVolume'],
        open = quoteJsonData['open'],
        close = quoteJsonData['close'],
        high = quoteJsonData['high'],
        low = quoteJsonData['low'],
        currency = quoteJsonData['currency'];

  Ativo() {}

  @override
  int compareTo(Ativo other) {
    // TODO: implement compareTo
    return this.symbol.compareTo(other.symbol);
  }
}
