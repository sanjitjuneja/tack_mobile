#!/usr/bin/env bash

printf "tackapp pub get\n"
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

printf "auth pub get\n"
cd features/auth || exit
flutter clean && flutter clean cache && flutter pub get
cd ../..
printf '\n\n'

printf "phone_verification pub get\n"
cd features/phone_verification || exit
flutter clean && flutter clean cache && flutter pub get
cd ../..
printf '\n\n'

printf "user_info_setup pub get\n"
cd features/user_info_setup || exit
flutter clean && flutter clean cache && flutter pub get
cd ../..
printf '\n\n'
