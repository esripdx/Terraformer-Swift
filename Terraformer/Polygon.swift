//
//  Polygon.swift
//  Terraformer
//
//  Created by Courtf on 6/13/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class Polygon : Geometry {
        var outer = LineString()
        var holes = LineString[]()
        
        init() {}
        
        convenience init(outer: LineString, holes: LineString[]) {
            self.init()
            self.outer = outer
            self.holes = holes
        }
        
        convenience init(outer: LineString, holes: LineString...) {
            self.init(outer: outer, holes: holes)
        }
        
        convenience init(coordinates: Double[][][]) {
            self.init()
            var outer = LineString()
            var holes = LineString[]()
            for var i = 0; i < coordinates.count; i++ {
                if i == 0 {
                    outer = LineString(coordinates: coordinates[0])
                } else {
                    holes.append(LineString(coordinates: coordinates[i]))
                }
            }
            
            self.outer = outer
            self.holes = holes
        }
        
        override func type() -> GeoJsonType {
            return GeoJsonType.Polygon
        }
        
        class func fromJson(json: NSDictionary) -> Polygon? {
            if getType(json) == GeoJsonType.Polygon {
                if let coords = json["coordinates"] as? Double[][][] {
                    return Polygon(coordinates: coords)
                }
            }
            
            return nil
        }
    }
}