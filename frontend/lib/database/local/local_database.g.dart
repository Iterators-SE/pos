// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore: lines_longer_than_80_chars
// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this, avoid_equals_and_hash_code_on_mutable_classes, avoid_positional_boolean_parameters
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
    return Product(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      photoLink: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}photo_link']),
      taxable: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}taxable']),
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
  bool operator ==(Object other) =>
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
    @required int id,
    @required String name,
    @required String description,
    @required String photoLink,
    @required bool taxable,
  })  : id = Value(id),
        name = Value(name),
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
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
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
    } else if (isInserting) {
      context.missing(_idMeta);
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
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Product map(Map<String, dynamic> data, {String tablePrefix}) {
    return Product.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
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
    return ProductVariant(
      variantid: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}variantid']),
      variantname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}variantname']),
      price: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}price']),
      productid: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}productid']),
      quantity: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}quantity']),
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
  bool operator ==(Object other) =>
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
    @required int variantid,
    @required String variantname,
    @required int price,
    @required int productid,
    @required int quantity,
  })  : variantid = Value(variantid),
        variantname = Value(variantname),
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
    return GeneratedIntColumn(
      'variantid',
      $tableName,
      false,
    );
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
    } else if (isInserting) {
      context.missing(_variantidMeta);
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
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ProductVariant map(Map<String, dynamic> data, {String tablePrefix}) {
    return ProductVariant.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
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
  final String inclusiveDates;
  final DateTime startTime;
  final DateTime endTime;
  Discount(
      {@required this.id,
      @required this.description,
      @required this.percentage,
      @required this.inclusiveDates,
      @required this.startTime,
      @required this.endTime});
  factory Discount.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Discount(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      percentage: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}percentage']),
      inclusiveDates: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}inclusive_dates']),
      startTime: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}start_time']),
      endTime: const DateTimeType()
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
    if (!nullToAbsent || inclusiveDates != null) {
      map['inclusive_dates'] = Variable<String>(inclusiveDates);
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
      inclusiveDates: inclusiveDates == null && nullToAbsent
          ? const Value.absent()
          : Value(inclusiveDates),
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
      inclusiveDates: serializer.fromJson<String>(json['inclusiveDates']),
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
      'inclusiveDates': serializer.toJson<String>(inclusiveDates),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime>(endTime),
    };
  }

  Discount copyWith(
          {int id,
          String description,
          int percentage,
          String inclusiveDates,
          DateTime startTime,
          DateTime endTime}) =>
      Discount(
        id: id ?? this.id,
        description: description ?? this.description,
        percentage: percentage ?? this.percentage,
        inclusiveDates: inclusiveDates ?? this.inclusiveDates,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
      );
  @override
  String toString() {
    return (StringBuffer('Discount(')
          ..write('id: $id, ')
          ..write('description: $description, ')
          ..write('percentage: $percentage, ')
          ..write('inclusiveDates: $inclusiveDates, ')
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
          $mrjc(
              percentage.hashCode,
              $mrjc(inclusiveDates.hashCode,
                  $mrjc(startTime.hashCode, endTime.hashCode))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Discount &&
          other.id == this.id &&
          other.description == this.description &&
          other.percentage == this.percentage &&
          other.inclusiveDates == this.inclusiveDates &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime);
}

class DiscountsCompanion extends UpdateCompanion<Discount> {
  final Value<int> id;
  final Value<String> description;
  final Value<int> percentage;
  final Value<String> inclusiveDates;
  final Value<DateTime> startTime;
  final Value<DateTime> endTime;
  const DiscountsCompanion({
    this.id = const Value.absent(),
    this.description = const Value.absent(),
    this.percentage = const Value.absent(),
    this.inclusiveDates = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
  });
  DiscountsCompanion.insert({
    @required int id,
    @required String description,
    @required int percentage,
    @required String inclusiveDates,
    @required DateTime startTime,
    @required DateTime endTime,
  })  : id = Value(id),
        description = Value(description),
        percentage = Value(percentage),
        inclusiveDates = Value(inclusiveDates),
        startTime = Value(startTime),
        endTime = Value(endTime);
  static Insertable<Discount> custom({
    Expression<int> id,
    Expression<String> description,
    Expression<int> percentage,
    Expression<String> inclusiveDates,
    Expression<DateTime> startTime,
    Expression<DateTime> endTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (description != null) 'description': description,
      if (percentage != null) 'percentage': percentage,
      if (inclusiveDates != null) 'inclusive_dates': inclusiveDates,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
    });
  }

  DiscountsCompanion copyWith(
      {Value<int> id,
      Value<String> description,
      Value<int> percentage,
      Value<String> inclusiveDates,
      Value<DateTime> startTime,
      Value<DateTime> endTime}) {
    return DiscountsCompanion(
      id: id ?? this.id,
      description: description ?? this.description,
      percentage: percentage ?? this.percentage,
      inclusiveDates: inclusiveDates ?? this.inclusiveDates,
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
    if (inclusiveDates.present) {
      map['inclusive_dates'] = Variable<String>(inclusiveDates.value);
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
          ..write('inclusiveDates: $inclusiveDates, ')
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
    return GeneratedIntColumn(
      'id',
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

  final VerificationMeta _inclusiveDatesMeta =
      const VerificationMeta('inclusiveDates');
  GeneratedTextColumn _inclusiveDates;
  @override
  GeneratedTextColumn get inclusiveDates =>
      _inclusiveDates ??= _constructInclusiveDates();
  GeneratedTextColumn _constructInclusiveDates() {
    return GeneratedTextColumn(
      'inclusive_dates',
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
      [id, description, percentage, inclusiveDates, startTime, endTime];
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
    } else if (isInserting) {
      context.missing(_idMeta);
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
    if (data.containsKey('inclusive_dates')) {
      context.handle(
          _inclusiveDatesMeta,
          inclusiveDates.isAcceptableOrUnknown(
              data['inclusive_dates'], _inclusiveDatesMeta));
    } else if (isInserting) {
      context.missing(_inclusiveDatesMeta);
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
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Discount map(Map<String, dynamic> data, {String tablePrefix}) {
    return Discount.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
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
    return Order(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      product: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product']),
      variant: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}variant']),
      quantity: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}quantity']),
      transactionid: const IntType()
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
  bool operator ==(Object other) =>
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
    @required int id,
    @required int product,
    @required int variant,
    @required int quantity,
    @required int transactionid,
  })  : id = Value(id),
        product = Value(product),
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
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
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
    } else if (isInserting) {
      context.missing(_idMeta);
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
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Order map(Map<String, dynamic> data, {String tablePrefix}) {
    return Order.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
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
    return Transaction(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
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
  bool operator ==(Object other) =>
      identical(this, other) || (other is Transaction && other.id == this.id);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  const TransactionsCompanion({
    this.id = const Value.absent(),
  });
  TransactionsCompanion.insert({
    @required int id,
  }) : id = Value(id);
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
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
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
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Transaction map(Map<String, dynamic> data, {String tablePrefix}) {
    return Transaction.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(_db, alias);
  }
}

class DiscountProduct extends DataClass implements Insertable<DiscountProduct> {
  final int productId;
  final int discountId;
  DiscountProduct({@required this.productId, @required this.discountId});
  factory DiscountProduct.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return DiscountProduct(
      productId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}product_id']),
      discountId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}discount_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || productId != null) {
      map['product_id'] = Variable<int>(productId);
    }
    if (!nullToAbsent || discountId != null) {
      map['discount_id'] = Variable<int>(discountId);
    }
    return map;
  }

  DiscountProductsCompanion toCompanion(bool nullToAbsent) {
    return DiscountProductsCompanion(
      productId: productId == null && nullToAbsent
          ? const Value.absent()
          : Value(productId),
      discountId: discountId == null && nullToAbsent
          ? const Value.absent()
          : Value(discountId),
    );
  }

  factory DiscountProduct.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DiscountProduct(
      productId: serializer.fromJson<int>(json['productId']),
      discountId: serializer.fromJson<int>(json['discountId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'productId': serializer.toJson<int>(productId),
      'discountId': serializer.toJson<int>(discountId),
    };
  }

  DiscountProduct copyWith({int productId, int discountId}) => DiscountProduct(
        productId: productId ?? this.productId,
        discountId: discountId ?? this.discountId,
      );
  @override
  String toString() {
    return (StringBuffer('DiscountProduct(')
          ..write('productId: $productId, ')
          ..write('discountId: $discountId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(productId.hashCode, discountId.hashCode));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiscountProduct &&
          other.productId == this.productId &&
          other.discountId == this.discountId);
}

class DiscountProductsCompanion extends UpdateCompanion<DiscountProduct> {
  final Value<int> productId;
  final Value<int> discountId;
  const DiscountProductsCompanion({
    this.productId = const Value.absent(),
    this.discountId = const Value.absent(),
  });
  DiscountProductsCompanion.insert({
    @required int productId,
    @required int discountId,
  })  : productId = Value(productId),
        discountId = Value(discountId);
  static Insertable<DiscountProduct> custom({
    Expression<int> productId,
    Expression<int> discountId,
  }) {
    return RawValuesInsertable({
      if (productId != null) 'product_id': productId,
      if (discountId != null) 'discount_id': discountId,
    });
  }

  DiscountProductsCompanion copyWith(
      {Value<int> productId, Value<int> discountId}) {
    return DiscountProductsCompanion(
      productId: productId ?? this.productId,
      discountId: discountId ?? this.discountId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (discountId.present) {
      map['discount_id'] = Variable<int>(discountId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiscountProductsCompanion(')
          ..write('productId: $productId, ')
          ..write('discountId: $discountId')
          ..write(')'))
        .toString();
  }
}

class $DiscountProductsTable extends DiscountProducts
    with TableInfo<$DiscountProductsTable, DiscountProduct> {
  final GeneratedDatabase _db;
  final String _alias;
  $DiscountProductsTable(this._db, [this._alias]);
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  GeneratedIntColumn _productId;
  @override
  GeneratedIntColumn get productId => _productId ??= _constructProductId();
  GeneratedIntColumn _constructProductId() {
    return GeneratedIntColumn('product_id', $tableName, false,
        $customConstraints: 'REFERENCES products(id)');
  }

  final VerificationMeta _discountIdMeta = const VerificationMeta('discountId');
  GeneratedIntColumn _discountId;
  @override
  GeneratedIntColumn get discountId => _discountId ??= _constructDiscountId();
  GeneratedIntColumn _constructDiscountId() {
    return GeneratedIntColumn('discount_id', $tableName, false,
        $customConstraints: 'REFERENCES discounts(id)');
  }

  @override
  List<GeneratedColumn> get $columns => [productId, discountId];
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
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id'], _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('discount_id')) {
      context.handle(
          _discountIdMeta,
          discountId.isAcceptableOrUnknown(
              data['discount_id'], _discountIdMeta));
    } else if (isInserting) {
      context.missing(_discountIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  DiscountProduct map(Map<String, dynamic> data, {String tablePrefix}) {
    return DiscountProduct.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DiscountProductsTable createAlias(String alias) {
    return $DiscountProductsTable(_db, alias);
  }
}

class Taxe extends DataClass implements Insertable<Taxe> {
  final int id;
  final String name;
  final bool isSelected;
  final double percentage;
  Taxe(
      {@required this.id,
      @required this.name,
      @required this.isSelected,
      @required this.percentage});
  factory Taxe.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return Taxe(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      isSelected: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_selected']),
      percentage: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}percentage']),
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
    if (!nullToAbsent || isSelected != null) {
      map['is_selected'] = Variable<bool>(isSelected);
    }
    if (!nullToAbsent || percentage != null) {
      map['percentage'] = Variable<double>(percentage);
    }
    return map;
  }

  TaxesCompanion toCompanion(bool nullToAbsent) {
    return TaxesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      isSelected: isSelected == null && nullToAbsent
          ? const Value.absent()
          : Value(isSelected),
      percentage: percentage == null && nullToAbsent
          ? const Value.absent()
          : Value(percentage),
    );
  }

  factory Taxe.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Taxe(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isSelected: serializer.fromJson<bool>(json['isSelected']),
      percentage: serializer.fromJson<double>(json['percentage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'isSelected': serializer.toJson<bool>(isSelected),
      'percentage': serializer.toJson<double>(percentage),
    };
  }

  Taxe copyWith({int id, String name, bool isSelected, double percentage}) =>
      Taxe(
        id: id ?? this.id,
        name: name ?? this.name,
        isSelected: isSelected ?? this.isSelected,
        percentage: percentage ?? this.percentage,
      );
  @override
  String toString() {
    return (StringBuffer('Taxe(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isSelected: $isSelected, ')
          ..write('percentage: $percentage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(isSelected.hashCode, percentage.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Taxe &&
          other.id == this.id &&
          other.name == this.name &&
          other.isSelected == this.isSelected &&
          other.percentage == this.percentage);
}

class TaxesCompanion extends UpdateCompanion<Taxe> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> isSelected;
  final Value<double> percentage;
  const TaxesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isSelected = const Value.absent(),
    this.percentage = const Value.absent(),
  });
  TaxesCompanion.insert({
    @required int id,
    @required String name,
    @required bool isSelected,
    @required double percentage,
  })  : id = Value(id),
        name = Value(name),
        isSelected = Value(isSelected),
        percentage = Value(percentage);
  static Insertable<Taxe> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<bool> isSelected,
    Expression<double> percentage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isSelected != null) 'is_selected': isSelected,
      if (percentage != null) 'percentage': percentage,
    });
  }

  TaxesCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<bool> isSelected,
      Value<double> percentage}) {
    return TaxesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
      percentage: percentage ?? this.percentage,
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
    if (isSelected.present) {
      map['is_selected'] = Variable<bool>(isSelected.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<double>(percentage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaxesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isSelected: $isSelected, ')
          ..write('percentage: $percentage')
          ..write(')'))
        .toString();
  }
}

class $TaxesTable extends Taxes with TableInfo<$TaxesTable, Taxe> {
  final GeneratedDatabase _db;
  final String _alias;
  $TaxesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
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

  final VerificationMeta _isSelectedMeta = const VerificationMeta('isSelected');
  GeneratedBoolColumn _isSelected;
  @override
  GeneratedBoolColumn get isSelected => _isSelected ??= _constructIsSelected();
  GeneratedBoolColumn _constructIsSelected() {
    return GeneratedBoolColumn(
      'is_selected',
      $tableName,
      false,
    );
  }

  final VerificationMeta _percentageMeta = const VerificationMeta('percentage');
  GeneratedRealColumn _percentage;
  @override
  GeneratedRealColumn get percentage => _percentage ??= _constructPercentage();
  GeneratedRealColumn _constructPercentage() {
    return GeneratedRealColumn(
      'percentage',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, isSelected, percentage];
  @override
  $TaxesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'taxes';
  @override
  final String actualTableName = 'taxes';
  @override
  VerificationContext validateIntegrity(Insertable<Taxe> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_selected')) {
      context.handle(
          _isSelectedMeta,
          isSelected.isAcceptableOrUnknown(
              data['is_selected'], _isSelectedMeta));
    } else if (isInserting) {
      context.missing(_isSelectedMeta);
    }
    if (data.containsKey('percentage')) {
      context.handle(
          _percentageMeta,
          percentage.isAcceptableOrUnknown(
              data['percentage'], _percentageMeta));
    } else if (isInserting) {
      context.missing(_percentageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Taxe map(Map<String, dynamic> data, {String tablePrefix}) {
    return Taxe.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TaxesTable createAlias(String alias) {
    return $TaxesTable(_db, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final int id;
  final String name;
  final String email;
  final String receiptMessage;
  final String address;
  UserProfile(
      {@required this.id,
      @required this.name,
      @required this.email,
      @required this.receiptMessage,
      @required this.address});
  factory UserProfile.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    return UserProfile(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email']),
      receiptMessage: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}receipt_message']),
      address: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}address']),
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
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || receiptMessage != null) {
      map['receipt_message'] = Variable<String>(receiptMessage);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      receiptMessage: receiptMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(receiptMessage),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      receiptMessage: serializer.fromJson<String>(json['receiptMessage']),
      address: serializer.fromJson<String>(json['address']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'receiptMessage': serializer.toJson<String>(receiptMessage),
      'address': serializer.toJson<String>(address),
    };
  }

  UserProfile copyWith(
          {int id,
          String name,
          String email,
          String receiptMessage,
          String address}) =>
      UserProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        receiptMessage: receiptMessage ?? this.receiptMessage,
        address: address ?? this.address,
      );
  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('receiptMessage: $receiptMessage, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(email.hashCode,
              $mrjc(receiptMessage.hashCode, address.hashCode)))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.receiptMessage == this.receiptMessage &&
          other.address == this.address);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> receiptMessage;
  final Value<String> address;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.receiptMessage = const Value.absent(),
    this.address = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    @required int id,
    @required String name,
    @required String email,
    @required String receiptMessage,
    @required String address,
  })  : id = Value(id),
        name = Value(name),
        email = Value(email),
        receiptMessage = Value(receiptMessage),
        address = Value(address);
  static Insertable<UserProfile> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> email,
    Expression<String> receiptMessage,
    Expression<String> address,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (receiptMessage != null) 'receipt_message': receiptMessage,
      if (address != null) 'address': address,
    });
  }

  UserProfilesCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> email,
      Value<String> receiptMessage,
      Value<String> address}) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      receiptMessage: receiptMessage ?? this.receiptMessage,
      address: address ?? this.address,
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
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (receiptMessage.present) {
      map['receipt_message'] = Variable<String>(receiptMessage.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('receiptMessage: $receiptMessage, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  final GeneratedDatabase _db;
  final String _alias;
  $UserProfilesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
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

  final VerificationMeta _emailMeta = const VerificationMeta('email');
  GeneratedTextColumn _email;
  @override
  GeneratedTextColumn get email => _email ??= _constructEmail();
  GeneratedTextColumn _constructEmail() {
    return GeneratedTextColumn(
      'email',
      $tableName,
      false,
    );
  }

  final VerificationMeta _receiptMessageMeta =
      const VerificationMeta('receiptMessage');
  GeneratedTextColumn _receiptMessage;
  @override
  GeneratedTextColumn get receiptMessage =>
      _receiptMessage ??= _constructReceiptMessage();
  GeneratedTextColumn _constructReceiptMessage() {
    return GeneratedTextColumn(
      'receipt_message',
      $tableName,
      false,
    );
  }

  final VerificationMeta _addressMeta = const VerificationMeta('address');
  GeneratedTextColumn _address;
  @override
  GeneratedTextColumn get address => _address ??= _constructAddress();
  GeneratedTextColumn _constructAddress() {
    return GeneratedTextColumn(
      'address',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, email, receiptMessage, address];
  @override
  $UserProfilesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'user_profiles';
  @override
  final String actualTableName = 'user_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<UserProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email'], _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('receipt_message')) {
      context.handle(
          _receiptMessageMeta,
          receiptMessage.isAcceptableOrUnknown(
              data['receipt_message'], _receiptMessageMeta));
    } else if (isInserting) {
      context.missing(_receiptMessageMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address'], _addressMeta));
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  UserProfile map(Map<String, dynamic> data, {String tablePrefix}) {
    return UserProfile.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(_db, alias);
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
  $TaxesTable _taxes;
  $TaxesTable get taxes => _taxes ??= $TaxesTable(this);
  $UserProfilesTable _userProfiles;
  $UserProfilesTable get userProfiles =>
      _userProfiles ??= $UserProfilesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        products,
        productVariants,
        discounts,
        orders,
        transactions,
        discountProducts,
        taxes,
        userProfiles
      ];
}
