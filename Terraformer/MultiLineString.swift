//
//  MultiLineString.swift
//  Terraformer
//
//  Created by Courtf on 6/13/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class MultiLineString<LineString> : CoordinateGeometry {
        var type = GeoJsonType.MultiLineString
        var coordinates = LineString[]()
        
        init(lineStrings: LineString[]) {
            coordinates = lineStrings
        }
        
        convenience init(_ lineStrings: LineString...) {
            self.init(lineStrings: lineStrings)
        }
        
        convenience init(coordinates: Double[][][]) {
            for arr in coordinates {
                self.coordinates.append(LineString(coordinates: arr))
            }
            self.init()
        }
        
        func toJson() -> NSDictionary {
            var c = Any[]()
            for ls in coordinates {
                c.append(ls.toJson())
            }
            
            return ["type": type.toRaw(), "coordinates": c]
        }
        
        class func fromJson(json: NSDictionary) -> MultiLineString? {
            if Terraformer.getType(json) == GeoJsonType.MultiLineString {
                if let coords = json["coordinates"] as? Double[][][] {
                    return MultiLineString(coordinates: coords)
                }
            }
            
            return nil
        }
    }
}