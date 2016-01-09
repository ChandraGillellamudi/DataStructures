# DataStructures

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build](https://img.shields.io/badge/build-passing-green.svg?style=flat)](#)
[![Platform](https://img.shields.io/badge/platform-ios | osx | watchos | tvos -lightgrey.svg?style=flat)](#)
[![Build](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://opensource.org/licenses/MIT)

A collection of data structures implemented in Swift.
For the time being the available data structures are:

- LinkedList
- SortedLinkedList
- Stack
- Queue
- Graph 
- BinaryHeap
- PriorityQueue*
- BloomFilter*
- Trie*
- Multimap*
- Bimap*
- Bag
- RedBlackTree

## Installation

### Carthage

To install Carthage, run (using Homebrew):

```bash
$ brew update
$ brew install carthage
```

Then add the following line to your `Cartfile`:

```
github "alexdrone/DataStructures" "master"    

```

## Usage

All collection types are implemented as structures with the exception of the LinkedList data structure. This means they are copied when they are assigned to a new constant or variable, or when they are passed to a function or method. 

About copying structs:  

> The behavior you see in your code will always be as if a copy took place. However, Swift only performs an actual copy behind the scenes when it is absolutely necessary to do so. Swift manages all value copying to ensure optimal performance, and you should not avoid assignment to try to preempt this optimization.

## Walkthrough


###LinkedList

All of the operations perform as could be expected for a doubly-linked list. Operations that index into the list will traverse the list from the beginning or the end, whichever is closer to the specified index.

Note that this implementation is not synchronized. If multiple threads access a linked list concurrently, and at least one of the threads modifies the list structurally, it must be synchronized externally.

```swift
import DataStructures

let linkedList = LinkedList<Int>()
linkedList.append(1)
linkedList.append(2)

print(linkedList) //[1,2]

let sortedLinkedList = SortedLinkedList<Int>()
linkedList.append(3)
linkedList.append(1)
linkedList.append(2)

print(sortedLinkedList) //[1,2,3]

```


###Graph

A graph can be constructed from a array literal, or a dependency list.
Operations like *BFS* and *DFS* visit, *shortestPath* and *topologicalSort* are available to the user.

Note that this implementation is not synchronized, it must be synchronized externally.

```swift
import DataStructures

//Graph (graphs can be directed/undirected and weighted/not weighted)
let graph = Graph<Int>(arrayLiteral: 1,7,4,3,5,2,6)

graph.addEdge(graph[1], to: graph[2])
graph.addEdge(graph[1], to: graph[3])
graph.addEdge(graph[1], to: graph[5])
graph.addEdge(graph[2], to: graph[4])
graph.addEdge(graph[4], to: graph[5])
graph.addEdge(graph[5], to: graph[6])
        

//bfs visit expected [1, 2, 3, 5, 4, 6]
let bfs = g.traverseBreadthFirst().map() { return $0.value }

//shortest path

var g = Graph<Int>(arrayLiteral: 1,7,4,3,5,2,6)
g.directed = true
g.weighted = true

g.addEdge(graph[1], to: graph[2], weight: 2)
g.addEdge(graph[1], to: graph[3], weight: 3)
g.addEdge(graph[1], to: graph[5], weight: 6)
g.addEdge(graph[2], to: graph[4], weight: 1)
g.addEdge(graph[4], to: graph[5], weight: 1)
g.addEdge(graph[5], to: graph[6], weight: 10)

//..or you can use the shorthand subscript to create an edge
 graph[1,2] = 2
 graph[1,3] = 3
 graph[1,5] = 6
 graph[2,4] = 1
 graph[4,5] = 1
 graph[5,6] = 10


//shortest path from 1 to 5, expected [1, 2, 4, 5] with cost 4
let p = graph.shortestPath(g[1], to: g[5])
(p?.vertices.map(){ return $0.value} //[1,2,4,5]

///topological sort and cycle check
let noCycle: Dictionary<String, [String]> = [ "A": [],  "B": [],  "C": ["D"], "D": ["A"], "E": ["C", "B"],  "F": ["E"] ]

var g = Graph<String>(directed: true, weighted: false)
g.populateFromDependencyList(noCycle)

g.isDirectedAcyclic() //true
g.topologicalSort() // ["A", "B", "D", "C", "E", "F"]
 

```

###Stack and Queue

Stacks and Queues are implemented through Array and LinkedList extension
Note that this implementation is not synchronized, it must be synchronized externally.

```swift

extension LinkedList : Stack {
    public func pop() -> T?
    public func push(element: T)
    public func peekStack() -> T?
}

extension Array : Stack {
    public func pop() -> T?
    public func push(element: T)
    public func peekStack() -> T?
}

extension LinkedList: Queue {
    public func enqueue(element: Q)    
    public func dequeue() -> Q?     
    public func peekQueue() -> Q?
}

extension Array: Queue {
    public func enqueue(element: Q)    
    public func dequeue() -> Q?     
    public func peekQueue() -> Q?
}

```

###PriorityQueue
An unbounded priority queue based on a priority heap. The elements of the priority queue are ordered according to the sort closure passed as argument in the constructor.
The head of this queue is the least element with respect to the specified ordering. If multiple elements are tied for least value, the head is one of those elements -- ties are broken arbitrarily.

Note that this implementation is not synchronized. Multiple threads should not access a PriorityQueue instance concurrently if any of the threads modifies the queue

```swift
import DataStructures

var pQueue = PriorityQueue<Int>(<)
pQueue.enqueue(3)
pQueue.enqueue(1)
pQueue.enqueue(2)
pQueue.dequeue() // 1

```

###BloomFilter

A Bloom filter is a space-efficient probabilistic data structure that is used to test whether an element is a member of a set. False positive matches are possible, but false negatives are not, thus a Bloom filter has a 100% recall rate. In other words, a query returns either "possibly in set" or "definitely not in set".

```swift

import DataStructures

var bFilter = BloomFilter<String>(expectedCount: 100)
bFilter.insert("a")
bFilter.contains("a") // true

```

###Trie

Is an ordered tree data structure that is used to store a dynamic set or associative array where the keys are strings.
Note that this implementation is not synchronized, it must be synchronized externally.


```swift

import DataStructures

var trie = Trie()
trie.insert("A")
trie.insert("AB")
trie.findPrefix("A") // ["A", "AB"]

```
###RedBlackTree

A red–black tree is a kind of self-balancing binary search tree. 
Balance is preserved by painting each node of the tree with one of two colors (typically called 'red' and 'black') in a way that satisfies certain properties, which collectively constrain how unbalanced the tree can become in the worst case.


The balancing of the tree is not perfect but it is good enough to allow it to guarantee searching in O(log n) time, where n is the total number of elements in the tree. The insertion and deletion operations, along with the tree rearrangement and recoloring, are also performed in O(log n) time.

Note that this implementation is not synchronized, it must be synchronized externally.

```swift
import DataStructures

 let tree = RedBlackTree<Int>(arrayLiteral:[1, 3, 5, 6, 7, 8, 9])
 tree.popFirst()

```

###Multimap

A generalization of a map or associative array data type in which more than one value may be associated with and returned for a given key.
Note that this implementation is not synchronized, it must be synchronized externally.


```swift

import DataStructures

var multimap = Multimap<String, Int>()
multimap.insertValue(1, forKey: "a")
multimap.insertValue(5, forKey: "a")
multimap["a"] // [1, 5]

```

###Bimap

A generalization of a map or associative array data type in which more than one value may be associated with and returned for a given key.
Note that this implementation is not synchronized, it must be synchronized externally.


```swift

import DataStructures

var bimap = Bimap<String, Int>()
bimap[key: "a"] = 1
bimap[value: 3] = "b"
bimap[value: 1] // "a"
bimap[key: "b"] // 3

```

###Bag

Similar to a set but allows repeated ("equal") values (duplicates). This is used in two distinct senses: either equal values are considered identical, and are simply counted, or equal values are considered equivalent, and are stored as distinct items. 

```swift

import DataStructures

var bag = Bag<String>()
bag.insert("a")
bag.insert("b")
bag.insert("a")
bag.distinctCount // 2
bag.count("a") // 2

```




## Credits
\* The PriorityQueue,Multimap,Bimap and BloomFilter data structures are forked from the excellent [Buckets](https://github.com/mauriciosantos/Buckets-Swift/) github project. I higly suggest to check it out!
The RedBlackTree datastructure is adapted from [SwiftDataStructures](https://github.com/oisdk/SwiftDataStructures) 