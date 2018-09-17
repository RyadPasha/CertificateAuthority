@echo off
setlocal

rem set root dir
set CA_HOME=C:/google/drive/ca
cd %CA_HOME%

rem prepare Root CA
mkdir certs crl csr newcerts private
touch index.txt
echo 1000 > serial
echo 1000 > crlnumber
rem create the Root CA key
openssl genrsa -aes256 -out private/ca.key.pem 4096
rem create the Root CA certificate (common name is the Root CA name you want)
openssl req -config openssl.cnf -key private/ca.key.pem -new -x509 -days 7300 -sha256 -extensions v3_ca -out certs/ca.cert.pem
openssl x509 -outform der -in certs/ca.cert.pem -out certs/ca.cert.crt
openssl pkcs12 -export -out certs/ca.cert.pfx -inkey private/ca.key.pem -in certs/ca.cert.pem
rem verify the Root CA certificate
openssl x509 -noout -text -in certs/ca.cert.pem

rem prepare Intermediate CA
cd %CA_HOME%/intermediate
mkdir certs crl csr newcerts private
touch index.txt
echo 1000 > serial
echo 1000 > crlnumber
cd %CA_HOME%
rem create the Intermediate CA key
openssl genrsa -aes256 -out intermediate/private/intermediate.key.pem 4096
rem create the Intermediate CA certificate (common name is the Intermediate CA name you want)
openssl req -config intermediate/openssl.cnf -new -sha256 -key intermediate/private/intermediate.key.pem -out intermediate/csr/intermediate.csr.pem
rem sign the Intermediate CA certificate with our Root CA certificate
openssl ca -config openssl.cnf -extensions v3_intermediate_ca -days 3650 -notext -md sha256 -in intermediate/csr/intermediate.csr.pem -out intermediate/certs/intermediate.cert.pem
openssl x509 -outform der -in intermediate/certs/intermediate.cert.pem -out intermediate/certs/intermediate.cert.crt
openssl pkcs12 -export -out intermediate/certs/intermediate.cert.pfx -inkey intermediate/private/intermediate.key.pem -in intermediate/certs/intermediate.cert.pem
rem verify the Intermediate CA certificate
openssl x509 -noout -text -in intermediate/certs/intermediate.cert.pem
rem verify the Intermediate CA certificate against the Root CA certificate
openssl verify -CAfile certs/ca.cert.pem intermediate/certs/intermediate.cert.pem

rem create the certificate chain file
cat intermediate/certs/intermediate.cert.pem certs/ca.cert.pem > intermediate/certs/ca-chain.cert.pem
