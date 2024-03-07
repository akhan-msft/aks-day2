---
title: AKS Certs - common issues
parent:  Module 6 - AKS Nginx Ingress - cert renewals
has_children: false
nav_order: 2
---

## Common Issues When Updating SSL Certificates for Ingress Controllers

- **Certificate and Key Mismatch**: This occurs when the private key doesn't match the SSL certificate. It's crucial to ensure that the certificate and key pair are correctly matched and correspond to each other.

- **Incomplete Certificate Chain**: Sometimes, the SSL certificate does not include the necessary intermediate certificates, leading to an "incomplete certificate chain" error. Clients may not trust the SSL certificate without the complete chain, including all intermediate certificates up to the root certificate.

- **Incorrect Secret Name or Namespace**: When specifying the default SSL certificate, an error can occur if the secret name or namespace is incorrect. Ensure that the specified secret exists and is in the same namespace as the Ingress controller.

- **Improper File Formatting**: SSL certificate and key files must be in the correct format (typically PEM) to be recognized. Ensure no improper formatting or headers that could cause parsing errors.

- **Permission Issues**: The Ingress controller may not have the necessary permissions to read the SSL certificate and key from the specified secret. Verify the permissions and RBAC settings to ensure the Ingress controller can access the secret.

- **TLS Version or Cipher Mismatch**: Compatibility issues may arise if the client and server support different sets of TLS versions or ciphers. Ensure your server configuration supports a broad range of clients while maintaining security.

- **DNS or Hostname Misconfiguration**: The SSL certificate's Common Name (CN) or Subject Alternative Name (SAN) must match the domain name used by clients to connect. Errors occur if there's a mismatch between the certificate's domain name and the actual domain name in use.

- **Rate Limits**: Certificate authorities like Let's Encrypt impose rate limits on certificate issuance. If you're frequently renewing or generating certificates, you may hit these limits, resulting in temporary inability to issue new certificates. If your AKS cluster is using **cert-manager**, this may be an issue.

- **Propagation Delays**: Changes to DNS settings or the deployment of new certificates might not be immediately visible due to DNS caching or propagation delays. Allow some time for changes to take effect globally.


