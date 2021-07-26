import 'package:account_flutter_app/net/flutterfire.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  final List<String> coins = const [
    'bitcoin',
    'tether',
    'ethereum',
  ];
  String _dropdownValue = "bitcoin";
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton(
          value: _dropdownValue,
          icon: Icon(Icons.keyboard_arrow_down),
          dropdownColor: Colors.blueGrey,
          items: coins.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              _dropdownValue = value!;
            });
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.3,
          child: TextFormField(
            controller: _amountController,
            decoration: InputDecoration(
                labelText: "Coin Amount",
                labelStyle: TextStyle(color: Colors.cyan)),
            // keyboardType: TextInputType.text,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.7,
          height: 40,
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(15.0),
            color: Colors.cyan,
          ),
          child: MaterialButton(
            onPressed: () async {
              await addCoin(_dropdownValue,_amountController.text);
              Navigator.of(context).pop();
            },
            child: Text("Add"),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 5,
        ),
      ],
    ));
  }
}
