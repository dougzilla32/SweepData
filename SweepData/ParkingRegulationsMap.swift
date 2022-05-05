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

public struct ParkingRegulationPath: LLPath, BinaryCodable {
    public let row: Int
    public let regulation: String
    public let days: [Day]
    public let hours: String
    public let hoursBegin: HourAndMinute?
    public let hoursEnd: HourAndMinute?
    public let regulationDetails: String
    public let timeLimit: HourAndMinute?
    public let exceptions: String
    public let fromTime: String
    public let toTime: String
    public let shapePath: [LatitudeLongitude]

    public let cnnRightLeft: RightLeft?
    public let left_fromAddress: Int?
    public let left_toAddress: Int?
    public let right_fromAddress: Int?
    public let right_toAddress: Int?
    public let streetName: String
    public let streetNum: Int?
    public let zipCode: Int?
    public let path: [LatitudeLongitude]
    
    public init(row: Int, regulation: String, days: [Day], hours: String, hoursBegin: HourAndMinute?, hoursEnd: HourAndMinute?, regulationDetails: String, timeLimit: HourAndMinute?, exceptions: String, fromTime: String, toTime: String, shapePath: [LatitudeLongitude], cnnRightLeft: RightLeft?, left_fromAddress: Int?, left_toAddress: Int?, right_fromAddress: Int?, right_toAddress: Int?, streetName: String, streetNum: Int?, zipCode: Int?, path: [LatitudeLongitude]) {
        self.row = row
        self.regulation = regulation
        self.days = days
        self.hours = hours
        self.hoursBegin = hoursBegin
        self.hoursEnd = hoursEnd
        self.regulationDetails = regulationDetails
        self.timeLimit = timeLimit
        self.exceptions = exceptions
        self.fromTime = fromTime
        self.toTime = toTime
        self.shapePath = shapePath
        self.cnnRightLeft = cnnRightLeft
        self.left_fromAddress = left_fromAddress
        self.left_toAddress = left_toAddress
        self.right_fromAddress = right_fromAddress
        self.right_toAddress = right_toAddress
        self.streetName = streetName
        self.streetNum = streetNum
        self.zipCode = zipCode
        self.path = path
    }
}
