//
//  MeterTypes.swift
//  SweepData
//
//  Created by Doug on 11/19/19.
//  Copyright © 2019 Doug. All rights reserved.
//

import Foundation

public struct Meters: BinaryCodable, Hashable {
    // Note: using array of length 1 to store meter stats, because BinaryCodable does not play well with optional values
    private let weekdaysStats: [MeterStats]
    private let saturdayStats: [MeterStats]
    private let sundayStats: [MeterStats]
    public let totalCount: Int
    public let eventVenues: [EventVenue]
    
    public var weekdays: MeterStats? {
        return weekdaysStats[safe: 0]
    }
    
    public var saturday: MeterStats? {
        return saturdayStats[safe: 0]
    }
    
    public var sunday: MeterStats? {
        return sundayStats[safe: 0]
    }
    
    public init() {
        self.weekdaysStats = []
        self.saturdayStats = []
        self.sundayStats = []
        self.totalCount = 0
        self.eventVenues = []
    }
    
    public init(weekdays: MeterStats?, saturday: MeterStats?, sunday: MeterStats?, totalCount: Int, eventVenues: [EventVenue]) {
        if let weekdays = weekdays {
            self.weekdaysStats = [weekdays]
        } else {
            self.weekdaysStats = []
        }
        if let saturday = saturday {
            self.saturdayStats = [saturday]
        } else {
            self.saturdayStats = []
        }
        if let sunday = sunday {
            self.sundayStats = [sunday]
        } else {
            self.sundayStats = []
        }
        self.totalCount = totalCount
        self.eventVenues = eventVenues
    }
    
    public var dayRange: (Day, Day) {
        let startDay, endDay: Day
        if weekdays != nil {
            startDay = .mon
            endDay = (sunday != nil) ? .sun : (saturday != nil) ? .sat : .fri
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
    public let rates: [Rate]
    
    public init(meterCount: [MeterColorAndCount], startTime: HourAndMinute, endTime: HourAndMinute, lowRate: Decimal, highRate: Decimal, lowTimeLimit: HourAndMinute, highTimeLimit: HourAndMinute, rates: [Rate]) {
        self.meterCount = meterCount
        self.startTime = startTime
        self.endTime = endTime
        self.lowRate = lowRate
        self.highRate = highRate
        self.lowTimeLimit = lowTimeLimit
        self.highTimeLimit = highTimeLimit
        self.rates = rates
    }
    
    open class Rate: BinaryCodable, Hashable, Comparable {
        public let fromTime: HourAndMinute
        public let toTime: HourAndMinute
        public let rate: Decimal

        public init(
            fromTime: HourAndMinute,
            toTime: HourAndMinute,
            rate: Decimal
        ) {
            self.fromTime = fromTime
            self.toTime = toTime
            self.rate = rate
        }
        
        public static func == (lhs: Rate, rhs: Rate) -> Bool {
            return lhs.fromTime == rhs.fromTime
                && lhs.toTime == rhs.toTime
                && lhs.rate == rhs.rate
        }
        
        public func hash(into hasher: inout Hasher) {
            fromTime.hash(into: &hasher)
            toTime.hash(into: &hasher)
            rate.hash(into: &hasher)
        }
        
        public static func < (lhs: MeterStats.Rate, rhs: MeterStats.Rate) -> Bool {
            return lhs.fromTime < rhs.fromTime
        }
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

public enum EventVenue: Int, BinaryCodable {
    case chaseCenter = 0, oraclePark
}

extension Decimal: BinaryCodable { }
