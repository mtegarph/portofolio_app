import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portofolio_app/features/detail/presentation/pages/detail_track_page.dart';
import 'package:portofolio_app/features/home/presentation/bloc/homepage_bloc.dart';
import 'package:portofolio_app/features/home/presentation/pages/add_item.dart';

class ShowItem extends StatelessWidget {
  const ShowItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<AddItem>(builder: (context) => const AddItem()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<HomepageBloc, HomepageState>(
        builder: (context, state) {
          if (state is HomepageLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomepageSuccess) {
            return _buildGridView(context, state);
          }
          if (state is HomepageFailure) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildGridView(BuildContext context, HomepageSuccess state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 100,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: state.rumahEntities.length,
        itemBuilder: (context, index) {
          return _buildGridItem(context, state, index);
        },
      ),
    );
  }

  Widget _buildGridItem(
      BuildContext context, HomepageSuccess state, int index) {
    return BlocBuilder<HomepageDataBloc, HomePageDataState>(
      builder: (context, stateData) {
        return GestureDetector(
          onLongPress: () {
            context.read<HomepageDataBloc>().add(
                  ShowDelete(showDelete: !stateData.showDelete),
                );
          },
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<DetailTrackPage>(
                  builder: (context) => DetailTrackPage(
                        rumah: state.rumahEntities[index],
                      )),
            );
          },
          child: Stack(
            fit: StackFit.passthrough,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(
                      state.rumahEntities[index].gambar,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Visibility(
                visible: stateData.showDelete,
                child: Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    onPressed: () {
                      context.read<HomepageBloc>().add(
                            DeleteTrackEvent(
                              id: state.rumahEntities[index].id,
                            ),
                          );
                      context.read<HomepageBloc>().add(
                            GetDataHomeEvent(),
                          );
                      context.read<HomepageDataBloc>().add(
                            ShowDelete(showDelete: !stateData.showDelete),
                          );
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 20,
                    ),
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
