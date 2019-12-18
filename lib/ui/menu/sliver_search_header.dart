import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_search_events.dart';
import 'package:my_thai_star_flutter/blocs/dish_bloc.dart';
import 'package:my_thai_star_flutter/models/search.dart';
import 'package:my_thai_star_flutter/ui/menu/search_bar.dart';
import 'package:my_thai_star_flutter/blocs/localization_bloc.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class SliverSearchHeader extends StatelessWidget {
  static const double _height = 160;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: UiHelper.elevation,
      floating: true,
      backgroundColor: Colors.white,
      leading: Container(),
      expandedHeight: _height,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              SearchBar(),
              _Sort(),
              _Buttons(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
            child: Text(
              LocalizationBloc.of(context).get("buttons/clearFilters"),
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.grey),
            ),
            onPressed: () {
              BlocProvider.of<CurrentSearchBloc>(context)
                  .dispatch(ClearSearchEvent());
            }),
        FlatButton(
          child: Text(
              LocalizationBloc.of(context).get("buttons/applyFilters"),
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Theme.of(context).accentColor)),
          onPressed: () =>
              BlocProvider.of<DishBloc>(context).dispatch(DishEvents.request),
        ),
      ],
    );
  }
}

class _Sort extends StatelessWidget {
  static const double _iconPadding = 12.0;
  static const double _dropDownPadding = 5;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentSearchBloc, Search>(
      builder: (context, state) => Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(_iconPadding),
            child: Icon(Icons.sort, color: Colors.grey),
          ),
          Text(
            LocalizationBloc.of(context).get("menu/filter/sort"),
            style: Theme.of(context).textTheme.subhead,
          ),
          SizedBox(width: _dropDownPadding),
          Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              value: state.sortBy,
              items: _mapDropDownItems(context),
              onChanged: (String sortBy) =>
                  BlocProvider.of<CurrentSearchBloc>(context)
                      .dispatch(SetSortEvent(sortBy)),
            ),
          ),
          IconButton(
            icon: Icon(
              state.descending
                  ? Icons.vertical_align_bottom
                  : Icons.vertical_align_top,
              color: Theme.of(context).accentColor,
            ),
            onPressed: () => BlocProvider.of<CurrentSearchBloc>(context)
                .dispatch(FlipDirectionEvent()),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _mapDropDownItems(BuildContext context) {
    return Search.sortCriteria
        .map((String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(
                LocalizationBloc.of(context).get("menu/filter/$value"),
              ),
            ))
        .toList();
  }
}
