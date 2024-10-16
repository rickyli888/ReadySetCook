import 'package:ready_set_cook/models/ingredient.dart';

class CommonIngredient {
  Ingredient _apple;
  Ingredient _banana;
  Ingredient _blackberry;
  Ingredient _blueberry;
  Ingredient _cherry;
  Ingredient _grape;
  Ingredient _grapefruit;
  Ingredient _kiwi;
  Ingredient _orange;
  Ingredient _peach;
  Ingredient _pear;
  Ingredient _pineapple;
  Ingredient _plum;
  Ingredient _raisins;
  Ingredient _raspberry;
  Ingredient _strawberry;
  Ingredient _tangerine;
  Ingredient _watermelon;
  Ingredient _asparagus;
  Ingredient _avocado;
  Ingredient _beans;
  Ingredient _broccoli;
  Ingredient _cabbage;
  Ingredient _carrot;
  Ingredient _cauliflower;
  Ingredient _celery;
  Ingredient _cucumber;
  Ingredient _eggplant;
  Ingredient _spinach;
  Ingredient _garlic;
  Ingredient _ginger;
  Ingredient _leek;
  Ingredient _lettuce;
  Ingredient _mushrooms;
  Ingredient _olive;
  Ingredient _onion;
  Ingredient _peas;
  Ingredient _potato;
  Ingredient _pumpkin;
  Ingredient _springOnion;
  Ingredient _squash;
  Ingredient _sweetCorn;
  Ingredient _sweetPotato;
  Ingredient _tomato;
  Ingredient _bacon;
  Ingredient _beef;
  Ingredient _caviar;
  Ingredient _chicken;
  Ingredient _cod;
  Ingredient _duckMeat;
  Ingredient _eel;
  Ingredient _ham;
  Ingredient _lamb;
  Ingredient _pork;
  Ingredient _salmon;
  Ingredient _sardine;
  Ingredient _sausage;
  Ingredient _shrimp;
  Ingredient _tuna;
  Ingredient _eggs;
  Ingredient _noodles;
  Ingredient _rice;
  Ingredient _tofu;

  List<Ingredient> commonFruits;
  List<Ingredient> commonVegetables;
  List<Ingredient> commonMeatAndSeafood;
  List<Ingredient> commonOtherIngredient;

  CommonIngredient() {
    _apple = Ingredient(
        name: 'Apple',
        quantity: "1",
        shelfLife: 56,
        imageUrl:
            "https://pbs.twimg.com/media/EX6OH8QXgAMeBkB?format=png&name=small");

    _banana = Ingredient(
        name: 'Banana',
        quantity: "1",
        shelfLife: 4,
        imageUrl:
            "https://cdn.mos.cms.futurecdn.net/42E9as7NaTaAi4A6JcuFwG-970-80.jpg.webp");

    _blackberry = Ingredient(
        name: 'Blackberry',
        quantity: "1",
        shelfLife: 3,
        imageUrl:
            "https://backyardberryplants.com/wp-content/uploads/2018/09/TripleCrown.jpg");

    _blueberry = Ingredient(
        name: 'Blueberry',
        quantity: "1",
        shelfLife: 5,
        imageUrl:
            "https://www.aces.edu/wp-content/uploads/2018/08/shutterstock_637387888-blueberries.jpg");

    _cherry = Ingredient(
        name: 'Cherry',
        quantity: "1",
        shelfLife: 5,
        imageUrl:
            "https://www.freshfruitportal.com/assets/uploads/2017/08/cerezas_53336629-1024x683.jpg");

    _grape = Ingredient(
        name: 'Grape',
        quantity: "1",
        shelfLife: 7,
        imageUrl:
            "https://images.ctfassets.net/cnu0m8re1exe/6uSVPiUx1FloQ23j38x2aM/0eafe5c0d6b3ce7e3aae6b389a997423/Grapes.jpg?w=650&h=433&fit=fill");

    _grapefruit = Ingredient(
        name: 'Grapefruit',
        quantity: "1",
        shelfLife: 42,
        imageUrl:
            "https://www.usnews.com/dims4/USNEWS/4f50f38/2147483647/resize/1200x%3E/quality/85/?url=http%3A%2F%2Fmedia.beam.usnews.com%2Fbb%2F3c%2Fc76be92d4b84aaab13584f1197c6%2Fgrapefruit.jpg");

    _kiwi = Ingredient(
        name: 'Kiwi',
        quantity: "1",
        shelfLife: 7,
        imageUrl:
            "https://images.immediate.co.uk/production/volatile/sites/30/2020/02/Kiwi-fruits-582a07b.jpg?quality=90&resize=661%2C600");

    _orange = Ingredient(
        name: 'Orange',
        quantity: "1",
        shelfLife: 10,
        imageUrl:
            "https://i.pinimg.com/736x/05/79/5a/05795a16b647118ffb6629390e995adb.jpg");

    _peach = Ingredient(
        name: 'Peach',
        quantity: "1",
        shelfLife: 5,
        imageUrl:
            "https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5f42b5182138dffac9bf05b7%2F0x0.jpg%3FcropX1%3D549%26cropX2%3D8140%26cropY1%3D0%26cropY2%3D5693");

    _pear = Ingredient(
        name: 'Pear',
        quantity: "1",
        shelfLife: 3,
        imageUrl:
            "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2012/11/27/0/HEW_Pears_s4x3.jpg.rend.hgtvcom.616.462.suffix/1371612039080.jpeg");

    _pineapple = Ingredient(
        name: 'Pineapple',
        quantity: "1",
        shelfLife: 5,
        imageUrl:
            "https://images-na.ssl-images-amazon.com/images/I/71bNsWlkyeL._AC_SX522_.jpg");

    _plum = Ingredient(
        name: 'Plum',
        quantity: "1",
        shelfLife: 5,
        imageUrl:
            "https://www.healthbenefitstimes.com/9/uploads/2012/10/Health-benefits-of-Plums-1.png");

    _raisins = Ingredient(
        name: 'Raisins',
        quantity: "1",
        shelfLife: 365,
        imageUrl:
            "https://i2.wp.com/nypost.com/wp-content/uploads/sites/2/2020/03/raisins-04.jpg?quality=80&strip=all&ssl=1");

    _raspberry = Ingredient(
        name: 'Raspberry',
        quantity: "1",
        shelfLife: 2,
        imageUrl:
            "https://cdn11.bigcommerce.com/s-7ktwhbi/images/stencil/2048x2048/products/87/272/Raspberry__69627.1399585740.jpg?c=2");

    _strawberry = Ingredient(
        name: 'Strawberry',
        quantity: "1",
        shelfLife: 5,
        imageUrl:
            "https://s30386.pcdn.co/wp-content/uploads/2019/08/Strawberries_HNL1306_ts104880701.jpg");

    _tangerine = Ingredient(
        name: 'Tangerine',
        quantity: "1",
        shelfLife: 14,
        imageUrl:
            "https://post.healthline.com/wp-content/uploads/2020/08/difference-between-tangerines-oranges-thumb.jpg");

    _watermelon = Ingredient(
        name: 'Watermelon',
        quantity: "1",
        shelfLife: 14,
        imageUrl:
            "https://i0.wp.com/www.eatthis.com/wp-content/uploads/2020/08/watermelon.jpg?fit=1200%2C879&ssl=1");

    commonFruits = List.from([
      _apple,
      _banana,
      _blackberry,
      _blueberry,
      _cherry,
      _grape,
      _grapefruit,
      _kiwi,
      _orange,
      _peach,
      _pear,
      _pineapple,
      _plum,
      _raisins,
      _raspberry,
      _strawberry,
      _tangerine,
      _watermelon
    ]);

    _asparagus = Ingredient(
        name: 'Asparagus',
        quantity: "1",
        shelfLife: 3,
        imageUrl:
            "https://media1.s-nbcnews.com/i/newscms/2020_06/3219151/how-to-make-roasted-asparagus-355-1200x800_2cdbbbe84008d453548f4e0775b5861c.jpg");

    _avocado = Ingredient(
        name: 'Avocado',
        quantity: "1",
        shelfLife: 3,
        imageUrl:
            "https://static.toiimg.com/thumb/msid-66866002,width-800,height-600,resizemode-75,imgsize-1441960/66866002.jpg");

    _beans = Ingredient(
        name: 'Beans',
        quantity: "1",
        shelfLife: 3,
        imageUrl:
            "https://www.jessicagavin.com/wp-content/uploads/2020/05/types-of-beans-1200.jpg");

    _broccoli = Ingredient(
        name: 'Broccoli',
        quantity: "1",
        shelfLife: 4,
        imageUrl:
            "https://www.cookforyourlife.org/wp-content/uploads/2018/08/shutterstock_294838064-min.jpg");

    _cabbage = Ingredient(
        name: 'Cabbage',
        quantity: "1",
        shelfLife: 30,
        imageUrl: "https://images.heb.com/is/image/HEBGrocery/000374791");

    _carrot = Ingredient(
        name: 'Carrot',
        quantity: "1",
        shelfLife: 90,
        imageUrl:
            "https://www.jessicagavin.com/wp-content/uploads/2019/02/carrots-7-1200.jpg");

    _cauliflower = Ingredient(
        name: 'Cauliflower',
        quantity: "1",
        shelfLife: 14,
        imageUrl:
            "https://www.yummytoddlerfood.com/wp-content/uploads/2019/02/cauliflower.jpg");

    _celery = Ingredient(
        name: 'Celery',
        quantity: "1",
        shelfLife: 14,
        imageUrl:
            "https://www.welcometothetable.coop/sites/default/files/styles/amp_metadata_content_image_min_696px_wide/public/wp-content/uploads/2011/06/Celery_0.jpg?itok=0J5T9aZB");

    _cucumber = Ingredient(
        name: 'Cucumber',
        quantity: "1",
        shelfLife: 7,
        imageUrl:
            "https://cdn.mos.cms.futurecdn.net/EBEXFvqez44hySrWqNs3CZ.jpg");

    _eggplant = Ingredient(
        name: 'Eggplant',
        quantity: "1",
        shelfLife: 5,
        imageUrl:
            "https://www.tasteofhome.com/wp-content/uploads/2019/07/Chinese-eggplant-shutterstock_2033421.jpg");

    _garlic = Ingredient(
        name: 'Garlic',
        quantity: "1",
        shelfLife: 21,
        imageUrl:
            "https://i.insider.com/5f73ab9a0ab50d00184ad298?width=1136&format=jpeg");

    _ginger = Ingredient(
        name: 'Ginger',
        quantity: "1",
        shelfLife: 21,
        imageUrl:
            "https://www.thespruceeats.com/thmb/QxqFC_PtR8hR7I9-tsCB3S9b7R8=/2128x1409/filters:fill(auto,1)/GettyImages-116360266-57fa9c005f9b586c357e92cd.jpg");

    _leek = Ingredient(
        name: 'Leek',
        quantity: "1",
        shelfLife: 14,
        imageUrl:
            "https://www.historic-uk.com/wp-content/uploads/2017/11/basket-leeks.jpg");

    _lettuce = Ingredient(
        name: 'Lettuce',
        quantity: "1",
        shelfLife: 7,
        imageUrl:
            "https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/03/romaine-lettuce-1296x728-body.jpg?w=1155&h=1528");

    _mushrooms = Ingredient(
        name: 'Mushroom',
        quantity: "1",
        shelfLife: 10,
        imageUrl:
            "https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/278858_2200-732x549.jpg");

    _olive = Ingredient(
        name: 'Olive',
        quantity: "1",
        shelfLife: 365,
        imageUrl:
            "https://www.thespruceeats.com/thmb/7JCmh1Ec7JiRDbl9Jm55bjLJtkE=/1976x1111/smart/filters:no_upscale()/greenolives-5a85e5dfa18d9e0037a56ce5.jpg");

    _onion = Ingredient(
        name: 'Onion',
        quantity: "1",
        shelfLife: 14,
        imageUrl:
            "https://images-na.ssl-images-amazon.com/images/I/81UeYuulNjL._SX466_.jpg");

    _peas = Ingredient(
        name: 'Peas',
        quantity: "1",
        shelfLife: 2,
        imageUrl:
            "https://assets.tmecosys.com/image/upload/t_web767x639/img/recipe/ras/Assets/b09aa6c8-cfcb-4423-b2c9-e5abb6070312/Derivates/deb92468-6554-4de4-b141-b4318958d1d4.jpg");

    _potato = Ingredient(
        name: 'Potato',
        quantity: "1",
        shelfLife: 21,
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/are-potatoes-healthy-1570222022.jpg?crop=1.00xw:0.752xh;0.00160xw,0.248xh&resize=1200:*");

    _pumpkin = Ingredient(
        name: 'Pumpkin',
        quantity: "1",
        shelfLife: 365,
        imageUrl:
            "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/facts-about-pumpkins-1534518871.jpg");

    _spinach = Ingredient(
        name: 'Spinach',
        quantity: "1",
        shelfLife: 5,
        imageUrl:
            "https://www.farmflavor.com/wp-content/uploads/2020/05/iStock-916931074-2-scaled.jpg");

    _springOnion = Ingredient(
        name: 'Spring Onion',
        quantity: "1",
        shelfLife: 14,
        imageUrl:
            "https://static.toiimg.com/thumb/msid-75736189,width-1200,height-900,imgsize-327934/75736189.jpg");

    _squash = Ingredient(
        name: 'Squash',
        quantity: "1",
        shelfLife: 30,
        imageUrl:
            "https://imagesvc.meredithcorp.io/v3/mm/image?q=85&c=sc&poi=face&w=2000&h=1047&url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F43%2F2020%2F04%2F06%2FGettyImages-187102725-2000.jpg");

    _sweetCorn = Ingredient(
        name: 'Sweet Corn',
        quantity: "1",
        shelfLife: 300,
        imageUrl:
            "https://www.thegunnysack.com/wp-content/uploads/2018/06/Boiled-Corn-On-The-Cob-Recipe-720x540.jpg");

    _sweetPotato = Ingredient(
        name: 'Sweet Potato',
        quantity: "1",
        shelfLife: 60,
        imageUrl:
            "https://upload.wikimedia.org/wikipedia/commons/5/58/Ipomoea_batatas_006.JPG");

    _tomato = Ingredient(
        name: 'Tomato',
        quantity: "1",
        shelfLife: 14,
        imageUrl:
            "https://post.healthline.com/wp-content/uploads/2020/09/tomatoes-1200x628-facebook-1200x628.jpg");

    commonVegetables = List.from([
      _asparagus,
      _avocado,
      _beans,
      _broccoli,
      _cabbage,
      _carrot,
      _cauliflower,
      _celery,
      _cucumber,
      _eggplant,
      _spinach,
      _garlic,
      _ginger,
      _leek,
      _lettuce,
      _mushrooms,
      _olive,
      _onion,
      _peas,
      _potato,
      _pumpkin,
      _springOnion,
      _squash,
      _sweetCorn,
      _sweetPotato,
      _tomato
    ]);

    _bacon = Ingredient(
        name: 'Bacon',
        quantity: "1",
        shelfLife: 240,
        imageUrl: "https://i.ytimg.com/vi/yjDpBnPuCnM/maxresdefault.jpg");

    _beef = Ingredient(
        name: 'Beef',
        quantity: "1",
        shelfLife: 90,
        imageUrl:
            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Rostas_%28ready_and_served%29.JPG/1200px-Rostas_%28ready_and_served%29.JPG");

    _caviar = Ingredient(
        name: 'Caviar',
        quantity: "1",
        shelfLife: 5,
        imageUrl:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYVajJ7Tm6D2BAsFVDczYRU9Pua_T7_uq83w&usqp=CAU");

    _chicken = Ingredient(
        name: 'Chicken',
        quantity: "1",
        shelfLife: 90,
        imageUrl:
            "https://www.maangchi.com/wp-content/uploads/2018/02/roasted-chicken-1.jpg");

    _cod = Ingredient(
        name: 'Cod',
        quantity: "1",
        shelfLife: 200,
        imageUrl:
            "https://cdn.shopify.com/s/files/1/0126/6076/8825/products/93cef06809c59c109aa02e3a480ab330_2700x.jpg?v=1539826157");

    _duckMeat = Ingredient(
        name: 'Duck Meat',
        quantity: "1",
        shelfLife: 60,
        imageUrl:
            "https://images-gmi-pmc.edge-generalmills.com/a161bab7-e468-4591-9717-1129814f5d4a.jpg");

    _eel = Ingredient(
        name: 'Eel',
        quantity: "1",
        shelfLife: 180,
        imageUrl:
            "https://images.japancentre.com/recipes/pics/1434/main/unagidon-edited.jpg?1469573896");

    _ham = Ingredient(
        name: 'Ham',
        quantity: "1",
        shelfLife: 180,
        imageUrl:
            "https://food.fnr.sndimg.com/content/dam/images/food/fullset/2015/8/14/0/WU1104H_Honey-Glazed-Ham_s4x3.jpg.rend.hgtvcom.616.462.suffix/1439583024885.jpeg");

    _lamb = Ingredient(
        name: 'Lamb',
        quantity: "1",
        shelfLife: 180,
        imageUrl:
            "https://img.apmcdn.org/ca50983f9e3aa3a807e3d33629b3ba9ba2d5bc6d/uncropped/ba80ff-splendid-table-redrubbedbabylambchops-lede.jpg");

    _pork = Ingredient(
        name: 'Pork',
        quantity: "1",
        shelfLife: 120,
        imageUrl:
            "https://justcook.butcherbox.com/wp-content/uploads/2019/06/Boneless-Porkchops-800x500.jpg");

    _salmon = Ingredient(
        name: 'Salmon',
        quantity: "1",
        shelfLife: 60,
        imageUrl:
            "https://www.onceuponachef.com/images/2018/02/pan-seared-salmon--1200x988.jpg");

    _sardine = Ingredient(
        name: 'Sardine',
        quantity: "1",
        shelfLife: 1400,
        imageUrl:
            "https://image.made-in-china.com/2f0j00uniEUtIPJNqk/Canned-Sardine-in-Oil-425g-235g-Cylinder-Can-Canned-Fish-Manufacturer.jpg");

    _sausage = Ingredient(
        name: 'Sausage',
        quantity: "1",
        shelfLife: 30,
        imageUrl:
            "https://www.southsidemarket.com/wp-content/uploads/2017/07/HeroFinal-36.jpg");

    _shrimp = Ingredient(
        name: 'Shrimp',
        quantity: "1",
        shelfLife: 540,
        imageUrl:
            "https://images-prod.healthline.com/hlcmsresource/images/AN_images/shrimp-on-wooden-platter-1296x728.jpg");

    _tuna = Ingredient(
        name: 'Tuna',
        quantity: "1",
        shelfLife: 270,
        imageUrl:
            "https://cdn.shopify.com/s/files/1/0280/3011/products/IMG_7587_2048x.jpg?v=1529541706");

    commonMeatAndSeafood = List.from([
      _bacon,
      _beef,
      _caviar,
      _chicken,
      _cod,
      _duckMeat,
      _eel,
      _ham,
      _lamb,
      _pork,
      _salmon,
      _sardine,
      _sausage,
      _shrimp,
      _tuna
    ]);

    _eggs = Ingredient(
        name: 'Eggs',
        quantity: "1",
        shelfLife: 35,
        imageUrl:
            "https://images-prod.healthline.com/hlcmsresource/images/AN_images/health-benefits-of-eggs-1296x728-feature.jpg");

    _noodles = Ingredient(
        name: 'Noodles',
        quantity: "1",
        shelfLife: 5,
        imageUrl:
            "https://www.seriouseats.com/2019/09/20190530-ramen-noodles-vicky-wasik-76-1500x1125.jpg");

    _rice = Ingredient(
        name: 'Rice',
        quantity: "1",
        shelfLife: 1400,
        imageUrl:
            "https://i.guim.co.uk/img/media/fe11954af9f0feb91e8c975620a98a09f80e3490/0_187_5616_3370/master/5616.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=e63d2edc6117fa7d8ac79dd0a1ab0153");

    _tofu = Ingredient(
        name: 'Tofu',
        quantity: "1",
        shelfLife: 5,
        imageUrl:
            "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/the-health-benefits-of-tofu-700-350-1550d79.jpg?quality=90&resize=960,872");

    commonOtherIngredient = List.from([
      _eggs,
      _noodles,
      _rice,
      _tofu,
    ]);
  }
}
