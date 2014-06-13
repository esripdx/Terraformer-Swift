//
//  Point.swift
//  Terraformer
//
//  Created by Josh Yaganeh on 6/11/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class Point : Geometry {
        var coordinates = Double[]()
        
        // Convenience accessors
        var x : Double {
        get { return coordinates[0] }
        set { coordinates[0] = newValue }
        }
        
        var y : Double {
        get { return coordinates[1] }
        set { coordinates[1] = newValue }
        }
        
        var latitude : Double {
        get { return y }
        set { y = newValue }
        }
        var longitude : Double {
        get { return x }
        set { x = newValue }
        }
        
        // todo: should this validate that length >= 2?
        init(coordinate: Double[]) {
            coordinates = coordinate
        }
        
        convenience init(latitude: Double, longitude: Double) {
            self.init(coordinate: [longitude, latitude])
        }
        
        convenience init(x: Double, y: Double) {
            self.init(coordinate: [x, y])
        }
        
        override func type() -> GeoJsonType {
            return GeoJsonType.Point
        }
        
        class func fromJson(json: NSDictionary) -> Point? {
            if getType(json) == GeoJsonType.Point {
                if let coord = json["coordinates"] as? Double[] {
                    return Point(coordinate: coord)
                }
            }
            
            return nil
        }
    }
}