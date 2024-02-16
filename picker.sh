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

# fw_base
cd $SOURCE_ROOT/frameworks/base
git restore --staged .
git restore .
rm core/java/com/android/internal/util/PropImitationHooks.java
rm core/res/res/values/custom_config.xml
rm core/res/res/values/custom_symbols.xml
if [ $2 != "r" ]; then
    git fetch $fw_base --depth 6
    git cherry-pick 4b676a89d79aabe2d9fcd701f8fbe1db9502d9c6^..3cce295b19356f8407343b6be95ce73657f05fca $CHERRYPICK_FLAGS
fi

# fw_av
cd $SOURCE_ROOT/frameworks/av
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $fw_av --depth 2
    git cherry-pick bd69f8347be6c72a3ccb3bcfcec78d2422b999ea $CHERRYPICK_FLAGS
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
    git cherry-pick 019a49272b659f9371a86e4930514ff854ed8aae^..a29bd13ae7bc6219fef551279a9240e9ebe609ad $CHERRYPICK_FLAGS
fi

exit 0
