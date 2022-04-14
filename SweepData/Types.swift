//
//  Types.swift
//  SweepData
//
//  Created by Doug on 7/23/19.
//  Copyright © 2019 Doug. All rights reserved.
//

import Foundation

public func minWithNil(_ a: Int?, _ b: Int?) -> Int {
    if a == nil { return b! }
    if b == nil { return a! }
    return min(a!, b!)
}

public func maxWithNil(_ a: Int?, _ b: Int?) -> Int {
    if a == nil { return b! }
    if b == nil { return a! }
    return max(a!, b!)
}

public func minWithNil(_ a: Double?, _ b: Double?) -> Double {
    if a == nil { return b! }
    if b == nil { return a! }
    return min(a!, b!)
}

public func maxWithNil(_ a: Double?, _ b: Double?) -> Double {
    if a == nil { return b! }
    if b == nil { return a! }
    return max(a!, b!)
}

extension Dictionary {
    public mutating func updateValue(forKey key: Key, closure: (Value?) -> Value?) {
        if let value = self.removeValue(forKey: key) {
            if let value = closure(value) {
                self[key] = value
            }
        }
        else {
            if let value = closure(nil) {
                self[key] = value
            }
        }
    }
}

extension Date: BinaryCodable { }

public enum RightLeft: Int, BinaryCodable {
    case right = 0, left

    public static let stringValues = [ "R", "L" ]

    public init?(string: String) {
        guard let index = RightLeft.stringValues.firstIndex(of: string) else { return nil }
        self.init(rawValue: index)
    }
    
    public var stringValue: String {
        return RightLeft.stringValues[rawValue]
    }
}

public enum CompassDirection: Int, BinaryCodable {
    case north = 0, south, east, west, northWest, northEast, southWest, southEast, none

    public static let stringValues = [ "North", "South", "East", "West", "NorthWest", "NorthEast", "SouthWest", "SouthEast", "None" ]
    
    public init?(string: String) {
        if string == "" {
            self = .none
        }
        else {
            guard let index = CompassDirection.stringValues.firstIndex(of: string) else { return nil }
            self.init(rawValue: index)
        }
    }
    
    public var stringValue: String {
        return CompassDirection.stringValues[rawValue]
    }
}

public enum Day: Int, BinaryCodable, Comparable {
    case sun = 1, mon, tue, wed, thu, fri, sat, holiday
    
    public var isWeekend: Bool {
        switch self {
        case .sat, .sun:
            return true
        default:
            return false
        }
    }
    
    public var isWeekday: Bool {
        switch self {
        case .mon, .tue, .wed, .thu, .fri:
            return true
        default:
            return false
        }
    }

    public static let fullStringValues = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
                                    "Friday", "Saturday", "Holiday" ]

    public static let shortStringValues = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Holiday" ]
    
    public static let dataSFValues = [ "Sun", "Mon", "Tues", "Wed", "Thu", "Fri", "Sat", "Holiday" ]
    
    public static let abbrevStringValues = [ "Su", "Mo", "Tu", "We", "Th", "Fr", "Sa", "H" ]

    public static func < (lhs: Day, rhs: Day) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    public static func create(from date: Date) -> Day {
        return Day(rawValue: Calendar.current.component(.weekday, from: date))!
    }
    
    public init?(shortString: String) {
        guard let index = Day.shortStringValues.firstIndex(of: shortString) else { return nil }
        self.init(rawValue: index + 1)
    }
    
    public init?(dataSF: String) {
        guard let index = Day.dataSFValues.firstIndex(of: dataSF) else { return nil }
        self.init(rawValue: index + 1)
    }
    
    public init?(abbrevString: String) {
        guard let index = Day.abbrevStringValues.firstIndex(of: abbrevString) else { return nil }
        self.init(rawValue: index + 1)
    }
    
    public var fullStringValue: String {
        return Day.fullStringValues[rawValue - 1]
    }
    
    public var shortStringValue: String {
        return Day.shortStringValues[rawValue - 1]
    }

    public var dataSFValue: String {
        return Day.dataSFValues[rawValue - 1]
    }

    public var abbrevStringValue: String {
        return Day.abbrevStringValues[rawValue - 1]
    }
}

public enum DayOrEvent: Int, BinaryCodable, Comparable {
    case sun = 1, mon, tues, wed, thu, fri, sat,
    giantsDay, giantsNight, postedEvents, postedServices, schoolDays, businessHours, performance

    public static let stringValues = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat",
                                "Giants Day", "Giants Night", "Posted Events", "Posted Services",
                                "School Days", "Business Hours", "Performance" ]
    
    public static let dataSFValues = [ "Sun", "Mon", "Tues", "Wed", "Thu", "Fri", "Sat",
                                "Giants Day", "Giants Night", "Posted Events", "Posted Services",
                                "School Days", "Business Hours", "Performance" ]
    
    public static let abbrevStringValues = [ "Su", "Mo", "Tu", "We", "Th", "Fr", "Sa",
                                      "Giants Day", "Giants Night", "Posted Events", "Posted Services",
                                      "School Days", "Business Hours", "Performance" ]
    
    public static func < (lhs: DayOrEvent, rhs: DayOrEvent) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }

    public static func create(from date: Date) -> DayOrEvent {
        return DayOrEvent(rawValue: Calendar.current.component(.weekday, from: date))!
    }

    public init?(string: String) {
        guard let index = DayOrEvent.stringValues.firstIndex(of: string) else { return nil }
        self.init(rawValue: index + 1)
    }
    
    public init?(dataSF: String) {
        guard let index = DayOrEvent.dataSFValues.firstIndex(of: dataSF) else { return nil }
        self.init(rawValue: index + 1)
    }
    
    public init?(abbrevString: String) {
        guard let index = DayOrEvent.abbrevStringValues.firstIndex(of: abbrevString) else { return nil }
        self.init(rawValue: index + 1)
    }
    
    public var stringValue: String {
        return DayOrEvent.stringValues[rawValue - 1]
    }

    public var abbrevStringValue: String {
        return DayOrEvent.abbrevStringValues[rawValue - 1]
    }
    
    public var isWeekend: Bool {
        switch self {
        case .sat: return true
        case .sun: return true
        default: return false
        }
    }
}

public struct HourAndMinute: BinaryCodable, Hashable, Comparable {
    public static func < (lhs: HourAndMinute, rhs: HourAndMinute) -> Bool {
        if lhs.hour < rhs.hour {
            return true
        }
        if lhs.hour > rhs.hour {
            return false
        }
        return lhs.minute < rhs.minute
    }

    public let hour: Int
    public let minute: Int
    
    public init(hour: Int, minute: Int) {
        self.hour = hour
        self.minute = minute
    }
    
    public init(minutes: Int) {
        self.hour = minutes / 60
        self.minute = minutes % 60
    }
    
    public init(date: Date) {
        hour = Calendar.current.component(.hour, from: date)
        minute = Calendar.current.component(.minute, from: date)
    }
    
    public init?(standardTime: String) {
        guard standardTime.hasSuffix("am") || standardTime.hasSuffix("AM") || standardTime.hasSuffix("pm") || standardTime.hasSuffix("PM") else {
            return nil
        }
        let isAM = standardTime.hasSuffix("am") || standardTime.hasSuffix("AM")
        
        let components = standardTime.dropLast(2).trimmingTrailingSpace.split(separator: ":")
        guard components.count <= 2 else {
            return nil
        }
        
        guard let h = Int(String(components[0])), 0...12 ~= h else {
            return nil
        }
        let hour: Int
        if isAM {
            hour = (h == 12) ? 0 : h
        } else {
            hour = (h == 12) ? h : (h + 12)
        }
        
        let minute: Int
        if components.count == 2 {
            guard let m = Int(String(components[1])), 0..<60 ~= m else {
                return nil
            }
            minute = m
        } else {
            minute = 0
        }
        
        self.init(hour: hour, minute: minute)
    }
    
    public init?(militaryTime: String) {
        let components = militaryTime.split(separator: ":")
        guard components.count == 2 else {
            return nil
        }
        guard let hour = Int(String(components[0])), 0..<24 ~= hour else {
            return nil
        }
        guard let minute = Int(String(components[1])), 0..<60 ~= minute else {
            return nil
        }
        self.init(hour: hour, minute: minute)
    }
    
    public init?(hourMinuteZeroSeconds: String) {
        let components = hourMinuteZeroSeconds.split(separator: ":")
        guard components.count == 2 || components.count == 3 else {
            return nil
        }
        if components.count == 3 {
            guard let seconds = Int(String(components[2])), seconds == 0 else {
                return nil
            }
        }
        guard let minute = Int(String(components[1])), 0..<60 ~= minute else {
            return nil
        }
        guard let hour = Int(String(components[0])), 0..<24 ~= hour || hour == 24 && minute == 0 else {
            return nil
        }
        self.init(hour: hour, minute: minute)
    }
    
    public init?(integerTime: Int) {
        let hour = integerTime / 100
        let minute = integerTime % 100
        guard minute < 60 else {
            return nil
        }
        self.init(hour: hour, minute: minute)
    }
    
    public init?(doubleTime: Double) {
        let hour = Int(doubleTime)
        let minute = Int((doubleTime - Double(hour)) * 60)
        self.init(hour: hour, minute: minute)
    }
    
    public var standardTime: String {
        var s = ""

        let h = (hour <= 12) ? (hour == 0 ? 12 : hour) : (hour - 12)
        s.append("\(h)")
        
        if minute > 0 {
            s.append(":")
            s.append(String(format: "%02d", minute))
        }
        
        s.append(hour <= 11 ? "am" : "pm")
        
        return s
    }

    public var integerTime: Int {
        return hour * 100 + minute
    }

    public var doubleTime: Double {
        return Double(hour) + Double(minute) / 60.0
    }

    public static func inRange(time: HourAndMinute, start: HourAndMinute, end: HourAndMinute) -> Bool {
        var r = true
        if r && start.hour == time.hour && start.minute > time.minute {
            r = false
        }
        if r && start.hour > time.hour {
            r = false
        }
        if r && end.hour == time.hour && end.minute <= time.minute {
            r = false
        }
        if r && end.hour < time.hour {
            r = false
        }
        return r
    }
}

extension Substring {
    public var trimmingTrailingSpace: Substring {
        var s = self
        if s.last?.isWhitespace == true {
            s = s.dropLast()
        }
        return s
    }
}

public enum RestrictionType: Int, BinaryCodable {
    case towAway, sweep

    public static let MinValue = RestrictionType.towAway
    public static let MaxValue = RestrictionType.sweep
}

public struct LatitudeLongitude: BinaryCodable, Hashable {
    public let latitude: Double
    public let longitude: Double
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public init(x: Double, y: Double) {
        self.latitude = y
        self.longitude = -x
    }
    
    public var x: Double { return -longitude }
    public var y: Double { return latitude }
    
    public var coord: String {
        return "(lat: \(latitude) lon: \(longitude))"
    }
}

public struct LLSegment: BinaryCodable, Hashable {
    public let from: LatitudeLongitude
    public let to: LatitudeLongitude
    
    public init(from: LatitudeLongitude, to: LatitudeLongitude) {
        self.from = from
        self.to = to
    }
    
    public var xy: String {
        return "from.x \(from.x) from.y \(from.y) to.x \(to.x) to.y \(to.y)"
    }
}

public struct Point: BinaryCodable, Hashable {
    public let x: Double
    public let y: Double

    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

public struct Segment: BinaryCodable, Hashable {
    public let from: Point
    public let to: Point

    public init(from: Point, to: Point) {
        self.from = from
        self.to = to
    }
}

public struct BoundingBox: BinaryCodable, Hashable {
    public private(set) var minX: Double
    public private(set) var minY: Double
    public private(set) var maxX: Double
    public private(set) var maxY: Double
    
    public init(minX: Double, minY: Double, maxX: Double, maxY: Double) {
        self.minX = minX
        self.minY = minY
        self.maxX = maxX
        self.maxY = maxY
    }
    
    public init() {
        self.minX = Double.infinity
        self.minY = Double.infinity
        self.maxX = -Double.infinity
        self.maxY = -Double.infinity
    }
    
    public init(path: [Point], offset: Double) {
        self.init()
        
        for p in path {
            minX = min(p.x - offset, minX)
            minY = min(p.y - offset, minY)
            maxX = max(p.x + offset, maxX)
            maxY = max(p.y + offset, maxY)
        }
    }
    
    public init(latlon: [LatitudeLongitude], offset: Double) {
        self.init()
        
        for p in latlon {
            minX = min(p.x - offset, minX)
            minY = min(p.y - offset, minY)
            maxX = max(p.x + offset, maxX)
            maxY = max(p.y + offset, maxY)
        }
    }
    
    public func contains(_ point: LatitudeLongitude, withPadding pad: Double) -> Bool {
        return (minX-pad)...(maxX+pad) ~= point.longitude && (minY-pad)...(maxY+pad) ~= point.latitude
    }
    
    public func intersects(_ other: BoundingBox) -> Bool {
        return !(other.maxX < minX || other.minX > maxX || other.maxY < minY || other.minY > maxY)
    }

    public static func pad(bbox: inout BoundingBox, padding: Double) {
        bbox.minX -= padding
        bbox.minY -= padding
        bbox.maxX += padding
        bbox.maxY += padding
    }
    
    public static func circumscribe(outer: inout BoundingBox, inner: BoundingBox) {
        outer.minX = min(outer.minX, inner.minX)
        outer.minY = min(outer.minY, inner.minY)
        outer.maxX = max(outer.maxX, inner.maxX)
        outer.maxY = max(outer.maxY, inner.maxY)
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}