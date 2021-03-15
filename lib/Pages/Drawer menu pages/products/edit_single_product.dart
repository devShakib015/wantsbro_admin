import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:wantsbro_admin/Providers/product_provider.dart';
import 'package:wantsbro_admin/Providers/storage_provider.dart';
import 'package:wantsbro_admin/models/single_product_model.dart';
import 'package:wantsbro_admin/theming/color_constants.dart';

class EditSingleProduct extends StatefulWidget {
  final String id;
  final Map product;
  final String parentId;
  final String childId;
  final String parentName;
  final String childName;
  final bool isSingle;

  const EditSingleProduct({
    Key key,
    this.id,
    this.product,
    this.parentId,
    this.childId,
    this.parentName,
    this.childName,
    this.isSingle,
  }) : super(key: key);

  @override
  _EditSingleProductState createState() => _EditSingleProductState();
}

class _EditSingleProductState extends State<EditSingleProduct> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _title;
  String _desc;
  String _weight;
  String _size;
  double _originalPrice;
  double _salePrice;
  int _stockCount;
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
        actions: [
          widget.id == null
              ? Opacity(
                  opacity: 0,
                  child: Icon(Icons.delete),
                )
              : IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await Provider.of<ProductProvider>(context, listen: false)
                        .deleteProduct(context, widget.id);
                    Navigator.pop(context);
                  })
        ],
        title: Text(
            widget.id == null ? "Add Single Product" : "Edit Single Product"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
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
                      initialValue: widget.id == null
                          ? null
                          : widget.product["description"],
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
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
                      height: 10,
                    ),
                    TextFormField(
                      initialValue:
                          widget.id == null ? null : widget.product["weight"],
                      decoration: InputDecoration(
                          labelText: "Weight",
                          helperText: "Weight in kg or gram"),
                      onChanged: (value) {
                        _weight = value;
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
                      initialValue:
                          widget.id == null ? null : widget.product["size"],
                      decoration: InputDecoration(
                          labelText: "Size",
                          helperText:
                              "Size like 12cmX12cmX30cm or in just cm or meter"),
                      onChanged: (value) {
                        _size = value;
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
                      initialValue: widget.id == null
                          ? null
                          : widget.product["originalPrice"].toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Original price",
                          helperText:
                              "Origial Price for the product not discount one"),
                      onChanged: (value) {
                        _originalPrice = double.tryParse(value) ?? 0;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Can't be empty";
                        } else if (double.tryParse(value) == null) {
                          return "The price cannot be letter";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: widget.id == null
                          ? null
                          : widget.product["salePrice"].toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Sale price",
                          helperText:
                              "Discount Price for the product. If no discount then make it 0"),
                      onChanged: (value) {
                        _salePrice = double.tryParse(value) ?? 0;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Can't be empty";
                        } else if (double.tryParse(value) == null) {
                          return "The price cannot be letter";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      initialValue: widget.id == null
                          ? null
                          : widget.product["stockCount"].toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Number of products in stock",
                      ),
                      onChanged: (value) {
                        _stockCount = int.tryParse(value) ?? 0;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Can't be empty";
                        } else if (int.tryParse(value) == null) {
                          return "The number cannot be letter";
                        }
                        return null;
                      },
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
                                  maxNumberOfImages: 6);
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
                                    .addNewSingleProduct(
                                    context,
                                    SingleProductModel(
                                      childCategoryID: widget.childId,
                                      childCategoryName: widget.childName,
                                      descImages: _descImages,
                                      description: _desc,
                                      featuredImages: _featuredImages,
                                      isSingle: widget.isSingle,
                                      originalPrice: _originalPrice,
                                      parentCategoryID: widget.parentId,
                                      parentCategoryName: widget.parentName,
                                      salePrice: _salePrice,
                                      size: _size,
                                      soldCount: 0,
                                      stockCount: _stockCount,
                                      title: _title,
                                      weight: _weight,
                                    ),
                                  )
                                : await Provider.of<ProductProvider>(context,
                                        listen: false)
                                    .updateSingleProduct(
                                    context,
                                    SingleProductModel(
                                      childCategoryID: widget.childId,
                                      childCategoryName: widget.childName,
                                      descImages: _descImages ??
                                          widget.product["descImages"],
                                      description: _desc ??
                                          widget.product["description"],
                                      featuredImages: _featuredImages ??
                                          widget.product["featuredImages"],
                                      isSingle: widget.isSingle,
                                      originalPrice: _originalPrice ??
                                          widget.product["originalPrice"],
                                      parentCategoryID: widget.parentId,
                                      parentCategoryName: widget.parentName,
                                      salePrice: _salePrice ??
                                          widget.product["salePrice"],
                                      size: _size ?? widget.product["size"],
                                      soldCount: 0,
                                      stockCount: _stockCount ??
                                          widget.product["stockCount"],
                                      title: _title ?? widget.product["title"],
                                      weight:
                                          _weight ?? widget.product["weight"],
                                    ),
                                    widget.id,
                                  );
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
