// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:fyp/services/settingDefaultDatabaseStuff.dart';

class TemplatePage extends StatefulWidget {
  //const TemplatePage({Key? key}) : super(key: key);
  String templateName;
  String template;
  TemplatePage({required this.templateName, required this.template});
  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  Color greenColor = const Color(0xFF00AF19);

  bool _isEditingText = false;
  late TextEditingController _editingController;
  @override
  void initState() {
    // TODO: implement templateState
    _editingController = TextEditingController(text: widget.template);
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.green[50],
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                color: Colors.grey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.templateName,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: greenColor,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.forward,
                        color: greenColor,
                        size: 35,
                      ),
                      onPressed: () {
                        widget.template = _editingController.value.text;
                        SettingDefaultStuff()
                            .setEditedTemplateForUser(value: widget.template);
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: greenColor,
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              content(),
            ],
          ),
        ),
      ),
    );
  }

  content() {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(left: 10, right: 10),
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.81,
            padding: EdgeInsets.only(
              left: 5,
              right: 5,
              bottom: 30,
            ),
            decoration: BoxDecoration(
              color: Colors.white, //Colors.grey[350],
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: _editTitleTextField(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _editTitleTextField() {
    if (_isEditingText)
      // ignore: curly_braces_in_flow_control_structures
      return Center(
        child: TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          // onSubmitted: (newValue) {
          //   setState(() {
          //     widget.template = newValue;
          //     _isEditingText = false;
          //   });
          // },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
      onTap: () {
        setState(() {
          _isEditingText = true;
        });
      },
      child: Text(
        widget.template,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
