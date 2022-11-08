import 'package:trade_quotes/blocs/lists_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:trade_quotes/network/api_reques.dart';

class ApiProvider extends InheritedWidget {
  // final SectorBloc sectorBloc;
  final ListsBloc listsBloc;
  final LosersListBloc losersListBloc;
  final StocksListBloc infocusListBloc;

  ApiProvider(
      {Key key,
      Widget child,
      LosersListBloc loBloc,
      StocksListBloc infoBloc,
      ListsBloc lBloc})
      : this.infocusListBloc = infoBloc != null
            ? infoBloc
            : StocksListBloc(ApiReques.getInstance()),
        this.losersListBloc =
            loBloc != null ? loBloc : LosersListBloc(ApiReques.getInstance()),
        this.listsBloc =
            lBloc != null ? lBloc : ListsBloc(ApiReques.getInstance()),
        super(child: child, key: key);

  static ListsBloc listsBlocOf(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ApiProvider>())
        .listsBloc;
  }

  static LosersListBloc losersListBlocOf(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ApiProvider>())
        .losersListBloc;
  }

  static StocksListBloc infocusListBlocOf(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ApiProvider>())
        .infocusListBloc;
  }

  @override
  bool updateShouldNotify(_) {
    print("Notify!!");
    return true;
  }
}
