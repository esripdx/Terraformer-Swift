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
        var type = GeoJsonType.Feature
        var geometry = Geometry()
        var properties = NSDictionary()
        
        init(geometry: Geometry, properties: NSDictionary) {
            self.geometry = geometry
            self.properties = properties
        }
        
        convenience init(geometry: Geometry) {
            self.init(geometry: geometry, properties: NSDictionary())
        }
        
        func toJson() -> NSDictionary {
            return ["type": type.toRaw(), "geometry": geometry.toJson()]
        }
        
        class func fromJson(json: NSDictionary) -> Feature? {
            if Terraformer.getType(json) == GeoJsonType.Feature {
                if let geom = Terraformer.parse(json["geometry"] as NSDictionary) as? Geometry {
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