abstract class ProductModel {
  String title;
  String parentCategoryID;
  String parentCategoryName;
  String childCategoryID;
  String childCategoryName;
  String description;
  ProductModel({
    this.title,
    this.parentCategoryID,
    this.parentCategoryName,
    this.childCategoryID,
    this.childCategoryName,
    this.description,
  });
}
