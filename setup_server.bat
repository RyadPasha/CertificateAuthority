@echo off
setlocal

rem set root dir
set CA_HOME=C:/google/drive/ca
cd %CA_HOME%

rem server certificate
rem create the server certificate key (leaving -aes256 will password protect the key - put before -out - if do this will require password to start server everytime)
openssl genrsa -out intermediate/private/eamdev.infor.com.key.pem 2048
rem create the server certificate (Common Name is the domain name)
openssl req -config intermediate/openssl.cnf -key intermediate/private/eamdev.infor.com.key.pem -new -sha256 -out intermediate/csr/eamdev.infor.com.csr.pem
rem sign the server certificate with our Intermediate CA certificate
openssl ca -config intermediate/openssl.cnf -extensions server_cert -days 375 -notext -md sha256 -in intermediate/csr/eamdev.infor.com.csr.pem -out intermediate/certs/eamdev.infor.com.cert.pem
openssl x509 -outform der -in intermediate/certs/eamdev.infor.com.cert.pem -out intermediate/certs/eamdev.infor.com.cert.crt
openssl pkcs12 -export -out intermediate/certs/eamdev.infor.com.cert.pfx -inkey intermediate/private/eamdev.infor.com.key.pem -in intermediate/certs/eamdev.infor.com.cert.pem -CAfile intermediate/certs/ca-chain.cert.pem
rem verify the server certificate
openssl x509 -noout -text -in intermediate/certs/eamdev.infor.com.cert.pem
rem verify the server certificate against the entire certificate chain
openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/eamdev.infor.com.cert.pem
