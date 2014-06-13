//
//  LineString.swift
//  Terraformer
//
//  Created by Courtf on 6/13/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class LineString<Point> : CoordinateGeometry {
        var coordinates = Point[]()
        var type = GeoJsonType.LineString
        
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
                c.append(p.toJson())
            }
            
            return ["type": type.toRaw(), "coordinates": c]
        }
        
        class func fromJson(json: NSDictionary) -> LineString? {
            if Terraformer.getType(json) == GeoJsonType.LineString {
                if let coords = json["coordinates"] as? Double[][] {
                    return LineString(coordinates: coords)
                }
            }
            
            return nil
        }
    }
}