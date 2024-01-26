// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class PixelImageEvent {}

class GetAllImageEvent extends PixelImageEvent {
  String url;

  GetAllImageEvent({
    this.url = "https://api.pexels.com/v1/curated?page=1&per_page=100",
  });
}
