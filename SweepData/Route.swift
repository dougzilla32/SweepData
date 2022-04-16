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
