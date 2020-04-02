import '../bloc/base.dart';
import '../model/course_details_model.dart';
import 'package:rxdart/rxdart.dart';


class CourseDetailsBloc extends BaseBloc<CourseDetailsModel> {

  Observable<CourseDetailsModel> get courseDetail => fetcher.stream;

  fetchCourseDetails(int courseId) async {
    CourseDetailsModel itemModel = await repository.fetchCourseDetails(courseId);
    fetcher.sink.add(itemModel);
  }
}

final courseDetailsBloc = CourseDetailsBloc();