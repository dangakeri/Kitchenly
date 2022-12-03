import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:kitchenly/model/api.dart';
import 'package:kitchenly/model/model.dart';
import 'package:kitchenly/pages/foods.dart';
import '../widgets/Listtileswidget.dart';
import '../widgets/foodWidget.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool showPrefix = true;
  final TextEditingController _editingController = TextEditingController();
  ScrollController scrollController = ScrollController();
  late Future<List<RecipeModel>> recipeData;
  @override
  void initState() {
    super.initState();
    recipeData = ApiService.getData();
    print(recipeData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: Colors.grey.withOpacity(.7),
                    ),
                  ),
                  child: TextFormField(
                    controller: _editingController,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      setState(() {
                        _editingController.text.isEmpty
                            ? showPrefix = true
                            : showPrefix = false;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: !showPrefix
                          ? const SizedBox()
                          : const Icon(
                              Icons.search_sharp,
                              color: Colors.white,
                            ),
                      hintText: 'Search',
                      hintStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    children: const [
                      ListtilesWidget(
                        title: 'Popular',
                      ),
                      ListtilesWidget(
                        title: 'Salad',
                      ),
                      ListtilesWidget(
                        title: 'Breakfast',
                      ),
                      ListtilesWidget(
                        title: 'Lunch',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .03),
                Row(
                  children: [
                    FutureBuilder<List<RecipeModel>>(
                      future: recipeData,
                      builder: ((context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Text(
                            '0 Popular',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        return Text(
                          '${snapshot.data!.length} Popular',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                    ),
                    const Spacer(),
                    Icon(
                      BootstrapIcons.sliders,
                      color: Colors.greenAccent.withOpacity(.6),
                      size: 35,
                    ),
                    const SizedBox(width: 15),
                  ],
                ),
              ]),
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<List<RecipeModel>>(
                  future: recipeData,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }
                    ;
                    List<RecipeModel>? data = snapshot.data;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: FoodWidget(
                            text1: '',
                            text2: '',
                            title: data[index].title,
                            subtitle: data[index].publisher,
                            image: data[index].img_url,
                            callback: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          FoodsPage(
                                            id: data[index].id,
                                          )));
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
