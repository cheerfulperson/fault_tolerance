// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/second_app_providers.dart';
// import 'components/nav_bar.dart';

// class TestOne extends StatefulWidget {
//   final String title;

//   const TestOne({Key? key, required this.title}) : super(key: key);

//   @override
//   _TestOneState createState() => _TestOneState();
// }

// class _TestOneState extends State<TestOne> {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<SecondAppProvider>(context, listen: false);
//     int t = provider.primer;
//     String resultText = 'Результат для t = $t: 20 лет';

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SecondAppNavBar(),
//             Text(
//               'Пятая страница',
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   t = int.parse(value);
//                   resultText = 'Результат для t = $t: 20 лет';
//                   provider.setPrimer(t);
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Введите значение для t',
//               ),
//             ),
//             SizedBox(height: 20),
//             Text(
//               resultText,
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
