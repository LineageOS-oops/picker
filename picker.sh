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

# fw_base
cd $SOURCE_ROOT/build/soong
git restore --staged .
git restore .
if [ $2 != "r" ]; then
    git fetch $fw_base --depth 2
    git cherry-pick 1c92461e564df35747ac99aabaaea18cc37bf7a3 $CHERRYPICK_FLAGS
fi

exit 0
