@echo off
setlocal

rem set root dir
set CA_HOME=C:/google/drive/ca
cd %CA_HOME%

rem create OCSP signing certificate for Intermediate CA certificates signed by our Root CA certificate
openssl genrsa -aes256 -out private/ocsp.ryadpasha.com.key.pem 4096
rem create the certificate (common name is the fully qualified domain name of the OCSP responder, IE: ocsp.ryadpasha.com)
openssl req -config openssl.cnf -new -sha256 -key private/ocsp.ryadpasha.com.key.pem -out csr/ocsp.ryadpasha.com.csr.pem
rem sign the OCSP certificate with our Root CA certificate
openssl ca -config openssl.cnf -extensions ocsp -days 375 -notext -md sha256 -in csr/ocsp.ryadpasha.com.csr.pem -out certs/ocsp.ryadpasha.com.cert.pem
rem verify the OCSP signing certificate
openssl x509 -noout -text -in certs/ocsp.ryadpasha.com.cert.pem

rem create OCSP signing certificate for client certificates signed by our Intermediate CA certificate
openssl genrsa -aes256 -out intermediate/private/ocsp.ryadpasha.com.key.pem 4096
rem create the certificate (common name is the fully qualified domain name of the OCSP responder, IE: ocsp.ryadpasha.com)
openssl req -config intermediate/openssl.cnf -new -sha256 -key intermediate/private/ocsp.ryadpasha.com.key.pem -out intermediate/csr/ocsp.ryadpasha.com.csr.pem
rem sign the OCSP certificate with our Intermediate CA certificate
openssl ca -config intermediate/openssl.cnf -extensions ocsp -days 375 -notext -md sha256 -in intermediate/csr/ocsp.ryadpasha.com.csr.pem -out intermediate/certs/ocsp.ryadpasha.com.cert.pem
rem verify the OCSP signing certificate
openssl x509 -noout -text -in intermediate/certs/ocsp.ryadpasha.com.cert.pem

rem OCSP certificates
cat intermediate/certs/ocsp.ryadpasha.com.cert.pem certs/ocsp.ryadpasha.com.cert.pem > intermediate/certs/ocsp-chain.cert.pem
