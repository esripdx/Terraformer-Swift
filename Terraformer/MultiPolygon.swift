//
//  MultiPolygon.swift
//  Terraformer
//
//  Created by Courtf on 6/13/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class MultiPolygon<Polygon> : CoordinateGeometry {
        var type = GeoJsonType.MultiPolygon
        var coordinates = Polygon[]()
        
        init(polygons: Polygon[]) {
            coordinates = polygons
        }
        
        convenience init(_ polygons: Polygon...) {
            self.init(polygons: polygons)
        }
        
        convenience init(coordinates: Double[][][][]) {
            for arr in coordinates {
                self.coordinates.append(Polygon(coordinates: arr))
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
        
        class func fromJson(json: NSDictionary) -> MultiPolygon? {
            if Terraformer.getType(json) == GeoJsonType.MultiPolygon {
                if let coords = json["coordinates"] as? Double[][][][] {
                    return MultiPolygon(coordinates: coords)
                }
            }
            
            return nil
        }
    }
}