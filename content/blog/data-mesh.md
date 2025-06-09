---
title: What Exactly is a Data Mesh?
date: 2022-09-03
---

There's a lot of talk around data meshes these days. It didn't click for me until I read [How to Move Beyond a Monolithic Data Lake to a Distributed Data Mesh](https://martinfowler.com/articles/data-monolith-to-mesh.html).

**A data mesh is like a microservice architecture for data.**

Applying a service-oriented architecture to applications and programs leads to microservices, which have been around in the software industry for some time now. Applying the same pattern to _data_ leads to a data mesh.

Whether a team's product is an application or data:

- Domain teams are responsible for maintaining their own product
- They define an API for other teams to interact with their product
- They define SLOs to make promises around the quality and characteristics of their product
- Other products query/pull as _they_ need, rather than pushing or publishing outward
- Implementation details are left up to the product team. Just like an application may choose which libraries it wants to use to deliver its results, a data team can choose how and where to store its intermediate data or how to structure its data transformation pipelines.
- Products are cataloged in some centrally available discovery tool so that the organization has a place for finding products
- Care must be taken to ensure that global definitions of the same concept are in line (in other words, the same ideas are represented consistently across the organization)
- Products are secure, etc.

Readings and resouces:

1. [How to Move Beyond a Monolithic Data Lake to a Distributed Data Mesh](https://martinfowler.com/articles/data-monolith-to-mesh.html)
1. [Data Mesh Principles and Logical Architecture](https://martinfowler.com/articles/data-mesh-principles.html)
1. [Dodging the data bottleneck — data mesh at Starship](https://www.starship.xyz/medium_blog_posts/dodging-the-data-bottleneckdata-mesh-at-starship/)
