// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;
  final String description;
  final String photoLink;
  final bool taxable;
  Product(
      {@required this.id,
      @required this.name,
      @required this.description,
      @required this.photoLink,
      @required this.taxable});
  factory Product.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Product(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      photoLink: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}photo_link']),
      taxable:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}taxable']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || photoLink != null) {
      map['photo_link'] = Variable<String>(photoLink);
    }
    if (!nullToAbsent || taxable != null) {
      map['taxable'] = Variable<bool>(taxable);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      photoLink: photoLink == null && nullToAbsent
          ? const Value.absent()
          : Value(photoLink),
      taxable: taxable == null && nullToAbsent
          ? const Value.absent()
          : Value(taxable),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      photoLink: serializer.fromJson<String>(json['photoLink']),
      taxable: serializer.fromJson<bool>(json['taxable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'photoLink': serializer.toJson<String>(photoLink),
      'taxable': serializer.toJson<bool>(taxable),
    };
  }

  Product copyWith(
          {int id,
          String name,
          String description,
          String photoLink,
          bool taxable}) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        photoLink: photoLink ?? this.photoLink,
        taxable: taxable ?? this.taxable,
      );
  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('photoLink: $photoLink, ')
          ..write('taxable: $taxable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(description.hashCode,
              $mrjc(photoLink.hashCode, taxable.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.photoLink == this.photoLink &&
          other.taxable == this.taxable);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> photoLink;
  final Value<bool> taxable;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.photoLink = const Value.absent(),
    this.taxable = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String description,
    @required String photoLink,
    @required bool taxable,
  })  : name = Value(name),
        description = Value(description),
        photoLink = Value(photoLink),
        taxable = Value(taxable);
  static Insertable<Product> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> description,
    Expression<String> photoLink,
    Expression<bool> taxable,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (photoLink != null) 'photo_link': photoLink,
      if (taxable != null) 'taxable': taxable,
    });
  }

  ProductsCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> description,
      Value<String> photoLink,
      Value<bool> taxable}) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      photoLink: photoLink ?? this.photoLink,
      taxable: taxable ?? this.taxable,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (photoLink.present) {
      map['photo_link'] = Variable<String>(photoLink.value);
    }
    if (taxable.present) {
      map['taxable'] = Variable<bool>(taxable.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('photoLink: $photoLink, ')
          ..write('taxable: $taxable')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _photoLinkMeta = const VerificationMeta('photoLink');
  GeneratedTextColumn _photoLink;
  @override
  GeneratedTextColumn get photoLink => _photoLink ??= _constructPhotoLink();
  GeneratedTextColumn _constructPhotoLink() {
    return GeneratedTextColumn(
      'photo_link',
      $tableName,
      false,
    );
  }

  final VerificationMeta _taxableMeta = const VerificationMeta('taxable');
  GeneratedBoolColumn _taxable;
  @override
  GeneratedBoolColumn get taxable => _taxable ??= _constructTaxable();
  GeneratedBoolColumn _constructTaxable() {
    return GeneratedBoolColumn(
      'taxable',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, photoLink, taxable];
  @override
  $ProductsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'products';
  @override
  final String actualTableName = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('photo_link')) {
      context.handle(_photoLinkMeta,
          photoLink.isAcceptableOrUnknown(data['photo_link'], _photoLinkMeta));
    } else if (isInserting) {
      context.missing(_photoLinkMeta);
    }
    if (data.containsKey('taxable')) {
      context.handle(_taxableMeta,
          taxable.isAcceptableOrUnknown(data['taxable'], _taxableMeta));
    } else if (isInserting) {
      context.missing(_taxableMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Product.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(_db, alias);
  }
}

class ProductVariant extends DataClass implements Insertable<ProductVariant> {
  final int variantid;
  final String variantname;
  final int price;
  final int productid;
  final int quantity;
  ProductVariant(
      {@required this.variantid,
      @required this.variantname,
      @required this.price,
      @required this.productid,
      @required this.quantity});
  factory ProductVariant.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return ProductVariant(
      variantid:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}variantid']),
      variantname: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}variantname']),
      price: intType.mapFromDatabaseResponse(data['${effectivePrefix}price']),
      productid:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}productid']),
      quantity:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}quantity']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || variantid != null) {
      map['variantid'] = Variable<int>(variantid);
    }
    if (!nullToAbsent || variantname != null) {
      map['variantname'] = Variable<String>(variantname);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<int>(price);
    }
    if (!nullToAbsent || productid != null) {
      map['productid'] = Variable<int>(productid);
    }
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<int>(quantity);
    }
    return map;
  }

  ProductVariantsCompanion toCompanion(bool nullToAbsent) {
    return ProductVariantsCompanion(
      variantid: variantid == null && nullToAbsent
          ? const Value.absent()
          : Value(variantid),
      variantname: variantname == null && nullToAbsent
          ? const Value.absent()
          : Value(variantname),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      productid: productid == null && nullToAbsent
          ? const Value.absent()
          : Value(productid),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
    );
  }

  factory ProductVariant.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ProductVariant(
      variantid: serializer.fromJson<int>(json['variantid']),
      variantname: serializer.fromJson<String>(json['variantname']),
      price: serializer.fromJson<int>(json['price']),
      productid: serializer.fromJson<int>(json['productid']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'variantid': serializer.toJson<int>(variantid),
      'variantname': serializer.toJson<String>(variantname),
      'price': serializer.toJson<int>(price),
      'productid': serializer.toJson<int>(productid),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  ProductVariant copyWith(
          {int variantid,
          String variantname,
          int price,
          int productid,
          int quantity}) =>
      ProductVariant(
        variantid: variantid ?? this.variantid,
        variantname: variantname ?? this.variantname,
        price: price ?? this.price,
        productid: productid ?? this.productid,
        quantity: quantity ?? this.quantity,
      );
  @override
  String toString() {
    return (StringBuffer('ProductVariant(')
          ..write('variantid: $variantid, ')
          ..write('variantname: $variantname, ')
          ..write('price: $price, ')
          ..write('productid: $productid, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      variantid.hashCode,
      $mrjc(
          variantname.hashCode,
          $mrjc(
              price.hashCode, $mrjc(productid.hashCode, quantity.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ProductVariant &&
          other.variantid == this.variantid &&
          other.variantname == this.variantname &&
          other.price == this.price &&
          other.productid == this.productid &&
          other.quantity == this.quantity);
}

class ProductVariantsCompanion extends UpdateCompanion<ProductVariant> {
  final Value<int> variantid;
  final Value<String> variantname;
  final Value<int> price;
  final Value<int> productid;
  final Value<int> quantity;
  const ProductVariantsCompanion({
    this.variantid = const Value.absent(),
    this.variantname = const Value.absent(),
    this.price = const Value.absent(),
    this.productid = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  ProductVariantsCompanion.insert({
    this.variantid = const Value.absent(),
    @required String variantname,
    @required int price,
    @required int productid,
    @required int quantity,
  })  : variantname = Value(variantname),
        price = Value(price),
        productid = Value(productid),
        quantity = Value(quantity);
  static Insertable<ProductVariant> custom({
    Expression<int> variantid,
    Expression<String> variantname,
    Expression<int> price,
    Expression<int> productid,
    Expression<int> quantity,
  }) {
    return RawValuesInsertable({
      if (variantid != null) 'variantid': variantid,
      if (variantname != null) 'variantname': variantname,
      if (price != null) 'price': price,
      if (productid != null) 'productid': productid,
      if (quantity != null) 'quantity': quantity,
    });
  }

  ProductVariantsCompanion copyWith(
      {Value<int> variantid,
      Value<String> variantname,
      Value<int> price,
      Value<int> productid,
      Value<int> quantity}) {
    return ProductVariantsCompanion(
      variantid: variantid ?? this.variantid,
      variantname: variantname ?? this.variantname,
      price: price ?? this.price,
      productid: productid ?? this.productid,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (variantid.present) {
      map['variantid'] = Variable<int>(variantid.value);
    }
    if (variantname.present) {
      map['variantname'] = Variable<String>(variantname.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (productid.present) {
      map['productid'] = Variable<int>(productid.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductVariantsCompanion(')
          ..write('variantid: $variantid, ')
          ..write('variantname: $variantname, ')
          ..write('price: $price, ')
          ..write('productid: $productid, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }
}

class $ProductVariantsTable extends ProductVariants
    with TableInfo<$ProductVariantsTable, ProductVariant> {
  final GeneratedDatabase _db;
  final String _alias;
  $ProductVariantsTable(this._db, [this._alias]);
  final VerificationMeta _variantidMeta = const VerificationMeta('variantid');
  GeneratedIntColumn _variantid;
  @override
  GeneratedIntColumn get variantid => _variantid ??= _constructVariantid();
  GeneratedIntColumn _constructVariantid() {
    return GeneratedIntColumn('variantid', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _variantnameMeta =
      const VerificationMeta('variantname');
  GeneratedTextColumn _variantname;
  @override
  GeneratedTextColumn get variantname =>
      _variantname ??= _constructVariantname();
  GeneratedTextColumn _constructVariantname() {
    return GeneratedTextColumn(
      'variantname',
      $tableName,
      false,
    );
  }

  final VerificationMeta _priceMeta = const VerificationMeta('price');
  GeneratedIntColumn _price;
  @override
  GeneratedIntColumn get price => _price ??= _constructPrice();
  GeneratedIntColumn _constructPrice() {
    return GeneratedIntColumn(
      'price',
      $tableName,
      false,
    );
  }

  final VerificationMeta _productidMeta = const VerificationMeta('productid');
  GeneratedIntColumn _productid;
  @override
  GeneratedIntColumn get productid => _productid ??= _constructProductid();
  GeneratedIntColumn _constructProductid() {
    return GeneratedIntColumn('productid', $tableName, false,
        $customConstraints: 'REFERENCES products(id)');
  }

  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  GeneratedIntColumn _quantity;
  @override
  GeneratedIntColumn get quantity => _quantity ??= _constructQuantity();
  GeneratedIntColumn _constructQuantity() {
    return GeneratedIntColumn(
      'quantity',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [variantid, variantname, price, productid, quantity];
  @override
  $ProductVariantsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'product_variants';
  @override
  final String actualTableName = 'product_variants';
  @override
  VerificationContext validateIntegrity(Insertable<ProductVariant> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('variantid')) {
      context.handle(_variantidMeta,
          variantid.isAcceptableOrUnknown(data['variantid'], _variantidMeta));
    }
    if (data.containsKey('variantname')) {
      context.handle(
          _variantnameMeta,
          variantname.isAcceptableOrUnknown(
              data['variantname'], _variantnameMeta));
    } else if (isInserting) {
      context.missing(_variantnameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price'], _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('productid')) {
      context.handle(_productidMeta,
          productid.isAcceptableOrUnknown(data['productid'], _productidMeta));
    } else if (isInserting) {
      context.missing(_productidMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity'], _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {variantid};
  @override
  ProductVariant map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ProductVariant.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $ProductVariantsTable createAlias(String alias) {
    return $ProductVariantsTable(_db, alias);
  }
}

class Discount extends DataClass implements Insertable<Discount> {
  final int id;
  final String description;
  final int percentage;
  final DateTime startTime;
  final DateTime endTime;
  Discount(
      {@required this.id,
      @required this.description,
      @required this.percentage,
      @required this.startTime,
      @required this.endTime});
  factory Discount.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Discount(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      percentage:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}percentage']),
      startTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}start_time']),
      endTime: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}end_time']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || percentage != null) {
      map['percentage'] = Variable<int>(percentage);
    }
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<DateTime>(startTime);
    }
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    return map;
  }

  DiscountsCompanion toCompanion(bool nullToAbsent) {
    return DiscountsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      percentage: percentage == null && nullToAbsent
          ? const Value.absent()
          : Value(percentage),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
    );
  }

  factory Discount.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Discount(
      id: serializer.fromJson<int>(json['id']),
      description: serializer.fromJson<String>(json['description']),
      percentage: serializer.fromJson<int>(json['percentage']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime>(json['endTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'description': serializer.toJson<String>(description),
      'percentage': serializer.toJson<int>(percentage),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
    };
  }

  Discount copyWith(
          {int id,
          String description,
          int percentage,
          DateTime startTime,
          DateTime endTime}) =>
      Discount(
        id: id ?? this.id,
        description: description ?? this.description,
        percentage: percentage ?? this.percentage,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
      );
  @override
  String toString() {
    return (StringBuffer('Discount(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('percentage: $percentage, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          description.hashCode,
          $mrjc(percentage.hashCode,
              $mrjc(startTime.hashCode, endTime.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Discount &&
          other.id == this.id &&
          other.description == this.description &&
          other.percentage == this.percentage &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime);
}

class DiscountsCompanion extends UpdateCompanion<Discount> {
  final Value<int> id;
  final Value<String> description;
  final Value<int> percentage;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  const DiscountsCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.percentage = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
  });
  DiscountsCompanion.insert({
    this.id = const Value.absent(),
    @required String description,
    @required int percentage,
    @required DateTime startTime,
    @required DateTime endTime,
  })  : description = Value(description),
        percentage = Value(percentage),
        startTime = Value(startTime),
        endTime = Value(endTime);
  static Insertable<Discount> custom({
    Expression<int> id,
    Expression<String> description,
    Expression<int> percentage,
    Expression<DateTime> startTime,
    Expression<DateTime> endTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (percentage != null) 'percentage': percentage,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
    });
  }

  DiscountsCompanion copyWith(
      {Value<int> id,
      Value<String> description,
      Value<int> percentage,
      Value<DateTime> startTime,
      Value<DateTime> endTime}) {
    return DiscountsCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      percentage: percentage ?? this.percentage,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<int>(percentage.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscountsCompanion(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('percentage: $percentage, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime')
          ..write(')'))
        .toString();
  }
}

class $DiscountsTable extends Discounts
    with TableInfo<$DiscountsTable, Discount> {
  final GeneratedDatabase _db;
  final String _alias;
  $DiscountsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _percentageMeta = const VerificationMeta('percentage');
  GeneratedIntColumn _percentage;
  @override
  GeneratedIntColumn get percentage => _percentage ??= _constructPercentage();
  GeneratedIntColumn _constructPercentage() {
    return GeneratedIntColumn(
      'percentage',
      $tableName,
      false,
    );
  }

  final VerificationMeta _startTimeMeta = const VerificationMeta('startTime');
  GeneratedDateTimeColumn _startTime;
  @override
  GeneratedDateTimeColumn get startTime => _startTime ??= _constructStartTime();
  GeneratedDateTimeColumn _constructStartTime() {
    return GeneratedDateTimeColumn(
      'start_time',
      $tableName,
      false,
    );
  }

  final VerificationMeta _endTimeMeta = const VerificationMeta('endTime');
  GeneratedDateTimeColumn _endTime;
  @override
  GeneratedDateTimeColumn get endTime => _endTime ??= _constructEndTime();
  GeneratedDateTimeColumn _constructEndTime() {
    return GeneratedDateTimeColumn(
      'end_time',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, description, percentage, startTime, endTime];
  @override
  $DiscountsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'discounts';
  @override
  final String actualTableName = 'discounts';
  @override
  VerificationContext validateIntegrity(Insertable<Discount> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('percentage')) {
      context.handle(
          _percentageMeta,
          percentage.isAcceptableOrUnknown(
              data['percentage'], _percentageMeta));
    } else if (isInserting) {
      context.missing(_percentageMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time'], _startTimeMeta));
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(_endTimeMeta,
          endTime.isAcceptableOrUnknown(data['end_time'], _endTimeMeta));
    } else if (isInserting) {
      context.missing(_endTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Discount map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Discount.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $DiscountsTable createAlias(String alias) {
    return $DiscountsTable(_db, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final int id;
  final int product;
  final int variant;
  final int quantity;
  final int transactionid;
  Order(
      {@required this.id,
      @required this.product,
      @required this.variant,
      @required this.quantity,
      @required this.transactionid});
  factory Order.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return Order(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      product:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}product']),
      variant:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}variant']),
      quantity:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}quantity']),
      transactionid: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}transactionid']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || product != null) {
      map['product'] = Variable<int>(product);
    }
    if (!nullToAbsent || variant != null) {
      map['variant'] = Variable<int>(variant);
    }
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<int>(quantity);
    }
    if (!nullToAbsent || transactionid != null) {
      map['transactionid'] = Variable<int>(transactionid);
    }
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      product: product == null && nullToAbsent
          ? const Value.absent()
          : Value(product),
      variant: variant == null && nullToAbsent
          ? const Value.absent()
          : Value(variant),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      transactionid: transactionid == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionid),
    );
  }

  factory Order.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<int>(json['id']),
      product: serializer.fromJson<int>(json['product']),
      variant: serializer.fromJson<int>(json['variant']),
      quantity: serializer.fromJson<int>(json['quantity']),
      transactionid: serializer.fromJson<int>(json['transactionid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'product': serializer.toJson<int>(product),
      'variant': serializer.toJson<int>(variant),
      'quantity': serializer.toJson<int>(quantity),
      'transactionid': serializer.toJson<int>(transactionid),
    };
  }

  Order copyWith(
          {int id,
          int product,
          int variant,
          int quantity,
          int transactionid}) =>
      Order(
        id: id ?? this.id,
        product: product ?? this.product,
        variant: variant ?? this.variant,
        quantity: quantity ?? this.quantity,
        transactionid: transactionid ?? this.transactionid,
      );
  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('product: $product, ')
          ..write('variant: $variant, ')
          ..write('quantity: $quantity, ')
          ..write('transactionid: $transactionid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          product.hashCode,
          $mrjc(variant.hashCode,
              $mrjc(quantity.hashCode, transactionid.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.product == this.product &&
          other.variant == this.variant &&
          other.quantity == this.quantity &&
          other.transactionid == this.transactionid);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<int> id;
  final Value<int> product;
  final Value<int> variant;
  final Value<int> quantity;
  final Value<int> transactionid;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.product = const Value.absent(),
    this.variant = const Value.absent(),
    this.quantity = const Value.absent(),
    this.transactionid = const Value.absent(),
  });
  OrdersCompanion.insert({
    this.id = const Value.absent(),
    @required int product,
    @required int variant,
    @required int quantity,
    @required int transactionid,
  })  : product = Value(product),
        variant = Value(variant),
        quantity = Value(quantity),
        transactionid = Value(transactionid);
  static Insertable<Order> custom({
    Expression<int> id,
    Expression<int> product,
    Expression<int> variant,
    Expression<int> quantity,
    Expression<int> transactionid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (product != null) 'product': product,
      if (variant != null) 'variant': variant,
      if (quantity != null) 'quantity': quantity,
      if (transactionid != null) 'transactionid': transactionid,
    });
  }

  OrdersCompanion copyWith(
      {Value<int> id,
      Value<int> product,
      Value<int> variant,
      Value<int> quantity,
      Value<int> transactionid}) {
    return OrdersCompanion(
      id: id ?? this.id,
      product: product ?? this.product,
      variant: variant ?? this.variant,
      quantity: quantity ?? this.quantity,
      transactionid: transactionid ?? this.transactionid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (product.present) {
      map['product'] = Variable<int>(product.value);
    }
    if (variant.present) {
      map['variant'] = Variable<int>(variant.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (transactionid.present) {
      map['transactionid'] = Variable<int>(transactionid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('product: $product, ')
          ..write('variant: $variant, ')
          ..write('quantity: $quantity, ')
          ..write('transactionid: $transactionid')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  final GeneratedDatabase _db;
  final String _alias;
  $OrdersTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _productMeta = const VerificationMeta('product');
  GeneratedIntColumn _product;
  @override
  GeneratedIntColumn get product => _product ??= _constructProduct();
  GeneratedIntColumn _constructProduct() {
    return GeneratedIntColumn('product', $tableName, false,
        $customConstraints: 'REFERENCES products(id)');
  }

  final VerificationMeta _variantMeta = const VerificationMeta('variant');
  GeneratedIntColumn _variant;
  @override
  GeneratedIntColumn get variant => _variant ??= _constructVariant();
  GeneratedIntColumn _constructVariant() {
    return GeneratedIntColumn('variant', $tableName, false,
        $customConstraints: 'REFERENCES productVariant(variantid)');
  }

  final VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  GeneratedIntColumn _quantity;
  @override
  GeneratedIntColumn get quantity => _quantity ??= _constructQuantity();
  GeneratedIntColumn _constructQuantity() {
    return GeneratedIntColumn(
      'quantity',
      $tableName,
      false,
    );
  }

  final VerificationMeta _transactionidMeta =
      const VerificationMeta('transactionid');
  GeneratedIntColumn _transactionid;
  @override
  GeneratedIntColumn get transactionid =>
      _transactionid ??= _constructTransactionid();
  GeneratedIntColumn _constructTransactionid() {
    return GeneratedIntColumn('transactionid', $tableName, false,
        $customConstraints: 'REFERENCES transaction(id)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, product, variant, quantity, transactionid];
  @override
  $OrdersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'orders';
  @override
  final String actualTableName = 'orders';
  @override
  VerificationContext validateIntegrity(Insertable<Order> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('product')) {
      context.handle(_productMeta,
          product.isAcceptableOrUnknown(data['product'], _productMeta));
    } else if (isInserting) {
      context.missing(_productMeta);
    }
    if (data.containsKey('variant')) {
      context.handle(_variantMeta,
          variant.isAcceptableOrUnknown(data['variant'], _variantMeta));
    } else if (isInserting) {
      context.missing(_variantMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity'], _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('transactionid')) {
      context.handle(
          _transactionidMeta,
          transactionid.isAcceptableOrUnknown(
              data['transactionid'], _transactionidMeta));
    } else if (isInserting) {
      context.missing(_transactionidMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Order.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(_db, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  Transaction({@required this.id});
  factory Transaction.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return Transaction(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
    };
  }

  Transaction copyWith({int id}) => Transaction(
        id: id ?? this.id,
      );
  @override
  String toString() {
    return (StringBuffer('Transaction(')..write('id: $id')..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(id.hashCode);
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) || (other is Transaction && other.id == this.id);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  const TransactionsCompanion({
    this.id = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
  });
  static Insertable<Transaction> custom({
    Expression<int> id,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
    });
  }

  TransactionsCompanion copyWith({Value<int> id}) {
    return TransactionsCompanion(
      id: id ?? this.id,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  final GeneratedDatabase _db;
  final String _alias;
  $TransactionsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  @override
  List<GeneratedColumn> get $columns => [id];
  @override
  $TransactionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'transactions';
  @override
  final String actualTableName = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Transaction.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(_db, alias);
  }
}

class DiscountProduct extends DataClass implements Insertable<DiscountProduct> {
  final int productid;
  final int discountid;
  DiscountProduct({@required this.productid, @required this.discountid});
  factory DiscountProduct.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    return DiscountProduct(
      productid:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}productid']),
      discountid:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}discountid']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || productid != null) {
      map['productid'] = Variable<int>(productid);
    }
    if (!nullToAbsent || discountid != null) {
      map['discountid'] = Variable<int>(discountid);
    }
    return map;
  }

  DiscountProductsCompanion toCompanion(bool nullToAbsent) {
    return DiscountProductsCompanion(
      productid: productid == null && nullToAbsent
          ? const Value.absent()
          : Value(productid),
      discountid: discountid == null && nullToAbsent
          ? const Value.absent()
          : Value(discountid),
    );
  }

  factory DiscountProduct.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DiscountProduct(
      productid: serializer.fromJson<int>(json['productid']),
      discountid: serializer.fromJson<int>(json['discountid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productid': serializer.toJson<int>(productid),
      'discountid': serializer.toJson<int>(discountid),
    };
  }

  DiscountProduct copyWith({int productid, int discountid}) => DiscountProduct(
        productid: productid ?? this.productid,
        discountid: discountid ?? this.discountid,
      );
  @override
  String toString() {
    return (StringBuffer('DiscountProduct(')
          ..write('productid: $productid, ')
          ..write('discountid: $discountid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(productid.hashCode, discountid.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is DiscountProduct &&
          other.productid == this.productid &&
          other.discountid == this.discountid);
}

class DiscountProductsCompanion extends UpdateCompanion<DiscountProduct> {
  final Value<int> productid;
  final Value<int> discountid;
  const DiscountProductsCompanion({
    this.productid = const Value.absent(),
    this.discountid = const Value.absent(),
  });
  DiscountProductsCompanion.insert({
    @required int productid,
    @required int discountid,
  })  : productid = Value(productid),
        discountid = Value(discountid);
  static Insertable<DiscountProduct> custom({
    Expression<int> productid,
    Expression<int> discountid,
  }) {
    return RawValuesInsertable({
      if (productid != null) 'productid': productid,
      if (discountid != null) 'discountid': discountid,
    });
  }

  DiscountProductsCompanion copyWith(
      {Value<int> productid, Value<int> discountid}) {
    return DiscountProductsCompanion(
      productid: productid ?? this.productid,
      discountid: discountid ?? this.discountid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productid.present) {
      map['productid'] = Variable<int>(productid.value);
    }
    if (discountid.present) {
      map['discountid'] = Variable<int>(discountid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscountProductsCompanion(')
          ..write('productid: $productid, ')
          ..write('discountid: $discountid')
          ..write(')'))
        .toString();
  }
}

class $DiscountProductsTable extends DiscountProducts
    with TableInfo<$DiscountProductsTable, DiscountProduct> {
  final GeneratedDatabase _db;
  final String _alias;
  $DiscountProductsTable(this._db, [this._alias]);
  final VerificationMeta _productidMeta = const VerificationMeta('productid');
  GeneratedIntColumn _productid;
  @override
  GeneratedIntColumn get productid => _productid ??= _constructProductid();
  GeneratedIntColumn _constructProductid() {
    return GeneratedIntColumn('productid', $tableName, false,
        $customConstraints: 'REFERENCES products(id)');
  }

  final VerificationMeta _discountidMeta = const VerificationMeta('discountid');
  GeneratedIntColumn _discountid;
  @override
  GeneratedIntColumn get discountid => _discountid ??= _constructDiscountid();
  GeneratedIntColumn _constructDiscountid() {
    return GeneratedIntColumn('discountid', $tableName, false,
        $customConstraints: 'REFERENCES discounts(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [productid, discountid];
  @override
  $DiscountProductsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'discount_products';
  @override
  final String actualTableName = 'discount_products';
  @override
  VerificationContext validateIntegrity(Insertable<DiscountProduct> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('productid')) {
      context.handle(_productidMeta,
          productid.isAcceptableOrUnknown(data['productid'], _productidMeta));
    } else if (isInserting) {
      context.missing(_productidMeta);
    }
    if (data.containsKey('discountid')) {
      context.handle(
          _discountidMeta,
          discountid.isAcceptableOrUnknown(
              data['discountid'], _discountidMeta));
    } else if (isInserting) {
      context.missing(_discountidMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  DiscountProduct map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return DiscountProduct.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $DiscountProductsTable createAlias(String alias) {
    return $DiscountProductsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ProductsTable _products;
  $ProductsTable get products => _products ??= $ProductsTable(this);
  $ProductVariantsTable _productVariants;
  $ProductVariantsTable get productVariants =>
      _productVariants ??= $ProductVariantsTable(this);
  $DiscountsTable _discounts;
  $DiscountsTable get discounts => _discounts ??= $DiscountsTable(this);
  $OrdersTable _orders;
  $OrdersTable get orders => _orders ??= $OrdersTable(this);
  $TransactionsTable _transactions;
  $TransactionsTable get transactions =>
      _transactions ??= $TransactionsTable(this);
  $DiscountProductsTable _discountProducts;
  $DiscountProductsTable get discountProducts =>
      _discountProducts ??= $DiscountProductsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        products,
        productVariants,
        discounts,
        orders,
        transactions,
        discountProducts
      ];
}
