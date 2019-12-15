import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thai_star_flutter/blocs/current_order_bloc.dart';
import 'package:my_thai_star_flutter/ui/current_order/dish_slip.dart';
import 'package:my_thai_star_flutter/ui/current_order/order_confirmation.dart';
import 'package:my_thai_star_flutter/ui/current_order/resume_header.dart';
import 'package:my_thai_star_flutter/ui/current_order/total_price_display.dart';
import 'package:my_thai_star_flutter/models/dish.dart';
import 'package:my_thai_star_flutter/router.dart';
import 'package:my_thai_star_flutter/ui/header/header.dart';
import 'package:my_thai_star_flutter/ui/shared_widgets/app_drawer.dart';
import 'package:my_thai_star_flutter/ui/current_order/order_list_header.dart';
import 'package:my_thai_star_flutter/ui/ui_helper.dart';

class CurrentOrderPage extends StatelessWidget {
  CurrentOrderPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      backgroundColor: Colors.white,
      drawer: AppDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ResumeHeader(),
                OrderListHeader(),
              ],
            ),
          ),
          BlocBuilder<CurrentOrderBloc, LinkedHashMap<Dish, int>>(
              builder: (context, dishes) {
            if (dishes.isEmpty) {
              return _ListEmpty();
            } else {
              return _DishList(dishes: dishes);
            }
          }),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                TotalPriceDisplay(),
                OrderConfirmation(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ListEmpty extends StatelessWidget {
  static const double height = 50;
  const _ListEmpty({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(UiHelper.standard_padding),
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "You did not add any dishes to your order",
            ),
            FlatButton(
              child: Text(
                "Show Menu",
                style: Theme.of(context).textTheme.button.copyWith(
                      color: Theme.of(context).accentColor,
                    ),
              ),
              onPressed: () => Navigator.pushNamed(context, Router.menu),
            ),
          ],
        ),
      ),
    );
  }
}

class _DishList extends StatelessWidget {
  const _DishList({
    Key key,
    this.dishes,
  }) : super(key: key);

  final LinkedHashMap<Dish, int> dishes;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Dish dish = dishes.keys.toList()[index];
          int amount = dishes[dish];

          return DishSlip(dish: dish, amount: amount);
        },
        childCount: dishes.length,
      ),
    );
  }
}