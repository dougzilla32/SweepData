//
//  ParkingRegulationsMap.swift
//  SweepData
//
//  Created by Doug on 5/4/22.
//

public struct ParkingRegulationsMap: BinaryCodable {
    public let date: Date
    public let segments: [ParkingRegulationsSegment]
    public let boundingBox: BoundingBox
    
    public init(date: Date, segments: [ParkingRegulationsSegment], boundingBox: BoundingBox) {
        self.date = date
        self.segments = segments
        self.boundingBox = boundingBox
    }
}

public struct ParkingRegulationsSegment: BinaryCodable {
    let row: Int
    let regulation: String
    let days: [Day]?
    let hours: String
    let hoursBegin: HourAndMinute?
    let hoursEnd: HourAndMinute?
    let regulationDetails: String
    let timeLimit: HourAndMinute?
    let exceptions: String
    let fromTime: String
    let toTime: String
    let shapePath: [LatitudeLongitude]

    let cnnRightLeft: RightLeft?
    let left_fromAddress: Int?
    let left_toAddress: Int?
    let right_fromAddress: Int?
    let right_toAddress: Int?
    let streetName: String
    let zipCode: Int?
    let path: [LatitudeLongitude]
    
    public init(row: Int, regulation: String, days: [Day]?, hours: String, hoursBegin: HourAndMinute?, hoursEnd: HourAndMinute?, regulationDetails: String, timeLimit: HourAndMinute?, exceptions: String, fromTime: String, toTime: String, shapePath: [LatitudeLongitude], cnnRightLeft: RightLeft?, left_fromAddress: Int?, left_toAddress: Int?, right_fromAddress: Int?, right_toAddress: Int?, streetName: String, zipCode: Int?, path: [LatitudeLongitude]) {
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
        self.zipCode = zipCode
        self.path = path
    }
}
