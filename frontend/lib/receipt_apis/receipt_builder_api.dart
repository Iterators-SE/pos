// import 'dart:io';
// import 'package:frontend/models/transaction.dart';
// import 'package:frontend/models/user_profile.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:frontend/features/orders/models/order.dart';
// import 'package:pdf/widgets.dart';

// class Utils {
//   static formatPrice(double price) => 'Php ${price.toStringAsFixed(2)}';
//   static formatDate(DateTime date) => DateFormat.yMd().format(date);
// }


// class ReceiptGenerator {
//   static Future<File> generateReceipt(Transaction transaction, UserProfile storeData) async {
//     var orders = transaction.orders;
//     var tax = transaction.tax;

//     final pdf = Document();

//     pdf.addPage(MultiPage(
//       build: (context) => [
//         buildHeader(storeData, transaction),
//         SizedBox(height: 3 * PdfPageFormat.cm),
//         buildTitle(order),
//         buildReceipt(order),
//         Divider(),
//         buildTotal(order),
//       ],
//       footer: (context) => buildFooter(order),
//     ));
//   }

//     static Widget buildHeader(UserProfile storeData, Transaction transaction) 
//     => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 1 * PdfPageFormat.cm),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               buildSupplierAddress(storeData.address)
//             ],
//           ),
//           SizedBox(height: 1 * PdfPageFormat.cm),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               buildReceiptInfo(transaction),
//             ],
//           ),
//         ],
//       );

//     static Widget buildSupplierAddress(UserProfile storeData) => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(storeData.name, style: TextStyle(fontWeight: FontWeight.bold)),
//       SizedBox(height: 1 * PdfPageFormat.mm),
//       Text(storeData.address),
//     ],
//   );

//     static Widget buildReceiptInfo(Transaction transaction) {
//     final titles = <String>['Receipt Number:', 'Receipt Date:'];
//     final data = <String>[
//       transaction.id.toString(),
//       Utils.formatDate(transaction.createdAt),
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: List.generate(titles.length, (index) {
//         final title = titles[index];
//         final value = data[index];

//         return buildText(title: title, value: value, width: 200);
//       }),
//     );
//   }

//   static Widget buildTitle(Order invoice) => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         'Receipt',
//         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//       ),
//       SizedBox(height: 0.8 * PdfPageFormat.cm),
//       Text(invoice.info.description),
//       SizedBox(height: 0.8 * PdfPageFormat.cm),
//     ],
//   );

  

//     static buildText({
//     required String title,
//     required String value,
//     double width = double.infinity,
//     TextStyle? titleStyle,
//     bool unite = false,
//   }) {
//     final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

//     return Container(
//       width: width,
//       child: Row(
//         children: [
//           Expanded(child: Text(title, style: style)),
//           Text(value, style: unite ? style : null),
//         ],
//       ),
//     );
//   }

// }
