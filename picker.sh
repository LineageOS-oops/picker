# /bin/bash
if [ "$#" -lt 1 ]; then
    echo "You must define path to root of aospa sources as first argument."
    echo "You can use 'r' as second argument. It's disable cherry-pick (only restore)."
    exit 1
fi

AOSPA_ROOT=$1
echo "Path to root of aospa sources: $AOSPA_ROOT"
echo ""

# Additional
CHERRYPICK_FLAGS="--no-commit"

# Repositories
fw_base="git@github.com:aospa-buki/android_frameworks_base.git"
fw_av="git@github.com:aospa-buki/android_frameworks_av.git"
system_core="git@github.com:aospa-buki/android_system_core.git"
build_make="git@github.com:aospa-buki/android_build.git"
vnd_aospa="git@github.com:aospa-buki/android_vendor_aospa.git"
vnd_ggl_pxl="git@github.com:aospa-buki/android_vendor_google_pixel.git"

# fw_base
cd $AOSPA_ROOT/frameworks/base
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $fw_base --depth 4
    git cherry-pick 6e32c81d1356cdbb730a242dfb300ba9c1fb1ab2^..ee1c11e6854f00f3e21e24e77f7e2faaf1735f97 $CHERRYPICK_FLAGS
fi

# fw_av
cd $AOSPA_ROOT/frameworks/av
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $fw_av --depth=3
    git cherry-pick e7bf4a92805c5855037bcac0ab44cb40a55b90e8^..2ddbf0b042f3d7c5bc2c70d34114715242686ce6 $CHERRYPICK_FLAGS
fi

# system_core
cd $AOSPA_ROOT/system/core
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $system_core --depth=2
    git cherry-pick 4cce6a6e8ba08ee2d86054b2c506868e51f4c211 $CHERRYPICK_FLAGS
fi

# build_make
cd $AOSPA_ROOT/build/make
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $build_make --depth=6
    git cherry-pick caa97fd4cfa3ac461516e5378b6e93ad7219fe8d^..819a61702911932b8304fdab8741df1e775e3f60 $CHERRYPICK_FLAGS
fi

# vnd_aospa
cd $AOSPA_ROOT/vendor/aospa
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $vnd_aospa --depth 3
    git cherry-pick 21b0cbdc80ccc636833771200569268b1a32b26f^..317cc51212cd6aeed0afec94a8b0a5b07dac154d $CHERRYPICK_FLAGS
fi

# vnd_ggl_pxl
cd $AOSPA_ROOT/vendor/google/pixel
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $vnd_ggl_pxl --depth 2
    git cherry-pick e3bb3f7708137a929d1427ad75187f50145a4cca $CHERRYPICK_FLAGS
fi

exit 0
