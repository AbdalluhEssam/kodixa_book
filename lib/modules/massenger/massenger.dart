import 'package:flutter/material.dart';

class Messenger extends StatelessWidget {
  const Messenger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                  "https://scontent.fcai19-7.fna.fbcdn.net/v/t1.6435-9/190275793_1221501371602072_365983569261749206_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=e3f864&_nc_ohc=nUNBZ-3w4akAX8GzuHe&_nc_ht=scontent.fcai19-7.fna&oh=00_AfBheaidvf5rcZzIdY3zPIw_fpLVZLSMYe_WfFFqyOTCFA&oe=64B2C691"),
            ),
            const SizedBox(
              width: 8,
            ),
            const Text("Chats"),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.camera_alt,
                  size: 18,
                  color: Colors.black,
                ),
              )),
          IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.edit,
                  size: 18,
                  color: Colors.black,
                ),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    hintText: "Search",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)))),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, index) => SizedBox(
                    width: 60,
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: const [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  "https://scontent.fcai19-7.fna.fbcdn.net/v/t1.6435-9/190275793_1221501371602072_365983569261749206_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=e3f864&_nc_ohc=nUNBZ-3w4akAX8GzuHe&_nc_ht=scontent.fcai19-7.fna&oh=00_AfBheaidvf5rcZzIdY3zPIw_fpLVZLSMYe_WfFFqyOTCFA&oe=64B2C691"),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.only(bottom: 3, end: 3),
                              child: CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.red,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Abdalluh Essam",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 8,
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              ListView.separated(
                itemCount: 30,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Row(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: const [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              "https://scontent.fcai19-7.fna.fbcdn.net/v/t1.6435-9/190275793_1221501371602072_365983569261749206_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=e3f864&_nc_ohc=nUNBZ-3w4akAX8GzuHe&_nc_ht=scontent.fcai19-7.fna&oh=00_AfBheaidvf5rcZzIdY3zPIw_fpLVZLSMYe_WfFFqyOTCFA&oe=64B2C691"),
                        ),
                        Padding(
                          padding:
                              EdgeInsetsDirectional.only(bottom: 3, end: 3),
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.red,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Abdalluh Essam ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  "Hello my name is abdalluh essam  Hello my name is abdalluh essam m  ",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Row(children: [
                                Container(
                                  width: 7,
                                  height: 7,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text("02:00 pm")
                              ])
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  height: 8,
                ),
              ),
            ],
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //     margin:
      //         const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      //     child: Wrap(
      //       children: [
      //         SizedBox(
      //           height: 40,
      //           child: TextFormField(
      //             decoration: const InputDecoration(
      //                 prefixIcon: Icon(Icons.search),
      //                 hintText: "Search",
      //                 border: OutlineInputBorder(
      //                     borderRadius:
      //                         BorderRadius.all(Radius.circular(50)))),
      //           ),
      //         ),
      //         const SizedBox(
      //           height: 30,
      //         ),
      //         SizedBox(
      //           height: 100,
      //           child: ListView.separated(
      //             itemCount: 10,
      //             scrollDirection: Axis.horizontal,
      //             shrinkWrap: true,
      //             itemBuilder: (context, index) => Column(
      //               children: [
      //                 Container(
      //                   height: 70,
      //                   width: 70,
      //                   clipBehavior: Clip.antiAliasWithSaveLayer,
      //                   decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(100)),
      //                   child: Image.network(
      //                       "https://scontent.fcai19-7.fna.fbcdn.net/v/t1.6435-9/190275793_1221501371602072_365983569261749206_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=e3f864&_nc_ohc=nUNBZ-3w4akAX8GzuHe&_nc_ht=scontent.fcai19-7.fna&oh=00_AfBheaidvf5rcZzIdY3zPIw_fpLVZLSMYe_WfFFqyOTCFA&oe=64B2C691"),
      //                 ),
      //                 const SizedBox(
      //                   height: 8,
      //                 ),
      //                 const Text("Abdalluh Essam")
      //               ],
      //             ),
      //             separatorBuilder: (BuildContext context, int index) {
      //               return const SizedBox(width: 8);
      //             },
      //           ),
      //         ),
      //         ListView.builder(
      //           itemCount: 20,
      //           physics: const NeverScrollableScrollPhysics(),
      //           shrinkWrap: true,
      //           itemBuilder: (context, index) => Row(
      //             children: [
      //               CircleAvatar(
      //                 height: 70,
      //                 width: 70,
      //                 clipBehavior: Clip.antiAliasWithSaveLayer,
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(100)),
      //                 child: Image.network(
      //                     "https://scontent.fcai19-7.fna.fbcdn.net/v/t1.6435-9/190275793_1221501371602072_365983569261749206_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=e3f864&_nc_ohc=nUNBZ-3w4akAX8GzuHe&_nc_ht=scontent.fcai19-7.fna&oh=00_AfBheaidvf5rcZzIdY3zPIw_fpLVZLSMYe_WfFFqyOTCFA&oe=64B2C691"),
      //               ),
      //               const SizedBox(
      //                 width: 20,
      //               ),
      //               const Text("Abdalluh Essam")
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // )
    );
  }
}
