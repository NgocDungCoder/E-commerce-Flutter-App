import 'package:ecomercy_app_flutter/configs/styles/theme.dart';
import 'package:ecomercy_app_flutter/views/blog/blog_logic.dart';
import 'package:ecomercy_app_flutter/widgets/Scaffold/primary_scaffold.dart';
import 'package:ecomercy_app_flutter/widgets/Text/primary_text.dart';
import 'package:ecomercy_app_flutter/widgets/footer/footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class BlogsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: GetX<BlogLogic>(
        builder: (logic) {
          return logic.state.isLoading.value
              ? Center(
                  child: Lottie.asset('assets/animations/cat_loading.json',
                      width: 150, height: 150),
                )
              : ListView(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PrimaryText(
                          'BLOG',
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                        ElevatedButton(
                          onPressed: logic.toggleListView,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: logic.state.isListView.value ? Icon(Icons.grid_view_rounded) : Icon(Icons.list_alt),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center, // Căn lề trái
                      child: Container(
                        width: 280, // Điều chỉnh chiều dài của thanh gạch
                        height: 1,
                        color: Colors.grey,
                        margin:
                            EdgeInsets.only(top: 8), // Cách lề trên một chút
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 45,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: logic.state.categories.length,
                        itemBuilder: (context, index) {
                          var category = logic.state.categories[index];
                          return Container(
                            height: 45,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                                child: PrimaryText(
                              category["name"],
                              color: Colors.white,
                            )),
                          );
                        },
                      ),
                    ),
                    logic.state.blogs.isNotEmpty
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            controller: logic.scrollController,
                            itemCount: logic.state.blogs.length,
                            itemBuilder: (BuildContext context, int index) {
                              var blog = logic.state.blogs[index];
                              return !logic.state.isListView.value
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 20,
                                              bottom: 10),
                                          child: ClipRRect(
                                              child: Stack(
                                            children: [
                                              // Hình ảnh
                                              Image.network(
                                                blog["coverImage"] ??
                                                    "https://drive.usercontent.google.com/download?id=1PD0UdSjPCIldfHZQJIaEPSlpx54ezB32&export=view&authuser=0",
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                height: 200,
                                                alignment: Alignment(-0.3, 0),
                                              ),

                                              // Lớp phủ Gradient (Giới hạn trong ảnh)
                                              Container(
                                                height: 200,
                                                // Đảm bảo lớp phủ chỉ nằm trong ảnh
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.center,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Colors.transparent,
                                                      Colors.black
                                                          .withOpacity(0.8),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // Tiêu đề
                                              Positioned(
                                                bottom: 16,
                                                left: 16,
                                                right: 16,
                                                child: PrimaryText(
                                                  blog["title"].toUpperCase() ??
                                                      "TITLE BLOG",
                                                  color: ThemeConfigs.whiteText,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
                                                ),
                                              ),

                                              // Bookmark Icon
                                              Positioned(
                                                top: 16,
                                                right: 16,
                                                child: Icon(
                                                  Icons.bookmark_border,
                                                  color: Colors.white,
                                                  size: 28,
                                                ),
                                              ),
                                            ],
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 230,
                                                child: Wrap(
                                                  spacing: 10,
                                                  runSpacing: 10,
                                                  children: List<String>.from(
                                                          blog["tags"])
                                                      .map((tag) {
                                                    return Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8,
                                                              vertical: 8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1),
                                                      ),
                                                      child: Text("#$tag",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 11)),
                                                    );
                                                  }).toList(), // Chuyển map về dạng List<Widget>
                                                ),
                                              ),
                                              PrimaryText(
                                                "Yesterday",
                                                color: Colors.grey,
                                                fontSize: 14,
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 20,
                                              bottom: 10),
                                          child: Row(
                                            children: [
                                              Container(
                                                  height: 230,
                                                  width: 170,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.blueAccent,
                                                          Colors.red
                                                        ],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment.bottomRight),
                                                    border: Border.all(
                                                      width: 3,
                                                      color: Colors.transparent,
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.only(
                                                        topRight: Radius
                                                            .circular(
                                                            15),
                                                        bottomLeft: Radius
                                                            .circular(
                                                            10)),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.only(
                                                        topRight: Radius
                                                            .circular(
                                                            15),
                                                        bottomLeft: Radius
                                                            .circular(
                                                            10)),
                                                    child: Image.network(
                                                      blog["coverImage"],
                                                      fit: BoxFit.cover,
                                                      alignment:
                                                          Alignment(0.65, 0),
                                                    ),
                                                  )),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                height: 230,
                                                width: 172,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    PrimaryText(
                                                      blog["title"],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                    PrimaryText(
                                                        blog["blogType"]),
                                                    PrimaryText(
                                                      "Yesterday",
                                                      color: Colors.grey,
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              Alignment.center, // Căn lề trái
                                          child: Container(
                                            width:
                                                350, // Điều chỉnh chiều dài của thanh gạch
                                            height: 1,
                                            color: Colors.grey,
                                            margin: EdgeInsets.only(
                                                top:
                                                    10), // Cách lề trên một chút
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                      ],
                                    );
                            },
                            //Image.network("https://drive.usercontent.google.com/download?id=1yB4kN2qu0gJXlZtAyvHmaOuymJ6b6mlH&export=view&authuser=0", fit: BoxFit.cover,),
                          )
                        : SizedBox.shrink(),
                    SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 250,
                        child: logic.state.isLoadmore.value ?
                        Center(
                          child: Lottie.asset('assets/animations/load_more.json',
                              width: 150, height: 150),
                        ) :
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(color: Colors.grey, width: 1),
                              ),
                            ),
                            onPressed: logic.loadMore,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PrimaryText(
                                  "LOAD MORE",
                                  fontSize: 18,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Icon(Icons.add),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.center, // Căn lề trái
                      child: Container(
                        width: 200, // Điều chỉnh chiều dài của thanh gạch
                        height: 1,
                        color: Colors.grey,
                        margin:
                            EdgeInsets.only(top: 8), // Cách lề trên một chút
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
                  ],
                );
        },
      ),
    );
  }
}
