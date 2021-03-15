import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:wantsbro_admin/Providers/category_provider.dart';
import 'package:wantsbro_admin/Providers/storage_provider.dart';
import 'package:wantsbro_admin/models/category_model.dart';
import 'package:wantsbro_admin/theming/color_constants.dart';

class EditCategory extends StatefulWidget {
  final String categoryId;
  final CategoryModel category;

  const EditCategory({
    Key key,
    this.categoryId,
    this.category,
  }) : super(key: key);

  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  String _imageUrl;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _parentId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          widget.categoryId == null
              ? Opacity(
                  opacity: 0,
                  child: Icon(Icons.ac_unit),
                )
              : IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Provider.of<CategoryProvider>(context, listen: false)
                        .deleteCategory(context, widget.categoryId);
                    Navigator.pop(context);
                  }),
        ],
        title: Text(
            widget.categoryId == null ? "Add New Vategory" : "Edit Category"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        _name = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Name cannot be empty";
                        }
                        return null;
                      },
                      initialValue: widget.categoryId == null
                          ? null
                          : widget.category.name,
                      decoration: InputDecoration(
                        labelText: "Category name",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        _parentId = value;
                      },
                      validator: (value) {
                        return null;
                      },
                      initialValue: widget.categoryId == null
                          ? null
                          : widget.category.parentID ?? "",
                      decoration: InputDecoration(
                        labelText: "Parent ID",
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                                  folderName: "Categories",
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
                        child: widget.categoryId == null
                            ? (_imageUrl == null
                                ? Icon(Icons.image)
                                : Image.network(_imageUrl))
                            : Image.network(widget.category.imageUrl),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (widget.categoryId == null) {
                            if (_imageUrl != null) {
                              setState(() {
                                _isLoading = true;
                              });
                              await Provider.of<CategoryProvider>(context,
                                      listen: false)
                                  .addNewCategory(
                                context,
                                CategoryModel(
                                    imageUrl: _imageUrl,
                                    name: _name,
                                    parentID: _parentId ?? ""),
                              );
                              setState(() {
                                _isLoading = false;
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "Please, Select a image, If you selected then Wait for the image to upload"),
                                ),
                              );
                            }
                          } else {
                            setState(() {
                              _isLoading = true;
                            });
                            await Provider.of<CategoryProvider>(context,
                                    listen: false)
                                .updateCategory(
                              context,
                              CategoryModel(
                                  imageUrl:
                                      _imageUrl ?? widget.category.imageUrl,
                                  name: _name ?? widget.category.name,
                                  parentID:
                                      _parentId ?? widget.category.parentID),
                              widget.categoryId,
                            );
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        }
                      },
                      child: Text("Save Category"),
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
