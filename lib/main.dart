
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(primarySwatch: Colors.blue),
  home: HomeScreen(),
)
);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  double umri = 0.0;
  var selectedYear;
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    animation = animationController;
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _showsDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(1900), 
      lastDate: DateTime.now()
    ).then((DateTime dates){
      setState(() {
        selectedYear = dates.year;
        ageCalculation();
      });
    });
  }

  void ageCalculation(){
    setState(() {
      umri = (2010 - selectedYear).toDouble();
      animation = Tween<double>(begin: animation.value, end: umri).animate(
        CurvedAnimation(curve: Curves.fastOutSlowIn, parent: animationController)
      );
      animation.addListener(() {});
    animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AGE FINDER"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlineButton(
              child: Text(selectedYear != null ? selectedYear.toString() : "Select the year of Birth"),
              borderSide: BorderSide(
                color: Colors.brown,
                width: 2,
              ),
              color: Colors.brown,
              onPressed: _showsDatePicker,
            ),
            Padding(
              padding: EdgeInsets.all(20.0)
            ),
            // Text("Umri wako ni miaka ${animation.value.toStringAsFixed(0)}", 
            Text("Umri wako ni miaka ${umri.toStringAsFixed(0)}",
              style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }
}