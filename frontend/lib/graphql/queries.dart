class MutationQuery {
  // ignore: avoid_positional_boolean_parameters
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

  String editProductDetails(
      int productId,
      String productName,
      String description,
      // ignore: avoid_positional_boolean_parameters
      bool isTaxable,
      String photoLink) {
    return """
      mutation {
        changeProductDetails(
          productId: $productId, 
          data:{
            productname: "$productName",
            description: "$description",
            taxable: $isTaxable,
            photolink: "$photoLink"
          })
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

  //variantQueries

    String getVariants(int productId) {
    return """
      query {
        getVariants(productId: $productId){
          variantid,
          variantname,
          price,
          quantity
        }
      }
    """;
  }

  String addVariant(
      String variantName, int quantity, int price, int productId) {
    return """
      mutation {
        addVariant(
          variantname: "$variantName",
          quantity: $quantity,
          price: $price,
          productId: $productId 
        )
      }
    """;
  }

  String editVariant(
    String variantName,
    int quantity,
    num price,
    int variantId,
  ) {
    return """
      mutation {
        editVariant(
          data:{
            variantname: $variantName,
            quantity: $quantity,
            price: $price,
          }, 
          variantid: $variantId
        )
      }
    """;
  }

  String deleteVariant(int variantId) {
    return """
      mutation {
        removeVariant(variantid: $variantId)
      }
    """;
  }

    String deleteAllVariants(int productId) {
    return """
      mutation {
        deleteAllVariants(productId: $productId)
      }
    """;
  }
}
