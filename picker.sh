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
    git cherry-pick 6ac3dd6a0e7d8a085c002412321f693180356bb7^..347c0718b5b68c94061959f0bf25e56258c4f502 $CHERRYPICK_FLAGS
fi

# fw_av
cd $AOSPA_ROOT/frameworks/av
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $fw_av --depth=2
    git cherry-pick 3de2ead3133c12ac4750af7c4bc469fb18fd55dd $CHERRYPICK_FLAGS
fi

# system_core
cd $AOSPA_ROOT/system/core
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $system_core --depth=2
    git cherry-pick 1d7f40f2ac51af2ec89397e2cbe437c746a9e0bf $CHERRYPICK_FLAGS
fi

# build_make
cd $AOSPA_ROOT/build/make
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $build_make --depth=6
    git cherry-pick e4b73da62eda637cc71f17191b2e37d105357c06^..36b547cc6eaaacc4593505c38c9becce454daf67 $CHERRYPICK_FLAGS
fi

# vnd_aospa
cd $AOSPA_ROOT/vendor/aospa
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $vnd_aospa --depth 2
    git cherry-pick 367681486b165de2f0c2cd4417aa3f91761b91d8 $CHERRYPICK_FLAGS
fi

# vnd_ggl_pxl
cd $AOSPA_ROOT/vendor/google/pixel
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $vnd_ggl_pxl --depth 2
    git cherry-pick c9addcc7e7c2126a58ce18628edbb3211c82d26e $CHERRYPICK_FLAGS
fi

exit 0
