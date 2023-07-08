# /bin/bash
if [ "$#" -lt 1 ]; then
    echo "You must define only path to root of lineageos sources as first argument."
    exit 1
fi

LOS_ROOT=$1
echo "Path to root of lineageos sources: $LOS_ROOT"
echo ""

# Repositories
fw_base="git@github.com:LineageOS-oops/android_frameworks_base.git"
fw_av="git@github.com:LineageOS-oops/android_frameworks_av.git"
system_core="git@github.com:LineageOS-oops/android_system_core.git"

# fw_base
cd $LOS_ROOT/frameworks/base
git fetch $fw_base --depth 10
git cherry-pick c960f627761f84f052ed724a98a12ab712d92681^..a04cfbe8fcf02946726c52c0b5a51906a5919dc6

# fw_av
cd $LOS_ROOT/frameworks/av
git fetch $fw_av --depth=2
git cherry-pick ca7046d20642d0391cb6d97f81d857e1eeaa5567

# system_core
cd $LOS_ROOT/system/core
git fetch $system_core --depth=3
git cherry-pick d8937c895531918159b5b6a7dbdd87e8c78a2269^..cf519bfea29ed26c4c2b25da5013f59cc6d10c4c

exit 0
