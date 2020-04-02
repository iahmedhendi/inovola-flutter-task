import 'dart:async';
import 'dart:convert';
import 'package:hendi_flutter_task/model/course_details_model.dart';
import 'package:http/http.dart' show Client;

class CourseApiProvider {
  Client client = Client();

  Future<CourseDetailsModel> fetchCourseDetails(int courseId) async {
    final response = await client
        .get("http://skillzycp.com/api/UserApi/getOneOccasion/$courseId/0");
   // print(response.body.toString());
    var responseSting = response.body.toString();
    var finalResponseString =
        responseSting.substring(1, responseSting.length - 1).replaceAll('\\"', '"');

          print("fianl response string is ");
          print(finalResponseString);

    if (response.statusCode == 200) {
      return CourseDetailsModel.fromJson(json.decode(finalResponseString));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
