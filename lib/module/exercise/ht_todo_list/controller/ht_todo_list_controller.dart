import 'package:example/config.dart';
import 'package:example/core.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';

class HtTodoListController extends State<HtTodoListView>
    implements MvcController {
  static late HtTodoListController instance;
  late HtTodoListView view;

  @override
  void initState() {
    instance = this;
    loadTodoList();
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  List todoList = [];
  loadTodoList() async {

    var response = await Dio().get(
      "${AppConfig.baseUrl}/todos",
    );

    var obj = response.data;
    todoList = obj["data"];
    print(obj);
    setState(() {});

    /*
    TODO: --
    1. Buat sebuah get request menggunakan DIO
    ! snippet: dio_get

    @GET
    @URL
   "${AppConfig.baseUrl}/todos",

    2. Masukkan response data ke dalam todoList,
    ###
    todoList = obj["data"];
    ###

    3. Panggil setState setelah-nya, lanjut ke point 4
    */
  }

  addTodo() async {
    showLoading();
    var faker = Faker.instance;

    var data = {
      "todo": faker.lorem.sentence(),
      "done": false,
    };
    print(data);
    var response = await Dio().post(
      "${AppConfig.baseUrl}/todos",
      data: data,
    );

    print(response.statusCode);

    await loadTodoList();
    hideLoading();

    /*
    TODO: --
    4. Buat sebuah get request menggunakan DIO
    ! snippet: dio_post

    @POST
    @URL
   "${AppConfig.baseUrl}/todos",

    @DATA
    data: {
      "todo": faker.lorem.sentence(),
      "done": false,
    },

    5. Panggil kode ini setelah-nya:
    ###
    await loadTodoList();
    hideLoading();
    ###
    */
  }

  deleteTodo(item) async {
    showLoading();
    print("Delete?");
    var id = item["id"];
    var response = await Dio().delete(
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
      "${AppConfig.baseUrl}/todos/$id",
    );
    await loadTodoList();
    hideLoading();

    /*
    TODO: --
    6. Buat sebuah delete request menggunakan DIO
    ! snippet: dio_delete

    @DELETE
    @URL
   "${AppConfig.baseUrl}/todos/$id",

    7. Atur nilai id, menjadi:
    var id = item["id"];

    8. Panggil kode ini di akhir function
    ###
    await loadTodoList();
    hideLoading();
    ###
    */
  }

  updateTodo(item) async {
    showLoading();
    var data = item;
    var id = item["id"];
    item["done"] = !item["done"];

    var response = Dio().post(
      "${AppConfig.baseUrl}/todos/$id",
      data: item,
    );

    await loadTodoList();
    hideLoading();
    /*
    TODO: --
    9. Buat sebuah post request menggunakan DIO
    ! snippet: dio_post

    @POST
    @URL
   "${AppConfig.baseUrl}/todos/$id",

    ! @DATA
    ! data: item,

    10. Atur nilai id, menjadi:
    var id = item["id"];

    11. Atur nilai key "done" menjadi:
    item["done"] = !item["done"];

    12. Panggil kode ini di akhir function
    ###
    await loadTodoList();
    hideLoading();
    ###

    13. YUk, test klik tombol add, apakah todo bertambah?
    14. Ceklis salah satu todo, apakah itu berubah?
    15. Test menghapus todo, klik tombol silang. Apakah todo-nya hilang?
    16. Jika ke tiga point di atas bekerja, tasks ini selesai!
    */
  }

  deleteAll() async {
    showLoading();
    var response = await Dio().delete(
      "${AppConfig.baseUrl}/todos/action/delete-all",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    print(response.statusCode);

    await loadTodoList();
    hideLoading();
  }
}
