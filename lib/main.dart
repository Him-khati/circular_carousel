import 'package:carousel_flutter/circular_carousel/carousel_options.dart';
import 'package:carousel_flutter/circular_carousel/carousel_slide_data.dart';
import 'package:carousel_flutter/circular_carousel/circular_corousel.dart';
import 'package:carousel_flutter/scroll_home_screen_behaviour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'gen/assets.gen.dart';
import 'utils/cache_manager.dart';
import 'utils/cache_demo_viewmodel.dart';

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

  // Add cache demo ViewModel
  late final CacheDemoViewModel cacheDemoViewModel;
  String cacheDemoResult = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final memoryCache = InMemoryCache();
    final diskCache = DiskCache();
    cacheDemoViewModel = CacheDemoViewModel(
      CombinedCacheManager(memoryCache: memoryCache, diskCache: diskCache),
    );
  }

  Future<void> _getData() async {
    setState(() => isLoading = true);
    final result = await cacheDemoViewModel.getData();
    setState(() {
      cacheDemoResult = result;
      isLoading = false;
    });
  }

  Future<void> _invalidateCache() async {
    await cacheDemoViewModel.invalidateCache();
    setState(() {
      cacheDemoResult = 'Cache invalidated!';
    });
  }

  Future<void> _clearAllCache() async {
    await cacheDemoViewModel.clearAllCache();
    setState(() {
      cacheDemoResult = 'All cache cleared!';
    });
  }

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
            const SizedBox(height: 32),
            // --- Cache Demo UI ---
            Text('Cache Demo', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            if (isLoading) const CircularProgressIndicator(),
            if (!isLoading) ...[
              Text(cacheDemoResult, key: const Key('cacheDemoResult')),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _getData,
                    child: const Text('Get Data'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _invalidateCache,
                    child: const Text('Invalidate Cache'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _clearAllCache,
                    child: const Text('Clear All'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
