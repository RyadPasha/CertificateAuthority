@echo off
setlocal

rem set root dir
set CA_HOME=C:/google/drive/ca
cd %CA_HOME%

rem create the CRL for Intermediate CA certificates signed by the Root CA certificate
openssl ca -config openssl.cnf -gencrl -out crl/ca.crl.pem
openssl crl -outform der -in crl/ca.crl.pem -out crl/ca.crl.crl
rem check the CRL content
openssl crl -in crl/ca.crl.pem -noout -text

rem create the CRL for client certificates signed by the Intermediate CA certificate
openssl ca -config intermediate/openssl.cnf -gencrl -out intermediate/crl/intermediate.crl.pem
openssl crl -outform der -in intermediate/crl/intermediate.crl.pem -out intermediate/crl/intermediate.crl.crl
rem check the CRL content
openssl crl -in intermediate/crl/intermediate.crl.pem -noout -text

rem create the CRL chain file
cat intermediate/crl/intermediate.crl.pem crl/ca.crl.pem > intermediate/crl/ca-chain.crl.pem
