import 'package:bloc/bloc.dart';
import 'package:pixal_lab_bloc/features/bloc/pixal_event.dart';
import 'package:pixal_lab_bloc/features/bloc/pixal_state.dart';
import 'package:pixal_lab_bloc/features/model/pixal_api_model.dart';
import 'package:pixal_lab_bloc/features/network/api_request.dart';

class PixalBloc extends Bloc<PixelImageEvent, PixelState> {
  ApiRequest apiRequest = ApiRequest();
  PixalBloc() : super(PixelState()) {
    on<GetAllImageEvent>(_getAllImages);
  }

  Future<void> _getAllImages(
      GetAllImageEvent event, Emitter<PixelState> emit) async {
    emit(state.copyWith(loading: true));
    PixalLabApiModel? pixalLabApiModel =
        await apiRequest.getAllImages(event.url);
    List<Photos> imagesList = pixalLabApiModel?.photos ?? [];

    emit(state.copyWith(
        loading: false,
        nextUrl: pixalLabApiModel?.nextPage ?? "",
        error: imagesList.isNotEmpty ? "" : "Something went wrong",
        imgList: [...state.imgList, ...imagesList]));
  }
}
