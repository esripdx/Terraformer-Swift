//
//  MultiPoint.swift
//  Terraformer
//
//  Created by Josh Yaganeh on 6/11/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class MultiPoint<Point> : CoordinateGeometry {
        var coordinates = Point[]()
        var type = GeoJsonType.MultiPoint
        
        init(points: Point[]) {
            coordinates = points
        }
        
        convenience init(_ points: Point...) {
            self.init(points: points)
        }
        
        convenience init(coordinates: Double[][]) {
            for coord in coordinates {
                self.coordinates.append(Point(coordinates: coord))
            }
            self.init()
        }
        
        func toJson() -> NSDictionary {
            var c = Any[]()
            for p in coordinates {
                c.append(p)
            }
            
            return ["type": type.toRaw(), "coordinates": c]
        }
        
        class func fromJson(json: NSDictionary) -> MultiPoint? {
            if Terraformer.getType(json) == GeoJsonType.MultiPoint {
                if let coords = json["coordinates"] as? Double[][] {
                    return MultiPoint(coordinates: coords)
                }
            }
            
            return nil
        }
    }
}