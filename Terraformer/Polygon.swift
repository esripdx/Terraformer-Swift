//
//  Polygon.swift
//  Terraformer
//
//  Created by Courtf on 6/13/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class Polygon<LineString> : CoordinateGeometry {
        var type = GeoJsonType.Polygon
        var outer = LineString()
        var holes = LineString[]()
        
        var coordinates: Polygon[] {
        get {
            var coords = LineString[]()
            coords.append(outer)
            for ls in holes {
                coords.append(ls)
            }
            
            return coords
        }
        set {
            
            for var i = 0; i < newValue.count; i++ {
                var hs = LineString[]()
                if i == 0 {
                    outer = newValue[i]
                } else {
                    holes.append(newValue[i])
                }
            }
        }
        }
        
        init() {}
        
        convenience init(outer: LineString, holes: LineString[]) {
            self.outer = outer
            self.holes = holes
            self.init()
        }
        
        convenience init(outer: LineString, holes: LineString...) {
            self.init(outer: outer, holes: holes)
        }
        
        convenience init(coordinates: Double[][][]) {
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
            self.init()
        }
        
        func toJson() -> NSDictionary {
            var c = Any[]()
            for p in coordinates {
                c.append(p)
            }
            
            return ["type": type.toRaw(), "coordinates": c]
        }
        
        class func fromJson(json: NSDictionary) -> Polygon? {
            if Terraformer.getType(json) == GeoJsonType.Polygon {
                if let coords = json["coordinates"] as? Double[][][] {
                    return Polygon(coordinates: coords)
                }
            }
            
            return nil
        }
    }
}