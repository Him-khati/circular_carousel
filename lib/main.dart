import 'package:carousel_flutter/circular_carousel/carousel_options.dart';
import 'package:carousel_flutter/circular_carousel/carousel_slide_data.dart';
import 'package:carousel_flutter/circular_carousel/circular_corousel.dart';
import 'package:carousel_flutter/scroll_home_screen_behaviour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'gen/assets.gen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Carousel',
      scrollBehavior: AppScrollBehavior(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: GoogleFonts.merriweatherTextTheme()
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CarouselSlideData? slideInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularImageCarousalWidget(
              key: const Key("carousel"),
              options: CarouselOptions(onSlideChangeCallback: (slideData) {

                setState(() {
                  slideInfo = slideData;
                });
              }),
              images: [
                CarouselSlideData(
                    id: 1,
                    image: Image.asset(Assets.images.hilaichi.path,fit: BoxFit.cover,),
                  title: "Heihachi",
                  subtitle: "Karate in Mishima style",
                ),
                CarouselSlideData(
                    id: 1,
                    image: Image.asset(Assets.images.jinKazama.path,fit: BoxFit.cover,),
                    title: "Jin",
                    subtitle: "yokushin Karate; full-contact, hard-hitting",),
                CarouselSlideData(
                    id: 4,
                    image: Image.asset(Assets.images.nina.path,fit: BoxFit.cover,),
                    title: "Nina",
                    subtitle: "Slapping aside, the advanced bone-breaking and grappling techniques"),
                CarouselSlideData(
                    id: 5,
                    image: Image.asset(Assets.images.paul.path ,fit: BoxFit.cover,),
                    title: "Paul",
                    subtitle: "fightingstyle based on Judo"),
                CarouselSlideData(
                    id: 6,
                    image: Image.asset(Assets.images.brian.path),
                    title: "Bryan",
                    subtitle: "Kickboxing; boxing + kicks"),
                CarouselSlideData(
                    id: 7,
                    image: Image.asset(Assets.images.yoshi.path),
                    title: "Yoshimitsu",
                    subtitle: "Manji Ninjutsu mixed with Samurai techniques"),
                CarouselSlideData(
                    id: 8,
                    image: Image.asset(Assets.images.xiaoyo.path,fit: BoxFit.cover,),
                    title: "Xiaoyu",
                    subtitle: "fightingstyle based on Hakke Sho and Hika Ken"),
              ],
            ),

            Text(
              slideInfo?.title ?? "Heihachi",
              key: ValueKey<String>(slideInfo?.title ?? "Heihachi"),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              slideInfo?.subtitle ?? "Karate in Mishima style", //TODO fix this hardcoded text
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
