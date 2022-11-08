import 'dart:async';

import 'package:trade_quotes/models/charts.dart' as Charts;
import 'package:trade_quotes/network/api_reques.dart' as API;

class ChartsBloc {
  final API.ApiReques _apiReques;
  final String symbol;
  Stream<Charts.ChartModel> chartsStream = Stream.empty();

  ChartsBloc(this._apiReques, this.symbol,
      [int intervals = 1,
      Charts.ChartDurations duration = Charts.ChartDurations.THREE_MONTHS]) {
    chartsStream =
        _apiReques.fetchChartData(symbol, duration, intervals).asStream();
  }

  void fetchDifferentDuration(Charts.ChartDurations newDuration) {
    chartsStream = _apiReques.fetchChartData(symbol, newDuration).asStream();
  }

  void fetchDifferentDurationIntervals(
      Charts.ChartDurations newDuration, int interval) {
    chartsStream =
        _apiReques.fetchChartData(symbol, newDuration, interval).asStream();
  }
}
