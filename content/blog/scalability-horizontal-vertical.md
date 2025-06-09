---
title: Horizontal vs Vertical Scalability
date: 2022-07-10
---

## What is scalability?

Simply put, *scalability* is the ability to adjust the capacity of a system (up or down) to efficiently meet demand. The growth of the system can be in different dimensions (size of data, concurrency requirements, and interaction rates) and can typically be measured by work throughput (requests per second, concurrent users, data processing, etc.).

## Types of scaling

### Vertical scaling

*Vertical scaling* powers up a single machine to increase performance. This might normally be done by upgrading the hardware or increasing the network throughput:

- Increase the I/O capacity via hard drives in [RAID arrays](https://en.wikipedia.org/wiki/RAID)
- Reduce I/O access times by switching to SSDs
- Reduce the number of I/O operations required by increasing RAM
- Increase network throughput by upgrading network interfaces or installing new ones
- Increase the number of CPU cores or make existing ones more powerful

For example, in the cloud it's easy to increase processing capacity by upgrading the instance type&mdash;just select your new type and reboot the VM. It's quite easy to develop within this paradigm, as everything runs on one server (avoiding slow cross-machine communication) and most programming languages support multithreading.

Although these upgrades are relatively simple, but can quickly become very expensive, and because the highest-end hardware is very expensive you get relatively poor performance for the price. The capacity of the system is still limited by the power of the one machine, and the machine acts as a single point of failure. Depending on which area you want to scale, it can sometimes take a long time to scale up as well.

### Horizontal scaling

*Horizontal scaling* is needed to perform at the global scale. Instead of upgrading the power of one machine, we increase the system's capacity by adding more servers. Ideally all workers are identical and replaceable, and if one goes down, we can add a new one to take its place ([cattle not pets](https://devops.stackexchange.com/questions/653/what-is-the-definition-of-cattle-not-pets)).

There is significant architectural overhead with adopting this approach, so it requires a big upfront investment but pays off later in scale. Communication between machines is now required in order to coordinate work, and this introduces a slew of potential problems and slowdowns. Once your application is set up to allow for this type of scaling, you can simply purchase more VM instances and they're available within minutes. Having replaceable workers also provides helpful redundancy in case of failures.

## References

- [Northwestern CS 310: Scalable Software Architectures](<https://www.mccormick.northwestern.edu/computer-science/academics/courses/-> [Web Scalability for Startup Engineers](https://www.amazon.com/Scalability-Startup-Engineers-Artur-Ejsmont/dp/0071843655)
- [Introduction to Architecting Systems for Scale](https://lethain.com/introduction-to-architecting-systems-for-scale/)
