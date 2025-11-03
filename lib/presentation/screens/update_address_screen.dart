import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freeza_food/core/constans/color.dart';
import 'package:freeza_food/data/repositories/address_repository.dart';
import 'package:freeza_food/presentation/widgets/main_shell.dart';
import 'package:geolocator/geolocator.dart';

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

    try {
      // تحقق من تشغيل خدمة الموقع
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _status = 'Location services are disabled');
        print('Location services disabled');
        return;
      }

      // تحقق من الإذن
      LocationPermission permission = await Geolocator.checkPermission();
      print('Initial permission: $permission');

      if (permission == LocationPermission.denied) {
        print('Requesting permission...');
        permission = await Geolocator.requestPermission();
        print('After request: $permission');
      }

      if (permission == LocationPermission.deniedForever) {
        print('Permission permanently denied');
        setState(() => _status = 'Permission permanently denied');
        return;
      }

      if (permission == LocationPermission.denied) {
        print('User denied permission');
        setState(() => _status = 'Permission denied');
        return;
      }

      // إذا وصلنا هنا فالإذن متاح
      setState(() => _status = 'Getting your location...');
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print('Current location: lat=${pos.latitude}, lng=${pos.longitude}');

      setState(() => _status = 'Updating your address...');
      final msg = await _repo.updateAddress(
        latitude: pos.latitude,
        longitude: pos.longitude,
      );
      print('Server response: $msg');
      setState(() => _status = msg);
    } catch (e, st) {
      print('Error in _start: $e\n$st');
      setState(() => _status = 'Failed to update address');
    }

    await Future.delayed(const Duration(seconds: 2));
    _navigateToHome();
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const MainShell(initialIndex: 0)),
    );
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
