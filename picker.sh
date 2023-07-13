# /bin/bash
if [ "$#" -lt 1 ]; then
    echo "You must define path to root of lineageos sources as first argument."
    echo "You can use 'r' as second argument. It's disable cherry-pick (only restore)."
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
hw_oplus="git@github.com:LineageOS-oops/android_hardware_oplus.git"

# fw_base
cd $LOS_ROOT/frameworks/base
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $fw_base --depth 10
    git cherry-pick 71c7964f56060b02b8030ed2ee84df09c9022222^..d6a41091f63334c0ad715a8a1a4e4ed9de1778d9 $CHERRYPICK_FLAGS
fi

# fw_av
cd $LOS_ROOT/frameworks/av
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $fw_av --depth=2
    git cherry-pick ca7046d20642d0391cb6d97f81d857e1eeaa5567 $CHERRYPICK_FLAGS
fi

# system_core
cd $LOS_ROOT/system/core
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $system_core --depth=3
    git cherry-pick d8937c895531918159b5b6a7dbdd87e8c78a2269^..cf519bfea29ed26c4c2b25da5013f59cc6d10c4c $CHERRYPICK_FLAGS
fi

# build_make
cd $LOS_ROOT/build/make
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $build_make --depth=7
    git cherry-pick cfd94035be02e4ad0174b199e7303ffa2f6eaf0c^..2d5449fd4fe6041d000dea3f4f14670686ea6682 $CHERRYPICK_FLAGS
fi

# hw_oplus
cd $LOS_ROOT/hardware/oplus
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $hw_oplus --depth=2
    git cherry-pick aea10112c4768f91729af9f1f6d174167a8a9b7f $CHERRYPICK_FLAGS
fi

exit 0
