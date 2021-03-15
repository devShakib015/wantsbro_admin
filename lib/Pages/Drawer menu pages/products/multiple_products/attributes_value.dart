import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:wantsbro_admin/Pages/Drawer%20menu%20pages/products/multiple_products/edit_multiple_product.dart';

class AttributesValue extends StatefulWidget {
  final String parentId;
  final String childId;
  final String parentName;
  final String childName;
  final bool isSingle;
  final String firstAttributeValue;
  final int firstAttributeNumber;
  final String secondAttributeValue;
  final int secondAttributeNumber;

  const AttributesValue({
    Key key,
    this.parentId,
    this.childId,
    this.parentName,
    this.childName,
    this.isSingle,
    this.firstAttributeValue,
    this.firstAttributeNumber,
    this.secondAttributeValue,
    this.secondAttributeNumber,
  }) : super(key: key);

  @override
  _AttributesValueState createState() => _AttributesValueState();
}

class _AttributesValueState extends State<AttributesValue> {
  List<Map<String, dynamic>> _attributeList = [];
  List<Color> _colorList = [];
  List _firstAtrributesValues = [];
  List _secondAttributesValues = [];

  List<Color> makeColorList(int number) {
    for (var i = 0; i < number; i++) {
      _colorList.add(Colors.transparent);
    }
    return _colorList;
  }

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.firstAttributeNumber; i++) {
      _firstAtrributesValues.add("nothing");
    }

    for (var i = 0; i < widget.secondAttributeNumber; i++) {
      _secondAttributesValues.add("nothing");
    }

    if (widget.firstAttributeValue == "color") {
      makeColorList(widget.firstAttributeNumber);
    } else if (widget.secondAttributeValue == "color") {
      makeColorList(widget.secondAttributeNumber);
    }
  }

  Color _pickerColor = Color(0xff443a49);

  Future<Color> chooseColor() async {
    Color changeColor;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Choose a color"),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: _pickerColor,
            onColorChanged: (Color color) {
              changeColor = color;
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
      ),
    );
    return changeColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attribues' Values"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
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
              Text(
                "${widget.firstAttributeNumber} - ${widget.firstAttributeValue.toUpperCase()}",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: widget.firstAttributeValue == "color"
                    ? _colorList
                        .map((e) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: e,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                    icon: Icon(Icons.border_color),
                                    onPressed: () async {
                                      Color choosedColor = await chooseColor();

                                      setState(() {
                                        _colorList[_colorList.indexOf(e)] =
                                            choosedColor;
                                      });
                                    })
                              ],
                            ))
                        .toList()
                    : [
                        for (var i = 0; i < widget.firstAttributeNumber; i++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (value) {
                                _firstAtrributesValues[i] = value;
                              },
                              decoration: InputDecoration(
                                labelText: (i + 1).toString(),
                              ),
                            ),
                          ),
                      ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "${widget.secondAttributeNumber} - ${widget.secondAttributeValue.toUpperCase()}",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: widget.secondAttributeValue == "color"
                    ? _colorList
                        .map((e) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: e,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                    ),
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                    icon: Icon(Icons.border_color),
                                    onPressed: () async {
                                      Color choosedColor = await chooseColor();

                                      setState(() {
                                        _colorList[_colorList.indexOf(e)] =
                                            choosedColor;
                                      });
                                    })
                              ],
                            ))
                        .toList()
                    : [
                        for (var i = 0; i < widget.secondAttributeNumber; i++)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (value) {
                                _secondAttributesValues[i] = value;
                              },
                              decoration: InputDecoration(
                                labelText: (i + 1).toString(),
                              ),
                            ),
                          ),
                      ],
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(
                          "Are you sure about all the fields you just typed? If you give any wrong info or no info then the value will be saved like that. So please be careful about this and why not check again?"),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              _attributeList.clear();
                              Navigator.pop(context);
                            },
                            child: Text("Check Again")),
                        ElevatedButton(
                          onPressed: () {
                            if (widget.firstAttributeValue == "color") {
                              for (var i in _colorList) {
                                for (var j in _secondAttributesValues) {
                                  _attributeList.add({
                                    widget.firstAttributeValue: i.toString(),
                                    widget.secondAttributeValue: j,
                                  });
                                }
                              }
                            } else if (widget.secondAttributeValue == "color") {
                              for (var i in _colorList) {
                                for (var j in _firstAtrributesValues) {
                                  _attributeList.add({
                                    widget.secondAttributeValue: i.toString(),
                                    widget.firstAttributeValue: j,
                                  });
                                }
                              }
                            } else {
                              for (var i in _firstAtrributesValues) {
                                for (var j in _secondAttributesValues) {
                                  _attributeList.add({
                                    widget.firstAttributeValue: i,
                                    widget.secondAttributeValue: j,
                                  });
                                }
                              }
                            }
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditMultipleProduct(
                                  attributesList: _attributeList,
                                  childId: widget.childId,
                                  childName: widget.childName,
                                  isSingle: widget.isSingle,
                                  parentId: widget.parentId,
                                  parentName: widget.parentName,
                                ),
                              ),
                            );
                          },
                          child: Text("Sure"),
                        ),
                      ],
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Next"),
                    Icon(Icons.arrow_right),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
