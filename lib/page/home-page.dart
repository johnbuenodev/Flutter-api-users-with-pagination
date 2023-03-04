import 'dart:convert'; // json.decode
import 'package:app_http_users_with_pagination_infinite_scrolling/models/user.dart';
import 'package:app_http_users_with_pagination_infinite_scrolling/repository/user-repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  //const MyWidget({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  
  late UserRepository userRepository;
  final loading = ValueNotifier(true);

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infinitiScrolling);

    userRepository = UserRepository();
    loadUsers();
  }

  infinitiScrolling() {
    //verifica o pixel position e o maxScroll para saber se chegou ao final
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !loading.value) {
      loadUsers();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  loadUsers() async {
    loading.value = true;

    await userRepository.getUsers();

    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Users Paginação - Infinite Scrolling"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: userRepository,
          builder: (context, snapshot) {
            return Stack(
              children: [
                ListView.separated(
                  controller: _scrollController,
                  itemCount: userRepository.users.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: ((context, index) {
                    User user = userRepository.users[index];

                    return GestureDetector(
                      onTap: () {
                        print("oi");
                      },
                      child: Container(
                        margin: const EdgeInsets.all(12.0),
                        padding: const EdgeInsets.all(16),
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black54,
                            width: 2,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            user.cell!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          subtitle: Text(
                            user.email!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              color: Colors.black54,
                            ),
                          ),
                          leading: index < 9
                              ? Image.network(
                                  'https://randomuser.me/api/portraits/lego/' +
                                      index.toString() +
                                      '.jpg')
                              : Image.network(
                                  'https://randomuser.me/api/portraits/lego/1.jpg'),
                        ),
                      ),
                    );
                  }),
                ),
                loadingWidget(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget loadingWidget() {
    return ValueListenableBuilder(
        valueListenable: loading,
        builder: (context, bool isLoading, _) {
          return (isLoading)
              ? Positioned(
                  left: (MediaQuery.of(context).size.width / 2) - 20,
                  bottom: 32,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child:  CircleAvatar(
                      backgroundColor: Colors.transparent,//colors.green
                      child:  SizedBox(
                        height: 20,
                        width: 20,
                        child:  CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.green, //colors.white
                        ),
                      ),
                    ),
                  ),
                )
              : Container();
        });
  }
}
