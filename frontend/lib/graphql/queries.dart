class MutationQuery {
  String addProducts(String productName, String description, bool isTaxable,
      String photoLink) {
    return """
      mutation {
        addProduct(
          productname: "$productName",
          description: "$description",
          taxable: $isTaxable
          photolink: "$photoLink",
        )
      }
    """;
  }

  String getProducts() {
    return """
      {
        getProducts{
          id,
          productname,
          description,
          photolink,
          taxable
        }
      }
    """;
  }

  String deleteProduct(int productId) {
    return """
      mutation {
        deleteProduct(
          productId: $productId
        )
      }
    """;
  }
}
