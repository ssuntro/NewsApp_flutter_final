import 'package:flutter/material.dart';
import 'package:news_app/news.dart';
import 'package:news_app/news_category.dart';
import 'package:news_app/news_tile.dart';
import 'package:news_app/news_status.dart';

import 'add_news_page.dart';

class MainNewsPage extends StatefulWidget {
  static const routeName = '/main-news-page';
  @override
  State<MainNewsPage> createState() => _MainNewsPageState();
}

List<News> stubData() {
  return [
    News(
        title: "11",
        body: "body 11",
        url: "https://emojipedia.org/party-popper/",
        status: NewsStatus.responded,
        category: NewsCategory.animal),
    News(
        title: "22",
        body: "body 22",
        url: "google.com",
        status: NewsStatus.closed,
        category: NewsCategory.globalWarming),
    News(
        title: "33",
        body: "body 33",
        url: "",
        status: NewsStatus.closed,
        category: NewsCategory.globalWarming),
    News(
        title:
            "4jkjkjkjkjkjkjkjkjjkjk444jkjkjkjkjkjkjkjkjjkjk444jkjkjkjkjkjkjkjkjjkjk44",
        body: "body 44",
        url: null,
        status: NewsStatus.pendingResponse,
        category: NewsCategory.finance)
  ];
  // [
  //   {
  //     "title":
  //         "4jkjkjkjkjkjkjkjkjjkjk444jkjkjkjkjkjkjkjkjjkjk444jkjkjkjkjkjkjkjkjjkjk44",
  //     // "status": NewsStatus.pendingResponse,
  //     // "category": NewsCategory.finance
  //   },
  // ];
}

class _MainNewsPageState extends State<MainNewsPage> {
  var newsList = stubData();
  var isReorderEnabled = false;

  onReoder(oldIndex, newIndex) {
    if (oldIndex < newIndex) {
      // removing the item at oldIndex will shorten the list by 1.
      newIndex -= 1;
    }
    final News element = newsList.removeAt(oldIndex);
    newsList.insert(newIndex, element);
  }

  onRefreshButtonDidClick() {
    setState(() {
      newsList = stubData();
    });
  }

  onAddNews(News aNews) {
    setState(() {
      newsList.add(aNews);
    });
  }

  onTileDidClick(String title) {
    final clicked = newsList.firstWhere((elem) => elem.title == title);
    Navigator.of(context).pushNamed(NewsPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            // AppBar( back button style
            //   automaticallyImplyLeading: false,
            //   title: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: <Widget>[
            //       SizedBox(
            //         height: 20, // Your Height
            //         width: 20, // Your width
            //         child: Text("ddddd"),
            //       ),
            //       // Your widgets here
            //     ],
            //   ),
            // ),

            AppBar(
          leading: ElevatedButton(
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     fullscreenDialog: true,
              //     builder: (ctx) => AddNewsPage(
              //       onAddButtonDidClick: onAddNews,
              //     ),
              //   ),
              // );
              showGeneralDialog(
                context: context,
                pageBuilder: (context, anim1, anim2) {
                  return AddNewsPage(
                    onAddButtonDidClick: onAddNews,
                  );
                },
                transitionBuilder: (context, anim1, anim2, child) {
                  return SlideTransition(
                    position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                        .animate(anim1),
                    child: child,
                  );
                },
              );
            },
            child: Icon(Icons.add),
          ),
          actions: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isReorderEnabled = !isReorderEnabled;
                    });
                  },
                  child: Text("Reorder"),
                ),
                ElevatedButton(
                  onPressed: onRefreshButtonDidClick,
                  child: Text("Refresh"),
                )
              ],
            ),
          ],
        ),
        body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.

            // child: SingleChildScrollView(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: [
            //       ...new List<int>.generate(10, (i) => i + 1)
            //           .map(
            //             (number) => Container(
            //               child: Text(
            //                 "${number}",
            //                 style: TextStyle(fontSize: 150),
            //               ),
            //               color: (number % 2 == 0)
            //                   ? Colors.amber
            //                   : Colors.blueAccent,
            //               height: 100,
            //               width: 10,
            //             ),
            //           )
            //           .toList()
            //     ],
            //   ),
            // ),

            child: ReorderableListView.builder(
                onReorder: onReoder,
                itemCount: newsList.length,
                itemBuilder: (ctx, index) {
                  final title = newsList[index].title ?? "";
                  final status = newsList[index].status;
                  final category = newsList[index].category;
                  return isReorderEnabled
                      ? NewsTile(
                          key: Key(title),
                          title: title,
                          status: status,
                          category: category,
                          color: Colors.amber)
                      : IgnorePointer(
                          key: Key(title),
                          child: NewsTile(
                            key: Key(title),
                            title: title,
                            status: status,
                            category: category,
                            color: Colors.white,
                          ),
                        );
                }

                // child: ListView.builder(
                //   itemCount: 10,
                //   itemBuilder: (ctx, index) => Container(
                //     child: Text(
                //       "${index + 1}",
                //       style: TextStyle(fontSize: 150),
                //     ),
                //     color: (index + 1) % 2 == 0 ? Colors.amber : Colors.blueAccent,
                //     height: 100,
                //     width: 10,
                //   ),
                // ),

                // child: ListView(
                //   children: <Widget>[
                //     ...new List<int>.generate(10, (i) => i + 1)
                //         .map(
                //           (number) => Container(
                //             child: Text(
                //               "${number}",
                //               style: TextStyle(fontSize: 150),
                //             ),
                //             color:
                //                 (number % 2 == 0) ? Colors.amber : Colors.blueAccent,
                //             height: 100,
                //             width: 10,
                //           ),
                //         )
                //         .toList()
                //   ],
                // ),
                )));
  }
}

// present popup == Navigator.of(context).push(
//   MaterialPageRoute(
//     fullscreenDialog: true,
//     builder: (ctx) => MainNewsScreen(),
//   ),
// );

// child: ListTile(
//   // dense: true,
//   minVerticalPadding: 0,
//   contentPadding: EdgeInsets.all(0),
//   // minLeadingWidth: 100,
//   leading: Expanded(
//     child: Container(
//       color: Colors.black,
//     ),
//   ),
//   // leading: Image.network(
//   //   "https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-800x825.jpg",
//   //   fit: BoxFit.cover, height: 100,
//   //   width: 100,
//   //   // width: 200,
//   // ),
//   title: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("A"),
//         ElevatedButton(
//           child: Text("Animal"),
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             primary: Color.fromARGB(255, 198, 126, 210),
//             onPrimary: Color.fromARGB(255, 108, 8, 125),
//             textStyle: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.normal),
//           ),
//         ),
//       ],
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly),
//   onTap: () {},
// ),
