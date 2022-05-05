//
//  MetersMap.swift
//  SweepData
//
//  Created by Doug on 5/4/22.
//

public struct MeterPath: LLPath, BinaryCodable {
    public let row: Int
    public let postID: String
    public let parkingSpaceID: Int
    public let smartMeterFlag: String
    public let capColor: MeterCapColor
    public let streetID: Int?
    public let streetName: String
    public let streetNum: Int?
    public let days: [Day]
    public let hoursBegin: HourAndMinute?
    public let hoursEnd: HourAndMinute?
    public let scheduleType: String
    public let hourlyRate: Decimal?
    public let timeLimit: HourAndMinute?
    public let orientation: Int?
    public let path: [LatitudeLongitude]
}
