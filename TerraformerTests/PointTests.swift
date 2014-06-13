////
////  PointTests.swift
////  Terraformer
////
////  Created by Josh Yaganeh on 6/11/14.
////  Copyright (c) 2014 esri. All rights reserved.
////
//
//import XCTest
//import Terraformer
//
//class PointTests: XCTestCase {
//    var point = Terraformer.Point(x: 0, y: 0)
//    
//    override func setUp() {
//        super.setUp()
//        
//        self.point = Terraformer.Point(x: 10, y: 10)
//    }
//    
//    override func tearDown() {
//        super.tearDown()
//    }
//
//    func testConvenienceAccessors() {
//        XCTAssertEqual(self.point.x, 10.0)
//        XCTAssertEqual(self.point.y, 10.0)
//    }
//    
//    func testCoordinateGetter() {
//        XCTAssertEqualObjects(self.point.coordinates, [10.0, 10.0])
//    }
//    
//    func testCoordinateSetters() {
//        self.point.x = 5.0
//        self.point.y = 5.0
//        XCTAssertEqualObjects(self.point.coordinates, [5.0, 5.0])
//    }
//}