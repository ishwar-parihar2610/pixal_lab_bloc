import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixal_lab_bloc/features/bloc/pixal_bloc.dart';
import 'package:pixal_lab_bloc/features/bloc/pixal_event.dart';
import 'package:pixal_lab_bloc/features/bloc/pixal_state.dart';
import 'package:pixal_lab_bloc/features/model/pixal_api_model.dart';

class DisplayImages extends StatefulWidget {
  const DisplayImages({super.key});

  @override
  State<DisplayImages> createState() => _DisplayImagesState();
}

class _DisplayImagesState extends State<DisplayImages> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    context.read<PixalBloc>().add(GetAllImageEvent());

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        PixelState initialState = context.read<PixalBloc>().state;
        print("next url is >> ${initialState.nextUrl}");
        context
            .read<PixalBloc>()
            .add(GetAllImageEvent(url: initialState.nextUrl));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pixal Lab"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<PixalBloc, PixelState>(
                builder: (context, state) {
                  return state.imgList.isNotEmpty
                      ? _imageView(state.imgList)
                      : state.loading
                          ? const Center(
                              child: CircularProgressIndicator.adaptive(),
                            )
                          : Center(
                              child: Text(state.error),
                            );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _imageView(List<Photos> photo) {
    print("image length ${photo.length}");
    return GridView.builder(
      controller: _scrollController,
      itemCount: photo.length,
      // cacheExtent: 999999,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
      itemBuilder: (context, index) {
        return SizedBox(
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              // memCacheHeight: 100,
              // memCacheWidth: 100,
              memCacheHeight: 400,
              imageUrl: photo[index].src?.original ?? "",
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
