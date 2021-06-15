import 'package:flutter/material.dart';
import '../../../../models/tax.dart';

class TaxListPage extends StatefulWidget {
  final List<Tax> taxes;
  final Function onSelect;
  final Function onDelete;

  const TaxListPage({Key key, this.taxes, this.onSelect, this.onDelete})
      : super(key: key);

  @override
  _TaxListPageState createState() => _TaxListPageState();
}

class _TaxListPageState extends State<TaxListPage> {
  List<Widget> createRadioListTaxes() {
    return widget.taxes.map((tax) {
      return Container(
        padding: EdgeInsets.only(left: 30),
        height: 90,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400],
                  offset: Offset(4.0, 4.0),
                  blurRadius: 5.0,
                  spreadRadius: 1.50)
            ],
            borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onTap: () {
            setState(() {
              print("selecting: $tax");
              widget.onSelect(context, tax);
            });
          },
          child: Row(
            children: <Widget>[
              tax.isSelected
                  ? Icon(Icons.check_circle_outlined)
                  : SizedBox(
                      width: 20,
                    ),
              Container(
                width: 80,
                margin: EdgeInsets.only(left: 30, top: 10, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tax Name",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      tax.name,
                      style: TextStyle(
                        fontFamily: "Montserrat Superbold",
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: 80,
                margin: EdgeInsets.only(left: 20, top: 10, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Percentage",
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      '${tax.percentage * 100}%',
                      style: TextStyle(
                        fontFamily: "Montserrat Superbold",
                        fontSize: 25,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                // padding: EdgeInsets.only(left: 10),
                child: tax.isSelected
                ? SizedBox()
                : IconButton(
                  onPressed: () {
                    widget.onDelete(context, tax);
                  },
                  icon: Icon(Icons.delete),
                ),
              )
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: createRadioListTaxes(),
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

// title: Card(
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           child:Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Flexible(
//   child: tax.isSelected
//       ? Icon(Icons.check_circle_outlined)
//       : SizedBox(
//           width: 20,
//         ),
// ),
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
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(Icons.delete)
//                   ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(Icons.edit)
//                   )
//               ],
//             ),
//         )
