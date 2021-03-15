import 'package:flutter/material.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/products/multiple_products/attributes_value.dart';
import 'package:wantsbro_admin/theming/color_constants.dart';

class Attributes extends StatefulWidget {
  final String parentId;
  final String childId;
  final String parentName;
  final String childName;
  final bool isSingle;
  const Attributes({
    Key key,
    this.parentId,
    this.childId,
    this.parentName,
    this.childName,
    this.isSingle,
  }) : super(key: key);

  @override
  _AttributesState createState() => _AttributesState();
}

class _AttributesState extends State<Attributes> {
  List<String> _attributes = ["size", "model", "weight", "color"];

  String _firstDropDownvalue = "size";
  int _firstDropDownNumber;

  String _secondDropDownvalue = "size";
  int _secondDropDownNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Make attributes"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "${widget.parentName}/${widget.childName}",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.indigo[900],
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Select First Atrribute"),
                        DropdownButton<String>(
                          value: _firstDropDownvalue,
                          icon: Icon(Icons.arrow_downward),
                          underline: Container(
                            height: 2,
                            color: mainColor,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              _firstDropDownvalue = newValue;
                            });
                          },
                          items: _attributes
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _firstDropDownNumber = int.tryParse(value) ?? 0;
                      },
                      decoration: InputDecoration(labelText: "How many?"),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.grey[900],
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Select Second Atrribute"),
                        DropdownButton<String>(
                          value: _secondDropDownvalue,
                          icon: Icon(Icons.arrow_downward),
                          underline: Container(
                            height: 2,
                            color: mainColor,
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              _secondDropDownvalue = newValue;
                            });
                          },
                          items: _attributes
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _secondDropDownNumber = int.tryParse(value) ?? 0;
                      },
                      decoration: InputDecoration(labelText: "How many?"),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (_firstDropDownNumber != null &&
                        _secondDropDownNumber != null) {
                      if (_firstDropDownNumber != 0 &&
                          _secondDropDownNumber != 0) {
                        if (_firstDropDownvalue != _secondDropDownvalue) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AttributesValue(
                                childId: widget.childId,
                                childName: widget.childName,
                                parentId: widget.parentId,
                                parentName: widget.parentName,
                                isSingle: widget.isSingle,
                                firstAttributeNumber: _firstDropDownNumber,
                                firstAttributeValue: _firstDropDownvalue,
                                secondAttributeNumber: _secondDropDownNumber,
                                secondAttributeValue: _secondDropDownvalue,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Both attributes cannot be same."),
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Numbers are not valid. Please change to number."),
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Numbers field cannot be empty"),
                        ),
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Next"),
                      Icon(Icons.arrow_right),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
