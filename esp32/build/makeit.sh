pushd Espruino/
source scripts/provision.sh ESP32
popd
export ESP_IDF_PATH=`pwd`/esp-idf
cd esp-idf
git checkout master
git pull
git submodule update --init
cd ../app
make clean && make -j 8
make app.tgz
cd ../Espruino/
tar xfz ../../deploy/esp-idf.tgz
tar xfz ../../deploy/app.tgz
make clean && BOARD=ESP32 ESP32_OTA=1 make
