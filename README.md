# Indiana Digital Family Tree

Indiana digital family tree structure for checking relatives and adding new family member

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for testing & production purposes. 

### Prerequisites

The following are required to run the digital tree application

```
Ruby
Rspec

```

### Installing

A step by step to get the application Up and running

For MAC OS

```
$ brew install ruby
```

For Centos OS

```
$ sudo yum install ruby

```

Install Rspec Testing Framework

```
$ bundle install

```

## Running Unit test

```
$ rspec

```

### Run App

Navigate into the project Directory

```
$ ruby init.rb
```

### To Add new member
```
> add member
```

### Add Instructions

```
Husband=name Wife=name
Mother=name Son=name
Mother=name Daughter=name
```

### Finding Relatives

To check relations in the family tree, enter input in this format

```
$ Action > find
```

```
$ Input Parameter > Person=Alex Relation=Brothers
```

### Find Instructions Available

```
Person=name Relation=Brothers
Person=name Relation=Sisters
Person=name Relation=Aunts
Person=name Relation=Uncles
Person=name Relation=Cousins
Person=name Relation=Father
Person=name Relation=Mother
Person=name Relation=Granddaughters
Person=name Relation=Grandsons
Person=name Relation=Grandfather
Person=name Relation=Grandmother
```

## Built With

* [Ruby] - Programming Language
* [Rspec](https://http://rspec.info//) - Unit test framework
* [YAML] - Data storage


## Authors

* **Osegbemoh Dania ** 
