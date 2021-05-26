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
    int price,
    int variantId,
  ) {
    return """
      mutation {
        editVariant(
          data:{
            variantname: "$variantName",
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
