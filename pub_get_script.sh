#!/usr/bin/env bash

printf "sonoair pub get\n"
flutter clean && flutter clean cache && flutter pub get
printf '\n\n'

printf "core pub get\n"
cd core || exit
flutter clean && flutter clean cache && flutter pub get
cd ..
printf '\n\n'

printf "core_ui pub get\n"
cd core_ui || exit
flutter clean && flutter clean cache && flutter pub get
cd ..
printf '\n\n'

printf "data pub get\n"
cd data || exit
flutter clean && flutter clean cache && flutter pub get
cd ..
printf '\n\n'

printf "domain pub get\n"
cd domain || exit
flutter clean && flutter clean cache && flutter pub get
cd ..
printf '\n\n'

printf "home pub get\n"
cd features/home || exit
flutter clean && flutter clean cache && flutter pub get
cd ../..
printf '\n\n'


printf "add inhaler pub get\n"
cd features/add_inhaler || exit
flutter clean && flutter clean cache && flutter pub get
cd ../..
printf '\n\n'

printf "auth pub get\n"
cd features/auth || exit
flutter clean && flutter clean cache && flutter pub get
cd ../..
printf '\n\n'

printf "take dose pub get\n"
cd features/take_dose || exit
flutter clean && flutter clean cache && flutter pub get
cd ../..
printf '\n\n'

printf "take dose pub get\n"
cd features/take_dose || exit
flutter clean && flutter clean cache && flutter pub get
cd ../..
printf '\n\n'