---
aliases:
  - HTTP
draft: true
tags:
  - computerscience
  - youtube
  - internet
title: Browsers HTTP and You!
date: 2024-07-18
---
Modified: July 19 2024 

[Link](https://www.youtube.com/watch?v=ZazQd2BCA08&list=PLU-P2PlzpIf3EpWfxk-Mu_ZVJVS5Wb-_e&index=36) to video.

-------------------------------------------------------------------------------

### Request/Response Cycle

It's like a conversation. Client and server advertise capabilities and supported formats to one another.

HTTP is stateless, but the implementation will do state like things like caching. You need to see both sides of the conversation.

### Anatomy of a request

```http
GET / HTTP/1.1
Host: localhost:8001

Request body.
```

### Anatomy of a response

```http
HTTP/1.0 200 OK
X-Headers: Here

Response body.
```

### Request headers

Sent automatically...when not doing Ajax

When sending `img`, `css`, or `script` requests, Cookies are sent.
