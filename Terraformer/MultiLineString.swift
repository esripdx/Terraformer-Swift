//
//  MultiLineString.swift
//  Terraformer
//
//  Created by Courtf on 6/13/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class MultiLineString : Geometry {
        var lineStrings = LineString[]()
        
        init(lineStrings: LineString[]) {
            self.lineStrings = lineStrings
        }
        
        convenience init(_ lineStrings: LineString...) {
            self.init(lineStrings: lineStrings)
        }
        
        convenience init(coordinates: Double[][][]) {
            self.init()
            for arr in coordinates {
                lineStrings.append(LineString(coordinates: arr))
            }
        }
        
        override func type() -> GeoJsonType {
            return GeoJsonType.MultiLineString
        }
        
        
        
        class func fromJson(json: NSDictionary) -> MultiLineString? {
            if getType(json) == GeoJsonType.MultiLineString {
                if let coords = json["coordinates"] as? Double[][][] {
                    return MultiLineString(coordinates: coords)
                }
            }
            
            return nil
        }
    }
}