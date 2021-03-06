import 'package:pex_flut/resource/resources.dart';
import 'package:pex_flut/src/model/image.dart';
import 'package:pex_flut/src/model/video.dart';
import '../bloc/media_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/media_list_bloc.dart';
import 'package:flutter/material.dart';

class BuildMediaWidget extends StatelessWidget {
  final Photo? photo;
  final Video? video;
  final int index;
  const BuildMediaWidget({
    Key? key,
    this.photo,
    this.video,
    required this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return (photo == null)
        ? _buildVideoWidget(context, video!, index)
        : _buildImageWidget(context, photo!, index);
  }
}

//*************************************************************
//
// Image Widget
//
//*************************************************************
Widget _buildImageWidget(BuildContext context, Photo photo, int index) {
  return Container(
    padding: EdgeInsets.only(top: 5, bottom: 20),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.pushNamed(context, 'mediaDetail/$photoCode/${photo.id}');
          },
          child: Container(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Image.network(photo.src.large, fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.only(left: 3.5, right: 3.5),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    photo.photographer,
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<MediaListBloc>(context).add(
                          LikeMediaEvent(
                              mediaTypeCode: photoCode,
                              mediaID: photo.id,
                              index: index));
                    },
                    icon: Icon(
                      photo.liked ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

//*************************************************************
//
// Video Widget
//
//*************************************************************
Widget _buildVideoWidget(BuildContext context, Video video, int index) {
  return Container(
    padding: EdgeInsets.only(top: 5, bottom: 20),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'mediaDetail/$videoCode/${video.id}');
          },
          child: Container(
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Image.network(
                  video.videoPictures[0].picture ??
                      'https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png',
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 150,
              icon: Icon(
                Icons.play_circle_filled,
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(
                    context, 'mediaDetail/$videoCode/${video.id}');
              },
            ),
            SizedBox(height: 70),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.only(left: 3.5, right: 3.5),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            height: 70,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    video.user.name,
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    icon: Icon(
                      video.liked ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      BlocProvider.of<MediaListBloc>(context).add(
                          LikeMediaEvent(
                              mediaTypeCode: videoCode,
                              mediaID: video.id,
                              index: index));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
