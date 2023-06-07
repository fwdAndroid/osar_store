import 'package:flutter/material.dart';
import 'package:osar_store/tab/current_orders.dart';
import 'package:osar_store/tab/past_orders.dart';

/// Flutter code sample for [TabBar].

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _OrderHistoryState extends State<OrderHistory>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Orders Page",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "Current Orders",
            ),
            Tab(
              text: "Past Orders",
            ),
          ],
          labelColor: Colors.black,
          dividerColor: Colors.yellow,
          indicatorColor: Colors.black,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[CurrentOrders(), PastOrders()],
      ),
    );
  }
}
