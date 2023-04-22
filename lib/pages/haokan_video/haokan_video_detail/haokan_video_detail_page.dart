// import 'package:flutter/material.dart';
// import 'package:flutter_video_player/providers/vod_item_provider.dart';
// import 'package:provider/provider.dart';

// import 'haokan_video_detail_model.dart';
// import 'haokan_video_detail_vm.dart';

// class VideoDetailPage extends StatelessWidget {
//   const VideoDetailPage({super.key});

// // 5177033977559325844
//   @override
//   Widget build(BuildContext context) {
//     var model = context.watch<VodItemProvider>().vodModel;
//     print('1.build VideoDetailPage object ${model?.firstEpisodes}');

//     return FutureProvider<VodDetailModel?>(
//       initialData: null,
//       create: (context) {
//         print('2.build VideoDetailPage object ${model?.firstEpisodes}');
//         return VodDetailViewModel.requestData(
//             dramaId: model?.firstEpisodes ?? "");
//       },
//       catchError: (context, error) {
//         print(error);
//       },
//       child: Scaffold(
//         body: Consumer<VodDetailModel?>(
//           builder: (context, value, child) {
//             print('3.build VideoDetailPage object ${model?.firstEpisodes}');
//             return Center(
//               child: TextButton(
//                   child: Text('data ${value?.apiData?.curVideoMeta?.playurl}'),
//                   onPressed: () {
//                     VodDetailViewModel.requestData(
//                         dramaId: model?.firstEpisodes ?? "");
//                   }),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
