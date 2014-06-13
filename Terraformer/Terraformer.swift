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
    case Unknown = "Unknown"
}

class Terraformer {
    
    class GeoJson {
        // override me
        func type() -> GeoJsonType {
            return GeoJsonType.Unknown
        }
        
        class func getType(json: NSDictionary) -> GeoJsonType {
            var returnVal = GeoJsonType.Unknown
            if let type = json["type"] as? String {
                if let gjt = GeoJsonType.fromRaw(type) {
                    returnVal = gjt
                }
            }
            
            return returnVal
        }
        
        class func parseGeoJson(json: NSDictionary) -> GeoJson? {
            switch getType(json) {
            case GeoJsonType.Point:
                return Point.fromJson(json)
            case GeoJsonType.MultiPoint:
                return MultiPoint.fromJson(json)
            case GeoJsonType.LineString:
                return LineString.fromJson(json)
            case GeoJsonType.MultiLineString:
                return MultiLineString.fromJson(json)
            case GeoJsonType.Polygon:
                return Polygon.fromJson(json)
            case GeoJsonType.MultiPolygon:
                return MultiPolygon.fromJson(json)
            case GeoJsonType.GeometryCollection:
                return GeometryCollection.fromJson(json)
            case GeoJsonType.Feature:
                return Feature.fromJson(json)
            case GeoJsonType.FeatureCollection:
                return FeatureCollection.fromJson(json)
            case GeoJsonType.Unknown:
                return nil
            }
        }
    }
    
    class Geometry : GeoJson {}
}