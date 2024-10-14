#!/bin/sh
(cd features/shared_dependencies && flutter clean)
(cd features/data && sh clean_all.sh)
(cd features/domain && sh clean_all.sh)
(cd features/presentation && sh clean_all.sh)

(flutter clean)
#(rm pubspec.lock)