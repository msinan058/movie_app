import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/base/base_state.dart';
import 'package:movie_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:movie_app/features/home/presentation/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> with AutomaticKeepAliveClientMixin {
  late PageController _pageController;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final homeState = context.read<HomeBloc>().state;
    final initialPage = homeState is HomeLoaded ? homeState.currentIndex : 0;
    _pageController = PageController(initialPage: initialPage);
    _pageController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<HomeBloc>().add(LoadMoreMovies());
    }
    
    if (_pageController.hasClients && _pageController.page != null) {
      context.read<HomeBloc>().add(
        UpdateScrollPosition(_pageController.page!.round()),
      );
    }
  }

  bool get _isBottom {
    if (!_pageController.hasClients) return false;
    final maxScroll = _pageController.position.maxScrollExtent;
    final currentScroll = _pageController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Future<void> _onRefresh() async {
    context.read<HomeBloc>().add(LoadMovies());
    // Wait for the state to be updated
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: theme.colorScheme.primary,
            ),
          );
        }

        if (state is HomeError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<HomeBloc>().add(LoadMovies()),
                  child: const Text('Tekrar Dene'),
                ),
              ],
            ),
          );
        }

        if (state is HomeLoaded) {
          return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _onRefresh,
            color: theme.colorScheme.primary,
            backgroundColor: theme.colorScheme.surface,
            displacement: 100,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.vertical,
                        physics: const ClampingScrollPhysics(),
                        padEnds: false,
                        itemCount: state.movies.length,
                        itemBuilder: (context, index) {
                          final movie = state.movies[index];
                          return MovieCard(
                            movie: movie,
                            height: MediaQuery.of(context).size.height - 
                                    MediaQuery.of(context).padding.top - 
                                    56, // Header height
                            index: index,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                if (state.isLoadingMore)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            theme.colorScheme.surface.withAlpha(0),
                            theme.colorScheme.surface.withAlpha((0.5 * 255).round()),
                          ],
                        ),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
} 