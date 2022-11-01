import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_pack/app_localizations.dart';
import 'package:starter_pack/bloc/customer/customer_all_products/bloc.dart';
import 'package:starter_pack/resources/widgets/background_widget.dart';
import 'package:starter_pack/services/all_services.dart';
import 'package:starter_pack/resources/values/colors.dart';
import 'package:starter_pack/resources/widgets/product/small_product_card.dart';

class CustomerAllProductsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CustomerAllProductsBloc(context),
      child: _CustomerAllProductsStatefulWidget(),
    );
  }
}

class _CustomerAllProductsStatefulWidget extends StatefulWidget {
  _CustomerAllProductsStatefulWidgetState createState() => _CustomerAllProductsStatefulWidgetState();
}

class _CustomerAllProductsStatefulWidgetState extends State<_CustomerAllProductsStatefulWidget> {
  CustomerAllProductsBloc _customerAllProductsBloc;

  String name = AllServices().databaseService.getUser().name != null ? AllServices().databaseService.getUser().name : "";
  String surname = AllServices().databaseService.getUser().surname != null ? AllServices().databaseService.getUser().surname : "";
  String address = AllServices().databaseService.getUser().address != null ? AllServices().databaseService.getUser().address : "";
  String phone = AllServices().databaseService.getUser().phone != null ? AllServices().databaseService.getUser().phone : "";

  @override
  void initState() {
    _customerAllProductsBloc = BlocProvider.of<CustomerAllProductsBloc>(context);
    _customerAllProductsBloc.add(InitiateCustomerAllProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AllServices().designService.setTransparentStatusAndNavigationBar();

    List<String> choices = <String>[
      AppLocalizations.of(context).translate("menu_all_products"),
      AppLocalizations.of(context).translate("menu_view_profile"),
      AppLocalizations.of(context).translate("menu_change_profile_data"),
      AppLocalizations.of(context).translate("menu_change_password"),
      AppLocalizations.of(context).translate("menu_logout"),
    ];

    return new WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: BackgroundWidget(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                PopupMenuButton(
                  onSelected: (String value) {
                    _customerAllProductsBloc.add(NavigateCustomerAllProductsEvent(value));
                  },
                  icon: Icon(
                    Icons.menu,
                    color: color_black,
                    size: 36,
                  ),
                  color: color_black,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context) {
                    return choices.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Container(
                          margin: EdgeInsets.only(top: 4),
                          padding: EdgeInsets.only(bottom: 4),
                          width: MediaQuery.of(context).size.width,
                          child: AutoSizeText(
                            choice.toUpperCase(),
                            style: TextStyle(
                              color: color_dots,
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: color_dots,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList();
                  },
                )
              ],
            ),
            body: SafeArea(
              child: BlocBuilder(
                bloc: _customerAllProductsBloc,
                builder: (BuildContext context, CustomerAllProductsState state) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: ListView.builder(
                          itemCount: state.products.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SmallProductCard(
                              product: state.products[index],
                              onTap: () {
                                _customerAllProductsBloc.add(ViewOneProductCustomerAllProductsEvent(state.products[index]));
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            floatingActionButton: new FloatingActionButton(
              elevation: 0.0,
              child: new Icon(Icons.shopping_basket),
              backgroundColor: color_floating_action_bar_color,
              onPressed: () {
                _customerAllProductsBloc.add(BasketCustomerAllProductsEvent());
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _customerAllProductsBloc.close();
    super.dispose();
  }
}
