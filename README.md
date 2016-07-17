Gilded Rose Kata
================

This is a fork of Jim Weirich's implementation of the Gilded Rose Kata.

Resources:

* [Original repo](https://github.com/jimweirich/gilded_rose_kata)
* [Kata](http://iamnotmyself.com/2011/02/13/refactor-this-the-gilded-rose-kata/)

Changes from the original
-------------------------

*Note*: "Original" here refers to [Jim Weirich's code](https://github.com/jimweirich/gilded_rose_kata).

This Ruby version follows the [original code](https://github.com/jimweirich/gilded_rose_kata)
very closely, but has the following changes:

* Updated the tests for style

  I prefer not to use the `Given` / `When` / `Then` structure. I also use
  `expect` in place of `should` which is deprecated. The content of the
  tests remains the same.

* Added a Dockerfile so the project can be run without having to set up
Ruby and RSpec

* Uses Make as a task runner

  No real reason other than personal familiarity. These are lightweight
  wrappers and Make is not needed for running the Dockerised project.

As per the original, the `master` branch contains the starting point
for the kata.

Setup
-----

The easiest way is to use [Docker](https://www.docker.com/).

Build the image:

```sh
make build
```

Run the tests:

```sh
make test
```

If you don't have/want to use Docker, the [original instructions](https://github.com/jimweirich/gilded_rose_kata#installation-hints) still work.

Development
-----------

After making any changes, the project image needs to be rebuilt with
the changed files before running the tests. This can be done in one
command with:

```sh
make build test
```

Alternatively, you can skip the build step by mounting local volumes
into the Docker container:

```sh
make test MOUNT_VOLUMES=true
```

Check the `Makefile` for other tasks that may be useful in development
with Docker.

Original Description of the Gilded Rose
---------------------------------------

Hi and welcome to team Gilded Rose. As you know, we are a small inn
with a prime location in a prominent city run by a friendly innkeeper
named Allison. We also buy and sell only the finest
goods. Unfortunately, our goods are constantly degrading in quality as
they approach their sell by date. We have a system in place that
updates our inventory for us. It was developed by a no-nonsense type
named Leeroy, who has moved on to new adventures. Your task is to add
the new feature to our system so that we can begin selling a new
category of items. First an introduction to our system:

- All items have a SellIn value which denotes the number of days we
  have to sell the item
- All items have a Quality value which denotes how valuable the item
  is
- At the end of each day our system lowers both values for every item

Pretty simple, right? Well this is where it gets interesting:

  - Once the sell by date has passed, Quality degrades twice as fast
  - The Quality of an item is never negative
  - "Aged Brie" actually increases in Quality the older it gets
  - The Quality of an item is never more than 50
  - "Sulfuras", being a legendary item, never has to be sold or
    decreases in Quality
  - "Backstage passes", like aged brie, increases in Quality as it's
    SellIn value approaches; Quality increases by 2 when there are 10
    days or less and by 3 when there are 5 days or less but Quality
    drops to 0 after the concert

We have recently signed a supplier of conjured items. This requires an
update to our system:

- "Conjured" items degrade in Quality twice as fast as normal items

Feel free to make any changes to the UpdateQuality method and add any
new code as long as everything still works correctly. However, do not
alter the Item class or Items property as those belong to the goblin
in the corner who will insta-rage and one-shot you as he doesn't
believe in shared code ownership (you can make the UpdateQuality
method and Items property static if you like, we'll cover for
you). Your work needs to be completed by Friday, February 18, 2011
08:00:00 AM PST.

Just for clarification, an item can never have its Quality increase
above 50, however "Sulfuras" is a legendary item and as such its
Quality is 80 and it never alters.
