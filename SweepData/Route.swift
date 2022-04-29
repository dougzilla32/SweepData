//
//  Route.swift
//  SweepData
//
//  Created by Doug on 6/20/19.
//  Copyright © 2019 Doug. All rights reserved.
//

open class Route: BinaryCodable, Hashable {
    public let cnn: Int
    public let rightLeft: RightLeft
    public let streetName: String
    public let neighborhood: String
    public let left_fromAddress: Int
    public let left_toAddress: Int
    public let right_fromAddress: Int
    public let right_toAddress: Int
    public let zipCode: Int
    public let sweep: [SweepSchedule]?
    public let towAway: [TowAwaySchedule]?
    public let timeLimit: [TimeLimitSchedule]?
    public var meters: Meters?
    public let parkingSupplyOnBlock: Int
    public var offsetPath: [LatitudeLongitude]

    public init(
        cnn: Int,
        rightLeft: RightLeft,
        streetName: String,
        neighborhood: String,
        left_fromAddress: Int,
        left_toAddress: Int,
        right_fromAddress: Int,
        right_toAddress: Int,
        zipCode: Int,
        sweep: [SweepSchedule]?,
        towAway: [TowAwaySchedule]?,
        timeLimit: [TimeLimitSchedule]?,
        meters: Meters?,
        parkingSupplyOnBlock: Int,
        offsetPath: [LatitudeLongitude]
    ) {
        self.cnn = cnn
        self.rightLeft = rightLeft
        self.streetName = streetName
        self.neighborhood = neighborhood
        self.left_fromAddress = left_fromAddress
        self.left_toAddress = left_toAddress
        self.right_fromAddress = right_fromAddress
        self.right_toAddress = right_toAddress
        self.zipCode = zipCode
        self.sweep = sweep
        self.towAway = towAway
        self.timeLimit = timeLimit
        self.meters = meters
        self.parkingSupplyOnBlock = parkingSupplyOnBlock
        self.offsetPath = offsetPath
    }

    open class When: BinaryCodable, Hashable {
        public let row: Int
        public let fromTime: HourAndMinute
        public let toTime: HourAndMinute
        public let day: Day

        public init(
            row: Int,
            fromTime: HourAndMinute,
            toTime: HourAndMinute,
            day: Day
        ) {
            self.row = row
            self.fromTime = fromTime
            self.toTime = toTime
            self.day = day
        }

        public static func == (lhs: Route.When, rhs: Route.When) -> Bool {
            return lhs.row == rhs.row
                && lhs.fromTime == rhs.fromTime
                && lhs.toTime == rhs.toTime
                && lhs.day == rhs.day
        }
        
        public func hash(into hasher: inout Hasher) {
            row.hash(into: &hasher)
            fromTime.hash(into: &hasher)
            toTime.hash(into: &hasher)
            day.hash(into: &hasher)
        }
    }

    open class SweepSchedule: When {
        public let holidays: Bool
        public let week1: Bool
        public let week2: Bool
        public let week3: Bool
        public let week4: Bool
        public let week5: Bool

        public init(
            row: Int,
            fromTime: HourAndMinute,
            toTime: HourAndMinute,
            day: Day,
            holidays: Bool,
            week1: Bool,
            week2: Bool,
            week3: Bool,
            week4: Bool,
            week5: Bool
        ) {
            self.holidays = holidays
            self.week1 = week1
            self.week2 = week2
            self.week3 = week3
            self.week4 = week4
            self.week5 = week5
            super.init(row: row, fromTime: fromTime, toTime: toTime, day: day)
        }
        
        required public init(from decoder: Decoder) throws {
            fatalError("init(from: decoder: Decoder) has not been implemented")
        }

        public static func == (lhs: Route.SweepSchedule, rhs: Route.SweepSchedule) -> Bool {
            return (lhs as When) == (rhs as When)
                && lhs.holidays == rhs.holidays
                && lhs.week1 == rhs.week1
                && lhs.week2 == rhs.week2
                && lhs.week3 == rhs.week3
                && lhs.week4 == rhs.week4
                && lhs.week5 == rhs.week5
        }
        
        override public func hash(into hasher: inout Hasher) {
            super.hash(into: &hasher)
            holidays.hash(into: &hasher)
            week1.hash(into: &hasher)
            week2.hash(into: &hasher)
            week3.hash(into: &hasher)
            week4.hash(into: &hasher)
            week5.hash(into: &hasher)
        }
    }

    open class TowAwaySchedule: When {
        public let holidays: Bool

        public init(
            row: Int,
            fromTime: HourAndMinute,
            toTime: HourAndMinute,
            day: Day,
            holidays: Bool
        ) {
            self.holidays = holidays
            super.init(row: row, fromTime: fromTime, toTime: toTime, day: day)
        }

        required public init(from decoder: Decoder) throws {
            fatalError("init(from: decoder: Decoder) has not been implemented")
        }

        public static func == (lhs: Route.TowAwaySchedule, rhs: Route.TowAwaySchedule) -> Bool {
            return (lhs as When) == (rhs as When)
                && lhs.holidays == rhs.holidays
        }
        
        override public func hash(into hasher: inout Hasher) {
            super.hash(into: &hasher)
            holidays.hash(into: &hasher)
        }
    }

    open class TimeLimitSchedule: When {
        public let timeLimit: HourAndMinute

        required public init(
            row: Int,
            fromTime: HourAndMinute,
            toTime: HourAndMinute,
            day: Day,
            timeLimit: HourAndMinute
        ) {
            self.timeLimit = timeLimit
            super.init(row: row, fromTime: fromTime, toTime: toTime, day: day)
        }
        
        required public init(from decoder: Decoder) throws {
            fatalError("init(from: decoder: Decoder) has not been implemented")
        }

        public static func == (lhs: Route.TimeLimitSchedule, rhs: Route.TimeLimitSchedule) -> Bool {
            return (lhs as When) == (rhs as When)
                && lhs.timeLimit == rhs.timeLimit
        }
        
        override public func hash(into hasher: inout Hasher) {
            super.hash(into: &hasher)
            timeLimit.hash(into: &hasher)
        }
    }

    public func hash(into hasher: inout Hasher) {
        cnn.hash(into: &hasher)
        rightLeft.hash(into: &hasher)
        streetName.hash(into: &hasher)
        neighborhood.hash(into: &hasher)
        left_fromAddress.hash(into: &hasher)
        left_toAddress.hash(into: &hasher)
        right_fromAddress.hash(into: &hasher)
        right_toAddress.hash(into: &hasher)
        zipCode.hash(into: &hasher)
        sweep.hash(into: &hasher)
        towAway.hash(into: &hasher)
        timeLimit.hash(into: &hasher)
        meters.hash(into: &hasher)
        parkingSupplyOnBlock.hash(into: &hasher)
    }
    
    public static func == (lhs: Route, rhs: Route) -> Bool {
        return lhs.cnn == rhs.cnn
            && lhs.rightLeft == rhs.rightLeft
            && lhs.streetName == rhs.streetName
            && lhs.neighborhood == rhs.neighborhood
            && lhs.left_fromAddress == rhs.left_fromAddress
            && lhs.left_toAddress == rhs.left_toAddress
            && lhs.right_fromAddress == rhs.right_fromAddress
            && lhs.right_toAddress == rhs.right_toAddress
            && lhs.zipCode == rhs.zipCode
            && lhs.sweep == rhs.sweep
            && lhs.towAway == rhs.towAway
            && lhs.timeLimit == rhs.timeLimit
            && lhs.meters == rhs.meters
            && lhs.parkingSupplyOnBlock == rhs.parkingSupplyOnBlock
    }

    public var shortName: String {
        return "\(streetName): left \(left_fromAddress) to \(left_toAddress), right \(right_fromAddress) to \(right_toAddress) ; \(rightLeft)"
    }

    public var summary: String {
        return "\(cnn) \(rightLeft) \(streetName) \(left_fromAddress) \(left_toAddress) \(right_fromAddress) \(right_toAddress) \(zipCode) \(meters != nil ? meters!.description : "")"
    }
}

public class MapRoute: Route {
    public let blockSide: CompassDirection
    public let originalPath: [LatitudeLongitude]
    public var snappedPath: [LatitudeLongitude]
    public var offsetPolygonPath: [LatitudeLongitude]

    // Debugging
    public var offsetExtend: [LLSegment]
    public var minLineExtend: [LLSegment]

    // X-Y coordinates, adjusting for longitude distance
    public var snappedPathXY: [Point]
    public var offsetPathXY: [Point]
    public var offsetPolygonPathXY: [Point]
    public var offsetExtendXY: [Segment]
    public var minLineExtendXY: [Segment]
     
    public init(
        cnn: Int,
        rightLeft: RightLeft,
        streetName: String,
        neighborhood: String,
        left_fromAddress: Int,
        left_toAddress: Int,
        right_fromAddress: Int,
        right_toAddress: Int,
        zipCode: Int,
        sweep: [SweepSchedule]?,
        towAway: [TowAwaySchedule]?,
        timeLimit: [TimeLimitSchedule]?,
        meters: Meters?,
        parkingSupplyOnBlock: Int,
        offsetPath: [LatitudeLongitude],
         
        blockSide: CompassDirection,
        originalPath: [LatitudeLongitude],
        snappedPath: [LatitudeLongitude],
        offsetPolygonPath: [LatitudeLongitude],
        offsetExtend: [LLSegment],
        minLineExtend: [LLSegment],
        snappedPathXY: [Point],
        offsetPathXY: [Point],
        offsetPolygonPathXY: [Point],
        offsetExtendXY: [Segment],
        minLineExtendXY: [Segment]
    ) {
        self.blockSide = blockSide
        self.originalPath = originalPath
        self.snappedPath = snappedPath
        self.offsetPolygonPath = offsetPolygonPath
        self.offsetExtend = offsetExtend
        self.minLineExtend = minLineExtend
        self.snappedPathXY = snappedPathXY
        self.offsetPathXY = offsetPathXY
        self.offsetPolygonPathXY = offsetPolygonPathXY
        self.offsetExtendXY = offsetExtendXY
        self.minLineExtendXY = minLineExtendXY

        super.init(
            cnn: cnn,
            rightLeft: rightLeft,
            streetName: streetName,
            neighborhood: neighborhood,
            left_fromAddress: left_fromAddress,
            left_toAddress: left_toAddress,
            right_fromAddress: right_fromAddress,
            right_toAddress: right_toAddress,
            zipCode: zipCode,
            sweep: sweep,
            towAway: towAway,
            timeLimit: timeLimit,
            meters: meters,
            parkingSupplyOnBlock: parkingSupplyOnBlock,
            offsetPath: offsetPath)
    }

    public required init(from decoder: Decoder) throws {
        fatalError("init(from: decoder: Decoder) has not been implemented")
    }
}
