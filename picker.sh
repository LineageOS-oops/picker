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
    git fetch $fw_base --depth 3
    git cherry-pick 60032dc6e08a72e728d868e4704198387b07a3dc^..8c666053e7ccc57e965a7308fc95e6c2c82ad6ac $CHERRYPICK_FLAGS
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
    git fetch $vnd_aospa --depth 2
    git cherry-pick 436f85a04c00c8b5d98f11e3d948b35cd96e8167 $CHERRYPICK_FLAGS
fi

# vnd_ggl_pxl
cd $AOSPA_ROOT/vendor/google/pixel
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $vnd_ggl_pxl --depth 2
    git cherry-pick 0bef9c78df422565e680e77645c23caa9eca4f9b $CHERRYPICK_FLAGS
fi

exit 0
