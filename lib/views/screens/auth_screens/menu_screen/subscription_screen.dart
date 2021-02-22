import 'package:RBS/colors.dart';
import 'package:RBS/models/subscription_model.dart';
import 'package:RBS/services/network/api_handlers.dart';
import 'package:RBS/services/network/rest_apis.dart';
import 'package:RBS/views/screens/auth_screens/menu_screen/payment_screen.dart';
import 'package:RBS/views/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:velocity_x/velocity_x.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool isLoading = true;
  List<SubscriptionModel> packages = List<SubscriptionModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSubscriptionPackages().then((response) {
      packages =
          (response as List).map((e) => SubscriptionModel.fromJson(e)).toList();
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      VxToast.show(context,
          msg: 'Something went wrong. Error: ${error.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: isLoading
            ? CircularProgressIndicator(
                backgroundColor: kPrimaryColor,
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        'Subscription Packages',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kColorWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ).pOnly(bottom: 20),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: packages.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            child: SubscriptionWidget(
                              plan: packages[index],
                            ),
                            onTap: () async {
                              bool isLoggedIn =
                                  await getBool(LOGGED_IN, defaultValue: false);
                              if (isLoggedIn) {
                                setState(() {
                                  isLoading = true;
                                  getTransactionData(
                                          packages[index].id,
                                          double.parse(packages[index].price)
                                              .toInt()
                                              .toString())
                                      .then((response) async {
                                    String txID = response['txID'];
                                    String form = response['form'];
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => PaymentWebView(
                                                  form: form,
                                                )));
                                    VxToast.show(context,
                                        msg: 'Checking transaction status',
                                        showTime: 3000);
                                    Map<dynamic, dynamic> request = {
                                      'txID': txID
                                    };
                                    getTransactionStatus(request)
                                        .then((response) {
                                      VxToast.show(context,
                                          msg:
                                              'Your payment for the subscription plan ${packages[index].name} is ${response['status']}',
                                          showTime: 4000);
                                    });
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }).catchError((error) {
                                    VxToast.show(context,
                                        msg: 'Something went wrong!');
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                });
                              } else {
                                pushNewScreen(context,
                                    screen: WelcomeScreen(), withNavBar: false);
                              }
                            },
                          );
                        }),
                  ],
                ),
              ),
      ),
    );
  }
}

class SubscriptionWidget extends StatelessWidget {
  final SubscriptionModel plan;

  const SubscriptionWidget({Key key, this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(10),
      width: size.width,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kColorRed,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: HStack(
        [
          VStack([
            Flexible(
                child: Text(plan.name)
                    .text
                    .white
                    .bold
                    .xl2
                    .make()
                    .pOnly(bottom: 5)),
            Flexible(
                child: Text(
              'Screens: ${plan.screen}',
              style: TextStyle(color: kColorText),
            ).text.bold.make().pOnly(bottom: 5)),
            Flexible(
                child: Text('Downloads: ${plan.downloads}',
                        style: TextStyle(color: kColorText))
                    .text
                    .bold
                    .make()
                    .pOnly(bottom: 5)),
          ]),
          VerticalDivider(
            color: kColorWhite,
          ),
          Flexible(child: Text('BDT ${plan.price}').text.xl2.white.bold.make()),
        ],
        alignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
