//
//  MeterTypes.swift
//  SweepData
//
//  Created by Doug on 11/19/19.
//  Copyright © 2019 Doug. All rights reserved.
//

import Foundation

public struct Meters: BinaryCodable, Hashable {
    public let weekdays: MeterStats?
    public let saturday: MeterStats?
    public let sunday: MeterStats?
    public let totalCount: Int
    
    public init(weekdays: MeterStats?, saturday: MeterStats?, sunday: MeterStats?, totalCount: Int) {
        self.weekdays = weekdays
        self.saturday = saturday
        self.sunday = sunday
        self.totalCount = totalCount
    }
    
    public var dayRange: (Day, Day) {
        let startDay, endDay: Day
        if weekdays != nil {
            startDay = .mon
            endDay = sunday != nil ? .sun : (saturday != nil) ? .sat : .fri
        } else if saturday != nil {
            startDay = .sat
            endDay = (sunday != nil) ? .sun : .sat
        } else {
            startDay = .sun
            endDay = .sun
        }
        return (startDay, endDay)
    }
    
    public func statsForDate(_ date: Date) -> MeterStats? {
        let stats: MeterStats?
        let day = Day.create(from: date)
        if day.isWeekday {
            stats = weekdays
        } else if day == .sat {
            stats = saturday
        } else if day == .sun {
            stats = sunday
        } else {
            fatalError()
        }
        return stats
    }
    
    public var description: String {
        var d = ""
        if weekdays == saturday && weekdays == sunday {
            d.append("    Mon-Sun\n\(weekdays?.description ?? "")")
        } else if weekdays == saturday {
            d.append("    Mon-Sat\n\(weekdays?.description ?? "")")
            d.append("    Sun\n\(sunday?.description ?? "")")
        } else {
            d.append("    Mon-Fri\n\(weekdays?.description ?? "")")
            d.append("    Sat\n\(saturday?.description ?? "")")
            d.append("    Sun\n\(sunday?.description ?? "")")
        }
        d.append("    Total count = \(totalCount)")
        return d
    }
}

public struct MeterStats: BinaryCodable, Hashable {
    public let meterCount: [MeterColorAndCount]
    public let startTime: HourAndMinute
    public let endTime: HourAndMinute
    public let lowRate: Decimal
    public let highRate: Decimal
    public let lowTimeLimit: HourAndMinute
    public let highTimeLimit: HourAndMinute
    
    public init(meterCount: [MeterColorAndCount], startTime: HourAndMinute, endTime: HourAndMinute, lowRate: Decimal, highRate: Decimal, lowTimeLimit: HourAndMinute, highTimeLimit: HourAndMinute) {
        self.meterCount = meterCount
        self.startTime = startTime
        self.endTime = endTime
        self.lowRate = lowRate
        self.highRate = highRate
        self.lowTimeLimit = lowTimeLimit
        self.highTimeLimit = highTimeLimit
    }
    
    public var description: String {
        var d = ""
        let mc = meterCount.sorted { mc1, mc2 in
            return mc1.count > mc2.count
        }
        for m in mc {
            d.append("        \(m.count) \(m.capColor.stringValue)\n")
        }
        d.append("        \(startTime.standardTime) to \(endTime.standardTime)\n")
        d.append("        $\(lowRate) - $\(highRate)\n")
        if lowTimeLimit == highTimeLimit {
            d.append("        \(lowTimeLimit.hour * 60 + lowTimeLimit.minute) minute limit\n")
        } else {
            d.append("        \(lowTimeLimit.hour * 60 + lowTimeLimit.minute) - \(highTimeLimit.hour * 60 + highTimeLimit.minute) minute time limit\n")
        }
        return d
    }
}

public struct MeterColorAndCount: BinaryCodable, Hashable {
    public let capColor: MeterCapColor
    public let count: Int

    public init(capColor: MeterCapColor, count: Int) {
        self.capColor = capColor
        self.count = count
    }
}

public enum MeterCapColor: Int, BinaryCodable {
    case none = 0, undefined, bTimeBandn, grey, brown, purple, green, white, black, yellow, red, blue, orange

    public init?(string: String) {
        guard let index = MeterCapColor.stringValues.firstIndex(of: string) else { return nil }
        self.init(rawValue: index)
    }
    
    public static let stringValues = [ "-", "Undefined", "BTimeBandn", "Grey", "Brown", "Purple", "Green", "White", "Black", "Yellow", "Red", "Blue", "Orange" ]
    
    public var stringValue: String {
        return MeterCapColor.stringValues[rawValue]
    }

    public var description: String {
        return stringValue
    }
}

extension Decimal: BinaryCodable { }