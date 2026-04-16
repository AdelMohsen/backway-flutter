import 'package:flutter/material.dart';
import 'package:greenhub/core/theme/colors/styles.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';
import 'package:greenhub/core/services/location/location_service.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:greenhub/features/home/ui/widgets/home_header_widget.dart';
import 'package:greenhub/features/home/ui/widgets/home_map_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocationService _locationService = LocationService();
  late String _locationName;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    _locationName = AppStrings.loading.tr;
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    final result = await _locationService.getCurrentLocation();
    if (result.success) {
      setState(() {
        _locationName = result.locationName ?? AppStrings.homeLocationAddress.tr;
        _latitude = result.latitude;
        _longitude = result.longitude;
      });
    } else {
      setState(() {
        _locationName = AppStrings.locationFailed.tr;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      backgroundColor: ColorsApp.KorangePrimary,
      needAppbar: false,
      needBottomGradient: false,
      child: CustomScrollView(
        physics: const ScrollPhysics(),
        slivers: [
          HomeHeaderWidget(locationName: _locationName),
          HomeMapWidget(
            latitude: _latitude,
            longitude: _longitude,
            onLocateMe: _fetchLocation,
          ),
        ],
      ),
    );
  }
}
