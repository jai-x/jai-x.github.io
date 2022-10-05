# A Look at Wifi in McDonalds
**2018-04-30**

Sometimes I like using my computer not at home. Working on personal projects or
just casually web-surfing, I end up using public wifi a lot. One such time I was
in the local McDonalds using the free wifi and after noticing a very prominent
router above my head, became curious on what kind of wifi service was being
provided. So I've ended up writing this tiny informal review of the public wifi
experience here in the McDonalds, Harvey Center, Harlow.

## The Wifi

As clear from both the in store logos and the branding on the captive portal
when logging in, the ISP of the wifi service is [O2][o2_wiki], a UK only
telecommunications provider. It's not clear if being an O2 customer
yields any additional benefit when using the wifi here (as I am not one), but
the captive portal does provide an option to login with an O2 customer account.

There are two available SSIDs for the service; `McDonald's Free Wifi`
and `O2 Wifi`. Presumably the O2 SSID is for the benefit of O2 customers in
which they provide wifi access points for them with a shared SSID. As with most
public wifi, the access point for these SSIDs was unsecured, with no form of
encrypted access between device and access point offered. The wifi access points
themselves were Cisco branded.

Connecting to access point and trying to access the internet will trigger the
[captive portal][captive_portal_wiki], which gates internet connectivity by a
mandatory login. You can login either by using a McDonalds wifi account or using
an O2 customer account, as mentioned above. The captive portal also allows you
to register a McDonalds wifi account if you don't have one. From a small sample
size of visiting 7 McDonalds locations across England and Wales, this account
seemed to allow access to all these locations.

Any unencrypted HTTP traffic will be automatically redirected to the captive
portal upon connection. However, encrypted traffic will bypass the captive
portal entirely and allow you to access the internet as normal. SSH connections
will also bypass the captive portal login requirement.

Internet connection quality was quite good, with no problems encountered in
regular usage after correctly authorising via the captive portal login. However
there was some misconfiguration of IP addresses within the access points.
Attempting to access the IPv4 address `1.1.1.1` will redirect to a Cisco
wireless admin login page. As a result, Cloudflare DNS will not work here.
Attempting to access the IPv4 addresses `8.8.8.8`/`8.8.4.4` will result in the
connection immediately timing out. As a result, Google DNS will not work here.

A small speed test was conducted at 17:06 using [speedtest.net][speedtest_net]:

| Attempt | Ping (ms) | DL (Mbps) | UP (Mbps) |
| ------- | ----------| --------- | --------- |
| 0       | 28        | 23.67     | 7.65      |
| 1       | 27        | 31.64     | 8.27      |
| 2       | 23        | 25.19     | 8.43      |


[o2_wiki]: https://en.wikipedia.org/wiki/O2_(UK)
[captive_portal_wiki]: https://en.wikipedia.org/wiki/Captive_portal
[speedtest_net]: https://speedtest.net
