---
layout: site
title: Home
---
Cloud Haskell: Erlang-style concurrent and distributed programming in Haskell.
The Cloud Haskell Platform consists of a
[generic network transport API](https://github.com/haskell-distributed/distributed-process/tree/master/packages/network-transport),
libraries for sending [static closures](https://github.com/haskell-distributed/distributed-process/tree/master/packages/distributed-static) to remote nodes, a rich [API for distributed programming](https://github.com/haskell-distributed/distributed-process/tree/master/packages/distributed-process) and a
set of platform libraries modelled after Erlang's [Open Telecom Platform](http://www.erlang.org/doc/).

Generic network transport backends have been developed for
[TCP](https://github.com/haskell-distributed/distributed-process/tree/master/packages/network-transport-tcp) and
[in-memory](https://github.com/haskell-distributed/distributed-process/tree/master/packages/network-transport-inmemory)
messaging, and several other implementations are available including a transport for
[Windows Azure](https://github.com/haskell-distributed/distributed-process-azure). The [wiki](/wiki.html) provides links to a number of resources for learning about the conceptual underpinnings of Cloud Haskell, and some [examples](https://github.com/haskell-distributed/distributed-process-demos).

Documentation is available on this site for HEAD, or
[hackage](http://hackage.haskell.org/package/distributed-process) for the current and preceding versions of
each library.
