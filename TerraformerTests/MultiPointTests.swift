//
//  MultiPointTests.swift
//  Terraformer
//
//  Created by Josh Yaganeh on 6/11/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import XCTest
import Terraformer

class MultiPointTests: XCTestCase {
    var mp = Terraformer.MultiPoint(points: Array<Terraformer.Point>())
    var p1 = Terraformer.Point(x: 0, y: 0)
    var p2 = Terraformer.Point(x: 1, y: 1)
    
    override func setUp() {
        super.setUp()
        
        mp = Terraformer.MultiPoint(points: [p1, p2])
    }
    
    func testCoordinates() {
        XCTAssertEqualObjects(mp[0].coordinates, p1.coordinates)
        XCTAssertEqualObjects(mp[1].coordinates, p2.coordinates)
    }
    
    func testGenerator() {
        var count = 0
        for p in mp {
            count++
        }
        XCTAssertEqual(count, mp.count)
    }
    
    func testBbox() {
        Terraformer.bbox(mp)
    }
}