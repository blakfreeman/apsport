import 'package:aptus/screens/home.dart';
import 'package:aptus/screens/home2.dart';
import 'package:aptus/services/locator.dart';
import 'package:aptus/services/auth.dart';
import 'package:aptus/model/base_model.dart';

class StartUpScreenModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      return Home2();
    } else {
      return Home();
    }
  }
}
