// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// GetItInjectorGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:_typedef/repos/legend_of_zelda_repo.dart'
    as i_legend_of_zelda_repo;

extension GetItX on GetIt {
  void init() {
    registerFactory(() => i_legend_of_zelda_repo.LegendOfZeldaRepo.new());
    registerFactory(
      () => i_legend_of_zelda_repo.LegendOfZeldaRepoConsumer.new(
        legendOfZeldaRepoFactory:
            get<i_legend_of_zelda_repo.LegendOfZeldaRepoFactory>(),
      ),
    );
  }
}
