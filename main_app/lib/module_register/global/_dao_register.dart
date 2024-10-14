part of 'global_module.dart';

void registerDao() {

  DIContainer.container.registerFactory<IMultimediaDao>(
    (container) => MultimediaDao(
      container.resolve<WSADatabase>(),
    ),
  );

  DIContainer.container.registerFactory<IPlotDao>(
    (container) => PlotDao(
      container.resolve<WSADatabase>(),
    ),
  );

  DIContainer.container.registerFactory<IAssetDao>(
    (container) => AssetDao(
      container.resolve<WSADatabase>(),
    ),
  );

  DIContainer.container.registerFactory<IMediaDao>(
        (container) => MediaDao(
      container.resolve<WSADatabase>(),
    ),
  );

  DIContainer.container.registerFactory<IMultimediaMappingDao>(
    (container) => MultimediaMappingDao(
      container.resolve<WSADatabase>(),
    ),
  );

  DIContainer.container.registerFactory<IContentConfigDao>(
    (container) => ContentConfigDao(
      container.resolve<WSADatabase>(),
    ),
  );
}
