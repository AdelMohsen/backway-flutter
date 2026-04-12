import 'package:equatable/equatable.dart';

class OffersParams extends Equatable {
  final String? lang;
  final String section;
  final String app;

  const OffersParams({
    this.lang,
    this.section = 'banners',
    this.app = 'customer',
  });

  Map<String, dynamic> returnedMap() {
    final map = <String, dynamic>{
      if (lang != null) 'lang': lang,
      'section': section,
      'app': app,
    };
    return map;
  }

  @override
  List<Object?> get props => [lang, section, app];
}
