//
//  Feature.swift
//  Terraformer
//
//  Created by Courtf on 6/13/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class Feature : GeoJson {
        var geometry = Geometry()
        var properties = NSDictionary()
        
        init(geometry: Geometry, properties: NSDictionary) {
            self.geometry = geometry
            self.properties = properties
        }
        
        convenience init(geometry: Geometry) {
            self.init(geometry: geometry, properties: NSDictionary())
        }
        
        override func type() -> GeoJsonType {
            return GeoJsonType.Feature
        }
        
        class func fromJson(json: NSDictionary) -> Feature? {
            if getType(json) == GeoJsonType.Feature {
                if let geom = parseGeoJson(json["geometry"] as NSDictionary) as? Geometry {
                    var feat = Feature(geometry: geom)
                    if let props = json["properties"] as? NSDictionary {
                        feat.properties = props
                    }
                    
                    return feat
                }
            }
            
            return nil
        }
    }
}