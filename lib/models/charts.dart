enum ChartDurations {
  FIVE_YEAR,
  TWO_YEAR,
  ONE_YEAR,
  YEAR_TO_DATE,
  SIX_MONTHS,
  THREE_MONTHS,
  ONE_MONTH,
  ONE_DAY,
  DEFAULT
}

class ChartModel {
  final String tickerSymbol;
  final ChartDurations tickerDuration;
  final int chartInterval;
  final List<ChartData> chartData;

  static String constructEndpoint(
      String symbol, ChartDurations duration, int interval) {
    String endpoint = '';
    switch (duration) {
      case ChartDurations.FIVE_YEAR:
        endpoint = endpoint + '$symbol/chart/5y';
        break;
      case ChartDurations.TWO_YEAR:
        endpoint = endpoint + '$symbol/chart/2y';
        break;
      case ChartDurations.ONE_YEAR:
        endpoint = endpoint + '$symbol/chart/1y';
        break;
      case ChartDurations.YEAR_TO_DATE:
        endpoint = endpoint + '$symbol/chart/ytd';
        break;
      case ChartDurations.SIX_MONTHS:
        endpoint = endpoint + '$symbol/chart/6m';
        break;
      case ChartDurations.THREE_MONTHS:
        endpoint = endpoint + '$symbol/chart/3m';
        break;
      case ChartDurations.ONE_MONTH:
        endpoint = endpoint + '$symbol/chart/1m';
        break;
      case ChartDurations.ONE_DAY:
        endpoint = endpoint + '$symbol/chart/1d';
        break;
      default:
        endpoint = endpoint + '$symbol/chart';
        break;
    }

    if (interval != null) {
      return '/stock/' + endpoint + '?chartInterval=$interval';
    } else {
      return '/stock/' + endpoint;
    }
  }

  ChartModel(this.tickerSymbol, this.tickerDuration, this.chartInterval,
      List chartData)
      : this.chartData = ChartData.fromJson(chartData);

  List<Map<String, double>> chartToOHLC() {
    List<Map<String, double>> filterData = [];
    this.chartData.forEach((chartData) {
      try {
        Map<String, double> d = chartData.toOHLCdata();
        filterData.add(d);
      } catch (e) {
        print(e);
      }
    });
    return filterData;
  }
}

class ChartData {
  final double high;
  final double low;
  final double volume;
  final double changeOverTime;
  final DateTime date;
  final double open;
  final double close;
  final String label;

  ChartData(this.high, this.low, this.label, this.volume, this.changeOverTime,
      this.date, this.open, this.close);

  static List<ChartData> fromJson(List chartJsonDataResponse) {
    return chartJsonDataResponse
        .map((chartJsonData) => ChartData.fromJsonKV(chartJsonData))
        .toList();
  }

  ChartData.fromJsonKV(Map chartJsonDataResponse)
      : this.high = chartJsonDataResponse['high']?.toDouble(),
        this.low = chartJsonDataResponse['low']?.toDouble(),
        this.volume = chartJsonDataResponse['volume']?.toDouble(),
        this.changeOverTime =
            chartJsonDataResponse['changeOverTime']?.toDouble(),
        this.date = DateTime.parse(chartJsonDataResponse['date']),
        this.label = chartJsonDataResponse['label'],
        this.open = chartJsonDataResponse['open']?.toDouble(),
        this.close = chartJsonDataResponse['close']?.toDouble();

  Map<String, double> toOHLCdata() {
    if (open != null ||
        close != null ||
        high != null ||
        low != null ||
        volume != null) {
      return {
        "open": open != null ? open : 0,
        "close": close != null ? close : 0,
        "high": high != null ? high : 0,
        "low": low != null ? low : 0,
        "volumeto": volume != null ? volume : 0
      };
    }
    throw Exception("Null entry found");
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Data from $date with volume: $volume high: $high, low: $low \n";
  }
}
