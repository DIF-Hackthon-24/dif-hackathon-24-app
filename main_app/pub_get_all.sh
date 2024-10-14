#!/bin/sh

(cd features/shared_dependencies && flutter pub get)
(cd features/data && flutter pub get)
(cd features/domain && flutter pub get)
(cd features/presentation && flutter pub get)
(flutter pub get)
