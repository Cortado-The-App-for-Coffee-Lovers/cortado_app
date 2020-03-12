import 'package:cortado_app/ui/splash/splash_page.dart';
import 'package:fluro/fluro.dart';
import 'package:cortado_app/ui/welcome/welcome_page.dart';

initRouter() {
  Router.appRouter
    // The '..' syntax is a Dart feature called cascade notation.
    // Further reading: https://dart.dev/guides/language/language-tour#cascade-notation-
    ..define(
      // The '/' route name is the one the MaterialApp defaults to as our initial one.
      '/',
      // Handler is a custom Fluro's class, in which you define the route's
      // widget builder as the Handler.handlerFunc.
      handler: Handler(
        handlerFunc: (context, params) => SplashPage(),
      ),
    )
    ..define(
      // The '/' route name is the one the MaterialApp defaults to as our initial one.
      '/welcome',
      // Handler is a custom Fluro's class, in which you define the route's
      // widget builder as the Handler.handlerFunc.
      handler: Handler(
        handlerFunc: (context, params) => WelcomePage(),
      ),
    );
  /*   ..define(
      // The ':id' syntax is how we tell Fluro to parse whatever comes in
      // that location and give it a name of 'id'. This is called a Path Param
      // or URI Param.
      'characters/:id',
      transitionType: TransitionType.native,
      handler: Handler(
        handlerFunc: (context, params) {
          // The 'params' is a dictionary where the key is the name we gave to
          // the parameter ('id' in this case), and the value is an array with
          // all the arguments that were provided (just a single `int` in this
          // case). Fluro gives us an array as the value instead of a single
          // item because when we're working with query string parameters,
          // we're able to pass an array as the argument, such as
          // '?name=Jesse,Walter,Gus'.
          final id = int.parse(params['id'][0]);
          return CharacterDetailPage(
            id: id,
          );
        },
      ),
    ) */
}
