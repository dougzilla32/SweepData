//
//  Route.swift
//  SweepData
//
//  Created by Doug on 6/20/19.
//  Copyright © 2019 Doug. All rights reserved.
//

public struct RouteData: BinaryCodable {
    public let version: String
    public let date: Date
    public let routes: [Route]
    public let boundingBox: BoundingBox

    public init(version: String, date: Date, routes: [Route], boundingBox: BoundingBox) {
        self.version = version
        self.date = date
        self.routes = routes
        self.boundingBox = boundingBox
    }
}

open class Route: BinaryCodable {
    public let cnn: Int
    public let rightLeft: RightLeft
    public let streetName: String
    public let neighborhood: String
    public let left_fromAddress: Int
    public let left_toAddress: Int
    public let right_fromAddress: Int
    public let right_toAddress: Int
    public let zipCode: Int
    public var meters: Meters?
    public let parkingSupplyOnBlock: Int
    public let when: [When]
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
        parkingSupplyOnBlock: Int,
        when: [When],
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
        self.meters = nil
        self.parkingSupplyOnBlock = parkingSupplyOnBlock
        self.when = when
        self.offsetPath = offsetPath
    }

    open class When: BinaryCodable, Hashable {
        public static func == (lhs: Route.When, rhs: Route.When) -> Bool {
            return lhs.type == rhs.type
                && lhs.fromHour == rhs.fromHour
                && lhs.toHour == rhs.toHour
                && lhs.holidays == rhs.holidays
                && lhs.week1 == rhs.week1
                && lhs.week2 == rhs.week2
                && lhs.week3 == rhs.week3
                && lhs.week4 == rhs.week4
                && lhs.week5 == rhs.week5
                && lhs.day == rhs.day
        }
        
        public func hash(into hasher: inout Hasher) {
            type.hash(into: &hasher)
            fromHour.hash(into: &hasher)
            toHour.hash(into: &hasher)
            holidays.hash(into: &hasher)
            week1.hash(into: &hasher)
            week2.hash(into: &hasher)
            week3.hash(into: &hasher)
            week4.hash(into: &hasher)
            week5.hash(into: &hasher)
            day.hash(into: &hasher)
        }

        
        public let type: RestrictionType
        public let fromHour: Int
        public let toHour: Int
        public let holidays: Bool
        public let week1: Bool
        public let week2: Bool
        public let week3: Bool
        public let week4: Bool
        public let week5: Bool
        public let day: Day

        public init(
            type: RestrictionType,
            fromHour: Int,
            toHour: Int,
            holidays: Bool,
            week1: Bool,
            week2: Bool,
            week3: Bool,
            week4: Bool,
            week5: Bool,
            day: Day
        ) {
            self.type = type
            self.fromHour = fromHour
            self.toHour = toHour
            self.holidays = holidays
            self.week1 = week1
            self.week2 = week2
            self.week3 = week3
            self.week4 = week4
            self.week5 = week5
            self.day = day
        }
    }

    public var shortName: String {
        return "\(streetName): left \(left_fromAddress) to \(left_toAddress), right \(right_fromAddress) to \(right_toAddress) ; \(rightLeft)"
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
        parkingSupplyOnBlock: Int,
        when: [MapWhen],
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
            parkingSupplyOnBlock: parkingSupplyOnBlock,
            when: when,
            offsetPath: offsetPath)
    }

    public required init(from decoder: Decoder) throws {
        blockSide = .north
        originalPath = []
        snappedPath = []
        offsetPolygonPath = []
        offsetExtend = []
        minLineExtend = []
        snappedPathXY = []
        offsetPathXY = []
        offsetPolygonPathXY = []
        offsetExtendXY = []
        minLineExtendXY = []

        try super.init(from: decoder)
    }

    public class MapWhen: Route.When {
        public let row: Int

        public init(
            type: RestrictionType,
            fromHour: Int,
            toHour: Int,
            holidays: Bool,
            week1: Bool,
            week2: Bool,
            week3: Bool,
            week4: Bool,
            week5: Bool,
            day: Day,
            row: Int
        ) {
            self.row = row

            super.init(
                type: type,
                fromHour: fromHour,
                toHour: toHour,
                holidays: holidays,
                week1: week1,
                week2: week2,
                week3: week3,
                week4: week4,
                week5: week5,
                day: day)
        }
        
        public required init(from decoder: Decoder) throws {
            self.row = 0
            try super.init(from: decoder)
        }
    }
}
