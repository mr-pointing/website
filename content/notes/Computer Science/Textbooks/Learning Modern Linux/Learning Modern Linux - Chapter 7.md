---
aliases:
draft: false
tags:
  - computerscience
  - textbook
  - linux
title: Learning Modern Linux - Chapter 7
date: 2025-08-06
updated: 2025-08-23T18:00
---

---

# Networking

A topic I've gone over before in a few notes now, so if you want a deeper dive on general topics, see [this]({{< ref "Introduction to Computer Networking" >}}) note. What we're going to look at now is the Linux side of things, and how the Linux protocol deals with connecting to the world wide web. Specifically, the network protocols used and tooling provided.

## Basics

Without network connection, everything in the last chapter would be a moot point. There's no external applications, supply chain past the initial purchase, and connection with the outside world. The tough part about networking is the amount of moving parts between all of the layers.

Linux also abstracts away parts of networking, making it difficult to diagnose problems. To start with our classifications, let's use categories we're already familiar with. For hardware, we need to have some Ethernet or WiFi card to enable the connection to happen. Then, in Kernel space, we deal with the TCP/IP stack, which we know is how the connection to the internet is processed and connection is safely made. Finally, in User space, we range from simple commands like `ip`, to full on GUI applications like a web browser.

## The TCP/IP Stack

Made up of 4, sequential layers;

1. **Link Layer**: Allows hardware and kernel drivers to communicate
2. **Internet Layer**: Uses IP protocol to route packets
3. **Transport Layer**: How the end-to-end connection occurs (UDP, TCP)
4. **Application Layer**: Web, SSH, mail, etc.

We'll move through each layer to see how each builds upon another, until the payload is a compilation of all four steps.

### The Link Layer

Some terms before we continue; we know a wired connection as Ethernet, a wireless connection as WiFi, a MAC address or _media access control_ address as the unique 48-character identifier for all hardware, and lastly, an **interface** is simply a network connection, physical or not.

One of the most important parts on the hardware side of the Link layer is your **NIC**, or a _network interface controller_ (or _card_). This is what actually allows you to connect to a network via Ethernet cable. There are two ways to get info on all NIC's on your system; `ifconfig` and `ip`. The former is considered deprecated, so we should be using the latter;

```bash
> ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: wlp192s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DORMANT group default qlen 1000
    link/ether 9a:39:d4:22:8e:1h brd ff:ff:ff:ff:ff:ff permaddr 84:9e:56:9c:a0:7b
    altname wlx849e569ca07b
```

The first option here, `lo`, is known as the _loopback interface_. This is sometimes known as localhost as well. What this allows your device to do is to self reference. Sounds confusing, but this is useful in a few different scenarios. Technically this is managed by the next layer, but I wanted to establish a good definition of this concept before moving on. This loopback interface provides a loopback address, that allows things like pings and transmission of packets all locally, without any leak into your network. If you want to build or host a server on your machine that only you have access too, it's most likely on your loopback address or localhost (most commonly 127.0.0.1).

Another concept shown above is the _maximum transmission unit_ or **MTU**. This is the maximum byte size for a package. We can see above our loopback interface shows we have a maximum of 65,536 bytes. When looking at option 2, we see the name of our connection (_wl_ for wireless, _p192_ for PCI bus 192, and _s0_ for slot 0) as well as some flags telling us the current status of the network. Since we see `UP` and `MULTICAST`, everything seems to be operational.

Another useful tool in the Link layer toolbox is the _Address Resolution Protocol_ (ARP) which maps out a IP address for each MAC address. This creates the connection between the Link layer which we're on now, to the next layer above, the Internet layer. Again, like most Linux things, there is an older deprecated version and a newer more standard version.

First up is `arp`, which returns the cache of mapped MAC addresses on your system. You can even through in the option `-n` to prevent hostname resolution and show IP addresses instead;

```bash
> arp
Address  HWtype  HWaddress           Flags Mask    Iface
_gateway ether   9a:39:d4:22:8e:1h   C             wlp192s0
```

Next up is `ip neigh` or `ip neighbor`, which will do the same thing as `arp` with a more modern approach. Again, any more details on either of these commands can be found within their man pages.

Now that I have information on what my NIC is called, I can use the command `iw` followed by some arguments to learn more about it;

```bash
> iw dev wlp192s0 info
Interface wlp192s0
        ifindex 2
        wdev 0x1
        addr 9a:39:d4:22:8e:1h
        ssid MyOptimum 118d2b
        type managed
        wiphy 0
        channel 149 (5745 MHz), width: 80 MHz, center1: 5775 MHz
        txpower 3.00 dBm
```

Now I can easily see the name of my router, as well as some info on the connection itself, like the WiFi frequency. If you want to gather more traffic related information, you can replace `info` with `link`.

### The Internet Layer

This section is going to be technically dense, so strap in. We know already the Internet layer is the second-lowest layer, and does the heavy lifting of routing packets from machine to machine. An assumption we should understand before going forward is that the structure of this layer is designed _for_ instability, meaning the active participants in your network (thin connections) are often changing. This assumption helps alleviate issues with devices that are wireless, or move often changing their local environment/outside connection.

This layer is also not focused on the performance of that packet transport. If anything, it just wants to ensure it's given the best effort possible, trying to send as many packets as possible. Losing one is no big deal.

We are also introduced formally to the worldwide standard for identifying devices; IP addresses. _Internet Protocol_ has two versions we should be concerned with; IPv4 and IPv6. Before we go through each, one example should help clear up some of the more technical jargon we're about to face; think of your IP address as a regular old mailing address. I don't have to be concerned with how my mail will get to you or how many methods of transportation it will take to get there; all I need to know is your address, and I can write you a letter from pretty much anywhere in the world.

#### IPv4

The most basic definition of an IPv4 address is a unique 32-bit number combination to identify a host or process acting as a point of communication via TCP/IP. Traditionally these are 4 octets separated by a period.

One place this IP address is important is inside the _IP Header_. This is a collection of metadata about a packet being transferred. This was set up by the **IETF**, or the Internet Engineering Task Force, sent out via a document called the [RFC 791 - Internet Protocol](https://datatracker.ietf.org/doc/html/rfc791). This was instituted all the way back in 1981!

Some of the metadata collected in that header can be see below;

- **Source Address**: IP address of the sender
- **Destination Address**: IP address of the receiver
- **Protocol**: Type of payload (TCP, UDP, or ICMP)
- **Time to Live (TTL)**: Maximum amount of time a packet should exist for

There are definitely other parts that make up that header, but that's not really the focus of this text so let's move on.

Another important and modern aspect to this layer is _Classless Inter-Domain Routing_, or _CIDR_. We understand the internet to be a network of networks, however, each network is not the same. To differentiate between types of networks (private, public, commercial, other networks, etc.), CIDR was implemented. It has two parts; the network address and how bits/IP addresses fit within that range.

`10.0.0.0/24` is a basic example. Let's math this out; we know an IP address consists of 32 bits. The first 24 bits in this example then is the network, while the remaining 8 bits are all of the available addresses on the network. So, in the above example, IP addresses start at `10.0.0.0` and go up to `10.0.0.255` (technically the first and last spot ((`.0` and `.255`)) are saved for special purposes).

Speaking of saved addresses, there are some reserved IPv4 addresses that will come up often. We already took a look at `127.0.0.0`, but there's also `0.0.0.0`, which is a non-routable address that can do a lot of things, but most interestingly for us can refer to all IPv4 addresses available on a given machine. If you want to take a quick look at all the IP interfaces, use `ip addr show`.

#### IPv6

The future of Internet Protocol, this time supporting a hexadecimal representation, 8 groups of 16 bits each, separated by a colon. Unfortunately, this will likely not become the standard for some time due to the shear amount of content using IPv4. The two are also not compatible, leading to an even wider gap.

#### Internet Control Message Protocol

There's an acronym used up above I personally never heard of we glanced right by; _ICMP_. The Internet Control Message Protocol is used by low-level components to send things like error messages. One useful feature you can use to test if a website is reachable or not is with the command `ping`. If you want to use something similar with an IPv6, you would have to use `ping6`.

#### Routing

How do the packets that we've been talking about this chapter get delivered? The real meat and potatoes of that process is beyond this text, but it does provide a nice overview of how to get routing info, which is super easy with `sudo route -n`, returning a table with the following info;

- **Destination**: IP Address of the destination of the packet (`0.0.0.0` means unspecified or unknown)
- **Gateway**: Meant for packets not on the same network
- **Genmask**: Subnet mask used
- **Flags**: Status flags
- **Iface**: Network interface used by the packet

The most modern method of obtaining this info is also `sudo ip route`, and you can even check for connections with `traceroute <website>`.

### The Transport Layer

How do we deal with the packets once they've been received? That's what the transport layer is for. This layer defines the communication between endpoints.

#### Ports

A concept many people know about but know little about, _ports_ are an important part of the transport layer. Regardless of the protocol used (we'll come back to that in a second) every connection needs a port. All that makes up a port is a 16-bit number identifying a service available at a given IP address. Since any given machine can have multiple services running at any given time, being able to distinguish between them is crucial.

Just like IP addresses, we reserve specific ports for different things;

- **0 - 1023**: Well known ports, reserved for daemons associated with servers and the like. Requires `root` permissions for usage.
- **1024 - 49151**: Registered ports, managed by the Internet Assigned Numbers Authority (**IANA**)
- **49152 - 65535**: Ephemeral ports, these cannot be registered. These are used for temporary ports or private services (internal company stuff)

To run what's being used by your local machine, run `nmap -A localhost`. However, to be safe, only run this on your own machine and in the comfort of your own private space.

#### TCP

Remember how I said we'd come back to protocols? Here we are. _Transmission Control Protocol_, or **TCP**, is a connection transport layer protocol used in things like HTTP and SSH. It guarantees the deliverance of whatever being sent, and actually re-sends any lost packets.

## Chapter Summary

## Chapter Resources

- [Interactive visual CIDR and IP range calculator](https://cidr.xyz/)
- [Why are IPv4 addresses running out? - Network Engineering Stack Exchange](https://networkengineering.stackexchange.com/questions/53935/why-are-ipv4-addresses-running-out)
- [How to Read `ip addr`](https://samuel-ricky.medium.com/how-to-interpret-the-output-of-ip-addr-show-8008c7c41dde)
-

---

Next:
