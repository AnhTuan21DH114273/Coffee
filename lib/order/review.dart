import 'package:app_coffee/data/model/review.dart';
import 'package:app_coffee/home/voucher.dart';
import 'package:app_coffee/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Review extends StatefulWidget {
  const Review({super.key});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF9F9F9)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back),
                  ),
                  const SizedBox(
                    width: 130,
                  ),
                  const Text(
                    "Review",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 25,),
            Container(
              width: 412,
              height: 41,
              color: Color(0xFFC3916B),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 10,),
                  SvgPicture.asset("assets/vectors/bean.svg"),
                  const SizedBox(width: 10,),
                  const Text("Rate and get up to 200 beans!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ), 
                  ),
                  const SizedBox(width: 125,),
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Voucher()));
                  }, 
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16,)
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100,),
            Container(
              margin: const EdgeInsets.only(left: 9.0, right: 9.0),
              child: const Divider(
                color: Color(0xFFE3E3E3),
                height: 30,
            )),
            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Color(0xFFFCDC94),
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            const SizedBox(
              width: 400, 
              height: 208,
              child: TextField(
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  filled: true, hintText: 'Enter a message',
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  ),
              ),
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
              itemCount: review.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  width: 210,
                  height: 44,
                  margin: EdgeInsets.only(left: 10, top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFEAEAEA)
                  ),
                  child: Center(
                    child: Text(
                      review[index],
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFAFAFAF)
                      ),
                    ),
                  )
                );
              },
            ),
            ),
            const SizedBox(height: 10,),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Image.asset("assets/images/FavoritePic.png")
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 111,
                    width: 430,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                      color: Colors.white
                    ),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Mainpage()));
                        },
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(12)),
                          minimumSize:
                              WidgetStateProperty.all<Size>(const Size(400, 11)),
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color(0xFFC67C4E)),
                          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: const BorderSide(color: Colors.grey)))),
                        child: const Text(
                          "View Delivery",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            height: 1.7,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}