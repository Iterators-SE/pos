class Tax {
  int id;
  String name;
  bool isSelected;
  double percentage;

  Tax({
    this.isSelected,
    this.id,
    this.name,
    this.percentage,
  });

  factory Tax.fromJson(Map<String, dynamic> taxJson) {
    return Tax(
      id: int.parse(taxJson['id']),
      name: taxJson['name'],
      isSelected: taxJson['isSelected'],
      percentage: taxJson['percentage'],
    );
  }

  @override
  String toString() {
    return '''
    taxId: $id
    taxName: $name
    isSelected: $isSelected
    percentage: $percentage
    \n
    ''';
  }
}
