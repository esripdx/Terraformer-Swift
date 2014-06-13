//
//  LineString.swift
//  Terraformer
//
//  Created by Courtf on 6/13/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class LineString : MultiPoint {
        override func type() -> GeoJsonType {
            return GeoJsonType.LineString
        }
        
        override class func fromJson(json: NSDictionary) -> LineString? {
            if getType(json) == GeoJsonType.LineString {
                if let coords = json["coordinates"] as? Double[][] {
                    return LineString(coordinates: coords)
                }
            }
            
            return nil
        }
    }
}