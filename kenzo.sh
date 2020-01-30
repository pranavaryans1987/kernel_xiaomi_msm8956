make clean
make mrproper
KERNEL_DIR=$PWD
Anykernel_DIR=$KERNEL_DIR/AnyKernel2/
DATE=$(date +"%d%m%Y")
KERNEL_NAME="kernel-Q"
DEVICE="-AmolAmrit-"
FINAL_ZIP="$KERNEL_NAME""$DEVICE""$DATE"

# Cleanup before 
rm -rf $Anykernel_DIR/*zip
rm -rf $Anykernel_DIR/Image.gz-dtb
rm -rf arch/arm64/boot/Image
rm -rf arch/arm64/boot/dts/qcom/kenzo-msm8956-mtp.dtb
rm -rf arch/arm64/boot/Image.gz
rm -rf arch/arm64/boot/Image.gz-dtb

# Export few variables
export KBUILD_BUILD_USER="Dungphp"
export KBUILD_BUILD_HOST="IT"
export CROSS_COMPILE=/root/toolchain/aarch64-linux-android-4.9/bin/aarch64-linux-android-
export ARCH="arm64"
export USE_CCACHE=1

make lineageos_kenzo_defconfig
make -j4

# Create the flashable zip
cp arch/arm64/boot/Image.gz-dtb $Anykernel_DIR
cd $Anykernel_DIR
zip -r9 ../$FINAL_ZIP.zip * -x .git README.md *placeholder

# Cleanup again
cd ../
rm -rf $Anykernel_DIR/Image.gz-dtb
rm -rf arch/arm64/boot/Image
rm -rf arch/arm64/boot/dts/qcom/kenzo-msm8956-mtp.dtb
rm -rf arch/arm64/boot/Image.gz
rm -rf arch/arm64/boot/Image.gz-dtb

