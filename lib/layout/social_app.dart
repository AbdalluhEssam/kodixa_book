import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kodixa_book/layout/cubit/cubit.dart';
import 'package:kodixa_book/layout/cubit/states.dart';
import 'package:kodixa_book/modules/new_posts/new_posts.dart';
import 'package:kodixa_book/shared/components/components.dart';
import 'package:kodixa_book/shared/styles/icon_broken.dart';

class SocialAppLayout extends StatelessWidget {
  const SocialAppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostState){
          navigateTo(context, const NewPostsScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 5,
            title:  Row(
              children: [
                Image.asset("assets/images/bookSmall.png",height: 45, fit: BoxFit.cover,),
                const SizedBox(width: 8,),
                Text(cubit.title[cubit.currentIndex])
              ],
            ),
            actions: [
              IconButton(onPressed: (){}, icon: const Icon(IconBroken.Notification)),
              IconButton(onPressed: (){}, icon: const Icon(IconBroken.Search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              navigateTo(context, const NewPostsScreen());
            }, child:   const Icon(IconBroken.Paper_Upload),),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,

          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: 'Chat'),
                BottomNavigationBarItem(icon: SizedBox(height: 25,), label: 'Post'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Location), label: 'Users'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Profile), label: 'Profile'),
              ]),
        );
      },
    );
  }
}
