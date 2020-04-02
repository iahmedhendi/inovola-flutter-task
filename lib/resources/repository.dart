import 'dart:async';

import '../model/course_details_model.dart';

import 'course_api_provider.dart';

class Repository {
  final courseApiProvider = CourseApiProvider();

  Future<CourseDetailsModel> fetchCourseDetails(int courseId) =>
      courseApiProvider.fetchCourseDetails(courseId);

 
}
