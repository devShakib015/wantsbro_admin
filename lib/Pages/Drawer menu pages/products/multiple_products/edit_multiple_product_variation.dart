import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:wantsbro_admin/Providers/storage_provider.dart';
import 'package:wantsbro_admin/theming/color_constants.dart';

class EditMultipleProductVariation extends StatefulWidget {
  final variation;
  const EditMultipleProductVariation({
    Key key,
    this.variation,
  }) : super(key: key);

  @override
  _EditMultipleProductVariationState createState() =>
      _EditMultipleProductVariationState();
}

class _EditMultipleProductVariationState
    extends State<EditMultipleProductVariation> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  double _originalPrice;
  double _salePrice;
  int _stockCount;
  String _imageUrl;

  @override
  Widget build(BuildContext context) {
    if (_imageUrl == null) {
      if (widget.variation["originalPrice"] == null) {
        _imageUrl = widget.variation["variationImageUrl"];
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.variation["originalPrice"] == null
            ? "Add a Product Variation"
            : "Edit a variation"),
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
                    Container(
                      padding: EdgeInsets.all(16),
                      color: mainColor,
                      child: widget.variation["attributes"]["color"] == null
                          ? Text(
                              widget.variation["attributes"].toString(),
                              textAlign: TextAlign.center,
                            )
                          : Wrap(
                              alignment: WrapAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(
                                      int.parse(
                                          widget.variation["attributes"]
                                                  ["color"]
                                              .split('(0x')[1]
                                              .split(')')[0],
                                          radix: 16),
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  width: 30,
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(widget.variation["attributes"].toString()),
                              ],
                            ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      initialValue: widget.variation["originalPrice"] == null
                          ? null
                          : widget.variation["originalPrice"].toString(),
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
                      keyboardType: TextInputType.number,
                      initialValue: widget.variation["originalPrice"] == null
                          ? null
                          : widget.variation["salePrice"].toString(),
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
                      keyboardType: TextInputType.number,
                      initialValue: widget.variation["originalPrice"] == null
                          ? null
                          : widget.variation["stockCount"].toString(),
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
                    Text("Select Variation Image"),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        try {
                          setState(() {
                            _isLoading = true;
                          });
                          final url = await Provider.of<StorageProvider>(
                                  context,
                                  listen: false)
                              .uploadSingleImage(
                                  folderName: "Products",
                                  imageName:
                                      "${DateTime.now().millisecondsSinceEpoch}");
                          setState(() {
                            _imageUrl = url;
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
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 2, color: mainColor),
                            top: BorderSide(width: 2, color: mainColor),
                            left: BorderSide(width: 2, color: mainColor),
                            right: BorderSide(width: 2, color: mainColor),
                          ),
                        ),
                        width: 300,
                        height: 300,
                        child: widget.variation["variationImageUrl"] == null
                            ? (_imageUrl == null
                                ? Icon(Icons.image)
                                : Image.network(_imageUrl))
                            : Image.network(
                                widget.variation["variationImageUrl"]),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (widget.variation["originalPrice"] == null) {
                            if (_imageUrl != null) {
                              widget.variation["originalPrice"] =
                                  _originalPrice ??
                                      widget.variation["originalPrice"];

                              widget.variation["salePrice"] =
                                  _salePrice ?? widget.variation["salePrice"];
                              widget.variation["stockCount"] =
                                  _stockCount ?? widget.variation["stockCount"];
                              widget.variation["variationImageUrl"] = _imageUrl;
                              Navigator.pop(context, widget.variation);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Please, Select a image, If you selected then Wait for the image to upload"),
                                ),
                              );
                            }
                          } else {
                            widget.variation["originalPrice"] =
                                _originalPrice ??
                                    widget.variation["originalPrice"];

                            widget.variation["salePrice"] =
                                _salePrice ?? widget.variation["salePrice"];
                            widget.variation["stockCount"] =
                                _stockCount ?? widget.variation["stockCount"];
                            widget.variation["variationImageUrl"] = _imageUrl ??
                                widget.variation["variationImageUrl"];
                            Navigator.pop(context, widget.variation);
                          }
                        }
                      },
                      child: Text("Save variation"),
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
