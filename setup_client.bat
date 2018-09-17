@echo off
setlocal

rem set root dir
set CA_HOME=C:/google/drive/ca
cd %CA_HOME%

rem client 1
rem create the client certificate key (leaving -aes256 will password protect the key - put before -out)
openssl genrsa -aes256 -out intermediate/private/client1.key.pem 2048
rem create the client certificate (Common Name is the identifier, this is where the EDIPI should be as well if using one)
openssl req -config intermediate/openssl.cnf -key intermediate/private/client1.key.pem -new -sha256 -out intermediate/csr/client1.csr.pem
rem sign the client certificate with our Intermediate CA certificate
openssl ca -config intermediate/openssl.cnf -extensions usr_cert -days 375 -notext -md sha256 -in intermediate/csr/client1.csr.pem -out intermediate/certs/client1.cert.pem
openssl x509 -outform der -in intermediate/certs/client1.cert.pem -out intermediate/certs/client1.cert.crt
openssl pkcs12 -export -out intermediate/certs/client1.cert.pfx -inkey intermediate/private/client1.key.pem -in intermediate/certs/client1.cert.pem -CAfile intermediate/certs/ca-chain.cert.pem
rem verify the client certificate
openssl x509 -noout -text -in intermediate/certs/client1.cert.pem
rem verify the client certificate against the entire certificate chain
openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/client1.cert.pem

rem client 2
openssl genrsa -out intermediate/private/client2.key.pem 2048
openssl req -config intermediate/openssl.cnf -key intermediate/private/client2.key.pem -new -sha256 -out intermediate/csr/client2.csr.pem
openssl ca -config intermediate/openssl.cnf -extensions usr_cert -days 375 -notext -md sha256 -in intermediate/csr/client2.csr.pem -out intermediate/certs/client2.cert.pem
openssl x509 -outform der -in intermediate/certs/client2.cert.pem -out intermediate/certs/client2.cert.crt
openssl pkcs12 -export -out intermediate/certs/client2.cert.pfx -inkey intermediate/private/client2.key.pem -in intermediate/certs/client2.cert.pem -CAfile intermediate/certs/ca-chain.cert.pem
openssl x509 -noout -text -in intermediate/certs/client2.cert.pem
openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/client2.cert.pem

rem client 3
openssl genrsa -out intermediate/private/client3.key.pem 2048
openssl req -config intermediate/openssl.cnf -key intermediate/private/client3.key.pem -new -sha256 -out intermediate/csr/client3.csr.pem
openssl ca -config intermediate/openssl.cnf -extensions usr_cert -days 375 -notext -md sha256 -in intermediate/csr/client3.csr.pem -out intermediate/certs/client3.cert.pem
openssl x509 -outform der -in intermediate/certs/client3.cert.pem -out intermediate/certs/client3.cert.crt
openssl pkcs12 -export -out intermediate/certs/client3.cert.pfx -inkey intermediate/private/client3.key.pem -in intermediate/certs/client3.cert.pem -CAfile intermediate/certs/ca-chain.cert.pem
openssl x509 -noout -text -in intermediate/certs/client3.cert.pem
openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/client3.cert.pem

rem client 4
openssl genrsa -aes256 -out intermediate/private/client4.key.pem 2048
openssl req -config intermediate/openssl.cnf -key intermediate/private/client4.key.pem -new -sha256 -out intermediate/csr/client4.csr.pem
openssl ca -config intermediate/openssl.cnf -extensions usr_cert -days 375 -notext -md sha256 -in intermediate/csr/client4.csr.pem -out intermediate/certs/client4.cert.pem
openssl x509 -outform der -in intermediate/certs/client4.cert.pem -out intermediate/certs/client4.cert.crt
openssl pkcs12 -export -out intermediate/certs/client4.cert.pfx -inkey intermediate/private/client4.key.pem -in intermediate/certs/client4.cert.pem -CAfile intermediate/certs/ca-chain.cert.pem
openssl x509 -noout -text -in intermediate/certs/client4.cert.pem
openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/client4.cert.pem

rem client 5
openssl genrsa -out intermediate/private/client5.key.pem 2048
openssl req -config intermediate/openssl.cnf -key intermediate/private/client5.key.pem -new -sha256 -out intermediate/csr/client5.csr.pem
openssl ca -config intermediate/openssl.cnf -extensions usr_cert -days 375 -notext -md sha256 -in intermediate/csr/client5.csr.pem -out intermediate/certs/client5.cert.pem
openssl x509 -outform der -in intermediate/certs/client5.cert.pem -out intermediate/certs/client5.cert.crt
openssl pkcs12 -export -out intermediate/certs/client5.cert.pfx -inkey intermediate/private/client5.key.pem -in intermediate/certs/client5.cert.pem -CAfile intermediate/certs/ca-chain.cert.pem
openssl x509 -noout -text -in intermediate/certs/client5.cert.pem
openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/client5.cert.pem

rem client 6
openssl genrsa -out intermediate/private/client6.key.pem 2048
openssl req -config intermediate/openssl.cnf -key intermediate/private/client6.key.pem -new -sha256 -out intermediate/csr/client6.csr.pem
openssl ca -config intermediate/openssl.cnf -extensions usr_cert -days 375 -notext -md sha256 -in intermediate/csr/client6.csr.pem -out intermediate/certs/client6.cert.pem
openssl x509 -outform der -in intermediate/certs/client6.cert.pem -out intermediate/certs/client6.cert.crt
openssl pkcs12 -export -out intermediate/certs/client6.cert.pfx -inkey intermediate/private/client6.key.pem -in intermediate/certs/client6.cert.pem -CAfile intermediate/certs/ca-chain.cert.pem
openssl x509 -noout -text -in intermediate/certs/client6.cert.pem
openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/client6.cert.pem
