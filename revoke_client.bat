@echo off
setlocal

rem set root dir
set CA_HOME=C:/google/drive/ca
cd %CA_HOME%

rem revoke a certificate (after doing this must re-generated crl if necessary)
openssl ca -config intermediate/openssl.cnf -revoke intermediate/certs/client1.cert.pem
openssl ca -config intermediate/openssl.cnf -revoke intermediate/certs/client4.cert.pem
