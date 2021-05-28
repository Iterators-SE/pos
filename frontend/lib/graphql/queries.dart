class MutationQuery {
  // ignore: avoid_positional_boolean_parameters
  String addProduct(String productName, String description, bool isTaxable,
      String photoLink) {
    return """
      mutation {
        addProduct(
          name: "$productName",
          description: "$description",
          isTaxable: $isTaxable
          photoLink: "$photoLink",
        ){
          id
        }
      }
    """;
  }

  String getProducts() {
    return """
      {
        getProducts{
          id,
          name,
          description,
          photoLink,
          isTaxable,
          variant {
            id, 
            name,
            quantity,
            price, 
          }
        }
      }
    """;
  }

    String getProductDetails(int productId) {
    return """
      {
        getProductDetails(productId: $productId){
          id,
          name,
          description,
          photoLink,
          isTaxable,
          variant{
            id,
            name,
            quantity,
            price
          }
        }
      }
    """;
  }

  String changeProductDetails(
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
            name: "$productName",
            description: "$description",
            isTaxable: $isTaxable,
            photoLink: "$photoLink"
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
          name: "$variantName",
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
    int price,
    int variantId,
  ) {
    return """
      mutation {
        editVariant(
          data:{
            name: "$variantName",
            quantity: $quantity,
            price: $price,
          }, 
          variantId: $variantId
        )
      }
    """;
  }

  String deleteVariant(int variantId) {
    return """
      mutation {
        deleteVariant(variantId: $variantId)
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

  String createGenericDiscount(
      String description, int percentage, List<int> products) {
    return """
      mutation{
        createGenericDiscount(input: {
          description : "$description",
          percentage : $percentage,
          products : $products
        }){
          description
          percentage
        }
      }
      """;
  }

  String updateGenericDiscount(
    int id,
      String description, int percentage, List<int> products) {
    return """
      mutation{
        updateGenericDiscount(
          id: $id,
          input: {
          description : "$description",
          percentage : $percentage,
          products : $products
        }){
          description
          percentage
        }
      }
      """;
  }

  String createCustomDiscount(
      String description,
      int percentage,
      List<int> products,
      String startTime,
      String endTime,
      DateTime startDate,
      DateTime endDate) {
    return """mutation{
        createCustomDiscount(
          input: {
            description: "$description",
            percentage: $percentage,
            products: $products
          }, 
          custom: {
            startTime: "$startTime",
            endTime: "$endTime",
            inclusiveDates: ["${startDate.toUtc().toString().split(' ')[0]}", 
            "${endDate.toUtc().toString().split(' ')[0]}"]
          }
        ){
          description
          percentage
        }
    }
    """;
  }

  String updateCustomDiscount(
      int id,
      String description,
      int percentage,
      List<int> products,
      String startTime,
      String endTime,
      DateTime startDate,
      DateTime endDate) {
    return """mutation{
        updateCustomDiscount(
          id: id,
          input: {
            description: "$description",
            percentage: $percentage,
            products: $products
          }, 
          custom: {
            startTime: "$startTime",
            endTime: "$endTime",
            inclusiveDates: ["${startDate.toUtc().toString().split(' ')[0]}", 
            "${endDate.toUtc().toString().split(' ')[0]}"]
          }
        ){
          description
          percentage
        }
    }
    """;
  }

  String getDiscounts() { 
    return """
    query{
      getDiscounts{
        id
        description
        percentage
      }
    }
    """;
  }

  String getDiscount(int id) {
    return """
    query{
      getDiscount(id: $id){
        description
        percentage
      }
    }
    """;
  }
  String deleteDiscount(int id){
    return """
    mutation{
      deleteDiscount(id : $id){}
    }
    """;
  }
}
