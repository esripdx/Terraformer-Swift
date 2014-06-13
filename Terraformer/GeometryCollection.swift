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
        var geometries = Geometry[]()
        
        init(geometries: Geometry[]) {
            self.geometries = geometries
        }
        
        convenience init(_ geometries: Geometry...) {
            self.init(geometries: geometries)
        }
        
        override func type() -> GeoJsonType {
            return GeoJsonType.GeometryCollection
        }
        
        override func coordinates() -> AnyObject[] {
            var c = AnyObject[]()
            for g in geometries {
                c.append(g.coordinates())
            }
            return c
        }
        
        class func fromJson(json: NSDictionary) -> GeometryCollection? {
            if getType(json) == GeoJsonType.GeometryCollection {
                if let geoms = json["geometries"] as? NSDictionary[] {
                    var gc = GeometryCollection()
                    for obj in geoms {
                        if let geom = parseGeoJson(json) as? Geometry {
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