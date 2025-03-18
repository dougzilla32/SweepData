//
//  ClosestDistance.swift
//  SweepNPark
//
//  Created by Doug on 10/6/19.
//  Copyright © 2019 Doug. All rights reserved.
//

import Foundation

public class ClosestDistance {
    /* Distance from a point (p1) to line l1 l2 */
    public static func distanceFromPoint(_ p: LatitudeLongitude, toLineSegment l1: LatitudeLongitude, and l2: LatitudeLongitude) -> (distance: Double, point: LatitudeLongitude) {
        let A = p.x - l1.x
        let B = p.y - l1.y
        let C = l2.x - l1.x
        let D = l2.y - l1.y

        let dot = A * C + B * D
        let len_sq = C * C + D * D
        let param = dot / len_sq

        var xx, yy: Double

        if param < 0 || (l1.x == l2.x && l1.y == l2.y) {
            xx = l1.x
            yy = l1.y
        } else if param > 1 {
            xx = l2.x
            yy = l2.y
        } else {
            xx = l1.x + param * C
            yy = l1.y + param * D
        }

        let dx = p.x - xx
        let dy = p.y - yy

        return (distance: sqrt(dx * dx + dy * dy), point: LatitudeLongitude(x: xx, y: yy))
    }
    
    public static func distance(from: [LatitudeLongitude], to: [LatitudeLongitude]) -> [Double] {
        guard to.count > 1 else { return [] }
        
        var distances = [Double]()
        for point in from {
            var minDistance: Double?
            for i in 0..<(to.count-1) {
                let p1 = to[i]
                let p2 = to[i+1]
                if p1 != p2 {
                    let distanceAndPoint = ClosestDistance.distanceFromPoint(point, toLineSegment: p1, and: p2)
                    minDistance = min(minDistance ?? Double.infinity, distanceAndPoint.distance)
                }
            }
            if let d = minDistance {
                distances.append(d)
            }
        }
        return distances
    }
}
