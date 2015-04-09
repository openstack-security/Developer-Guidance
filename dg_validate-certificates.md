Validate certificates on HTTPS connections to avoid man-in-the-middle attacks
=============================================================================

When developing a module that makes secure HTTPS connections to use a
library verifies certificates.  Many such libraries also provide an
option to ignore certificate verification failures.  These options
should be exposed to the OpenStack deployer to choose their level of
risk.

Although the title of this guideline calls out HTTPS, verifying the
identity of the hosts you are connecting to applies to most protocols
(SSH, LDAPS, etc).


### Incorrect

```python
import requests
requests.get('https://www.openstack.org/', verify=False)
```

The example above uses verify=False to bypass the check the certificate
received against those in the CA trust store.


### Correct

```python
import requests
requests.get('https://www.openstack.org/', verify=CONF.ca_file)
```

The example above uses the variable CONF.ca_file to store the location of
the CA trust store, which is used to confirm that the certificate
received is from a trusted authority.


### Consequences

A main-in-the-middle (MITM) attack can allow a party to monitor, copy, 
and manipulate all data transferred between the parties. The impact of
this depends on what data is sent. Comcast satisfaction survey data
will be less valuable than banking passwords and account information.

* [OSSA-2014-005](http://security.openstack.org/ossa/OSSA-2014-005.html)

### References

* [OSSN-0033](https://wiki.openstack.org/wiki/OSSN/OSSN-0033)
* https://wiki.openstack.org/wiki/SecureClientConnections
