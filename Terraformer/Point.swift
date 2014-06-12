//
//  Point.swift
//  Terraformer
//
//  Created by Josh Yaganeh on 6/11/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

extension Terraformer {
    class Point : NSObject, GeoJson, Geometry, Sequence {
        let type = GeoJsonType.Point
        var coordinates: Double[]
        
        var x: Double {
        get { return coordinates[0] }
        set { coordinates[0] = newValue }
        }
        var y: Double {
        get { return coordinates[1] }
        set { coordinates[1] = newValue }
        }
        
        var latitude: Double {
            get { return coordinates[1] }
            set { coordinates[1] = newValue }
        }
        var longitude: Double {
        get { return coordinates[0] }
        set { coordinates[0] = newValue }
        }
        
        init(x: Double, y: Double) {
            self.coordinates = [x, y]
        }
        
        convenience init(latitude: Double, longitude: Double) {
            self.init(x: longitude, y: latitude)
        }
        
        func generate() -> GeneratorOf<Double> {
            return GeneratorOf(coordinates.generate())
        }
    }
    

}