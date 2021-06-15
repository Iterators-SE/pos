import 'package:either_option/either_option.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:provider/provider.dart';

import '../../../core/error/failure.dart';
import '../../../core/state/app_state.dart';
import '../../../core/ui/styled_text_button.dart';
import '../../../models/discounts.dart';
import '../../../models/product.dart';
import '../../../models/product_variant.dart';
import '../../../models/tax.dart';
import '../../../models/user_profile.dart';
import '../../../repositories/inventory/inventory_repository_implementation.dart';
import '../../../repositories/profile/profile_repository_implementation.dart';
// import '../../../repositories/discount/discount_repository_implementation.dart';
import '../../../repositories/tax/tax_repository_implementation.dart';
import '../models/order.dart';
import '../presenters/order_screen_presenter.dart';
import '../views/order_screen_view.dart';
import 'invoice_screen.dart';
import 'widget/custom_alert_dialog.dart';
import 'widget/custom_data_table.dart';
import 'widget/custom_floating_action_button.dart';
import 'widget/discount_dialog.dart';
import 'widget/order_button.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> implements OrderScreenView {
  OrderScreenPresenter _presenter;

  Order order;
  AppState state = AppState.loading;
  Failure failure;
  Widget body;
  bool hasProducts = false;
  UserProfile profileData;
  Tax tax;
  List<Product> allProducts = [];
  List<Discount> allDiscounts = [];

  @override
  Function cancelOrder() {
    return () => setState(() {
          hasProducts = false;
          order = Order();
        });
  }

  @override
  Function processOrder() {
    print(allProducts);
    return () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(),
              body: InvoiceScreen(
                userProfileData: profileData,
                order: order,
                allProducts: allProducts,
              ),
            ),
          ),
        );
  }

  @override
  void addProduct(ProductVariant product) {
    setState(() {
      hasProducts = true;
      order.editProduct(product);
    });
  }

  Future<Either<Failure, Tax>> selectedTax() async {
    var taxResult = await Provider.of<TaxRepository>(context, listen: false)
        .getSelectedTax();

    print(taxResult);

    if (taxResult.isLeft) {
      return Right(Tax(id: 0, isSelected: true, name: "None", percentage: 0));
    }

    print(taxResult);
    return taxResult;
  }

  Future<Either<Failure, UserProfile>> getUserProfile() async {
    var profileResult =
        await Provider.of<ProfileRepository>(context, listen: false)
            .getProfileInfo();

    if (profileResult.isLeft) {
      return Right(UserProfile(
          address: "", email: "", id: 0, name: "", receiptMessage: ""));
    }

    return profileResult;
  }

  @override
  void addDiscount(List<Discount> discounts) {
    setState(() => order.addDiscount(discounts));
  }

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    return await Provider.of<InventoryRepository>(context, listen: false)
        .getProducts();
  }

  @override
  Future<Either<Failure, List<Discount>>> getDiscounts() async {
    // return await Provider.of<DiscountRepository>(context, listen: false)
    //     .getDiscounts();

    return Right([
      Discount(
        id: 1,
        percentage: 20,
        products: [1, 2],
        description: "Senior Citizen",
      ),
      Discount(
        id: 2,
        percentage: 15,
        products: [1, 2],
        description: "PWD",
      )
    ]);
  }

  @override
  void initState() {
    _presenter = OrderScreenPresenter();
    _presenter.attachView(this);

    state = AppState.loading;
    order = Order();

    getDiscounts().then((value) {
      var data = value.fold((failure) => failure, (result) => result);

      if (value.isRight) {
        setState(() => allDiscounts = data);

        getProducts().then((product) async {
          var data = product.fold((failure) => failure, (result) => result);
          if (product.isRight) {
            var taxResult = await selectedTax();
            var taxData = taxResult.fold((fail) => fail, (tax) => tax);

            var profileResult = await getUserProfile();
            var profile =
                // ignore: lines_longer_than_80_chars
                profileResult.fold(
                    (fail) => UserProfile(
                        address: "",
                        email: "",
                        id: 0,
                        name: "",
                        receiptMessage: ""),
                    (data) => data);

            if (taxResult.isRight) {
              setState(() {
                tax = taxData;
                order.setTax(tax);
                print(taxData);
                state = AppState.done;
              });
            }

            if (profileResult.isRight) {
              setState(() {
                print(profile.name);
                print(profile.email);
                profileData = profile;
              });
            }

            setState(() {
              allProducts = data;
              print(allProducts);
              print(allProducts);
            });
          } else {
            setState(() {
              state = AppState.error;
              failure = data;
            });
          }
        });
      } else {
        setState(() {
          state = AppState.error;
          failure = data;
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: state == AppState.loading
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: body = hasProducts
                      ? SingleChildScrollView(
                        child: Container(
                        // margin: const EdgeInsets.all(15.0),
                        // padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomDataTable(
                                order: order,
                                products: allProducts,
                                onPressed: () => (productVariant) async =>
                                    await showDialog(
                                      context: context,
                                      builder: (context) => CustomAlertDialog(
                                        chosenProduct: allProducts.firstWhere(
                                          (e) =>
                                              e.id == productVariant.productId,
                                        ),
                                        quantity: productVariant.quantity,
                                        chosenVariant:
                                            productVariant.variantName,
                                        allProducts: allProducts,
                                        onPressed: () => addProduct,
                                      ),
                                    ),
                              ),
                              SizedBox(height: 20),
                              CustomDataTable(
                                products: allProducts,
                                columns: [
                                  DataColumn(
                                      label: Text(
                                    'Description',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                  DataColumn(
                                    label: Text(
                                      'Breakdown',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    numeric: true,
                                  ),
                                ],
                                rows: [
                                  DataRow(
                                    cells: [
                                      DataCell(Text("Base Price")),
                                      DataCell(
                                        Text(
                                          order.total.toString(),
                                        ),
                                      )
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      DataCell(Text("Discount")),
                                      DataCell(
                                        Text(
                                          order.discountTotal.toString(),
                                        ),
                                      )
                                    ],
                                  ),
                                  DataRow(
                                    cells: [
                                      DataCell(Text("Total")),
                                      DataCell(
                                        Text(
                                          // ignore: lines_longer_than_80_chars
                                          '${order.total - order.discountTotal}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  OrderButton(
                                    text: "Cancel Order",
                                    onPressed:
                                        !hasProducts ? null : cancelOrder(),
                                  ),
                                  OrderButton(
                                    text: "Process Order",
                                    onPressed:
                                        hasProducts ? processOrder() : null,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ))
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(child: Image(
                              image: AssetImage(
                              'images/empty_orders.png',),
                                width: 120,
                                height: 160,
                              )
                            ), 
                            Align(
                              alignment: Alignment.center, 
                              child: Text("Looks a little empty ..."),
                            ),
                            StyledTextButton(
                              text: "Add an Order",
                              onPressed: () async => await showDialog(
                                context: context,
                                builder: (context) => CustomAlertDialog(
                                  allProducts: allProducts,
                                  onPressed: () => addProduct,
                                ),
                              ),
                            )
                          ],
                        ),
                ),
              ],
            ),
      floatingActionButton: CustomFAB(
        onAddProduct: () async => await showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            allProducts: allProducts,
            onPressed: () => addProduct,
          ),
        ),
        onAddDiscount: () async => await showDialog(
          context: context,
          builder: (context) => DiscountDialog(
            discounts: allDiscounts,
            selectedDiscounts: order.discounts.toList(),
            onPressed: () => addDiscount,
          ),
        ),
      ),
    );
  }
}
