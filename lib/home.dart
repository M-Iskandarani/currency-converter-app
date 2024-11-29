import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String fromCurrency = "USD";
  String toCurrency = "LBP";
  double amount = 0.0;
  String result = "";
  List<String> conversionHistory = [];

  final Map<String, double> exchangeRates = {
    "USD_EUR": 0.93,
    "USD_GBP": 0.77,
    "USD_LBP": 89000,
    "USD_CAD": 1.35,
    "USD_AUD": 1.5,
    "USD_JPY": 150,
    "USD_INR": 83,
    "EUR_USD": 1.08,
    "GBP_USD": 1.3,
    "LBP_USD": 1 / 89000,
    "CAD_USD": 1 / 1.35,
    "AUD_USD": 1 / 1.5,
    "JPY_USD": 1 / 150,
    "INR_USD": 1 / 83,
  };

  void convert() {
    String key = "${fromCurrency}_$toCurrency";
    if (exchangeRates.containsKey(key)) {
      double rate = exchangeRates[key]!;
      double converted = amount * rate;
      setState(() {
        result = "$amount $fromCurrency = ${converted.toStringAsFixed(2)} $toCurrency";
        conversionHistory.add(result);
      });
    } else {
      setState(() {
        result = "Conversion rate not available!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4B0082), Color(0xFFFFA07A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        color: Color(0xFFF8F8F8),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Convert Your Currency',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            _buildDropdown('From Currency', fromCurrency, (value) {
              setState(() {
                fromCurrency = value!;
              });
            }),
            SizedBox(height: 10),
            _buildDropdown('To Currency', toCurrency, (value) {
              setState(() {
                toCurrency = value!;
              });
            }),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Color(0xFF4B0082)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  amount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: convert,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4B0082),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'Convert',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            if (result.isNotEmpty)
              Card(
                color: Color(0xFFE0FFFF),
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4B0082)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/history', arguments: conversionHistory);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFA07A),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('View History', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String value, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF4B0082)),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.grey.shade300, blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: SizedBox(),
            items: ["USD", "EUR", "GBP", "LBP", "CAD", "AUD", "JPY", "INR"].map((currency) {
              return DropdownMenuItem(
                value: currency,
                child: Row(
                  children: [
                    Icon(Icons.monetization_on, color: Color(0xFF4B0082)), // Placeholder for flags
                    SizedBox(width: 10),
                    Text(currency),
                  ],
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
