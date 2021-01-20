import 'package:flutter/material.dart';

class DropdownCustom extends StatefulWidget {
  final List<String> items;
  String valueSelected;
  final ValueChanged<String> onChanged;

  DropdownCustom({this.items, this.valueSelected, this.onChanged});

  @override
  _DropdownCustomState createState() => _DropdownCustomState();
}

class _DropdownCustomState extends State<DropdownCustom> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.grey,
      ),
      child: DropdownButton<String>(
        hint: const Text("Selecione uma moeda", style: TextStyle(color: Colors.white),),
        items: widget.items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: widget.onChanged,
        value: widget.valueSelected,
        style: TextStyle(color: Colors.white),
        iconEnabledColor: Colors.white,
        isExpanded: true,
      ),
    );
  }
}
