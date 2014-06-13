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
        var coordinate = Double[]()
        
        // Convenience accessors
        var x : Double {
        get { return coordinate[0] }
        set { coordinate[0] = newValue }
        }
        
        var y : Double {
        get { return coordinate[1] }
        set { coordinate[1] = newValue }
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
            self.coordinate = coordinate
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
        
        func toJson() -> NSDictionary {
            return [
                "type": type().toRaw(),
                "coordinates": coordinate
            ]
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