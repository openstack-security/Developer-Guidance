Cross-Site Scripting (XSS)
==========================

Cross-Site Scripting is a class of vulnerability whereby an attacker is
able to present active web content to a web service, which is
subsequently echoed back to a user and executed by the browser.

There are three main classes of XSS issue: Persistent, Reflected and
DOM-Based. Persistent XSS issues are those where user input is stored by
the server, either in a database or in server files. This is later
presented to any user visiting the affected web page. Reflected XSS
issues are those where user input in a request is immediately reflected
to the user without sanitization. DOM-Based issues are less common, and
are present in web applications with rich client-side JavaScript clients
which generate dynamic code or web content using user controllable data
(i.e. URL parameters).

In a general sense, best practice is to validate data and encode unsafe
output.

### Incorrect

```php
$name = $_GET['name'];

echo("Hello ".name);
```


### Correct

Reflected XSS PHP example:
```php
$name = htmlspecialchars($_GET['name']);

echo("Hello ".$name);
```


### Details
When building web applications in Python, it is recomended to use Django's
template system, ensure auto-escaping is enabled. Additionally, when dynamic
data is inserted, all attributes should be set in quotes.

There are several cases where data must be manually validated. It is
necessary to manually escape data inserted into CSS or Javascript. When
inserting data into an attribute where a URL is expected, such as a href or
img src. It is recommended to whitelist these URLs to ensure they are valid.
Another case is if you do use mark_safe, Django must manually be informed
what data has been escaped. This is not recommended. It is necessary to
manually escape data inserted into CSS or Javascript. Don't insert dynamic
data inside a HTML comment.

Unfortunately, DOM-based XSS must be handled separately.


### Consequences

* Hijack of legitimate user sessions
* Disclosure of sensitive information
* Access to privileged services and functionality
* Delivery of malware and browser exploits from our trusted domain


### References

* [OWASP XSS Guide](https://www.owasp.org/index.php/Cross-site_Scripting_%28XSS%29)
* [OWASP XSS Prevention Cheat Sheet](https://www.owasp.org/index.php/XSS_(Cross_Site_Scripting)_Prevention_Cheat_Sheet)
