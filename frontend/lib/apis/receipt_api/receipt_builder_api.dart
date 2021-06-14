import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../features/orders/models/order.dart';
import '../../models/product.dart';
import '../../models/user_profile.dart';
import 'receipt_save_api.dart';

class PdfGeneratorApi {
  static Future<File> generate(
      Order order, UserProfile user, List<Product> products) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(user),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(),
        buildReceipt(order, products),
        Divider(),
        buildTotal(order),
      ],
      footer: (context) => buildFooter(user),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(UserProfile user) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(user),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.end,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     buildCustomerAddress(order.customer),
          //     buildReceiptInfo(order.info),
          //   ],
          // ),
        ],
      );

  // static Widget buildCustomerAddress(Customer customer) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
  //         Text(customer.address),
  //       ],
  //     );

  // static Widget buildReceiptInfo(OrderInfo info) {
  //   final titles = <String>['Receipt Number:', 'Receipt Date:', 'Due Date:'];
  //   final data = <String>[
  //     info.number,
  //     Utils.formatDate(info.date),
  //     Utils.formatDate(info.dueDate),
  //   ];

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: List.generate(titles.length, (index) {
  //       final title = titles[index];
  //       final value = data[index];

  //       return buildText(title: title, value: value, width: 200);
  //     }),
  //   );
  // }

  static Widget buildSupplierAddress(UserProfile user) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(user.address),
           Text(user.email),
        ],
      );

  static Widget buildTitle() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Receipt',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildReceipt(Order order, List<Product> products) {
    final headers = [
      'Product Name',
      'Variant',
      'Quantity',
      'Unit Price',
      'Tax',
      'Total'
    ];
    final data = order.products.map((product) {
      // final total = product.price * product.quantity;
    // final totalVat = product.price * product.quantity * order.tax.percentage;

      return [
        products.where((element) => element.id == product.productId)
        .toList().first.name,
        product.variantName,
        '${product.quantity}',
        'Php ${product.price}',
        '${order.tax.percentage * 100} %',
        'Php ${product.price * product.quantity}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.center,
        3: Alignment.centerLeft,
        4: Alignment.centerLeft,
        5: Alignment.centerLeft,
      },
    );
  }

  static Widget buildTotal(Order order) {
    // ignore: unused_local_variable
    final total = order.totalAmountTax + order.total;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total',
                  value: "Php ${order.total}",
                  unite: true,
                ),
                buildText(
                  title: '${order.tax.name}: ${order.tax.percentage * 100}%',
                  value: "Php ${order.totalAmountTax}",
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Grand total',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: "Php ${order.total + order.totalAmountTax}",
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildFooter(UserProfile user) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Text(user.receiptMessage)
          // buildSimpleText(title: 'Email Address', value: user.email),
          // SizedBox(height: 1 * PdfPageFormat.mm),
    // buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
        ],
      );

  // ignore: type_annotate_public_apis
  // static buildSimpleText({
  //   String title,
  //   String value,
  // }) {
  //   final style = TextStyle(fontWeight: FontWeight.bold);

  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     crossAxisAlignment: pw.CrossAxisAlignment.end,
  //     children: [
  //       Text(title, style: style),
  //       SizedBox(width: 2 * PdfPageFormat.mm),
  //       Text(value),
  //     ],
  //   );
  // }

  // ignore: type_annotate_public_apis
  static buildText({
    String title,
    String value,
    double width = double.infinity,
    TextStyle titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
