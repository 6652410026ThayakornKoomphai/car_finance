// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  int downCheck = 0;
  int selectedMonth = 0;
  int period = 12;

  TextEditingController carCtrl = TextEditingController();
  TextEditingController downCtrl = TextEditingController();

  List<String> downType = [
    '12 งวด (1 ปี)',
    '24 งวด (2 ปี)',
    '36 งวด (3 ปี)',
    '48 งวด (4 ปี)',
    '60 งวด (5 ปี)',
    '72 งวด (6 ปี)',
  ];

  showWarningDialog(context, message) async {
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('คำเตือน'),
            content: Text(message),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ตกลก'),
              ),
            ],
          ),
    );
  }

  showResultDialog(context, message) async {
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('ค่างวดต่อเดือนเป็นเงิน'),
            content: Text(message + ' บาท'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ตกลก'),
              ),
            ],
          ),
    );
  }

  // สร้างฟังก์ชันคำนวณค่างวดต่อเดือน
  calculateFinance() {
    // เงื่อนไขตรวจค่าที่กรอกและโชว์ผลลัพธ์
    if (carCtrl.text.isEmpty || carCtrl.text == '0') {
      showWarningDialog(context, 'ราคาห้ามว่าง และห้ามเป็น 0');
    } else if (downCtrl.text.isEmpty || downCtrl.text == '0') {
      showWarningDialog(context, 'ดอกเบี้ยห้ามว่าง และห้ามเป็น 0');
    } else {
      // ตัวแปรเพื่อเก็บค่าราคารถและดอกเบึ้ย
      double carPrice = double.parse(carCtrl.text);
      double interestRate = double.parse(downCtrl.text) / 100;

      // คำนวณเงินดาวน์
      double downPayment = (downCheck / 100) * carPrice;
      // คำนวณยอดไฟแนนซ์
      double financeAmount = carPrice - downPayment;
      // คำนวณจำนวนเงินดอกเบี้ย
      double interestAmount = (financeAmount * interestRate / 100) * period;
      // คำนวณค่างวดต่อเดือน
      double monthlyPayment = (financeAmount + interestAmount) / period;
      // แสดงผลลัพธ์
      showResultDialog(context, monthlyPayment.toStringAsFixed(2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Car Finance App',
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/icon/icon.png',
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ราคารถ/บาท',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: carCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '0.00',
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'จํานวนเงินดาวน์/เปอร์เซ็นต์(%)',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Radio(
                      value: 0,
                      groupValue: downCheck,
                      onChanged: (value) {
                        setState(() {
                          downCheck = value as int;
                        });
                      },
                    ),
                    Text('0'),
                    Radio(
                      value: 10,
                      groupValue: downCheck,
                      onChanged: (value) {
                        setState(() {
                          downCheck = value as int;
                        });
                      },
                    ),
                    Text('10'),
                    Radio(
                      value: 15,
                      groupValue: downCheck,
                      onChanged: (value) {
                        setState(() {
                          downCheck = value as int;
                        });
                      },
                    ),
                    Text('15'),
                    Radio(
                      value: 20,
                      groupValue: downCheck,
                      onChanged: (value) {
                        setState(() {
                          downCheck = value as int;
                        });
                      },
                    ),
                    Text('20'),
                    Radio(
                      value: 25,
                      groupValue: downCheck,
                      onChanged: (value) {
                        setState(() {
                          downCheck = value as int;
                        });
                      },
                    ),
                    Text('25'),
                  ],
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'จํานวนงวด',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButton(
                  value: selectedMonth,
                  isExpanded: true,
                  items:
                      downType
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(e, style: TextStyle(fontSize: 16)),
                              value: downType.indexOf(e),
                            ),
                          )
                          .toList(),
                  onChanged: (valueParam) {
                    int index = valueParam!.toInt();
                    setState(() {
                      selectedMonth = index;
                      switch (index) {
                        case 0:
                          period = 12;
                          break;
                        case 1:
                          period = 24;
                          break;
                        case 2:
                          period = 36;
                          break;
                        case 3:
                          period = 48;
                          break;
                        case 4:
                          period = 60;
                          break;
                        case 5:
                          period = 72;
                          break;
                        default:
                          period = 0;
                      }
                    });
                  },
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ดอกเบี้ย/%ต่อปี',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: downCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '0.00',
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          calculateFinance();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('คำนวณ'),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            carCtrl.clear();
                            downCtrl.clear();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('ยกเลิก'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
