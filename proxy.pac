/*******************************************************
** Proxy Auto Configure Script
**
** Author:  gentooman
** License: Public Domain
********************************************************/

var Tor_socks = "SOCKS5 127.0.0.1:9050";

var I2P_http = "PROXY 127.0.0.1:4444";
var I2P_https = "PROXY 127.0.0.1:4445";

var normal_connect = "DIRECT"; // no proxy

//////////////////////////////////////

function FindProxyForURL(url, host)
{
    host = host.toLowerCase();

    if (shExpMatch(host, "*.onion")) return Tor_socks;

    if (shExpMatch(host, "*.i2p"))
    {
        if (url.substring(0,5) == "https") return I2P_https;
        return I2P_http;
    }

    var hostip = dnsResolve(host);
    if (host == "localhost" ||
        isInNet(hostip, "127.0.0.0", "255.0.0.0") ||
        isInNet(hostip, "10.0.0.0", "255.0.0.0") ||
        isInNet(hostip, "172.16.0.0", "255.240.0.0") ||
        isInNet(hostip, "192.168.0.0", "255.255.0.0"))
        return "DIRECT";

    return normal_connect;
}
// base64 -w0 proxy.pac
