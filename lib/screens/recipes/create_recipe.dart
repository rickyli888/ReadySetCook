import 'package:flutter/material.dart';
import 'package:ready_set_cook/models/ingredient.dart';
import 'package:ready_set_cook/models/nutrition.dart';
import 'package:ready_set_cook/models/recipe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ready_set_cook/screens/recipes/add_instruction.dart';
import 'package:ready_set_cook/services/recipes_database.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:ready_set_cook/screens/recipes/add_ingredient.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:uuid/uuid.dart';

class CreateRecipe extends StatefulWidget {
  final Function toggleView;
  CreateRecipe({this.toggleView});

  @override
  _CreateRecipeState createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  RecipesDatabaseService recipeDB;

  String _recipeName = "";
  double _rating = 0;
  int _numRatings = 0;
  String calories = "";
  String protein = "";
  String totalCarbs = "";
  String totalFat = "";
  List<Ingredient> _ingredients = [];
  bool instruction_added = false;
  bool ingredient_added = false;
  String _instruction_error = "";
  String _ingredient_error = "";
  Nutrition nutrition;
  bool _fav;

  String _ingredientName = "";
  String _quantity = "";
  String _unit = "";

  final List<String> _instructions = [];
  String instruction = "";
  int ins_ind = 0;

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  TextEditingController _controller4 = TextEditingController();
  TextEditingController _controller5 = TextEditingController();
  TextEditingController _controller6 = TextEditingController();
  TextEditingController _controller7 = TextEditingController();
  TextEditingController _controller8 = TextEditingController();
  TextEditingController _controller9 = TextEditingController();

  File _image = null;
  String _imageUrl = null;
  String _filePath = null;
  final _picker = ImagePicker();

  void getImage() async {
    final pickedFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    _filePath = pickedFile.path;
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _createIngredient() {
    ingredient_added = true;
    _ingredients.add(new Ingredient(
        name: _ingredientName, quantity: _quantity, unit: _unit));
    _controller1.clear();
    _controller2.clear();
    _controller3.clear();
    setState(() {});
  }

  _createInstruction() {
    instruction_added = true;
    _instructions.add(instruction);
    _controller4.clear();
    setState(() {});
  }

  Future<void> _createRecipe() async {
    if (_image != null) {
      var ref = FirebaseStorage.instance
          .ref()
          .child('recipe_images')
          .child(_filePath);
      await ref.putFile(_image).whenComplete(() => null);
      _imageUrl = await ref.getDownloadURL();
    }

    nutrition = new Nutrition(
        calories: calories,
        protein: protein,
        totalCarbs: totalCarbs,
        totalFat: totalFat);
    var _recipeId = Uuid().v4();
    recipeDB.addCustomRecipe(new Recipe(
        recipeId: _recipeId,
        name: _recipeName,
        ingredients: _ingredients,
        instructions: _instructions,
        nutrition: nutrition,
        rating: _rating,
        numRatings: _numRatings,
        imageUrl: _imageUrl,
        fav: _fav));
    _controller1.clear();
    _controller2.clear();
    _controller3.clear();
    _controller4.clear();
    _ingredients.clear();
    _instructions.clear();
    // setState(() {});
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final _uid = FirebaseAuth.instance.currentUser.uid;
    recipeDB = RecipesDatabaseService(uid: _uid);

    final _tabPages = <Widget>[
      // Ingredients
      Scaffold(
        backgroundColor: Colors.blue[50],
        body: Container(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(15),
                itemCount: !ingredient_added ? 1 : _ingredients.length,
                itemBuilder: (context, index) {
                  if (!ingredient_added) {
                    return Center(
                        child: Text(
                      _ingredient_error,
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ));
                  }
                  return ListTile(
                      title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((index + 1).toString() +
                          ")   " +
                          _ingredients[index].name),
                      Text(" " +
                          _ingredients[index].quantity.toString() +
                          " " +
                          _ingredients[index].unit),
                    ],
                  ));
                })),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Add"),
          onPressed: () async {
            dynamic result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddIngredientPage()),
            );
            if (result != null) {
              setState(() {
                _ingredientName = result.name;
                _quantity = result.quantity;
                _unit = result.unit;
                _createIngredient();
              });
            }
          },
        ),
      ),

      // Instructions
      Scaffold(
        backgroundColor: Colors.blue[50],
        body: Container(
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.all(15),
              itemCount: !instruction_added ? 1 : _instructions.length,
              itemBuilder: (context, index) {
                if (!instruction_added) {
                  return Center(
                      child: Text(
                    _instruction_error,
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ));
                }
                return SingleChildScrollView(
                  child: ListTile(
                    title: Text(
                        (index + 1).toString() + ")   " + _instructions[index]),
                  ),
                );
              }),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text("Add"),
          onPressed: () async {
            dynamic result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddInstructionsPage()),
            );
            if (result != null) {
              setState(() {
                instruction = result;
                _createInstruction();
              });
            }
          },
        ),
      ),

      // Nutrition
      Center(
          child: Scaffold(
        backgroundColor: Colors.blue[50],
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
              child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Container(
                  height: 200,
                  width: 200,
                  child: (_image == null)
                      ? Image(
                          image: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/480px-No_image_available.svg.png"))
                      : Image.file(_image),
                ),
                FlatButton(
                  color: Colors.grey[300],
                  child: Text("Add Image"),
                  onPressed: getImage,
                ),
                SizedBox(height: 40.0),
                TextFormField(
                  controller: _controller5,
                  decoration: new InputDecoration(
                    labelText: "Enter Total Calories",
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() => calories = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _controller6,
                  decoration: new InputDecoration(
                    labelText: "Enter Total Protein",
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() => protein = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _controller7,
                  decoration: new InputDecoration(
                    labelText: "Enter Total Fats",
                    border: new OutlineInputBorder(
                      borderSide: new BorderSide(),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() => totalFat = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _controller8,
                  decoration: InputDecoration(
                    labelText: "Enter Total Carbohydrates",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() => totalCarbs = val);
                  },
                ),
                SizedBox(height: 20.0),
              ],
            ),
          )),
        ),
      ))
    ];
    final _tabs = <Tab>[
      const Tab(icon: Icon(Icons.add), text: 'Ingredients'),
      const Tab(icon: Icon(Icons.add), text: 'Instructions'),
      const Tab(icon: Icon(Icons.add), text: 'Additional Info')
    ];
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: TextFormField(
            controller: _controller9,
            style: TextStyle(color: Colors.white, fontSize: 20),
            decoration: InputDecoration(
              hintText: "Recipe Name",
              hintStyle:
                  TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
              contentPadding:
                  new EdgeInsets.symmetric(vertical: 50.0, horizontal: 0),
            ),
            onChanged: (val) {
              setState(() => _recipeName = val);
            },
          ),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              child: Text('Done', style: TextStyle(fontSize: 16)),
              onPressed: () {
                if (ingredient_added && instruction_added) {
                  _createRecipe();
                  Navigator.of(context).pop();
                }
                if (!ingredient_added) {
                  setState(() {
                    _ingredient_error = "Please enter at least one ingredient";
                  });
                }
                if (!instruction_added) {
                  setState(() {
                    _instruction_error =
                        "Please enter at least one instruction";
                  });
                }
              },
            )
          ],
          bottom: TabBar(
            tabs: _tabs,
          ),
        ),
        body: TabBarView(
          children: _tabPages,
        ),
      ),
    );
  }
}
