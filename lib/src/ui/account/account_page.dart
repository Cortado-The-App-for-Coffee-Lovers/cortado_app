import 'package:cortado_app/src/bloc/auth/bloc.dart';
import 'package:cortado_app/src/data/user.dart';
import 'package:cortado_app/src/ui/drawer/drawer_home_page.dart';
import 'package:cortado_app/src/ui/widgets/app_bar_with_pic.dart';
import 'package:cortado_app/src/ui/widgets/cortado_button.dart';
import 'package:cortado_app/src/ui/widgets/loading_state_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../style.dart';

class AccountPage extends DrawerPage {
  AccountPage(Widget drawer, this.user) : super(drawer);
  final User user;
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.light,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: widget.drawer,
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          CustomScrollView(shrinkWrap: true, slivers: <Widget>[
            AppBarWithImage(
              actions: coffeeRedemptionWidget(widget.user),
              image: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/account.png")))),
              lower: Container(
                color: AppColors.dark,
                height: SizeConfig.screenHeight * .3,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        widget.user.firstName + " " + widget.user.lastName,
                        style: TextStyles.kAccountNameTextStyle,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "Member Since: " +
                              Format.dateFormatter
                                  .format(widget.user.createdAt),
                          style: TextStyles.kDefaultSmallTextStyle,
                        )),
                  ],
                ),
              ),
            ),
          ]),
          Container(
            height: SizeConfig.screenHeight * .5,
            child: ListView(children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Subscription:",
                  style: TextStyles.kDefaultDarkTextStyle,
                ),
              ),
              Container(
                margin: EdgeInsets.all(18.0),
                child: CortadoButton(
                  lineDist: 0,
                  text: getAccountType(),
                  textStyle: TextStyles.kAccountTitleTextStyle,
                  onTap: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
                color: AppColors.dark,
                height: 2.0,
                width: SizeConfig.safeBlockHorizontal * .9,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Money saved:",
                  style: TextStyles.kDefaultDarkTextStyle,
                ),
              ),
              Container(
                margin: EdgeInsets.all(18.0),
                child: CortadoButton(
                  lineDist: 0,
                  text: widget.user.moneySaved != null
                      ? "\$ " + widget.user.moneySaved.toString()
                      : "0\$",
                  textStyle: TextStyles.kAccountTitleTextStyle,
                  onTap: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
                color: AppColors.dark,
                height: 2.0,
                width: SizeConfig.safeBlockHorizontal * .9,
              ),
              SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 25),
                  child: Text(
                    "Past redemptions:",
                    style: TextStyles.kDefaultDarkTextStyle,
                  ),
                ),
              ),
            ]),
          )
        ],
      )),
      floatingActionButton: Container(
          height: SizeConfig.iHeight == IphoneHeight.i667 ? 50 : 125,
          child: Column(children: <Widget>[
            Center(
              child: LoadingStateButton<AuthLoadingState>(
                bloc: _authBloc,
                button: Container(
                  child: GestureDetector(
                      child: Text(
                        "Sign Out",
                        style: TextStyles.kContinueTextStyle,
                      ),
                      onTap: () {
                        _authBloc.add(SignOut());
                      }),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              color: AppColors.caramel,
              height: 1.0,
              width: SizeConfig.safeBlockHorizontal * .5,
            ),
          ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  getAccountType() {
    switch (widget.user.cbPlanId) {
      case "premium-unlimited":
        return "Premium Unlimited";
      case "black-unlimited":
        return "Black Unlimited";
      case "premium-daily":
        return "Premium Daily";
      case "black-daily":
        return "Black Daily";
      case "mini-pack":
        return "Mini Pack";
      default:
        return "None";
    }
  }
}

enum AccountType { premium, regular }
