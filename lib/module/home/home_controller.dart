import 'package:get/get.dart';
import 'package:nexus_app/models/user_model.dart';
import 'package:nexus_app/module/auth/unauthorized_view.dart';
import 'package:nexus_app/module/auth/unverified_view.dart';
import 'package:nexus_app/repository/profile_repository.dart';
import 'package:nexus_app/theme/loaderScreen.dart';

class HomeController extends GetxController {
  final ProfileRepository profileRepository = ProfileRepository();
  User? user;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  // Fetch user data from the repository
  void fetchUser() async {
    try {
      user = await profileRepository.getUser();
    } catch (e) {
      Loader().onError(msg: 'Failed to fetch user data: $e');
    }
  }

  // Check user authorization and navigate accordingly
  void checkUserAuthorization(Function onAuthorized) {
    if (user == null) {
      // Fetch the user if it hasn't been retrieved yet
      fetchUser();
    }

    if (user != null) {
      // Check if the user is a student or teacher
      if (user!.userType == 'student') {
        // If student, navigate to the Unauthorized page
        Get.to(() => const UnauthorizedView());
      } else if (user!.userType == 'teacher') {
        // If teacher, check if they are verified
        if (user!.isVerified == 1) {
          onAuthorized(); // Proceed if teacher is verified
        } else {
          // If teacher is not verified, navigate to Unverified page
          Get.to(() => const UnverifiedView());
        }
      } else {
        Loader().onError(msg: 'Unknown user type');
      }
    }
  }
}
