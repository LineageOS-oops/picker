# /bin/bash
if [ "$#" -lt 1 ]; then
    echo "You must define only path to root of lineageos sources as first argument."
    exit 1
fi

LOS_ROOT=$1
echo "Path to root of lineageos sources: $LOS_ROOT"
echo ""

# Additional
CHERRYPICK_FLAGS="--no-commit"

# Repositories
fw_base="git@github.com:LineageOS-oops/android_frameworks_base.git"
fw_av="git@github.com:LineageOS-oops/android_frameworks_av.git"
system_core="git@github.com:LineageOS-oops/android_system_core.git"
build_make="git@github.com:LineageOS-oops/android_build.git"

# fw_base
cd $LOS_ROOT/frameworks/base
git fetch $fw_base --depth 10
git cherry-pick c960f627761f84f052ed724a98a12ab712d92681^..a04cfbe8fcf02946726c52c0b5a51906a5919dc6 $CHERRYPICK_FLAGS

# fw_av
cd $LOS_ROOT/frameworks/av
git fetch $fw_av --depth=2
git cherry-pick ca7046d20642d0391cb6d97f81d857e1eeaa5567 $CHERRYPICK_FLAGS

# system_core
cd $LOS_ROOT/system/core
git fetch $system_core --depth=3
git cherry-pick d8937c895531918159b5b6a7dbdd87e8c78a2269^..cf519bfea29ed26c4c2b25da5013f59cc6d10c4c $CHERRYPICK_FLAGS

# build_make
cd $LOS_ROOT/build/make
git fetch $build_make --depth=6
git cherry-pick c5188a1269cb76f4d1d00ee26a44db17bac6ca88^..a24618f78890ac8133adb5be19502e999b0ab56f $CHERRYPICK_FLAGS

exit 0
