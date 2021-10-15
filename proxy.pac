function FindProxyForURL(url, host) {
	if (shExpMatch(host, "*.i2p"))
		return "PROXY 127.0.0.1:4444";
	
	else if (shExpMatch(host,"127.0.0.1") || shExpMatch(host,"localhost"))
		return "DIRECT";

	else
		return "SOCKS5 127.0.0.1:9050";
}
