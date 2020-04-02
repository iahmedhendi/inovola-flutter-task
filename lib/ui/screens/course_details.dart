import 'package:flutter/material.dart';
import 'package:hendi_flutter_task/constants/global.dart';
import 'package:hendi_flutter_task/model/course_details_model.dart';
import 'package:hendi_flutter_task/ui/widgets/carousel_with_indicator.dart';
import '../../bloc/course_details_bloc.dart';
import 'package:intl/intl.dart' show DateFormat, intl;

class CourseDetailsScreen extends StatefulWidget {
  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    courseDetailsBloc.fetchCourseDetails(389);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBody(context),
          Positioned(
            child: _buildReservButton(context),
            bottom: 0,
            right: 0,
            left: 0,
          ),
          Positioned(
            //Place it at the top, and not use the entire screen
            top: 40.0,
            left: 0.0,
            right: 0.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.star,
                        color: Colors.white, // Here
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.share,
                        color: Colors.white, // Here
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white, // Here
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: courseDetailsBloc.courseDetail,
          builder: (context, AsyncSnapshot<CourseDetailsModel> snapshot) {
            if (snapshot.hasData) {
              return buildContent(snapshot, context);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }

            return Container(
                height: MediaQuery.of(context).size.height,
                child: Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }

  Widget buildContent(
      AsyncSnapshot<CourseDetailsModel> snapshot, BuildContext context) {
    return Container(
      child: Container(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                _buildHeader(context, snapshot.data.imgsOnlyHttp),
                Padding(
                  padding: EdgeInsets.only(top: 0),
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _buildBasicCourseData(
                          context,
                          snapshot.data.title,
                          snapshot.data.date,
                          snapshot.data.address,
                          snapshot.data.interest),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                            height: 1, color: AppColors.primary.withAlpha(80)),
                      ),
                      _buildTrainer(
                          context,
                          snapshot.data.trainerName,
                          snapshot.data.trainerImgOnlyHtpp,
                          snapshot.data.trainerInfo),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                            height: 1, color: AppColors.primary.withAlpha(80)),
                      ),
                      _buildAboutCourse(context, snapshot.data.occasionDetail),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Container(
                            height: 1, color: AppColors.primary.withAlpha(80)),
                      ),
                      _buildCostOfCourse(context, snapshot.data.reservTypes),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildHeader(BuildContext context, List<String> imgList) {
    return Container(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var width = constraints.biggest.width;
        return Stack(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: CarouselWithIndicator(imgList),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  _buildBasicCourseData(BuildContext context, String title, DateTime dateTime,
      String address, String interest) {
    return Container(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var width = constraints.biggest.width;
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
          child: Container(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      interest.trim(),
                      style: Theme.of(context).textTheme.bodyText1,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline1,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      DateFormat('EEEE, d MMM, yyyy h:mm a').format(dateTime),
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'assets/images/ic_date.png',
                      width: 20,
                      height: 20,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      address,
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'assets/images/ic_pin.png',
                      width: 20,
                      height: 20,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  _buildTrainer(
    BuildContext context,
    String trainerName,
    String trainerImage,
    String trainerInfo,
  ) {
    return Container(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var width = constraints.biggest.width;
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    trainerName,
                    style: Theme.of(context).textTheme.headline2,
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 23.0,
                    backgroundImage: NetworkImage(trainerImage),
                    backgroundColor: Colors.transparent,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      trainerInfo,
                      style: Theme.of(context).textTheme.bodyText1,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  _buildAboutCourse(
    BuildContext context,
    String courseInfo,
  ) {
    return Container(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var width = constraints.biggest.width;
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "عن الدورة",
                    style: Theme.of(context).textTheme.headline2,
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      courseInfo,
                      style: Theme.of(context).textTheme.bodyText1,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  _buildCostOfCourse(
    BuildContext context,
    List<ReservType> reservTypes,
  ) {
    return Container(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var width = constraints.biggest.width;
        return Padding(
          padding: const EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: reservTypes.map((reserveType) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "${reserveType.price} SAR",
                      style: Theme.of(context).textTheme.headline2,
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      "${reserveType.name}",
                      style: Theme.of(context).textTheme.headline2,
                      textDirection: TextDirection.rtl,
                    )
                  ],
                );
              }).toList()),
        );
      }),
    );
  }

  _buildReservButton(
    BuildContext context,
  ) {
    return Container(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return ButtonTheme(
          minWidth: double.infinity,
          height: 50,
          child: MaterialButton(
            color: AppColors.buttonColor,
            onPressed: () {},
            child: Text(
              "قم بالحجز الآن",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: FontFamily.mainFont,
                color: Colors.white,
                height: 1,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
        );
      }),
    );
  }
}
