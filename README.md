Certificate Authority
---------------------
```
Root CA
Root CA > Intermediate CA
Root CA > OCSP signing certificate
Root CA > CRL
Intermediate CA > Client certificate
Intermediate CA > OCSP signing certificate
Intermediate CA > CRL
```

Order
-----
- Make sure Root CA and Intermediate CA directory in the two openssl.cnf files are correct
- Make sure the CRL urls are correct in the two openssl.cnf files
- Make sure the OCSP responder urls are correct in the two openssl.cnf files

```
setup_ca.bat
setup_client.bat
setup_server.bat
setup_ocsp.bat
revoke_client.bat
setup_crl.bat
```

- `revoke_client.bat`, `setup_crl.bat` can be re-run many times depending on if any more certificates were revoked


OCSP Responder
--------------
- Start (Root):
```
    openssl ocsp -port ocsp.ryadpasha.com:2561 -text -sha256 -index index.txt -CA certs/ca.cert.pem -rkey private/ocsp.ryadpasha.com.key.pem -rsigner certs/ocsp.ryadpasha.com.cert.pem
```
- Request (Root):
```
    openssl ocsp -CAfile certs/ca.cert.pem -url http://ocsp.ryadpasha.com:2561 -resp_text -issuer certs/ca.cert.pem -cert intermediate/certs/intermediate.cert.pem
```
- Start (Intermediate):
```
    openssl ocsp -port ocsp.ryadpasha.com:2560 -text -sha256 -index intermediate/index.txt -CA intermediate/certs/ca-chain.cert.pem -rkey intermediate/private/ocsp.ryadpasha.com.key.pem -rsigner intermediate/certs/ocsp.ryadpasha.com.cert.pem
```
- Request (Intermediate):
```
    openssl ocsp -CAfile intermediate/certs/ca-chain.cert.pem -url http://ocsp.ryadpasha.com:2560 -resp_text -issuer intermediate/certs/intermediate.cert.pem -cert intermediate/certs/client1.cert.pem
```

<sup><sub>Based off of https://jamielinux.com/docs/openssl-certificate-authority/index.html with a few tweaks.</sub></sup>

## Discussion
If you have questions or problems with installation or usage [create an Issue](https://github.com/ryadpasha/certificateauthority).

For any queries contact me at: **me@ryadpasha.com**
