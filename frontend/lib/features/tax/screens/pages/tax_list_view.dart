import 'package:flutter/material.dart';
import '../../../../models/tax.dart';

class TaxListPage extends StatefulWidget {
  final List<Tax> taxes;
  final Tax selectedTax;
  final Function onSelect;
  final Function setSelectedTaxLocal;

  const TaxListPage(
      {Key key,
      this.taxes,
      this.onSelect,
      this.selectedTax,
      this.setSelectedTaxLocal})
      : super(key: key);

  @override
  _TaxListPageState createState() => _TaxListPageState();
}

class _TaxListPageState extends State<TaxListPage> {
  Tax selectedTaxLocal;
  @override
  void initState() {
    selectedTaxLocal = widget.selectedTax;
    super.initState();
  }

  List<Widget> createRadioListTaxes(Tax theSelectedTax) {
    return widget.taxes.map((tax) {
      return ListTile(
        onTap: () {
          setState(() {
            print("selecting: $tax");
            widget.onSelect(context, tax);
            selectedTaxLocal = tax;
          });
        },
        title: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: tax == selectedTaxLocal
                      ? Icon(Icons.check_circle_outlined)
                      : SizedBox(
                          width: 20,
                        ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: TextFormField(
                    readOnly: true,
                    initialValue: '${tax.name}',
                    decoration: InputDecoration(
                        labelText: 'Tax Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: TextFormField(
                    readOnly: true,
                    initialValue: '${tax.percentage * 100}%',
                    decoration: InputDecoration(
                        labelText: 'Percentage',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.selectedTax);
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: createRadioListTaxes(widget.selectedTax),
          ),
        ),
      ),
    );
  }
}

// class TaxListPage extends StatelessWidget {
//   final List<Tax> taxes;
//   final Tax selectedTax;
//   final Function onSelect;
//   final Function setSelectedTaxLocal;

//   const TaxListPage(
//       {Key key,
//       this.taxes,
//       this.onSelect,
//       this.selectedTax,
//       this.setSelectedTaxLocal})
//       : super(key: key);

//   List<Widget> createRadioListTaxes(BuildContext context) {
//     return taxes.map((tax) {
//       return ListTile(
//         onTap: () {
//           onSelect(context, tax);
//           setSelectedTaxLocal(tax);
//           print("selected: $selectedTax}");
//         },
//         title: Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           child: Padding(
//             padding: EdgeInsets.all(40.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Flexible(
//                   child: tax == selectedTax
//                       ? Icon(Icons.check_circle_outlined)
//                       : SizedBox(
//                           width: 20,
//                         ),
//                 ),
//                 SizedBox(
//                   width: 15.0,
//                 ),
//                 Flexible(
//                   child: TextFormField(
//                     readOnly: true,
//                     initialValue: '${tax.name}',
//                     decoration: InputDecoration(
//                         labelText: 'Tax Name',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         )),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 15.0,
//                 ),
//                 Flexible(
//                   child: TextFormField(
//                     readOnly: true,
//                     initialValue: '${tax.percentage * 100}%',
//                     decoration: InputDecoration(
//                         labelText: 'Percentage',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         )),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );

//       // Card(
//       //     elevation: 4,
//       //     shape: RoundedRectangleBorder(
//       //       borderRadius: BorderRadius.circular(15.0),
//       //     ),
//       //     child: Padding(
//       //       padding: EdgeInsets.all(40.0),
//       //       child: Row(
//       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //         children: <Widget>[
//       //           Flexible(
//       //             child: tax == selectedTax
//       //                 ? Icon(Icons.check_circle_outlined)
//       //                 : SizedBox(
//       //                     width: 20,
//       //                   ),
//       //           ),
//       //           SizedBox(
//       //             width: 15.0,
//       //           ),
//       //           Flexible(
//       //             child: TextFormField(
//       //               readOnly: true,
//       //               initialValue: '${tax.name}',
//       //               decoration: InputDecoration(
//       //                   labelText: 'Tax Name',
//       //                   border: OutlineInputBorder(
//       //                     borderRadius: BorderRadius.circular(10),
//       //                   )),
//       //             ),
//       //           ),
//       //           SizedBox(
//       //             width: 15.0,
//       //           ),
//       //           Flexible(
//       //             child: TextFormField(
//       //               readOnly: true,
//       //               initialValue: '${tax.percentage * 100}%',
//       //               decoration: InputDecoration(
//       //                   labelText: 'Percentage',
//       //                   border: OutlineInputBorder(
//       //                     borderRadius: BorderRadius.circular(10),
//       //                   )),
//       //             ),
//       //           ),
//       //         ],
//       //       ),
//       //     ),
//       //   );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(selectedTax);
//     return Container(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: createRadioListTaxes(context),
//           ),
//         ),
//       ),
//     );
//   }
// }
