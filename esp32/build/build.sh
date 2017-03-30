pushd Espruino/
source scripts/provision.sh ESP32
popd
export ESP_IDF_PATH=`pwd`/esp-idf
cd esp-idf
git checkout -f master
#git checkout -f v2.0-rc2
git checkout -f tags/v2.0-rc2
git pull
git submodule update --init
cd ../app
make clean && make -j 8
make app.tgz
cd ../Espruino/
tar xfz ../../deploy/esp-idf.tgz
tar xfz ../../deploy/app.tgz
make clean && BOARD=ESP32 USE_FLASH_FILESYSTEM=1 make
