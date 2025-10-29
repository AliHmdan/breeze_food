// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:freeza_food/presentation/screens/auth/login.dart';

// class SplashVideoScreen extends StatefulWidget {
//   const SplashVideoScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashVideoScreen> createState() => _SplashVideoScreenState();
// }

// class _SplashVideoScreenState extends State<SplashVideoScreen> {
//   late VideoPlayerController _controller;
//   bool _didNavigate = false;

//   // الصوت
//   bool _isMuted = true; // ابدأ بوضع صامت
//   double _volumeBeforeMute = 1.0; // نتذكر مستوى الصوت السابق
//   StreamSubscription? _tickerSub;
//   Timer? _safetyTimer;

//   @override
//   void initState() {
//     super.initState();
//     _init();
//   }

//   Future<void> _init() async {
//     _controller = VideoPlayerController.asset('assets/video/splachscreen.mp4');

//     // ✅ نبدأ التشغيل فوراً تقريباً بعد إنشاء الـcontroller
//     _controller.setLooping(false);
//     _controller.setVolume(_isMuted ? 0.0 : 1.0);
//     _controller.initialize().then((_) {
//       if (!mounted) return;
//       setState(() {}); // إعادة بناء الواجهة بعد التحميل
//       _controller.play();
//     });

//     // ✅ لا تنتظر initialize — شغّل المؤقت مباشرة
//     _safetyTimer = Timer(const Duration(seconds: 8), _goNextSafely);

//     // ✅ ابدأ متابعة زمن الفيديو حتى النهاية
//     _tickerSub = Stream.periodic(const Duration(milliseconds: 200)).listen((_) {
//       if (!_controller.value.isInitialized) return;
//       final v = _controller.value;
//       if (v.position >= v.duration - const Duration(milliseconds: 200)) {
//         _goNextSafely();
//       }
//     });
//   }

//   Future<void> _applyVolume() async {
//     // إن كان مكتومًا → 0.0، غير ذلك → أعد المستوى السابق أو 1.0
//     final vol = _isMuted ? 0.0 : (_volumeBeforeMute.clamp(0.0, 1.0));
//     await _controller.setVolume(vol);
//   }

//   Future<void> _toggleMute() async {
//     // عند الكتم، خزّن المستوى الحالي (إن رغبت لاحقًا بدقة أعلى يمكن عمل منطق إضافي)
//     if (_isMuted) {
//       // إلغاء الكتم → أعد الصوت السابق
//       setState(() => _isMuted = false);
//       await _applyVolume();
//     } else {
//       // كتم → خزّن الصوت الحالي (إن كان 0 نرفع الافتراضي 1.0 عند الإعادة)
//       _volumeBeforeMute = _volumeBeforeMute == 0.0 ? 1.0 : _volumeBeforeMute;
//       setState(() => _isMuted = true);
//       await _applyVolume();
//     }
//   }

//   void _goNextSafely() {
//     if (_didNavigate || !mounted) return;
//     _didNavigate = true;

//     _tickerSub?.cancel();
//     _safetyTimer?.cancel();

//     Navigator.of(
//       context,
//     ).pushReplacement(MaterialPageRoute(builder: (_) =>  Login()));
//   }

//   @override
//   void dispose() {
//     _tickerSub?.cancel();
//     _safetyTimer?.cancel();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final initialized = _controller.value.isInitialized;

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // الفيديو
//           Center(
//             child: AspectRatio(
//               aspectRatio: _controller.value.isInitialized
//                   ? _controller.value.aspectRatio
//                   : 16 / 9,
//               child: VideoPlayer(_controller),
//             ),
//           ),

//           // زر كتم/تشغيل الصوت
//           if (initialized)
//             SafeArea(
//               child: Align(
//                 alignment: Alignment.bottomRight,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Material(
//                     color: Colors.black.withOpacity(0.35),
//                     shape: const CircleBorder(),
//                     clipBehavior: Clip.antiAlias,
//                     child: IconButton(
//                       tooltip: _isMuted ? 'تشغيل الصوت' : 'كتم الصوت',
//                       icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
//                       color: Colors.white,
//                       onPressed: _toggleMute,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
