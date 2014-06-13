
//
//  FeatureCollection.swift
//  Terraformer
//
//  Created by Courtf on 6/13/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class FeatureCollection : GeoJson {
        var features = Feature[]()
        
        init(features: Feature[]) {
            self.features = features
        }
        
        convenience init(_ features: Feature...) {
            self.init(features: features)
        }
        
        override func type() -> GeoJsonType {
            return GeoJsonType.FeatureCollection
        }
        
        class func fromJson(json: NSDictionary) -> FeatureCollection? {
            if getType(json) == GeoJsonType.FeatureCollection {
                if let feats = json["features"] as? NSDictionary[] {
                    var fc = FeatureCollection()
                    for obj in feats {
                        if let feat = parseGeoJson(obj) as? Feature {
                            fc.features.append(feat)
                        }
                    }
                    
                    return fc
                }
            }
            
            return nil
        }
    }
}