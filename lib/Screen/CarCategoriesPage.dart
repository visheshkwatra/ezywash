import 'package:carwash/Model/Model.dart';
import 'package:carwash/Widgets/widget.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class CarCategoriesPage extends StatefulWidget {
  static String id = 'CarCategories';
  const CarCategoriesPage({Key? key}) : super(key: key);

  @override
  _CarCategoriesPageState createState() => _CarCategoriesPageState();
}

class _CarCategoriesPageState extends State<CarCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Theme.of(context).colorScheme.background,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    EzyWashLogo(),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 1.75,
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 12),
                      itemCount: CarCategories.carCategories.length,
                      itemBuilder: (context, int index) {
                        index = index + 3;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                SelectedInformation.mainCategoryID =
                                    MainCategories.mainCategories[index].id ??
                                        2;
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return HomePage();
                                    },
                                  ),
                                );
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 120,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'IMAGES/${MainCategories.mainCategories[index].imgData ?? ''}'),
                                            fit: BoxFit.contain)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    child: Text(
                                      '${MainCategories.mainCategories[index].name ?? ''}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      })),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
