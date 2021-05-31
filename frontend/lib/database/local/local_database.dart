import 'package:moor_flutter/moor_flutter.dart';

part "local_database.g.dart";

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get photoLink => text()();
  BoolColumn get taxable => boolean()();
}

class ProductVariants extends Table {
  IntColumn get variantid => integer().autoIncrement()();
  TextColumn get variantname => text()();
  IntColumn get price => integer()();
  IntColumn get productid =>
      integer().customConstraint('REFERENCES products(id)')();
  IntColumn get quantity => integer()();
}

class Discounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
  IntColumn get percentage => integer()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
}

class Orders extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get product =>
      integer().customConstraint('REFERENCES products(id)')();
  IntColumn get variant =>
      integer().customConstraint('REFERENCES productVariant(variantid)')();
  IntColumn get quantity => integer()();
  IntColumn get transactionid =>
      integer().customConstraint('REFERENCES transaction(id)')();
}

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
}

class DiscountProducts extends Table {
  IntColumn get productid =>
      integer().customConstraint('REFERENCES products(id)')();
  IntColumn get discountid =>
      integer().customConstraint('REFERENCES discounts(id)')();
}

@UseMoor(tables: [
  Products,
  ProductVariants,
  Discounts,
  Orders,
  Transactions,
  DiscountProducts
])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  Future<List<Product>> getProducts() => select(products).get();
  Future<List<ProductVariant>> getProductVariants() =>
      select(productVariants).get();
  Future<Product> getProduct(int id) {
    return (select(products)..where((product) => product.id.equals(id)))
        .getSingle();
  }

  Future<List<Discount>> getDiscounts() => select(discounts).get();
  Future<Discount> getDiscount(int id) {
    return (select(discounts)..where((discount) => discount.id.equals(id)))
        .getSingle();
  }

  Future<List<Order>> getOrders() => select(orders).get();
  Future<Transaction> getTransaction(int id) {
    return (select(transactions)
          ..where((transaction) => transaction.id.equals(id)))
        .getSingle();
  }

  Future<List<Transaction>> getTransactions() => select(transactions).get();
}