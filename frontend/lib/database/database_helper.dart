import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// import '../models/product.dart';
import './product_temp.dart';

class InventoryDatabase {
  static String path;
  static final _databaseName = "pos.db";
  static final _databaseVersion = 1;
  static final _tableProduct = 'product';

  InventoryDatabase._privateConstructor();
  static final InventoryDatabase instance =
      InventoryDatabase._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE product(
        id INTEGER PRIMARY KEY autoincrement, 
        productname VARCHAR(256), 
        description VARCHAR(256), 
        photolink Varchar(256), 
        taxable BOOLEAN
      )

      Create TABLE variants(
        variantid INTEGER PRIMARY KEY,
        variantname VARCHAR(255),
        price INTEGER,
        FOREIGN KEY (productid) REFERENCES product (id)
      )
      ''');
  }

  Future<int> addProduct(ProductTemp product) async {
    var db = await instance.database;

    List products = await db.rawQuery(
      '''
        INSERT INTO product(
          id,
          productname,
          description,
          photolink,
          taxable
        );
      '''
    );

    if (products.isEmpty) {
      return -1;
    }
    return await db.insert(_tableProduct, product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<ProductTemp>> getProducts() async {
    var db = await instance.database;
    var res = await db.rawQuery("select * from product");
    var list = await res.toList().map((c) => ProductTemp.fromMap(c)).toList();

    return list;
  }

  Future<ProductTemp> getProductDetails(ProductTemp product) async {
    var productId = product.id;

    var db = await instance.database;
    var res =
        await db.rawQuery("select * from product where id = '$productId'");
    if (res.isNotEmpty) {
      List<dynamic> list =
          res.toList().map((c) => ProductTemp.fromMap(c)).toList();

      print("Data $list");
      await db.insert("logins", list[0].toUserMap());
      return list[0];
    }
    return null;
  }

  Future<int> deleteProduct(ProductTemp product) async {
    var db = await instance.database;
    var products = db
        .delete(_tableProduct, where: "productid = ?", whereArgs: [product.id]);
    return products;
  }
}
