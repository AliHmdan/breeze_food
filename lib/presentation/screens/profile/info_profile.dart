import 'package:breezefood/blocs/auth/info/info_cubit.dart';
import 'package:breezefood/blocs/auth/info/info_state.dart';
import 'package:breezefood/core/constans/color.dart';
import 'package:breezefood/data/model/profile/user_profile.dart';
import 'package:breezefood/presentation/widgets/button/custom_button.dart';
import 'package:breezefood/presentation/widgets/profile/custom_textfaild_info.dart';
import 'package:breezefood/presentation/widgets/title/custom_appbar_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../blocs/profile/profile_cubit.dart';
import '../../../blocs/profile/profile_state.dart';
import '../../../data/repositories/profile_repository.dart';

// استورد AuthCubit العالمي
import 'package:breezefood/blocs/auth/auth_cubit.dart';

// ✅ NEW: استيراد InfoCubit + InfoState


// TODO: استبدلها بتخزين التوكن الحقيقي لديك
Future<String> _readToken() async => 'PASTE_YOUR_TOKEN_HERE';

class InfoProfile extends StatefulWidget {
  const InfoProfile({super.key});

  @override
  State<InfoProfile> createState() => _InfoProfileState();
}

class _InfoProfileState extends State<InfoProfile> {
  final Map<String, String> avatarMap = const {
    'a1': 'assets/avatars/a1.png',
    'a2': 'assets/avatars/a2.png',
  };

  String? _selectedAvatarCode; // a1, a2, ...
  final _firstCtrl = TextEditingController();
  final _lastCtrl  = TextEditingController();
  final _phoneCtrl = TextEditingController();
  UserProfile? _current;

  late final ProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ProfileCubit(ProfileRepository());

    // (اختياري): تحميل عبر InfoCubit لو موجود أعلى الشجرة
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await _readToken();
      _cubit.loadProfile(token);

      // ✅ NEW: جرّب تحميل InfoCubit إن كان موفراً في السياق
      final infoCubit = context.read<InfoCubit?>();
      if (infoCubit != null) {
        infoCubit.load(); // سيطلق InfoLoaded لاحقًا ونلتقطه بالـ Listener أدناه
      }
    });
  }

  @override
  void dispose() {
    _firstCtrl.dispose();
    _lastCtrl.dispose();
    _phoneCtrl.dispose();
    _cubit.close();
    super.dispose();
  }

  ImageProvider _avatarImageProvider() {
    final code = _selectedAvatarCode ?? _current?.avatar;
    if (code != null && avatarMap.containsKey(code)) {
      return AssetImage(avatarMap[code]!);
    }
    return const AssetImage('assets/images/person.jpg');
  }

  void _showAvatarPicker() {
    final codes = avatarMap.keys.toList();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColor.Dark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Expanded(
                child: Text(
                  'اختر صورة Avatar',
                  style: TextStyle(
                    color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ]),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: codes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemBuilder: (_, i) {
                final code = codes[i];
                final selected = (_selectedAvatarCode ?? _current?.avatar) == code;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedAvatarCode = code);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected ? AppColor.LightActive : Colors.white24,
                        width: selected ? 3 : 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: CircleAvatar(backgroundImage: AssetImage(avatarMap[code]!)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: MultiBlocListener(
        listeners: [
          // ✅ NEW: التفاعل مع InfoCubit -> InfoLoaded
          BlocListener<InfoCubit, InfoState>(
            listenWhen: (prev, curr) => curr is InfoLoaded,
            listener: (context, state) {
              final s = state as InfoLoaded;
              // حدّث الحقول من InfoLoaded (first_name/last_name/email/birthday…)
              _firstCtrl.text = s.firstName ?? _firstCtrl.text;
              _lastCtrl.text  = s.lastName  ?? _lastCtrl.text;
              // لو عندك phone ضمن /me أضفه في InfoState وحدث هنا
              // _phoneCtrl.text = s.phone ?? _phoneCtrl.text;

              // إن أردت ضبط الأفاتار لو كان يأتي من /me (أضفه في InfoState أولاً):
              // if (s.avatar != null) setState(() => _selectedAvatarCode = s.avatar);
            },
          ),

          // عند حفظ البروفايل بنجاح، حدّث AuthCubit
          BlocListener<ProfileCubit, ProfileState>(
            listenWhen: (prev, curr) => curr is ProfileSaved,
            listener: (context, state) {
              if (state is ProfileSaved) {
                context.read<AuthCubit>().setUser(state.profile);
              }
            },
          ),
        ],
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileLoaded) {
              _current = state.profile;
              _firstCtrl.text = state.profile.firstName ?? _firstCtrl.text;
              _lastCtrl.text  = state.profile.lastName  ?? _lastCtrl.text;
              _phoneCtrl.text = state.profile.phone     ?? _phoneCtrl.text;
              // لو للبروفايل أفاتار مخزن ككود
              if (state.profile.avatar != null) {
                _selectedAvatarCode ??= state.profile.avatar;
              }
            } else if (state is ProfileSaved) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('تم الحفظ')));
            } else if (state is ProfileError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final busy = state is ProfileLoading || state is ProfileSaving;

            return Scaffold(
              backgroundColor: AppColor.Dark,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(60.h),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomAppbarProfile(
                    title: "Profile",
                    icon: Icons.arrow_back_ios,
                    ontap: () => Navigator.pop(context),
                  ),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 70.r,
                            backgroundImage: _avatarImageProvider(),
                          ),
                          GestureDetector(
                            onTap: _showAvatarPicker,
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color: AppColor.Dark,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColor.LightActive,
                                  width: 1.w,
                                ),
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/edit.svg",
                                width: 18.w, height: 18.h,
                                colorFilter: const ColorFilter.mode(
                                  AppColor.white, BlendMode.srcIn),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 35.h),

                      CustomTextfaildInfo(
                        label: "First Name",
                        hint: "First Name",
                        controller: _firstCtrl,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 15.h),
                      CustomTextfaildInfo(
                        label: "Last Name",
                        hint: "Last Name",
                        controller: _lastCtrl,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 15.h),
                      CustomTextfaildInfo(
                        label: "Phone Number",
                        hint: "0938204147",
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 30.h),

                      CustomButton(
                        title: busy ? "Saving..." : "Save",
                        onPressed: busy
                            ? null
                            : () async {
                                final token = await _readToken();
                                context.read<ProfileCubit>().saveProfile(
                                  token: token,
                                  firstName: _firstCtrl.text.trim(),
                                  lastName : _lastCtrl.text.trim(),
                                  phone    : _phoneCtrl.text.trim(),
                                  avatarCode: _selectedAvatarCode ?? _current?.avatar,
                                  base: _current,
                                );
                              },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
