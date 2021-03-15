import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/products/multiple_products/edit_multiple_product_variation.dart';
import 'package:wantsbro_admin/Providers/product_provider.dart';
import 'package:wantsbro_admin/Providers/storage_provider.dart';
import 'package:wantsbro_admin/models/multiple_product_model.dart';
import 'package:wantsbro_admin/models/multiple_product_variation_model.dart';
import 'package:wantsbro_admin/theming/color_constants.dart';

class EditMultipleProduct extends StatefulWidget {
  final String id;
  final Map product;
  final List productVariation;
  final String parentId;
  final String childId;
  final String parentName;
  final String childName;
  final bool isSingle;
  final List<Map<String, dynamic>> attributesList;

  const EditMultipleProduct({
    Key key,
    this.id,
    this.product,
    this.productVariation,
    this.parentId,
    this.childId,
    this.parentName,
    this.childName,
    this.isSingle,
    this.attributesList,
  }) : super(key: key);

  @override
  _EditMultipleProductState createState() => _EditMultipleProductState();
}

class _EditMultipleProductState extends State<EditMultipleProduct> {
  List _productvariation = [];

  @override
  void initState() {
    super.initState();
    if (widget.productVariation == null) {
      for (var item in widget.attributesList) {
        _productvariation.add(MultipleProductVariationModel(
          attributes: item,
          originalPrice: null,
          salePrice: null,
          soldCount: 0,
          stockCount: null,
          variationImageUrl: null,
        ).toMap());
      }
    } else {
      _productvariation = widget.productVariation;
    }
  }

  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String _title;
  String _desc;

  List<dynamic> _featuredImages;
  List<dynamic> _descImages;

  @override
  Widget build(BuildContext context) {
    if (_featuredImages == null) {
      if (widget.id != null) {
        _featuredImages = widget.product["featuredImages"];
      }
    }

    if (_descImages == null) {
      if (widget.id != null) {
        _descImages = widget.product["descImages"];
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null
            ? "Add New Multiple Product"
            : "Edit Multiple Product"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("${widget.parentName}/${widget.childName}"),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue:
                          widget.id == null ? null : widget.product["title"],
                      decoration: InputDecoration(labelText: "Title"),
                      onChanged: (value) {
                        _title = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Can't be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      initialValue: widget.id == null
                          ? null
                          : widget.product["description"],
                      decoration: InputDecoration(labelText: "Description"),
                      onChanged: (value) {
                        _desc = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Can't be empty";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Product variations - ${_productvariation.length}"),
                    Column(
                      children: _productvariation
                          .map((e) => Padding(
                                padding: EdgeInsets.all(8),
                                child: Card(
                                  child: ListTile(
                                    onTap: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditMultipleProductVariation(
                                            variation: e,
                                          ),
                                        ),
                                      );
                                      if (result != null) {
                                        setState(() {
                                          _productvariation[_productvariation
                                              .indexOf(e)] = result;
                                        });
                                      }
                                    },
                                    leading: e["variationImageUrl"] == null
                                        ? Icon(Icons.image)
                                        : Container(
                                            width: 50,
                                            height: 50,
                                            child: Image.network(
                                                e["variationImageUrl"]),
                                          ),
                                    title: e["attributes"]["color"] == null
                                        ? Text(
                                            e["attributes"].toString(),
                                            textAlign: TextAlign.center,
                                          )
                                        : Wrap(
                                            alignment:
                                                WrapAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Color(
                                                    int.parse(
                                                        e["attributes"]["color"]
                                                            .split('(0x')[1]
                                                            .split(')')[0],
                                                        radix: 16),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                ),
                                                width: 30,
                                                height: 30,
                                              ),
                                              Text(e["attributes"].toString()),
                                            ],
                                          ),
                                    subtitle: Text(
                                      "Original Price: ${e["originalPrice"]}",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        width: double.infinity - 30,
                        height: 300,
                        color: disableWhite,
                        child: _featuredImages == null
                            ? Center(
                                child: Text(
                                  "No featured images selected",
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            : (_featuredImages == []
                                ? Center(
                                    child: Icon(Icons.error),
                                  )
                                : ListView(
                                    children: _featuredImages
                                        .map((e) => Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              width: double.infinity,
                                              height: 150,
                                              child: Image.network(
                                                e,
                                                fit: BoxFit.cover,
                                              ),
                                            ))
                                        .toList(),
                                  )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          setState(() {
                            _isLoading = true;
                          });
                          final url = await Provider.of<StorageProvider>(
                                  context,
                                  listen: false)
                              .uploadMultipleImages(context,
                                  actionBarTitle: "Select featured images",
                                  foldName: "Products",
                                  maxNumberOfImages: 10);
                          setState(() {
                            _featuredImages = url;
                            _isLoading = false;
                          });
                        } catch (e) {
                          setState(() {
                            _isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "There is an error uploading the image."),
                            ),
                          );
                        }
                      },
                      child: Text("Upload Featured Images"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        width: double.infinity - 30,
                        height: 500,
                        color: disableWhite,
                        child: _descImages == null
                            ? Center(
                                child: Text(
                                  "No description images selected",
                                  style: TextStyle(color: Colors.black),
                                ),
                              )
                            : (_descImages == []
                                ? Center(
                                    child: Icon(Icons.error),
                                  )
                                : ListView(
                                    children: _descImages
                                        .map((e) => Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              width: double.infinity,
                                              height: 250,
                                              child: Image.network(
                                                e,
                                                fit: BoxFit.cover,
                                              ),
                                            ))
                                        .toList(),
                                  )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            setState(() {
                              _isLoading = true;
                            });
                            final url = await Provider.of<StorageProvider>(
                                    context,
                                    listen: false)
                                .uploadMultipleImages(context,
                                    actionBarTitle: "Select Description images",
                                    foldName: "Products",
                                    maxNumberOfImages: 20);
                            setState(() {
                              _descImages = url;
                              _isLoading = false;
                            });
                          } catch (e) {
                            setState(() {
                              _isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "There is an error uploading the image."),
                              ),
                            );
                          }
                        },
                        child: Text("Upload Description Images")),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (_featuredImages != null) {
                            setState(() {
                              _isLoading = true;
                            });
                            widget.id == null
                                ? await Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .addNewMultipleProduct(
                                        context,
                                        MultipleProductModel(
                                            childCategoryID: widget.childId,
                                            childCategoryName: widget.childName,
                                            descImages: _descImages,
                                            description: _desc,
                                            featuredImages: _featuredImages,
                                            isSingle: widget.isSingle,
                                            parentCategoryID: widget.parentId,
                                            parentCategoryName:
                                                widget.parentName,
                                            productVariation: _productvariation,
                                            title: _title))
                                : await Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .updateMultipleProduct(
                                        context,
                                        MultipleProductModel(
                                          childCategoryID: widget.childId,
                                          childCategoryName: widget.childName,
                                          descImages: _descImages ??
                                              widget.product["descImages"],
                                          description: _desc ??
                                              widget.product["description"],
                                          featuredImages: _featuredImages ??
                                              widget.product["featuredImages"],
                                          isSingle: widget.isSingle,
                                          parentCategoryID: widget.parentId,
                                          parentCategoryName: widget.parentName,
                                          productVariation: _productvariation,
                                          title:
                                              _title ?? widget.product["title"],
                                        ),
                                        widget.id);
                            setState(() {
                              _isLoading = false;
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "At least one featured image is required"),
                              ),
                            );
                          }
                        }
                      },
                      child: Text("Save product"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
