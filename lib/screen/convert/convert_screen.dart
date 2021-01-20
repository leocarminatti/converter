import 'package:currency_converter/common/helper.dart';
import 'package:currency_converter/domain/error/converter_error.dart';
import 'package:currency_converter/screen/convert/convert_provider.dart';
import 'package:currency_converter/widgets/arrows_convert.dart';
import 'package:currency_converter/widgets/dropdown_custom.dart';
import 'package:currency_converter/widgets/snack_bar_launcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConvertScreen extends StatefulWidget {
  @override
  _ConvertScreenState createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(), () {
      Provider.of<ConvertProvider>(context, listen: false).getCurrenciesCode();
    });
  }

  @override
  void didChangeDependencies() {
    Provider.of<ConvertProvider>(context).errorStateStream
        .listen(null)
        .onError((handleError){
          final ConverterError error = handleError;
          displaySnackBar(context, error: error.message);
        });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ConvertProvider>(context);
    return Stack(
      children: [
        // Consumer(
        //   builder: (context, data, child) => SnackBarLauncher(error: data.error),
        // ),
        SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                "Conversor",
                                style:
                                    TextStyle(fontSize: 30, color: Colors.blue),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                                child: Text(
                              provider.convertedValue.toStringAsFixed(2),
                              style:
                                  TextStyle(fontSize: 50, color: Colors.blue),
                            )),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(35.0),
                              topRight: const Radius.circular(35.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 40, right: 20, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Consumer<ConvertProvider>(
                                  builder: (context, data, child) {
                                return DropdownCustom(
                                  items: data.items,
                                  valueSelected: data.selectedFrom,
                                  onChanged: (String newValue) {
                                    data.selectedFrom = newValue;
                                  },
                                );
                              }),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: ArrowsConvert(),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Consumer<ConvertProvider>(
                                  builder: (context, data, child) {
                                return DropdownCustom(
                                  items: data.items,
                                  valueSelected: data.selectedTo,
                                  onChanged: (String newValue) {
                                    data.selectedTo = newValue;
                                  },
                                );
                              }),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "Valor a ser convertido",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextField(
                                  controller: _controller,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ))),
                              SizedBox(
                                height: 20,
                              ),
                              ButtonTheme(
                                height: 40,
                                child: RaisedButton(
                                  onPressed: () {
                                    provider.amountConvert(
                                        double.parse(_controller.value.text));
                                  },
                                  child: Text("Converter"),
                                  textColor: Colors.white,
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.green),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
