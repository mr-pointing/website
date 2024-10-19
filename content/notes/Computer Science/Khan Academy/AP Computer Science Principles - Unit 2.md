---
aliases: 
draft: false
tags:
  - computerscience
  - internet
title: AP Computer Science Principles - Unit 2
date: 2024-08-14
updated: 2024-10-09T18:11
---

-------------------------------------------------------------------------------


# Unit 2: The Internet


The internet is a global connection of computers communicating with one another. The constant flow of input and output keeps the internet going. 

It's an *open* system, meaning anyone can join given they follow the proper **protocols**. These include but aren't limited too:

- **IP:** Protocol for identifying IP addresses with some routing strategy to send and receive information
- **TCP/UDP:** Protocols that transfer packets of data that check for errors along the route
- **TLS:** Protocol for encrypting data
- **HTTP & DNS:** Protocols for internet browsers

Even though we likely use the internet everyday, a lot of these protocols are so far abstracted that we hardly have to think about these. That doesn't mean we shouldn't understand them.


## Connecting Networks

We can define a *computer network* as any group of interconnecting computing devices (any device that can run a program) that are capable of sending and receiving data. This makes the internet the largest computer network in the world.

### Building a Network

When creating a network, you have to consider the **network topology**, or the way in which your devices connect. Let's consider we have six different computers. You can see below that we have a few different ways of connecting these six devices. Some all can talk to one another, where some they have to go through one or more devices.

{{< image src="/images/topologies_image.svg" alt="Topologies Image" position="center" style="border-radius: 8px;" >}}
[Source](https://www.khanacademy.org/computing/ap-computer-science-principles/the-internet/x2d2f703b37b450a3:connecting-networks/a/computer-networks-overview)

### Types of Networks

**LAN** or Local Area Network is a small, limited network that covers areas like a home or school. **WAN** or Wide Area Network covers large geographic ground, and is actually made up of many LAN's communicating. **DCN** is a Data Center Network that relies on instant data transfer (think number data, statistics, not so much visual or graphics).


### Physical Network Connections

**Copper cables** make up lots of connections throughout the world, on LAN and WLAN. We can find an **Ethernet** cable laying around anywhere; if we cut it open, we'd find four twisted-pair copper wires. These cables transmit electricity in the form of binary electric signals and are understood via the Ethernet standards. 

**Fiber-optic cables** work similarly to copper cables and follow the Ethernet standard, but use pulses of light instead of electricity to pass along binary signals. Since they use light they can transfer information faster (up to ~25 Tbps), and they're commonly used to connect networks across oceans. The biggest downside is the cost being on the expensive side.

**Wireless connections** are exactly what they sound like; network connections without an initial cable connection. A computing device will send out a signal in binary radio waves through the air. The waves should be picked up by a wireless access point, **WAP**, which is connected through some copper or fiber-optic cables.  


## Bit rate, Bandwidth, and Latency

### 1's and 0's

We know that computers transmit all of their data through binary. There are two main ways this is done, let's use the example of sending the number 5 (101);

1) We could use three cables to send the signal all at once; 1 on, 1 off, and another 1 on.
2) We could use one cable, and transmit a character or number over a set amount of time. As long as both computers communicating agree on the same amount of time, the receiving computer will wait for the entire on, off, on to happen on a single wire. We call this *line coding*.

### Bit Rate

We can measure the amount of bits sent each second, and determine the speed of a connection through this *bit rate*. The internet first began with speeds around 75 bps (bits per second), while today we have speeds in the Mbps (megabits per second) and Gbps (gigabits per second).


| Unit    | Number of Bits |
| ------- | -------------- |
| kilobit | 1000           |
| megabit | 1000^2         |
| gigabit | 1000^3         |
| terabit | 1000^4         |
| petabit | 1000^5         |


### Bandwidth

Simply the maximum bit rate of a given system. If your system has a bandwidth of 10 Gbps, it can transfer speeds at no faster than 10 gigabits per second (which is very fast).


### Latency

Instead of measuring how fast a system can transfer data, we can measure how late said bits arrive. This is the measure of *latency*. If I send a message to a server, and it takes 30 milliseconds, and the response back from the server that my message was received took 50 milliseconds to get back, we would say the round-trip latency of 80 ms.


### Internet Speed

The speed of our internet is made up of a combination of your bandwidth and latency. Computers communicate in a packet-exchange system; a computer cannot send another message until the first packet was received. Because of this, our bandwidth is only part of it, since latency will determine the speed of sending and receiving said packets. 

We can also use the term *ping* to refer to latency. Upon running a [speed test](https://www.speedtest.net/) we will often see faster download than upload. This makes sense, since most users will need to download data more often than upload (think visiting sites and loading text, images, videos, etc.)

## IP Addresses

Meaning **Internet Protocol**, it's one of the most important protocols that comprise the internet. All online communication, addressing and routing, are done through here.

*IP addresses* are the unique key that identify a device to the internet. When sending a request, or message to another computer, both the sender and the recipients IP addresses are sent. There are two main versions of addresses; IPv4 and IPv6. The first is the first type of address ever for the internet, and the later is a backwards-compatible successor.

### IPv4

This is a basic IP address: 74.125.20.113

Wonder what it's for? Type it in your browser to visit it.

As you can see, the syntax is four numbers between 0 and 255 separated by periods. As we know, this means it's really easy for the computer to store the address in 8 binary bits for each number. 

### IPv6

Here's a IPv6 address: 2001:0db8:0000:0042:0000:8a2e:0370:7334

Since there can only be `2^32` IPv4 addresses, IPv6 are designed to include hexadecimal numbers, allowing for *way* more.


### The Hierarchy of an Address

Similar to a phone number, the IP address can be broken down to make it easier to send and route messages.

The first sequence of bits represents the network used for the address, and the final bits identify the specific node in the network (almost exactly how phone numbers work).


## Routing with Redundancy

### IP Packets

Since messages can be small as pings to large files and pages, there has to be a limit. In order to keep things manageable, networking protocols break down messages into digestible *packets*.

Packets have two components, **headers**, which make up the information about data being sent as well as the IP addresses, and the actual **data**.

First, packets are sent to a router. Once at the router, the router will look at the packets destination IP address, and consult it's *forwarding table*, which is a list of IP address prefixes that are common. The layout is hierarchical. It will try to send the packet to another router that's closer to the destination until it has finally reached it, going through a variable amount of routers along the way.

### Redundancy & Fault Tolerance

When accessing the internet, there are often many different paths a packet can take. In the event a path closes, usually there is another path that the packets of data can take. This concept is called *redundancy*, the redundancy of a network can be measured by the amount of network availability.

We consider the internet **Fault Tolerant** because it can experience failure without having the entire system become unusable. To this day, no one has been able to completely break the internet, due to how interconnected it is around the world. A *point of failure* is any connection that would completely severe the network.


### Transporting Packets

Now that we can conceptualize how the internet works, it's a wonder anything gets done. There are lots of issues that can possibly occur; If a computer sends multiple messages, the computer has to keep track of which *packets* belong to which message. Packets often arrive *out of order*, or can be corrupted for whichever reason. Packets can even be lost; in certain messages, a single packet can mean the message is incomplete.

To circumnavigate these issues, we can use protocols like TCP or UDP to keep track of our packets and handle errors.

**UDP** or User Datagram Protocol is a lightweight data transportation 

The layout of the IP packet is now reformatted as a UDP segment, made up of a header and data portion with the actual payload (data being delivered). The header is made up of the next four sections:

- **Port numbers:** First four bytes of the header. Every networking device can receive messages via different pathways, or *virtual ports*. It stores the port numbers for the source and destination.
- **Segment Length:** The next two bites; storing the length of the segment (maximum length is 65,535).
- **Checksum:** The last two bites of the UDP that is an encoding of the data being transported. Used by the sender (computes a checksum on data in the segment, stores it) and by the receiver (computes checksum on received data, compares with stored; if not the same, data corrupted).


### TCP

**TCP** or *Transmission Control Protocol* is another layer that is used with IP, that's significantly more secure than UDP. It is the most common, and the stack used for the internet is commonly know as *TCP/IP*.

TCP deals with packet loss, out or order packets, and even duplicate and corrupted packets.

The same structure used in UDP is used here, the IP's data segment is reformatted into a TCP segment. However this time the TCP segment's header has all of the UDP (source and destination port number, checksum) and even more. The best way is to walk through each layer sequentially.

##### Step 1: Establish Connection

Before any information is sent anywhere, a *three-way handshake* is made between the source and destination. 

The source will send a packet with just a `SYN` bit set to 1. This is the first computer asking the second to *synchronize*. The second computer, upon receipt, sends back a packet with the `SYN` bit and an additional `ACK` bit set to 1, which indicates the second computers *acknowledgment*. Once the first computer gets these two back, it sends back an `ACK` bit in acceptance of the transfer.

These `SYN` and `ACK` bits are actually part of the TCP header and don't actually contain any data. 

##### Step 2: Send Packets of Data

Anytime data is sent to a destination, that destination must send back a sign of acknowledgement. 

The way it does so is actually quite interesting. The data sent and split into packets will send over both the data and some sequence number. In order to properly acknowledge the data sent, the receiver will send back the `ACK` bit as well as an acknowledgement number increased by the length of the data sent.

Both the *sequence number* and *acknowledgement number* are parts of the TCP header. We'll talk about how these help keep track of things in a minute.

##### Step 3: Close the Connection

Very similar to the first step, we have another three-way handshake that instead of asking to use a `SYN` bit, we use a `FIN` bit set to 1, or *finish*.


#### Detecting Lost Packets

We would consider a packet lost if there was never an acknowledgement sent back from the second computer. To avoid this, TCP uses a timer system that will resend packets after a specific amount of time. In the event that the first packet wasn't lost and just taking a long time to finish, we can delete the duplicate packet. 


#### Handling Out of Order Packets

Thankfully, since we have the sequence and acknowledgement numbers, we can successfully keep an accurate timeline of how our packets are supposed to be ordered. Even if we were to receive them out of order, they can be resorted using the sequence and acknowledgement numbers. 

When sent an out of order packet, the receiver will actually be able to acknowledge this, and sends back the *expected sequence number* in order to show that something is wrong. This will lead to the protocol to check and resort the sequence. 


## Web Protocols

What we understand as the *web* is just a huge interconnected network of web pages, files, and applications we define as the **World Wide Web** (this is where the `WWW` comes from in a URL).

Since the web is clearly huge, it too needs some protocols in order to keep things together. Two we'll look at are *Domain Name System (DNS) protocol* and *HyperText Transfer Protocol (HTTP)*. 

There's also *Transport Layer Security (TLS) protocol* which we're going to look at later. For now, it's important to understand that these protocols are happening on top of the Internet Protocols. TCP/IP is used alongside HTTP requests.


### DNS

Obviously, no one wants to memorize IP addresses. To circumnavigate this inconvenience, **DNS** was invented. A *domain name* is just the address we use in place of the IP address

They don't go into this in Khan Academy, but I was curious about who invented DNS. It was a guy named Paul Mockapetris, and the way the internet used to work is pretty interesting. Before the web as we know it today, every single name to an IP address was stored in a single table within a *single* text file called `HOSTS.TXT`. That means any changes or additions needed to be made by *hand*. Pretty nuts stuff.

The anatomy of DNS is pretty straight forward:

```
[third-level-domain].[second-level-domain].[top-level-domain]
```

The top lever or TLD's are your `.com` or `.org`'s, and the second level belongs to each individual who owns/runs the site (think `loughlin` or `mrpointing`). The third level can be called a sub-level, mostly because it will belong again to the individual who owns the site (some websites will start with `m.` to specify a mobile version).


Now that we understand that, it's again, quite a wonder websites respond so fast. How is it that a computer stores every single domain to IP address relation? Well...it doesn't. There's a step by step process that happens every time you search for a URL:

1. **Cache is Checked**
	- Your browser keeps a list of all the recently visited websites in order to easily retrieve the IP addresses upon request. After a while though, they will eventually be replaced with other more frequented domain-to-IP pairs
2. **Ask the ISP cache**
	- Your *internet service provider* or ISP will have their own local cache, so if you never visited a website but a local neighbor did, your browser would find it there
3. **Ask the Name Servers**
	- There exist around the globe numerous servers that are just up and running for the sake of updating and keeping track of the millions of different domain names
	- There are hierarchy for the servers: root name servers -> TLD name servers -> Host name servers
		1. ISP asks the root name servers which name servers know about the TLD you're looking for, and sends back the IP address of the TLD name server for your TLD
		2. ISP asks that TLD name server which Host name servers know about the second level name you're looking for, and similarly returns that IP address of that specified name Host name server
		3. ISP asks the Host name server what the IP address is for the domain name you're looking for, and returns it

### HTTP

HyperText Transfer Protocol is how your computer downloads and retrieves that page your computer so desperately sought out just a moment ago. Here's how it works:

1. Direct Browser to URL
	- **URL** or *uniform resource locator* is the link to the website you're trying to get
	- The URL is made up of the domain name and the HTTP protocol signal, the `http://` part of the URL
2. Browser Looks Up IP
	- Does the process defined up above of finding the IP address
3. Browser Sends HTTP request
	- I have a note on this already, [Designing a RESTful API]({{< ref "Designing a RESTful API" >}}). It talks about the basics of HTTP a bit more in depth