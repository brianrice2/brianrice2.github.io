---
title: Spatial Indexing
date: 2022-07-13
---

Compared to regular B- and B+-trees used for relational table indexes, spatial indexes are key for multidimensional data. Instead of indexing the features themselves, they index the _bounding boxes_ (minimum bounding rectangles) of the features. This allows the DBMS to do a quick check to identify if the MBR is relevant; if it is, it can do a slower but more precise check.

## Quadtrees

_Quadtrees_ are a type of tree data structure commonly used to divide two-dimensional space into quadrants (typically rectangles, although regions may have arbitrary shapes). A quadtree requires that every internal node has exactly four children&mdash;each child is either a point or a smaller region.

However, quadtrees are not balanced and are divided according to insertion order, so can degenerate in cases of data skew or unfavorable insertion order.

- [Wikipedia](https://en.wikipedia.org/wiki/Quadtree)
- [Jim Kang](https://jimkang.com/quadtreevis/)

![Quadtree. From https://opendsa-server.cs.vt.edu/ODSA/Books/fisd/cs3/fall-2020/1B_-_Adv_CS/html/_images/PRexamp.png](quadtree.png)

## R-trees

The _R-tree_ is the natural extension of the B-tree to higher dimensions. The root node has at least two children, and each internal node has between m and M children. Each node's stored data is the minimum bounding rectangle for its children.

![R-tree. From https://media.springernature.com/original/springer-static/image/prt%3A978-0-387-39940-9%2F18/MediaObjects/978-0-387-39940-9_18_Part_Fig3-300_HTML.jpg](r-tree.jpg)

## Grid files

_Grid files_ index points only, and use a k-dimensional array as an index which points to larger data pages/buckets for storage.

![Grid file. From https://raw.github.com/alexeygrigorev/wiki-figures/master/ulb/dbsa/ind/grid-files-ex1.png](grid-files.png)

## k-d-B trees

_k-d-B-trees_ subdivide space into two half-spaces according to comparison in one dimension (like a k-d tree), but keep the tree balanced like a B-tree.

- [k-d-B trees](https://en.wikipedia.org/wiki/K-D-B-tree)
- [k-d-B trees](https://xlinux.nist.gov/dads/HTML/kdbtree.html)
- [k-d trees](https://en.wikipedia.org/wiki/K-d_tree)

![k-d-B tree. From https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/KBDtreeStructure.png/220px-KBDtreeStructure.png](kdb-tree.png)

## Other References

- [PostGIS](https://postgis.net/workshops/postgis-intro/indexing.html#how-spatial-indexes-work)
