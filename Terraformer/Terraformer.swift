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

// todo: consider returning NSError for some of these base functions
// todo: someday, when class vars are supported, use consts for the key strings
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
                return nil
            case GeoJsonType.FeatureCollection:
                return nil
            case GeoJsonType.Unknown:
                return nil
            }
        }
    }
    
    class Geometry : GeoJson {}
    
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
    
    class Feature : GeoJson {
        var geometry = Geometry()
        var properties = Dictionary<String, AnyObject>()
        
        init(geometry: Geometry, properties: Dictionary<String, AnyObject>) {
            self.geometry = geometry
            self.properties = properties
        }
        
        convenience init(geometry: Geometry) {
            self.init(geometry: geometry, properties: Dictionary<String, AnyObject>())
        }
        
        override func type() -> GeoJsonType {
            return GeoJsonType.Feature
        }
    }
    
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
    }
    
    class Point : Geometry {
        var coordinates = Double[]()
        
        // Convenience accessors
        var x : Double {
            get { return coordinates[0] }
            set { coordinates[0] = newValue }
        }
        
        var y : Double {
            get { return coordinates[1] }
            set { coordinates[1] = newValue }
        }
        
        var latitude : Double {
            get { return y }
            set { y = newValue }
        }
        var longitude : Double {
            get { return x }
            set { x = newValue }
        }
        
        // todo: should this validate that length >= 2?
        init(coordinate: Double[]) {
            coordinates = coordinate
        }
        
        convenience init(latitude: Double, longitude: Double) {
            self.init(coordinate: [longitude, latitude])
        }
        
        convenience init(x: Double, y: Double) {
            self.init(coordinate: [x, y])
        }
        
        override func type() -> GeoJsonType {
            return GeoJsonType.Point
        }
        
        class func fromJson(json: NSDictionary) -> Point? {
            if getType(json) == GeoJsonType.Point {
                if let coord = json["coordinates"] as? Double[] {
                    return Point(coordinate: coord)
                }
            }
       
            return nil
        }
    }
    
    class MultiPoint : Geometry {
        var points = Point[]()
        
        init(points: Point[]) {
            self.points = points
        }
        
        convenience init(_ points: Point...) {
            self.init(points: points)
        }
        
        convenience init(coordinates: Double[][]) {
            self.init()
            for dblArray in coordinates {
                points.append(Point(coordinate: dblArray))
            }
        }
        
        override func type() -> GeoJsonType {
            return GeoJsonType.MultiPoint
        }
        
        class func fromJson(json: NSDictionary) -> MultiPoint? {
            if getType(json) == GeoJsonType.MultiPoint {
                if let coords = json["coordinates"] as? Double[][] {
                    return MultiPoint(coordinates: coords)
                }
            }
            
            return nil
        }
    }
    
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
    
    class Polygon : Geometry {
        var outer = LineString()
        var holes = LineString[]()
        
        init() {}
        
        convenience init(outer: LineString, holes: LineString[]) {
            self.init()
            self.outer = outer
            self.holes = holes
        }
        
        convenience init(outer: LineString, holes: LineString...) {
            self.init(outer: outer, holes: holes)
        }
        
        convenience init(coordinates: Double[][][]) {
            self.init()
            var outer = LineString()
            var holes = LineString[]()
            for var i = 0; i < coordinates.count; i++ {
                if i == 0 {
                    outer = LineString(coordinates: coordinates[0])
                } else {
                    holes.append(LineString(coordinates: coordinates[i]))
                }
            }
            
            self.outer = outer
            self.holes = holes
        }
        
        override func type() -> GeoJsonType {
            return GeoJsonType.Polygon
        }
        
        class func fromJson(json: NSDictionary) -> Polygon? {
            if getType(json) == GeoJsonType.Polygon {
                if let coords = json["coordinates"] as? Double[][][] {
                    return Polygon(coordinates: coords)
                }
            }
            
            return nil
        }
    }
    
    class MultiPolygon : Geometry {
        var polygons = Polygon[]()
        
        init(polygons: Polygon[]) {
            self.polygons = polygons
        }
        
        convenience init(_ polygons: Polygon...) {
            self.init(polygons: polygons)
        }
        
        convenience init(coordinates: Double[][][][]) {
            self.init()
            for arr in coordinates {
                polygons.append(Polygon(coordinates: arr))
            }
        }
        
        override func type() -> GeoJsonType {
            return GeoJsonType.MultiPolygon
        }
        
        class func fromJson(json: NSDictionary) -> MultiPolygon? {
            if getType(json) == GeoJsonType.MultiPolygon {
                if let coords = json["coordinates"] as? Double[][][][] {
                    return MultiPolygon(coordinates: coords)
                }
            }
            
            return nil
        }
    }
}