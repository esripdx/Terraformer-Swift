//
//  Terraformer.swift
//  Terraformer
//
//  Created by Josh Yaganeh on 6/11/14.
//  Copyright (c) 2014 esri. All rights reserved.
//

import Foundation

enum GeoJsonType: String {
    case Point = "Point"
    case MultiPoint = "MultiPoint"
    case Polygon = "Polygon"
    case MultiPolygon = "MultiPolygon"
    case LineString = "LineString"
    case MultiLineString = "MultiLineString"
    case GeometryCollection = "GeometryCollection"
    case Feature = "Feature"
    case FeatureCollection = "FeatureCollection"
}

protocol GeoJson {
    var type: GeoJsonType { get }
}

protocol Geometry {
    typealias CoordinateType
    var coordinates: CoordinateType[] { get }
}

class Terraformer {
    
    class func bbox<T: Geometry>(geometry: T) -> (xmin: Double, xmax: Double, ymin: Double, ymax: Double){
        return (xmin: 0.0, xmax: 0.0, ymin: 0.0, ymax: 0.0)
    }
}