---
toc: false
layout: post
description:
categories: [swe]
title: Abstractions - The Most Important Piece of Building Software?
---

During my limited time as a software engineer so far, one thing has risen to be a pretty good indicator of how difficult it will be to build and maintain the project: the abstractions. The ability to identify and separate different moving parts is a very valuable skill to have.

In practice, this comes down to a few more specific things:

- Logical and relevant grouping of code
- Having functions do only one thing
- Naming functions based on verbs and behaviors (or _what_ is being done) rather than implementation (_how_ it's being done)

Besides the Holy Grails of Software like SOLID and DRY adherence, it also just makes the workday more enjoyable. I have a lot easier time thinking about what the function _should do_ and _actually does_ when  it's written at a third-grade level, and this also means that it's easy to write simple tests on its behavior.

Plus, a good set of abstractions makes future improvements really easy (Everybody has their own take on writing futureproof software, but right now I'm in the boat of writing clear and simple code that meets the requirements _without_ trying to write tomorrow's software today. People are pretty bad about predicting what we'll need in the future – politicians, stock traders, and, yes, even programmers). Got a slow search or sort algorithm? Swap out the code in that one function and you're all set. Need to use a different SQL templating framework? No problem. The database connection mechanism probably shouldn't change.

In physical training we like to shoot for the [minimum effective volume](https://rpstrength.com/training-volume-landmarks-muscle-growth/), which is just enough volume to actually improve without nearly as much injury risk as the _most_ you can tolerate. But in software, things skew towards the maximum tolerable complexity – the teetering point at which we can just barely maintain the system. With all due respect, developing a software project that assumes my coworkers are at a high school level would probably (hopefully?) yield clarity and simplicity in the code, tests, and documentation. Your coworkers won't walk away thinking you're a genius, but they'll walk away knowing what's going on. In the era of hypercomplexity, Stupid Simple Software is the way for our work to outlive our tenure.
