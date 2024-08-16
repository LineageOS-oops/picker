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
if [ $2 != "r" ]; then
    git fetch $fw_base --depth 7
    git cherry-pick b3ea5572ee5319553b77779600839b9b950ed46b^..789c432fdf5796a15fa83f234f0fbe7b023ed134 $CHERRYPICK_FLAGS
fi

# fw_av
cd $SOURCE_ROOT/frameworks/av
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $fw_av --depth 3
    git cherry-pick cf6f185cd716aa8c06a4aad2f315e3c0cfe2db63 $CHERRYPICK_FLAGS
fi

# system_core
cd $SOURCE_ROOT/system/core
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $system_core --depth 2
    git cherry-pick 3525250775043a2d861fd5814525e7961ba0643b $CHERRYPICK_FLAGS
fi

# build_make
cd $SOURCE_ROOT/build/make
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $build_make --depth=7
    git cherry-pick bf2083c16b051e9913da962356a9fc137e109f5b^..b49e09f068e60da8e588f50daecf9394b2c518c6 $CHERRYPICK_FLAGS
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
