//
//  DataStructuresTests.swift
//  DataStructuresTests
//
//  Created by Alex Usbergo on 29/12/15.
//  Copyright © 2015 Alex Usbergo. All rights reserved.
//

import XCTest
import DataStructures

class DataStructuresTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLinkedList() {
        
        let linkedList = LinkedList<Int>()
        XCTAssert(linkedList.count == 0)
        
        linkedList.append(1)
        XCTAssert(linkedList[0] == 1)
        XCTAssert(linkedList.count == 1)
        
        linkedList.append(2)
        XCTAssert(linkedList[1] == 2)
        XCTAssert(linkedList.count == 2)
        
        linkedList.append(3)
        XCTAssert(linkedList[2] == 3)
        XCTAssert(linkedList.count == 3)
        
        linkedList.append(4)
        XCTAssert(linkedList[3] == 4)
        XCTAssert(linkedList.count == 4)
        
        linkedList.append(5)
        XCTAssert(linkedList[4] == 5)
        XCTAssert(linkedList.count == 5)
    }
    
    let numberOfTries = 100
    
    func testLinkedListPerformance() {
        
        measureBlock { () -> Void in
            let l = LinkedList<Int>()
            for i in 1...self.numberOfTries { l.append(i) }
            let _ = l.reduce(0, combine: { return $0 + $1 })
            
            for i in 1...self.numberOfTries {
                if i%10 == 0 { XCTAssert(l.contains(i)) }
            }
            
            for i in 1...self.numberOfTries {
                if i % 2 == 0 { l.removeFirst() }
                else { l.removeLast() }
            }
            
            XCTAssert(l.count == 0)
        }
    }
    
    func testArrayPerformance() {
        
        measureBlock { () -> Void in
            var l = Array<Int>()
            for i in 1...self.numberOfTries { l.append(i) }
            let _ = l.reduce(0, combine: { return $0 + $1 })
            
            for i in 1...self.numberOfTries {
                if i%10 == 0 { XCTAssert(l.contains(i)) }
            }
            
            for i in 1...self.numberOfTries {
                if i % 2 == 0 { l.removeFirst() }
                else { l.removeLast() }
            }
            
            XCTAssert(l.count == 0)
        }
    }
    
    func testGraph() {
     
        let g = Graph<Int>(arrayLiteral: 1,7,4,3,5,2,6)
        g.directed = true
        g.weighted = true
        
        g.addEdge(g[1], to: g[2], weight: 2)
        g.addEdge(g[1], to: g[3], weight: 3)
        g.addEdge(g[1], to: g[5], weight: 6)
        g.addEdge(g[2], to: g[4], weight: 1)
        g.addEdge(g[4], to: g[5], weight: 1)
        g.addEdge(g[5], to: g[6], weight: 10)

        //bfs visit expected [1, 2, 3, 5, 4, 6]
        let bfs = g.traverseBreadthFirst().map() { return $0.value }
        XCTAssert(bfs.count == 6)
        XCTAssert(bfs == [1,2,3,5,4,6])
        
        //shortest path from 1 to 5, expected [1, 2, 4, 5] with cost 4
        let p = g.shortestPath(g[1], to: g[5])
        XCTAssert(p?.cost == 4)
        XCTAssert((p?.vertices.map(){ return $0.value})! == [1,2,4,5])
        
    }
    
}
