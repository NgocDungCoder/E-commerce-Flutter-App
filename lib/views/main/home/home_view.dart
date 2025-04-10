import 'package:ecomercy_app_flutter/configs/styles/themes/themes.dart';
import 'package:ecomercy_app_flutter/widgets/footer/footer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../../routes/route.dart';
import '../../../utils/social_icon.dart';
import '../../../widgets/Text/primary_text.dart';
import '../../../widgets/video/video_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // AppBar
        SliverAppBar(
          pinned: false,
          backgroundColor: Colors.black,
          title: Text('OPEN FASHION',
              style: TextStyle(color: ThemeConfigs.whiteText)),
          centerTitle: true,
        ),

        // Banner
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/main1.png",
                    fit: BoxFit.cover,
                  ),
                ),
                // Lớp phủ mờ cho dễ đọc chữ (nếu muốn)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),

                // Text nằm giữa ảnh
                Positioned(
                  bottom: 40,
                  left: 20,
                  right: 0,
                  child:
                      Text('Luxury \n   Fashion \n& Accessories'.toUpperCase(),
                          style: GoogleFonts.playfairDisplay(
                            color: ThemeConfigs.whiteText,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          )),
                ),
              ],
            ),
          ),
        ),

        const SliverPadding(
          padding: EdgeInsets.only(top: 45),
        ),
        // Title
        SliverToBoxAdapter(
          child: Center(
            child: PrimaryText(
              'NEW ARRIVAL',
              letterSpacing: 5,
              fontSize: 22,
            ),
          ),
        ),

        // Row Text
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 220, // full width
                height: 0.5, // độ dày line
                color: Theme.of(context).colorScheme.onSurface, // màu line
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              PrimaryText('Tất cả'),
              PrimaryText('Váy'),
              PrimaryText('Áo thun'),
              PrimaryText('Túi xách'),
              PrimaryText('Giày'),
            ],
          ),
        ),

        // Grid 2 column
        SliverPadding(
          padding: EdgeInsets.all(15),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.5,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/product10.png",
                      fit: BoxFit.cover,
                    ),
                    PrimaryText("Tên sản phẩm ", maxLines: 2),
                    PrimaryText(
                      "Giá tiền",
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              childCount: 4,
            ),
          ),
        ),

        // Explore more
        SliverToBoxAdapter(
          child: GestureDetector(
            onTap: () {
              Get.toNamed(Routes.products.p);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PrimaryText('Explore more ', fontSize: 22),
                Icon(Icons.arrow_forward_outlined),
              ],
            ),
          ),
        ),

        const SliverPadding(
          padding: EdgeInsets.only(top: 25),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 190, // full width
                height: 0.5, // độ dày line
                color: Theme.of(context).colorScheme.onSurface, // màu line
              ),
            ),
          ),
        ),

        // Grid 3 column
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.5,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                color: Colors.white,
                child: Image.asset(
                  "assets/logo/chanel.png",
                  fit: BoxFit.contain,
                ),
              ),
              childCount: 6,
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 190, // full width
                height: 0.5, // độ dày line
                color: Theme.of(context).colorScheme.onSurface, // màu line
              ),
            ),
          ),
        ),

        // Collection
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
                child: PrimaryText(
              'BỘ SƯU TẬP',
              fontSize: 22,
              letterSpacing: 5,
            )),
          ),
        ),

        // Banner cuối
        SliverToBoxAdapter(
          child: Container(
            height: 250,
            color: Colors.green,
            child: Image.asset(
              "assets/blog3.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 55, vertical: 45),
            height: 300,
            color: Colors.green,
            child: Image.asset(
              "assets/blog1.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: VideoCard(
            videoUrl:
                'https://drive.google.com/uc?export=download&id=12SgTq0uuj4iv8lIis2Ckk10rsBq5bOPE', // link video
          ),
        ),

        const SliverPadding(
          padding: EdgeInsets.only(top: 45),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
                child: PrimaryText(
              'DÀNH CHO BẠN'.toUpperCase(),
              fontSize: 22,
              letterSpacing: 5,
            )),
          ),
        ),

        // Collection
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: 30),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 190, // full width
                height: 0.5, // độ dày line
                color: Theme.of(context).colorScheme.onSurface, // màu line
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 450,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: 5,
              // số item
              separatorBuilder: (_, __) => SizedBox(width: 12),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 3 / 4,
                        child: Image.network(
                          'https://picsum.photos/200/300?random=$index',
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 8),
                      Center(
                        child: PrimaryText(
                          'Harris Tweed Three button Jacket',
                          maxLines: 2,
                        ),
                      ),
                      SizedBox(height: 4),
                      Center(
                        child: PrimaryText(
                          '\$120',
                          color: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.only(top: 45),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: PrimaryText(
                    '@TRENDING',
                    letterSpacing: 5,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: List.generate(
                    tagList.length,
                    (index) => Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tagList[index],
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(children: [
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialIcon(icon: FontAwesomeIcons.facebook, url: 'https://www.facebook.com'),
                SizedBox(width: 16),
                SocialIcon(icon: FontAwesomeIcons.instagram, url: 'https://www.instagram.com/accounts/login/?hl=en'),
                SizedBox(width: 16),
                SocialIcon(icon: FontAwesomeIcons.youtube, url: 'https://www.youtube.com/watch?v=ieHJC9ZtoYg&list=RDieHJC9ZtoYg&start_radio=1'),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center, // Căn lề trái
              child: Container(
                width:
                200, // Điều chỉnh chiều dài của thanh gạch
                height: 1,
                color: Theme.of(context).colorScheme.onSurface,
                margin: EdgeInsets.only(
                    top: 8), // Cách lề trên một chút
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryText(
                  'support@openui.design',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
                PrimaryText(
                  '+60 825 876',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
                PrimaryText(
                  '08:00 - 22:00 - Everyday',
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ],
            ),
            Footer(),
          ]),
        )
      ],
    );
  }
}

List<String> tagList = [
  '#2021',
  '#spring',
  '#collection',
  '#fall',
  '#dress',
  '#autumncollection',
  '#openfashion',
];
