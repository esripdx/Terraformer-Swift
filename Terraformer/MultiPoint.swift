//
//  MultiPoint.swift
//  Terraformer
//
//  Created by Josh Yaganeh on 6/11/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class MultiPoint : Geometry {
        var points = Point[]()
        
        init(points: Point[]) {
            self.points = points
        }
        
        convenience init(_ points: Point...) {
            self.init(points: points)
        }
        
        convenience init(coordinates: Double[][]) {
            self.init()
            for dblArray in coordinates {
                points.append(Point(coordinate: dblArray))
            }
        }
        
        override func type() -> GeoJsonType {
            return GeoJsonType.MultiPoint
        }
        
        
        func toJson() -> Dictionary<String, AnyObject> {
            var c = AnyObject[]()
            for p in points {
                c.append(p.coordinate)
            }
            
            return ["type": type().toRaw(), "coordinates": c]
        }
        
        class func fromJson(json: NSDictionary) -> MultiPoint? {
            if getType(json) == GeoJsonType.MultiPoint {
                if let coords = json["coordinates"] as? Double[][] {
                    return MultiPoint(coordinates: coords)
                }
            }
            
            return nil
        }
    }
}