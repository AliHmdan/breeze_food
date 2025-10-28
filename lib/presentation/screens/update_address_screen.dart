import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/data/repositories/address_repository.dart';
import 'package:freeza_food/presentation/screens/home/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateAddressScreen extends StatefulWidget {
  const UpdateAddressScreen({super.key});

  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  final AddressRepository _repo = AddressRepository();
  String _status = 'Updating your location...';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _start());
  }

  Future<void> _start() async {
    print("UpdateAddressScreen started");
    // Arguments can be passed when navigating to this route: { 'latitude': 12.3, 'longitude': 45.6 }
    final args = ModalRoute.of(context)?.settings.arguments;
    double? lat;
    double? lng;
    if (args is Map) {
      lat = (args['latitude'] is num)
          ? (args['latitude'] as num).toDouble()
          : null;
      lng = (args['longitude'] is num)
          ? (args['longitude'] as num).toDouble()
          : null;
    }

    if (lat == null || lng == null) {
      // No coordinates provided — skip update and open Home
      // _navigateToHome();
      return;
    }

    try {
      setState(() => _status = 'Updating your address...');
      final msg = await _repo.updateAddress(latitude: lat, longitude: lng);
      setState(() => _status = msg);
    } catch (e) {
      setState(() => _status = 'Failed to update address');
    }
    log('Address update process completed $lng');
    // Proceed to Home regardless of success to avoid blocking the user
    await Future.delayed(const Duration(seconds: 300));

    // _navigateToHome();
  }

  void _navigateToHome() {
    // Replace this route with the real Home widget
    // Navigator.of(
    //   context,
    // ).pushReplacement(MaterialPageRoute(builder: (_) => const Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.Dark,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on, size: 84.w, color: AppColor.primaryColor),
              const SizedBox(height: 16),
              CircularProgressIndicator(color: AppColor.primaryColor),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  _status,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
