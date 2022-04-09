#!/bin/bash

wget https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.8/EasyRSA-3.0.8.tgz
tar -xzf EasyRSA-3.0.8.tgz
rm EasyRSA-3.0.8.tgz

mv EasyRSA-3.0.8/vars.example EasyRSA-3.0.8/vars

./EasyRSA-3.0.8/easyrsa init-pki
./EasyRSA-3.0.8/easyrsa build-ca nopass
./EasyRSA-3.0.8/easyrsa gen-req tls nopass
./EasyRSA-3.0.8/easyrsa sign-req server tls nopass

cp pki/issued/tls.crt .
cp pki/private/tls.key .

rm -r EasyRSA-3.0.8
rm -r pki

docker build -t incloud .
docker run --rm -v $(pwd):/app incloud /bin/bash -c "openssl pkcs12 -export -inkey tls.key -in tls.crt -out keystore.pkcs12 -password pass:password && keytool -importkeystore -noprompt -srckeystore keystore.pkcs12 -srcstoretype pkcs12 -destkeystore keystore.jks -storepass password -srcstorepass password"
