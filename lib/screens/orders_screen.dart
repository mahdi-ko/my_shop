import 'package:flutter/material.dart';
import 'package:my_shop/providers/order.dart';
import 'package:my_shop/widgets/main_drawer.dart';
import 'package:my_shop/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isloading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isloading = true;
      });
      try {
        await Provider.of<Orders>(context).fetchAndSetOrders();
        setState(() {
          _isloading = false;
        });
      } catch (error) {
        setState(() {
          _isloading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orders.allOrders.length,
              itemBuilder: (ctx, i) => OrderItem(orders.allOrders[i]),
            ),
      drawer: MainDrawer(),
    );
  }
}
