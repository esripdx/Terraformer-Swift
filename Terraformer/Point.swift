//
//  Point.swift
//  Terraformer
//
//  Created by Courtf on 6/13/2014.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class Point<Double> : CoordinateGeometry {
        var type = GeoJsonType.Point
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
        init(coordinates: Double[]) {
            self.coordinates = coordinates
        }
        
        convenience init(_ coordinates: Double...) {
            self.init(coordinates: coordinates)
        }
        
        convenience init(latitude: Double, longitude: Double) {
            self.init(coordinates: [longitude, latitude])
        }
        
        convenience init(x: Double, y: Double) {
            self.init(coordinates: [x, y])
        }
        
        func toJson() -> NSDictionary {
            return [
                "type": type.toRaw(),
                "coordinates": coordinates
            ]
        }
        
        class func fromJson(json: NSDictionary) -> Point? {
            if Terraformer.getType(json) == GeoJsonType.Point {
                if let coord = json["coordinates"] as? Double[] {
                    return Point(coordinates: coord)
                }
            }
            
            return nil
        }
    }
}