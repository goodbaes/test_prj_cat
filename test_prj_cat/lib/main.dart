import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_prj_cat/bloc/bloc.dart';
import 'package:test_prj_cat/repositories/cat_api_client.dart';
import 'package:test_prj_cat/simple_bloc_observer.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (context) => CatBloc(),
          child: MyHomePage(),
        ));
  }
}

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  var b;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
      future: CatApiClient().getImgUrl(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Image.memory(snapshot.data);
      },
    ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    BlocProvider.of<CatBloc>(context).add(CatRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('widget.title'),
      ),
      body: BlocBuilder<CatBloc, CatState>(builder: (context, state) {
        if (state is CatInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CatLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CatLoadSuccess) {
          return Center(
            child: Image.memory(state.catUrl),
          );
        }
        if (state is CatLoadFailure) {
          return Text('smth wrong');
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
