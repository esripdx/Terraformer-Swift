//
//  GeometryCollection.swift
//  Terraformer
//
//  Created by Josh Yaganeh on 6/12/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class GeometryCollection : Geometry {
        var type = GeoJsonType.GeometryCollection
        var geometries = Geometry[]()
        
        init(geometries: Geometry[]) {
            self.geometries = geometries
        }
        
        convenience init(_ geometries: Geometry...) {
            self.init(geometries: geometries)
        }
        
        func toJson() -> NSDictionary {
            var gs = Any[]()
            for g in geometries {
                gs.append(g.toJson())
            }
            
            return ["type": type.toRaw(), "geometries": gs]
        }
        
        class func fromJson(json: NSDictionary) -> GeometryCollection? {
            if Terraformer.getType(json) == GeoJsonType.GeometryCollection {
                if let geoms = json["geometries"] as? NSDictionary[] {
                    var gc = GeometryCollection()
                    for obj in geoms {
                        if let geom = Terraformer.parse(json) as? Geometry {
                            gc.geometries.append(geom)
                        }
                    }
                    
                    return gc
                }
            }
            
            return nil
        }
    }
}