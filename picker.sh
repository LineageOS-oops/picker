# /bin/bash
if [ "$#" -lt 1 ]; then
    echo "You must define path to root of aospa sources as first argument."
    echo "You can use 'r' as second argument. It's disable cherry-pick (only restore)."
    exit 1
fi

SOURCE_ROOT=$1
echo "Path to root of aospa sources: $SOURCE_ROOT"
echo ""

# Additional
CHERRYPICK_FLAGS="--no-commit"

# Repositories
fw_base="git@github.com:LineageOS-oops/android_frameworks_base.git"
fw_av="git@github.com:LineageOS-oops/android_frameworks_av.git"
system_core="git@github.com:LineageOS-oops/android_system_core.git"
build_make="git@github.com:LineageOS-oops/android_build.git"
hw_interfaces="git@github.com:LineageOS-oops/android_hardware_interfaces.git"

# fw_base
cd $SOURCE_ROOT/frameworks/base
git restore --staged .
git restore .
rm core/java/com/android/internal/util/PropImitationHooks.java
rm core/res/res/values/custom_config.xml
rm core/res/res/values/custom_symbols.xml
rm core/java/com/android/internal/util/IKeyboxProvider.java
rm core/java/com/android/internal/util/KeyProviderManager.java
rm core/java/com/android/internal/util/KeyboxImitationHooks.java
if [ $2 != "r" ]; then
    git fetch $fw_base --depth 10
    git cherry-pick 22a361654f44da5ae068428da6b305cb5cc603a9^..e758c91e554d1abc4ef76a9ac82f3eb3d3726d26 $CHERRYPICK_FLAGS
    git cherry-pick 9963f8e48450dabb2d5e624d1e3df0e030d8cdd7^..4e570301b64d1605b49ba60619e9796d0e9c3d60 $CHERRYPICK_FLAGS
fi

# fw_av
cd $SOURCE_ROOT/frameworks/av
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $fw_av --depth 3
    git cherry-pick 872e6b8ba168245420d4e63bedd2357bbf40b7ca^..5c371cf92245d2a6f9958a8621a142dfb3ff960c $CHERRYPICK_FLAGS
fi

# system_core
cd $SOURCE_ROOT/system/core
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $system_core --depth 2
    git cherry-pick ad0ff917f31b56e3606f5f9617e7ded6b69b7ab9 $CHERRYPICK_FLAGS
fi

# build_make
cd $SOURCE_ROOT/build/make
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $build_make --depth=7
    git cherry-pick 6053ad52c17d54063a0a70255c783e6ec947f3a9^..9a96904ee59f02bad4566c5328b113d0d14919ef $CHERRYPICK_FLAGS
fi

# hw_interfaces
#cd $SOURCE_ROOT/hardware/interfaces
#git restore --staged .
#git restore .
#if [ $2 != "r" ]; then
#    git fetch $hw_interfaces --depth=2
#    git cherry-pick ca2411918b26a3647735f2664d3137f7ca163c8a $CHERRYPICK_FLAGS
#fi

exit 0
