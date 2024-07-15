import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hackathon/Buyer/myOrders.dart';
import 'package:hackathon/Buyer/shoppingBag.dart';
import 'package:hackathon/Buyer/likedAnimation.dart';
import 'package:hackathon/Buyer/likedPage.dart';
import 'package:swipe_cards/swipe_cards.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MatchEngine _matchEngine;
  List<SwipeItem> _swipeItems = [];
  List<String> cartImages = [];
  List<String> likedImages = [];
  List<String> dislikedImages = [];
  int points = 0;
  bool showHeart = false;
  bool showBrokenHeart = false;

  @override
  void initState() {
    super.initState();
    _loadAllImages();
  }

  void _loadAllImages() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('DummyDataset2').get();
    setState(() {
      _swipeItems = querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return SwipeItem(
          content: data,
          likeAction: () {
            // Increment 'No of Right Swipes' in Firestore
            int currentRightSwipes = data['No of Right Swipes'] ?? 0;
            FirebaseFirestore.instance
                .collection('DummyDataset2')
                .doc(doc.id)
                .update({
              'No of Right Swipes': currentRightSwipes + 1,
            });
            points++;
            setState(() {
              showHeart = true;
              likedImages.add(data['img']);
            });
          },
          nopeAction: () {
            dislikedImages.add(data['img']);
            points++;
            setState(() {
              showBrokenHeart = true;
            });
          },
        );
      }).toList();

      _matchEngine = MatchEngine(swipeItems: _swipeItems);
    });
  }

  void _onHeartAnimationComplete() {
    setState(() {
      showHeart = false;
    });
  }

  void _onBrokenHeartAnimationComplete() {
    setState(() {
      showBrokenHeart = false;
    });
  }

  void _addToBag(String image) {
    cartImages.add(image);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(child: Text('Added to bag!')),
      backgroundColor: Color.fromARGB(255, 11, 72, 33),
      duration: Duration(milliseconds: 500),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Fashion Rental',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border,
                color: Color.fromARGB(213, 255, 68, 190)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LikedScreen(
                    likedImages: likedImages,
                    dislikedImages: dislikedImages,
                    points: points,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined,
                color: Color.fromARGB(213, 255, 68, 190)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingBag(cartImages: cartImages),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.menu, color: Color.fromARGB(213, 255, 68, 190)),
            onSelected: (String result) {
              if (result == 'show_orders') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersPage()),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'show_orders',
                child: Text('Show Orders'),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Displaying categories as static buttons without any functionality
              Container(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(154, 248, 190, 228),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color.fromARGB(255, 216, 216, 216)),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.grey[850],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.fromLTRB(4, 10, 4, 10),
                    child: _swipeItems.isEmpty
                        ? Center(
                            child: Text(
                              'No images available',
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                        : Builder(builder: (context) {
                            return SwipeCards(
                              matchEngine: _matchEngine,
                              itemBuilder: (BuildContext context, int index) {
                                var item = _swipeItems[index].content;
                                return GestureDetector(
                                  onDoubleTap: () {
                                    _addToBag(item['img']);
                                    _matchEngine.currentItem?.like();
                                  },
                                  child: Center(
                                    child: SizedBox(
                                      width: 350,
                                      height: 600,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          side: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 154, 152, 152),
                                              width: 2),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  item['img'],
                                                  fit: BoxFit.fitWidth,
                                                  width: double.infinity,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                            item['name'],
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15)),
                                                      ),
                                                      Divider(height: 15),
                                                      SizedBox(height: 10),
                                                      Text(
                                                          'Renting Price:  Rs. ${item['price']}',
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      SizedBox(height: 10),
                                                      Text(
                                                          'Seller: ${item['brand']}',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      Text(
                                                          'Selected: ${item['No of rents']} times',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Ratings: ${item['avg_rating']} ',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color:
                                                                Color.fromARGB(255, 225, 187, 18),
                                                            size: 16,
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 20),
                                                      Center(
                                                        child: Text(
                                                            'Add Reviews:',
                                                            style: TextStyle(
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                fontSize: 15)),
                                                      ),
                                                      Column(
                                                        children: [
                                                          if (item['reviews'] !=
                                                              null)
                                                            ...item['reviews']
                                                                .map<Widget>(
                                                                    (review) {
                                                              return Row(
                                                                children: [
                                                                  RatingBarIndicator(
                                                                    rating: review[
                                                                            'avg_rating']
                                                                        .toDouble(),
                                                                    itemBuilder:
                                                                        (context,
                                                                                index) =>
                                                                            Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber,
                                                                    ),
                                                                    itemCount:
                                                                        5,
                                                                    itemSize:
                                                                        18.0,
                                                                    direction: Axis
                                                                        .horizontal,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8.0,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      review[
                                                                          'text'],
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            }).toList(),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    TextField(
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        'Add your review...',
                                                                    border:
                                                                        OutlineInputBorder(),
                                                                  ),
                                                                  onSubmitted:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      item['reviews'] ??=
                                                                          [];
                                                                      item['reviews']
                                                                          .add({
                                                                        'avg_rating':
                                                                            0.0,
                                                                        'text':
                                                                            value,
                                                                      });
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              IconButton(
                                                                icon: Icon(
                                                                    Icons.send),
                                                                onPressed: () {
                                                                  // Handle review submission
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              onStackFinished: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('No more items.'),
                                  duration: Duration(milliseconds: 500),
                                ));
                              },
                              upSwipeAllowed: true,
                              fillSpace: true,
                            );
                          }),
                  ),
                ),
              ),
            ],
          ),
          if (showHeart)
            IconAnimation(
              show: showHeart,
              onComplete: _onHeartAnimationComplete,
              icon: Icons.favorite,
              color: Colors.red,
            ),
          if (showBrokenHeart)
            IconAnimation(
              show: showBrokenHeart,
              onComplete: _onBrokenHeartAnimationComplete,
              icon: Icons.sentiment_dissatisfied_outlined,
              color: Colors.yellow,
            ),
        ],
      ),
    );
  }
}

final categories = [
  'Ethnic',
  'Dresses',
  'Jeans',
  'Skirts',
  'Necklace',
  'Earings',
];
