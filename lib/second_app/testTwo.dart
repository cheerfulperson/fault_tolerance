// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'components/nav_bar.dart';
// import '../providers/second_app_providers.dart';

// class TestTwo extends StatefulWidget {
//   final String title;

//   const TestTwo({Key? key, required this.title}) : super(key: key);

//   @override
//   _TestTwoState createState() => _TestTwoState();
// }

// class _TestTwoState extends State<TestTwo> {
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<SecondAppProvider>(context);
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
