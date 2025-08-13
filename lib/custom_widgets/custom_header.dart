import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zoodtime_admin/utils/helpers/global.dart';
import '../services/storage.dart';
import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import '../utils/app_strings.dart';
import '../utils/app_styles.dart';
import '../utils/helpers/configs.dart';

class CustomHeader extends StatefulWidget {
  String title;
  CustomHeader({super.key,required this.title});

  @override
  State<CustomHeader> createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {

  Future<void> _loadProfile() async {
    final dynamic data = await Storage.getLogin();
    if (data != null && data is Map) {
      userSD = data;
      print("userSD================$userSD");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.title,
          style: AppStyles.blackTextStyle()
              .copyWith(
            fontSize: 30.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Spacer(),
        Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
              border: Border.all(
                  color: kBorderColor,
                  width: 0.6
              )
          ),
          child: Center(child: SvgPicture.asset(kNotiIcon,height: 15,width: 15,)),
        ),
        SizedBox(width: 12.w,),
        SizedBox(
          height: 50,
          width: 50,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: userSD?['profileImageUrl'] ?? '',
                cacheManager: Configs.customCacheManager,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(child: CircularProgressIndicator(color: kPrimaryColor)),
                errorWidget: (context, url, error) {
                  debugPrint("Image load error: $error");
                  return Image.asset(kPersonImage,fit: BoxFit.cover,);
                },
              ),),
        )
      ],
    );
  }
}
