import 'package:flutter/material.dart';
import 'dart:async';




class StockTicker extends StatefulWidget {
  const StockTicker({Key? key}) : super(key: key);

  @override
  _StockTickerState createState() => _StockTickerState();
}

class _StockTickerState extends State<StockTicker> {
  late ScrollController _scrollController;
  final List<String> _stockData = [
    "AAPL: \$150.23",
    "GOOG: \$2801.12",
    "AMZN: \$3452.15",
    "MSFT: \$299.56",
    "TSLA: \$700.01",
    "META: \$230.89",
    "NFLX: \$550.12",
  ];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

 void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds:2), (timer) {
      if (_scrollController.hasClients) {
        if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
          _scrollController.jumpTo(0); // Reset to the start for infinite scrolling
        }
        _scrollController.jumpTo(
          _scrollController.offset + 1, // Adjust speed by changing this value
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title :Text(
          "SIP"
        ),
      ),
      body: Container(
      height: 30,
      color: Colors.white,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        // itemCount: _stockData.length * 10, // Repeat data for continuous effect
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5), // Gap between boxes
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5),
              //     spreadRadius: 1,
              //     blurRadius: 5,
              //     offset: const Offset(0, 3), // Shadow position
              //   ),
              // ],
            ),
            alignment: Alignment.center,
            child: Text(
              _stockData[index % _stockData.length],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    )
    );
  }
}
