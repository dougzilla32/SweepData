//
//  DebugPathMap.swift
//  SweepData
//
//  Created by Doug on 6/18/22.
//

import Foundation

public struct DebugPathMap: BinaryCodable {
    public let date: Date
    public let paths: [DebugPath]
    public let boundingBox: BoundingBox
    
    public init(date: Date, paths: [DebugPath], boundingBox: BoundingBox) {
        self.date = date
        self.paths = paths
        self.boundingBox = boundingBox
    }
}

public struct DebugPath: BinaryCodable, Hashable {
    public let row: Int
    public let path: [LatitudeLongitude]
    public let description: String
    
    public init(row: Int, path: [LatitudeLongitude], description: String) {
        self.row = row
        self.path = path
        self.description = description
    }
}
