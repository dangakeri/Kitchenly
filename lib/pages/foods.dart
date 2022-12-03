import 'package:flutter/material.dart';
import 'package:kitchenly/model/api.dart';
import 'package:kitchenly/pages/webviewPage.dart';
import '../model/model.dart';
import '../widgets/content.dart';

class FoodsPage extends StatefulWidget {
  final String id;
  const FoodsPage({super.key, required this.id});

  @override
  State<FoodsPage> createState() => _FoodsPageState();
}

class _FoodsPageState extends State<FoodsPage> {
  late Future<RecipesModel> recipesData;
  @override
  void initState() {
    recipesData = ApiService.getRecipeData(widget.id);
    print(recipesData);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text(
          'Slicing with fruits',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          const SizedBox(width: 20),
        ],
      ),
      body: FutureBuilder<RecipesModel>(
          future: recipesData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .03),
                Center(
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(snapshot.data!.img_url),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(150),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.5),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      border: Border.all(color: Colors.grey.withOpacity(.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        contentWidget(
                          title: snapshot.data!.cooking_time.toString(),
                          subtitle: 'Min',
                        ),
                        contentWidget(
                          title: snapshot.data!.servings.toString(),
                          subtitle: 'Serving',
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 450,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.01),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ListView(children: [
                        Column(
                          children: snapshot.data!.ingridients
                              .map((e) => Text(
                                    e.toString(),
                                    style: TextStyle(color: Colors.white),
                                  ))
                              .toList(),
                        ),
                      ]),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                GestureDetector(
                  onTap: () {
                    print(snapshot.data!.source_url);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => WebviewPage(
                                  source_url: snapshot.data!.source_url,
                                )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Center(
                        child: Text(
                          'Learn More',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
