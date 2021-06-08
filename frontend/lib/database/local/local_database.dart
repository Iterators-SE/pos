import 'package:moor_flutter/moor_flutter.dart';

part "local_database.g.dart";

class Products extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get photoLink => text()();
  BoolColumn get taxable => boolean()();
}

class ProductVariants extends Table {
  IntColumn get variantid => integer()();
  TextColumn get variantname => text()();
  IntColumn get price => integer()();
  IntColumn get productid =>
      integer().customConstraint('REFERENCES products(id)')();
  IntColumn get quantity => integer()();
}

class Discounts extends Table {
  IntColumn get id => integer()();
  TextColumn get description => text()();
  IntColumn get percentage => integer()();
  TextColumn get inclusiveDates => text()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
}

class Orders extends Table {
  IntColumn get id => integer()();
  IntColumn get product =>
      integer().customConstraint('REFERENCES products(id)')();
  IntColumn get variant =>
      integer().customConstraint('REFERENCES productVariant(variantid)')();
  IntColumn get quantity => integer()();
  IntColumn get transactionid =>
      integer().customConstraint('REFERENCES transaction(id)')();
}

class Transactions extends Table {
  IntColumn get id => integer()();
}

class DiscountProducts extends Table {
  IntColumn get productid =>
      integer().customConstraint('REFERENCES products(id)')();
  IntColumn get discountid =>
      integer().customConstraint('REFERENCES discounts(id)')();
}

class Taxes extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  BoolColumn get isSelected => boolean()();
  IntColumn get perccentage => integer()();
}

class UserProfiles extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  TextColumn get receiptMessage => text()();
  TextColumn get address => text()();
}

@UseMoor(tables: [
  Products,
  ProductVariants,
  Discounts,
  Orders,
  Transactions,
  DiscountProducts,
  Taxes,
  UserProfiles
])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  Future<void> addProduct(Product product) => into(products).insert(product);
  Future<List<Product>> getProducts() => select(products).get();
  Future<void> addVariant(ProductVariant productVariant) =>
      into(productVariants).insert(productVariant);
  Future<List<ProductVariant>> getProductVariants() =>
      select(productVariants).get();
  Future<Product> getProduct(int id) {
    return (select(products)..where((product) => product.id.equals(id)))
        .getSingle();
  }

  Future<void> addDiscount(Discount discount) =>
      into(discounts).insert(discount);
  Future<List<Discount>> getDiscounts() => select(discounts).get();
  Future<Discount> getDiscount(int id) {
    return (select(discounts)..where((discount) => discount.id.equals(id)))
        .getSingle();
  }

  Future<void> addOrder(Order order) => into(orders).insert(order);
  Future<List<Order>> getOrders() => select(orders).get();
  Future<void> addTransaction(Transaction transaction) =>
      into(transactions).insert(transaction);
  Future<Transaction> getTransaction(int id) {
    return (select(transactions)
          ..where((transaction) => transaction.id.equals(id)))
        .getSingle();
  }

  Future<void> addTax(Taxe tax) => into(taxes).insert(tax);
  Future<List<Taxe>> getTaxes() => select(taxes).get();
  Future<Taxe> getSelectedTax() {
    return (select(taxes)..where((tax) => tax.isSelected.equals(true)))
        .getSingle();
  }

  Future<Taxe> getTaxDetails(int taxId) {
    return (select(taxes)..where((tax) => tax.id.equals(taxId))).getSingle();
  }

  Future<List<Transaction>> getTransactions() => select(transactions).get();
  Future<void> addProfileInfo(UserProfile userProfile) =>
      into(userProfiles).insert(userProfile);
  Future<UserProfile> getProfileInfo() => select(userProfiles).getSingle();
  Future<void> clearCache() async {
    await customStatement('PRAGMA foreign_keys = OFF');
    for (final table in allTables){
      await delete(table).go();
    }
  }
}
