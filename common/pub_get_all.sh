#!/bin/sh
(cd core/app-mobile-core/src && pwd && flutter pub get)
(cd core/app-mobile-core/src/example && pwd && flutter pub get)
(cd network_manager/app-mobile-networkmanager/src && pwd && flutter pub get)
(cd task_manager/app-mobile-taskmanager/src && pwd && flutter pub get)
(cd widgets/app-mobile-widgets/src && pwd && flutter pub get)
(cd widgets/app-mobile-widgets/src/example && pwd && flutter pub get)
(cd theme_font && pwd && flutter pub get)
