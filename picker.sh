# /bin/bash
if [ "$#" -lt 1 ]; then
    echo "You must define path to root of lineageos sources as first argument."
    echo "You can use 'r' as second argument. It's disable cherry-pick (only restore)."
    exit 1
fi

SOURCE_ROOT=$1
echo "Path to root of lineageos sources: $SOURCE_ROOT"
echo ""

# Additional
CHERRYPICK_FLAGS="--no-commit"

# Repositories
build_soong="git@github.com:LineageOS-oops/android_build_soong.git"
fw_av="git@github.com:LineageOS-oops/android_frameworks_av.git"
fw_base="git@github.com:LineageOS-oops/android_frameworks_base.git"
system_core="git@github.com:LineageOS-oops/android_system_core.git"
device_lineage_sepolicy="git@github.com:LineageOS-oops/android_device_lineage_sepolicy.git"
audio="git@github.com:LineageOS-oops/android_hardware_qcom_audio.git"

# build_soong
cd $SOURCE_ROOT/build/soong
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $build_soong --depth 3
    git cherry-pick d898f2b171511347b0d9bd1803f92251280a7c94^..b457dea01a8ddc6d9c0739d42c41aa205b1be77f $CHERRYPICK_FLAGS
fi

# fw_av
cd $SOURCE_ROOT/frameworks/av
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $fw_av --depth 4
    git cherry-pick dc3db347660b4acc6a11e37f6646b9887d842b8d^..ea30e6908eaed1756e8d889e2642993c201e390d $CHERRYPICK_FLAGS
fi

# fw_base
cd $SOURCE_ROOT/frameworks/base
git restore --staged .
git restore .
rm -rf services/core/java/com/android/server/gmscompat/
rm -rf core/java/com/android/internal/gmscompat/
rm -rf core/java/com/oplus/
if [ $2 != "r" ]; then
    git fetch $fw_base --depth 12
    git cherry-pick 4bfdd06f5916393f16a56b29f5b5e30729f89eb2^..7b1d27d003f392156c89dc61f26b844dc8cf71c8 $CHERRYPICK_FLAGS
fi

# system_core
cd $SOURCE_ROOT/system/core
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $system_core --depth 5
    git cherry-pick afaa524a0bd23bf39a8544b4c135802b1ede907c^..4df3c935da24b6cd2f5c722361e63cc4209a2b78 $CHERRYPICK_FLAGS
fi

# device_lineage_sepolicy
cd $SOURCE_ROOT/device/lineage/sepolicy
git restore --staged .
git restore .
rm common/private/gmscore_app.te
if [ $2 != "r" ]; then
    git fetch $device_lineage_sepolicy --depth 2
    git cherry-pick 0ff869d05e15c8e31a4199fe9fda87ed1cc48625 $CHERRYPICK_FLAGS
fi

# audio
#cd $SOURCE_ROOT/hardware/qcom-caf/sm8350/audio
#git restore --staged .
#git restore .
#rm hal/audio_hw_lvacfs.*
#rm hal/audio_hw_lvimfs.*
#if [ $2 != "r" ]; then
#    git fetch $audio --depth 3
#    git cherry-pick afab4823bae19e93fa7b0903152254d15a37171a^..c0bccfb386e9f96abf19485dd29be509ff709432 $CHERRYPICK_FLAGS
#fi

#exit 0
