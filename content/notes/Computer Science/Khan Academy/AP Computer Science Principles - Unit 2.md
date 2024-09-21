---
aliases: 
draft: false
tags:
  - computerscience
title: AP Computer Science Principles - Unit 2
date: 2024-08-14
updated: 2024-09-20T12:15
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