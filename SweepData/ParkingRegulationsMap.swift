//
//  ParkingRegulationsMap.swift
//  SweepData
//
//  Created by Doug on 5/4/22.
//

public struct ParkingRegulationsMap: BinaryCodable {
    public let date: Date
    public let paths: [ParkingRegulationPath]
    public let boundingBox: BoundingBox
    
    public init(date: Date, paths: [ParkingRegulationPath], boundingBox: BoundingBox) {
        self.date = date
        self.paths = paths
        self.boundingBox = boundingBox
    }
}

public struct ParkingRegulationPath: LLPath, BinaryCodable, Hashable {
    public let row: Int
    public let regulation: String
    public let days: [Day]
    public let hours: String
    public let hoursBegin: HourAndMinute
    public let hoursEnd: HourAndMinute
    public let regulationDetails: String
    public let timeLimit: HourAndMinute
    public let exceptions: String
    public let fromTime: String
    public let toTime: String
    public let shapePath: [LatitudeLongitude]

    public let cnnRightLeft: RightLeft
    public let left_fromAddress: Int
    public let left_toAddress: Int
    public let right_fromAddress: Int
    public let right_toAddress: Int
    public let streetName: String
    public let streetNum: Int
    public let zipCode: Int
    public let path: [LatitudeLongitude]
    
    public init(row: Int, regulation: String, days: [Day], hours: String, hoursBegin: HourAndMinute?, hoursEnd: HourAndMinute?, regulationDetails: String, timeLimit: HourAndMinute?, exceptions: String, fromTime: String, toTime: String, shapePath: [LatitudeLongitude], cnnRightLeft: RightLeft?, left_fromAddress: Int?, left_toAddress: Int?, right_fromAddress: Int?, right_toAddress: Int?, streetName: String, streetNum: Int?, zipCode: Int?, path: [LatitudeLongitude]) {
        self.row = row
        self.regulation = regulation
        self.days = days
        self.hours = hours
        self.hoursBegin = hoursBegin ?? HourAndMinute(hour: 0, minute: 0)
        self.hoursEnd = hoursEnd ?? HourAndMinute(hour: 0, minute: 0)
        self.regulationDetails = regulationDetails
        self.timeLimit = timeLimit ?? HourAndMinute(hour: 0, minute: 0)
        self.exceptions = exceptions
        self.fromTime = fromTime
        self.toTime = toTime
        self.shapePath = shapePath
        self.cnnRightLeft = cnnRightLeft ?? .right
        self.left_fromAddress = left_fromAddress ?? 0
        self.left_toAddress = left_toAddress ?? 0
        self.right_fromAddress = right_fromAddress ?? 0
        self.right_toAddress = right_toAddress ?? 0
        self.streetName = streetName
        self.streetNum = streetNum ?? 0
        self.zipCode = zipCode ?? 0
        self.path = path
    }

    public func hash(into hasher: inout Hasher) {
        row.hash(into: &hasher)
    }
    
    public static func == (lhs: ParkingRegulationPath, rhs: ParkingRegulationPath) -> Bool {
        return lhs.row == rhs.row
    }
}
