import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            //stretch: _stretch,
            onStretchTrigger: () async {
              // Triggers when stretching
            },
            actions: [
              IconButton(icon: Icon(Icons.visibility_off), onPressed: () {}),
            ],
            // [stretchTriggerOffset] describes the amount of overscroll that must occur
            // to trigger [onStretchTrigger]
            //
            // Setting [stretchTriggerOffset] to a value of 300.0 will trigger
            // [onStretchTrigger] when the user has overscrolled by 300.0 pixels.
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Мои дела'),
              background: Container(color: Colors.blueAccent),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((
              BuildContext context,
              int index,
            ) {
              return ListTile(
                title: Text('Купить что-то #$index'),
                leading: Checkbox(value: false, onChanged: (bool? value) {}),
                trailing: IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {},
                ),
              );
            }, childCount: 20),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
