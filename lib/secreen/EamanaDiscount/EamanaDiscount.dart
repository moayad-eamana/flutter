import 'package:eamanaapp/secreen/widgets/appbarW.dart';
import 'package:eamanaapp/utilities/ViewFile.dart';
import 'package:eamanaapp/utilities/globalcss.dart';
import 'package:eamanaapp/utilities/testbase64.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EamanaDiscount extends StatefulWidget {
  @override
  _EamanaDiscountState createState() => _EamanaDiscountState();
}

class _EamanaDiscountState extends State<EamanaDiscount> {
  var json = [
    {
      "Created": "3/15/2021 9:25:35 AM",
      "ID": "27",
      "Title": "مركزداركوف للتأهيل والعلاج الطبيعي ",
      "DiscountRate": "تجدون بالمرفق ",
      "Notes": "العرض ساري من تاريخ 15 فبراير 2021م حتى تاريخ 15 فبراير 2022م ",
      "WebsiteUrl": "https://saudidarkov.com/home2/",
      "ServiceCategories": "طبي",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "3/15/2021 10:07:18 AM",
      "ID": "28",
      "Title": "فندق ويندام جاردن الدمام ",
      "DiscountRate": "تجدون بالمرفق ",
      "Notes": "العرض ساري من تاريخ 01 فبراير 2021م حتى 31 ديسمبر 2021م",
      "WebsiteUrl": "https://wyndhamgardendammam.com/?lang=ar",
      "ServiceCategories": "الفنادق",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "3/15/2021 10:29:06 AM",
      "ID": "29",
      "Title": "فندق اسكوت كورنيش الخبر ",
      "DiscountRate": "تجدون بالمرفق ",
      "Notes": "العرض ساري من تاريخ 01 يناير 2021م  حتى تاريخ 31 ديسمبر 2021 م",
      "WebsiteUrl":
          "https://www.ascottmea.com/ar/hotels/ascott-corniche-al-khobar",
      "ServiceCategories": "الفنادق",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "3/15/2021 10:35:32 AM",
      "ID": "30",
      "Title": "شوكلت ديزاين ",
      "DiscountRate": "20%",
      "Notes": "العرض ساري لعام 2021م ",
      "WebsiteUrl": "http://ww1.chocolate-design.net/contact-us/",
      "ServiceCategories": "محلات",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "3/15/2021 10:42:11 AM",
      "ID": "31",
      "Title": "مجمع عيادات اكاديمية د . امجد الحقيل ",
      "DiscountRate": "تجدون بالمرفق ",
      "Notes": "العرض ساري من تاريخ 26/01/2021م حتى تاريخ 31/12/2021م",
      "WebsiteUrl": "https://tajmeeli.com/clinic/مجمع-عيادات-الحقيل/",
      "ServiceCategories": "عيادات",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "3/16/2021 8:32:35 AM",
      "ID": "32",
      "Title": "شركة ولاء للتأمين التعاوني",
      "DiscountRate": "10% للتأمين الشامل / 15% للتأمين ضد الغير ",
      "Notes": {"-self-closing": "true"},
      "WebsiteUrl": "https://www.walaa.com/",
      "ServiceCategories": "شركات التامين",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "3/16/2021 8:38:16 AM",
      "ID": "33",
      "Title": "المستشفى السعودي الألماني الدمام ",
      "DiscountRate": "تجدون بالمرفق ",
      "Notes": {"-self-closing": "true"},
      "WebsiteUrl": "https://www.saudigermanhealth.com/ar",
      "ServiceCategories": "مستشفيات",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "4/14/2021 10:41:42 AM",
      "ID": "34",
      "Title": "شركة فندق كمبينسكي العثمان المحدودة ",
      "DiscountRate": "تجدون بالمرفق ",
      "Notes":
          "العرض ساري ابتداء من تاريخ 11 ابريل2021  الى 31 ابريل ديسمبر 2021",
      "WebsiteUrl": "https://www.kempinski.com/ar/hotels/privacy-policy/",
      "ServiceCategories": "الفنادق",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "4/22/2021 11:00:18 AM",
      "ID": "35",
      "Title": "مؤسسة أغصان البتيلة التجارية ",
      "DiscountRate": "25% للتمور والحلويات  -   20% الشوكلاته البلجيكي ",
      "Notes": "العرض ساري من تاريخ 2021/4/11م ولمدة عام ميلادي من تاريخه. ",
      "WebsiteUrl": "https://albatilh.com/",
      "ServiceCategories": "محلات",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "5/19/2021 7:39:59 AM",
      "ID": "36",
      "Title": "شركة لجام للرياضة \" مراكز وقت اللياقة\"",
      "DiscountRate": "تجدونه بالمرفق ",
      "Notes": "العرض ساري حتى تاريخ  2021/12/31م ",
      "WebsiteUrl": "https://www.fitnesstime.com.sa/ar-sa",
      "ServiceCategories": "الاندية الرياضية",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "6/3/2021 10:45:45 AM",
      "ID": "37",
      "Title": "المجدوعي للسيارات - شركة بيجو ",
      "DiscountRate": "تجدونه بالمرفق ",
      "Notes":
          "العرض ساري اعتبارا من تاريخ 26 مايو 2021م وحتى 31 ديسمبر 2021م ",
      "WebsiteUrl": "https://peugeotksa.com/",
      "ServiceCategories": "وكالة سيارات",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "6/3/2021 10:54:49 AM",
      "ID": "38",
      "Title": "المجدوعي للسيارات - شركة شانجان ",
      "DiscountRate": "تجدونه بالمرفق ",
      "Notes":
          "العرض ساري اعتبارا من تاريخ  26/05/2021م وحتى تاريخ 25/05/2022م ",
      "WebsiteUrl":
          "https://www.google.com/aclk?sa=L&ai=DChcSEwiO6KzwpfvwAhWB4uYKHRNVB5EYABAAGgJ3cw&ae=2&sig=AOD64_0ujOwvpgDYb3SlXMqVXI_VJvIhEw&q&adurl&ved=2ahUKEwiVzKXwpfvwAhUJJBoKHfm8DbEQ0Qx6BAgDEAE",
      "ServiceCategories": "وكالة سيارات",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "6/3/2021 11:05:04 AM",
      "ID": "39",
      "Title": "الموارد للقوى البشرية ",
      "DiscountRate": "تجدونه بالمرفق ",
      "Notes":
          "للاستفادة من الخصم لخدمات تأجير العمالة الشهري إبراز بطاقة العمل \nأما بالنسبة لتأجير العمالة اليومي عن طريق التطبيق ( همة) باستخدام الكود ( EAMN) \nللاستفسار:قنوات التواصل في المنطقة الشرقية:\nفرع الجبيل / 0559341310\nفرع الخبر/ 0501101220- 0552229189 ",
      "WebsiteUrl": "https://www.mawarid.com.sa/Pages/default.aspx",
      "ServiceCategories": "أخري",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "6/20/2021 11:05:45 AM",
      "ID": "40",
      "Title": "سكة الطيب ",
      "DiscountRate": "20% - 35% ",
      "Notes": {"-self-closing": "true"},
      "WebsiteUrl": "https://sokkat-alteeb.com/discount/EAMANA",
      "ServiceCategories": "محلات",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "6/23/2021 9:18:28 AM",
      "ID": "41",
      "Title": "مجمع سمو الطبي ",
      "DiscountRate": "تجدونه بالمرفق ",
      "Notes":
          "العرض ساري لمدة سنة من تاريخ 12/06/2021م \n\n \nتجدون بالمرفق عرض أسعار جميع الخدمات المتوفرة لدى مجمع سمو الطبي ",
      "WebsiteUrl": "http://sumuomedical.com/",
      "ServiceCategories": "طبي",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "7/26/2021 7:21:42 AM",
      "ID": "42",
      "Title": "مركز اعلى طبقة النسائي",
      "DiscountRate": "15%",
      "Notes":
          "تتشرف ادارة مركز توب كوت النسائي بتقديم خصم خاص (15%) لمنسوبي امانة المنطقة الشرقية",
      "WebsiteUrl": "https://www.instagram.com/topcoatnail/",
      "ServiceCategories": "صالون",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "7/26/2021 7:31:03 AM",
      "ID": "43",
      "Title": "بارفيوم لاونج",
      "DiscountRate": "20%",
      "Notes":
          "تتشرف ادارة بارفيوم لاونج بتقديم عرض لمنسوبي امانة المنطقة الشرقية بنسبة (20%)\nللتواصل: 00966599419333",
      "WebsiteUrl":
          "https://instagram.com/perfumeloungesa?utm_medium=copy_link",
      "ServiceCategories": "محلات",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "7/26/2021 7:40:10 AM",
      "ID": "44",
      "Title": "مؤوسسة حذاء الشرق",
      "DiscountRate": "10%",
      "Notes":
          "تتشرف مؤوسسة حذاء الشرق المتخصصون في مجال وتفصيل الاحذية الشرقية تقديم عرض خاص لمنسوبي امانة المنطقة الشرقية 10%",
      "WebsiteUrl": "https://hethaalsharq.com/",
      "ServiceCategories": "محلات",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "7/26/2021 7:51:10 AM",
      "ID": "45",
      "Title": "الملحم للاقمشة الرجالية",
      "DiscountRate": "10%",
      "Notes":
          "تتقدم الملحم للاقمشة الرجالية ان تقدم خصم لمنسوبي امانة المنطقة الشرقية 10%",
      "WebsiteUrl": "https://almulhimfab.com/",
      "ServiceCategories": "محلات",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "7/28/2021 8:37:22 AM",
      "ID": "46",
      "Title": "فندق ومركز مؤتمرات شيراتون الدمام ",
      "DiscountRate": "تجدونه بالمرفق ",
      "Notes": {"-self-closing": "true"},
      "WebsiteUrl": "https://g.page/SheratonDammam?share",
      "ServiceCategories": "الفنادق",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "7/29/2021 8:45:16 AM",
      "ID": "47",
      "Title": "مقهى ومحمصة شرق ",
      "DiscountRate": "20%",
      "Notes":
          "خصم خاص لمنسوبي ومنسوبات أمانة النطقة الشرقية على النحو التالي:\n1- المشروبات الساخنة والباردة 20%\n2- ادوات تحضير القهوة 15% على الموقع وباستخدام الكود (emana)\n3- محاصيل القهوة15% من خلال الموقع وباستخدام الكود (emana)",
      "WebsiteUrl":
          "https://www.alsharqiacafes.com/2020/%D9%85%D9%82%D9%87%D9%8A-%D9%88%D9%85%D8%AD%D9%85%D8%B5%D9%87-%D8%B4%D8%B1%D9%82/",
      "ServiceCategories": "محلات",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "7/29/2021 8:58:39 AM",
      "ID": "48",
      "Title": "منتجع شاطئ الدانة",
      "DiscountRate": "تجدونة بالمرفق",
      "Notes":
          "نسبة الخصم الخاص لمنسوبي امانة المنطقة الشرقية \n1- 20% خصم على اسعار الإقامة بالفلل خلال ايام الاسبوع \n2- 15% خصم على اسعار الإقامة بالفلل خلال ايام عطلة نهاية الأسبوع \n3- 10% خصم على الأغذية والمشروبات في حالة حجز فيلا ",
      "WebsiteUrl": "https://www.dbr.sa/",
      "ServiceCategories": "الفنادق",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "8/1/2021 6:44:11 AM",
      "ID": "49",
      "Title": "شركة هاير والجبر السعودية الالكترونية للتجارة ",
      "DiscountRate": "30%",
      "Notes":
          "خصم 30% على سعر المنتج الأصلي أو 10% على سعر عروض التخفيضات الحالية فقط في معرض هاير الخبر ",
      "WebsiteUrl":
          "https://www.haier.com/sa-ar/service-support/warranty-declaration/",
      "ServiceCategories": "محلات",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "8/4/2021 7:40:47 AM",
      "ID": "50",
      "Title": "فندق كارلتون المعيبد ",
      "DiscountRate": "خصم 20% لحجوزات غرف الفندق ",
      "Notes":
          "*خصم يصل الى 15% لمطاعم الفندق ( مطعم حبق ومطعك لاكوميدا)\n*هدية قسيمة مشتريات لقاعة السمر لحفلات الزواج بمبلغ 5000ريال \n*خصم يصل اللى 10% للطلبات الخارجية ",
      "WebsiteUrl":
          "https://www.google.com/aclk?sa=L&ai=DChcSEwiLsvOsgJfyAhXY2tUKHeLOBJ8YABAAGgJ3cw&ae=2&sig=AOD64_1u7FkRVx-PVlLx2PDf330OPJE6OQ&q&adurl&ved=2ahUKEwjqruysgJfyAhUOkRQKHW1aAgQQ0Qx6BAgDEAE",
      "ServiceCategories": "الفنادق",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "8/18/2021 6:37:31 AM",
      "ID": "51",
      "Title": "شركة الجبر التجارية",
      "DiscountRate": "تجدون بالمرفق",
      "Notes":
          "خصم 7% من السعر الرسمي المعلن في حالة الشراء النقدي\nخصم 3% من السعر الرسمي في حالة الشراء بالتأجير التمويلي من خلال اي تجربة تمويلية\nخصم 15% على خدمات الصيانة وقطع الغيار من خلال مركز خدمة كيا الجبر\nخصم  30%  على اسعار التاجير اليومي من خلال شركة الجبر للتاجير السيارات",
      "WebsiteUrl": "https://www.jrac.com.sa/ar",
      "ServiceCategories": "تاجير السيارات",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "8/18/2021 6:46:45 AM",
      "ID": "52",
      "Title": "منتجع موفنبيك شاطئ الخبر",
      "DiscountRate": "تجدون بالمرفق",
      "Notes":
          "خصم 20% على الفلل السكنية\nخصم 20%  على النادي الصحي والسبأ\nخصم 15%  للاغذية والمشروبات في مطعم ازور\n",
      "WebsiteUrl":
          "https://www.movenpick.com/ar/middle-east/saudi-arabia/al-khobar/resort-al-khobar-beach/overview/",
      "ServiceCategories": "الترفيه",
      "AttachementIsPresent": "true"
    },
    {
      "Created": "8/31/2021 7:42:31 AM",
      "ID": "53",
      "Title": "مؤوسسة الهدية المميزة للورد والكوش للهدايا",
      "DiscountRate": "20%",
      "Notes": {"-self-closing": "true"},
      "WebsiteUrl": "https://instagram.com/special1.gift?utm_medium=copy_link",
      "ServiceCategories": "محلات",
      "AttachementIsPresent": "true"
    }
  ];
  //swss
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBarW.appBarW("عروض الموظفين", context, null),
          body: Stack(
            children: [
              Image.asset(
                imageBG,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      for (int i = 0; i <= 10; i++)
                        Container(
                          height: 100,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          decoration: containerdecoration(BackGWhiteColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 100.w <= 375 ? 100 : 120,
                                        child: Stack(
                                          fit: StackFit.loose,
                                          overflow: Overflow.visible,
                                          clipBehavior: Clip.hardEdge,
                                          children: [
                                            Container(
                                              height: 45,
                                              decoration: containerdecoration(
                                                  baseColor),
                                              child: Row(
                                                //  crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    "70%",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "خصم",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: -9,
                                              left: 0.2,
                                              child: Container(
                                                height: 25,
                                                width: 60,
                                                decoration: containerdecoration(
                                                    secondryColor),
                                                child: Center(
                                                    child: Text(
                                                  "ترفيهي",
                                                  style: descTx1(Colors.white),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "العرض ساري حتى تاريخ  2020/02/12",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: secondryColorText),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10, top: 3),
                                    child: Text(
                                      "شركة مؤيد العوفي",
                                      style: subtitleTx(baseColorText),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    color: secondryColor,
                                    icon: Icon(
                                      Icons.download,
                                      size: 30,
                                    ),
                                    onPressed: () async {
                                      await ViewFile.open(testbase64Pfd, "pdf");
                                    },
                                  ),
                                  Text(
                                    "إستعراض",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: secondryColorText,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
