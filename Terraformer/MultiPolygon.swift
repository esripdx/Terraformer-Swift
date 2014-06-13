//
//  MultiPolygon.swift
//  Terraformer
//
//  Created by Courtf on 6/13/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class MultiPolygon : Geometry {
        var polygons = Polygon[]()
        
        init(polygons: Polygon[]) {
            self.polygons = polygons
        }
        
        convenience init(_ polygons: Polygon...) {
            self.init(polygons: polygons)
        }
        
        convenience init(coordinates: Double[][][][]) {
            self.init()
            for arr in coordinates {
                polygons.append(Polygon(coordinates: arr))
            }
        }
        
        override func type() -> GeoJsonType {
            return GeoJsonType.MultiPolygon
        }
        
        class func fromJson(json: NSDictionary) -> MultiPolygon? {
            if getType(json) == GeoJsonType.MultiPolygon {
                if let coords = json["coordinates"] as? Double[][][][] {
                    return MultiPolygon(coordinates: coords)
                }
            }
            
            return nil
        }
    }
}