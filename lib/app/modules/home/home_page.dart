import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sttagered_grid/app/models/item_model.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (_, constraints) {
          final width = constraints.maxWidth;
          final itemWidth = ((width * 0.5)) - 32;
          final height = constraints.maxHeight + itemWidth;

          return OverflowBox(
            maxWidth: width,
            minWidth: width,
            maxHeight: height,
            minHeight: height,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                padding: EdgeInsets.only(top: itemWidth / 2, bottom: itemWidth),
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return Transform.translate(
                    offset: Offset(0.0, index.isOdd ? itemWidth * 0.5 : 0),
                    child: MealsItem(
                      itemModel: items[index],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class MealsItem extends StatelessWidget {
  final ItemModel itemModel;

  const MealsItem({Key key, this.itemModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: ClipOval(
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  itemModel.imageUrl,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(itemModel.title),
              Text(itemModel.subTitle),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    5,
                    (index) =>
                        index < 4 ? Icon(Icons.star) : Icon(Icons.star_border)),
              )
            ],
          )
        ],
      ),
    );
  }
}
