import 'package:currency_converter/common/helper.dart';
import 'package:currency_converter/domain/error/converter_error.dart';
import 'package:currency_converter/screen/currecies/currencies_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrenciesScreen extends StatefulWidget {
  @override
  _CurrenciesScreenState createState() => _CurrenciesScreenState();
}

class _CurrenciesScreenState extends State<CurrenciesScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(), () {
      Provider.of<CurrenciesProvider>(context, listen: false).getCurrencies();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<CurrenciesProvider>(context).errorStateStream
        .listen(null)
        .onError((handleError){
      final ConverterError error = handleError;
      displaySnackBar(context, error: error.message);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Moedas"),
        ),
        backgroundColor: Color(0xFFF7F9F9),
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Consumer<CurrenciesProvider>(
            builder: (context, data, child) {
              return ListView.builder(
                  itemCount: data.items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(10),
                        border: Border(
                          left: BorderSide(width: 2.0, color: generateRandomColor()),
                        ),
                        color: Colors.white
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              data.items[index].id,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(width: 1.0, color: Color(0xFFD7DBDD)),
                                ),
                              ),
                              child: Text(
                                data.items[index].description,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      ),
                      margin: const EdgeInsets.only(bottom: 8, left: 10, right: 10,),
                    );
                  }
              );
            },
          ),
        ),
      ),
    );
  }
}
