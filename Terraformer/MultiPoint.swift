//
//  MultiPoint.swift
//  Terraformer
//
//  Created by Josh Yaganeh on 6/11/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

//extension Terraformer {
//    class MultiPoint: GeoJson, Geometry, Coordinates, Sequence {
//        var coordinates = Point[]()
//        
//        var count: Int {
//        get {
//            return coordinates.count
//        }
//        }
//        
//        init() { }
//        
//        convenience init(points: Point[]) {
//            self.init()
//            coordinates = points
//        }
//        
//        convenience init(points: Point...) {
//            self.init(points: points)
//        }
//        
//        convenience init(_ coords: Double[]...) {
//            self.init()
//            for c in coords {
//                coordinates.append(Point(x: c[0], y: c[1]))
//            }
//        }
//        
//        subscript(index: Int) -> Point {
//            get {
//                return coordinates[index]
//            }
//            set {
//                coordinates[index] = newValue
//            }
//        }
//        
//        func generate() -> GeneratorOf<Point> {
//            return GeneratorOf(coordinates.generate())
//        }
//
//        func type() -> GeoJsonType {
//            return GeoJsonType.MultiPoint
//        }
//    }
//}