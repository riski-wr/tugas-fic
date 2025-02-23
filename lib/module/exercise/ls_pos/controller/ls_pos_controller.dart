import 'package:example/core.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';

class LsPosController extends State<LsPosView> implements MvcController {
  static late LsPosController instance;
  late LsPosView view;

  @override
  void initState() {
    instance = this;
    loadProductList();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  bool ready = false;
  List productList = [];
  Faker faker = Faker.instance;
  loadProductList() async {
    ready = true;
    productList = mainStorage.get("products") ?? [];
    setState(() {});

    /*
    TODO: --
    1. Ok, baca storage "products" dan masukkan ke dalam List
    ###
    productList = mainStorage.get("products") ?? [];
    ###

    2. Panggil setState setelah-nya!

    3. Tutup View-nya dan kembali lagi, Apakah kamu punya beberapa product?
    Jika belum tambahkan di ProductCRUD (tasks sebelumnya)
    Cukup tambahkan 5 saja
    */
  }

  increaseQty(item) {
    item["qty"]++;
    setState(() {});
    /*
    4. Tambahkan qty dari item dengan klik tombol add
    gunakan kode ini:
    ###
    item["qty"]++;
    setState(() {});
    ###
    */
  }

  decreaseQty(item) {
    if (item["qty"] == 0) return;
    item["qty"]--;
    setState(() {});
    /*
    5. Kurangi qty dari item, dengan klik tombol minus
    gunakan kode ini:
    ###
    if (item["qty"] == 0) return;
    item["qty"]--;
    setState(() {});
    ###
    */
  }

  double get total {
    var itemTotal = 0.0;

    for (var i = 0; i < productList.length; i++) {
      var product = productList[i];
      print(product);
      itemTotal += product["qty"] * product["price"];
    }

    /*
    6. Yuk hitung total product-nya,
    Gunakan looping seperti dibawah ini:
    ###
    for (var i = 0; i < productList.length; i++) {
      var product = productList[i];
      itemTotal += product["qty"] * product["price"];
    }
    ###
    */
    return itemTotal;
  }

  emptyCart() {
    for (var i = 0; i < productList.length; i++) {
      var product = productList[i];
      product["qty"] = 0;
    }
  }

  checkout() async {

    Map order = {
      "created_at": DateTime.now(),
      "customer": "-",
      "payment_method": "Cash",
      "total": total,
      "items": productList,
    };

    List orders = await mainStorage.get("orders") ?? [];
    orders.add(order);
    mainStorage.put("orders", orders);

    /*
    7. Yuk kita checkout pos-nya dengan konsep master-detail
    Kita akan perlu sebuah Map, yang akan berisi detail order
    dan detail items yang dibeli,
    Buat map ini:
    ###
    Map order = {
      "created_at": DateTime.now(),
      "customer": "-",
      "payment_method": "Cash",
      "total": total,
      "items": productList,
    };
    ###

    8. Nice, selanjutnya kita akan menambahkan order-nya
    ke dalam orders storage. 
    Gunakan kode ini:
    ###
    List orders = await mainStorage.get("orders") ?? [];
    orders.add(order);
    mainStorage.put("orders", orders);
    ###

    9. Silahkan test, tekan tombol plus beberapa kali untuk beberapa item
    Lalu klik checkout, jika alert Your Order is Complete muncul,
    Maka task kamu sudah selesai!
    */

    emptyCart();
    await showInfoDialog("Your order is complete!");
    Get.back();
  }
}
