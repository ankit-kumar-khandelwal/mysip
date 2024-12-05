import 'dart:async';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _pageController;
  late Timer _timer;
  int _currentIndex = 0;

  final List<String> _names = [
    'Ankit',
    'Vijay',
    'Manglaram',
    'Ashish',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85, initialPage: 0);

    // Initialize the timer for automatic sliding
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (_currentIndex + 1) % _names.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentIndex = nextPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SIP"
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _names.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    if (_pageController.position.haveDimensions) {
                      value = _pageController.page! - index;
                      value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                    }
                    return Center(
                      child: SizedBox(
                        height: Curves.easeInOut.transform(value) * 150,
                        width: Curves.easeInOut.transform(value) * 300,
                        child: child,
                      ),
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.blueAccent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _names[index],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _names.length,
              (index) => GestureDetector(
                onTap: () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  setState(() {
                    _currentIndex = index;
                  });
                },
                child: Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.blueAccent
                        : Colors.grey.shade400,
                  ),
                ),
              ),
            ),
          ),
          
          Text(
            "Investing"
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
            Column(
              children: [
                
                         customBox(title: "Hello", color: Colors.black, width: 100, height: 100,image: Image.asset("",height:20 ,width: 20,)),
        
                              SizedBox(height: 4),
                
              ],
            ),
            SizedBox(width:30),
              Column(
              children: [
                           customBox(title: "Hello", color: Colors.black, width: 100, height: 100,image: Image.asset("",height:20 ,width: 20,)),
        
                
              ],
            ),
                      SizedBox(width:30),
        
              Column(
              children: [
                          customBox(title: "Hello", color: Colors.black, width: 100, height: 100,image: Image.asset("",height:20 ,width: 20,)),
        
                              SizedBox(height: 4),
        
                
              ],
            )
        
          ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            
            Column(
              children: [
                
              customBox(title: "Hello", color:  Colors.grey.withOpacity(0.9), width: 100, height: 100,image: Image.asset("assets/images/money.png",height:70 ,width: 60,)),
          
              ],
            ),
            SizedBox(width:30),
              Column(
              children: [
                        customBox(title: "Hello", color: Colors.black, width: 100, height: 100,image: Image.asset("",height:20 ,width: 20,)),
        
              ],
            ),
                      SizedBox(width:30),
        
              Column(
              children: [
                           customBox(title: "Hello", color: Colors.black, width: 100, height: 100,image: Image.asset("",height:20 ,width: 20,)),
        
                              SizedBox(height: 4),
        
               
                
              ],
            )
        
          ],),
        ],
            ),
      )
    );
  }
}

Widget customBox({
  required String title,
  required Color color,
  required double width,
  required double height,
  required Image image,
}) {
  return Column(
    children: [
      Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child:image,
        ),
      ),
      Text(
        title
      )
    ],
  );
}
