import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/features/home/data/datasources/repository_local_data_source.dart';
import 'package:flutter_task/features/home/data/datasources/repository_remote_data_source.dart';
import 'package:flutter_task/features/home/data/repositories/repository_repository_impl.dart';
import 'package:flutter_task/features/home/domain/entities/repository.dart';
import 'package:flutter_task/features/home/domain/usecases/fetch_repositories.dart';
import 'package:flutter_task/features/home/presentation/controller/cubit/repository_cubit.dart';
import 'package:flutter_task/features/home/presentation/views/home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(RepositoryAdapter());
  final repositoryBox = await Hive.openBox<Repository>('repositoryBox');
  final repositoryLocalDataSource = RepositoryLocalDataSourceImpl(repositoryBox);
  final repositoryRemoteDataSource = RepositoryRemoteDataSourceImpl();
  final repositoryRepository = RepositoryRepositoryImpl(
    remoteDataSource: repositoryRemoteDataSource,
     localDataSource: repositoryLocalDataSource);
  final fetchRepositories = FetchRepositories(repositoryRepository);
  runApp( MyApp(fetchRepositories: fetchRepositories,));
}

class MyApp extends StatelessWidget {
   final FetchRepositories fetchRepositories;
  const MyApp({super.key, required this.fetchRepositories});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
         colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.green,
      ), 
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context)=> RepositoryCubit(fetchRepositories: fetchRepositories),
        child: const HomeView()),
    );
  }
}

