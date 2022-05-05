//
//  LLPath.swift
//  SweepData
//
//  Created by Doug on 5/5/22.
//

public protocol LLPath {
    var row: Int { get }
    var days: [Day] { get }
    var hoursBegin: HourAndMinute? { get }
    var hoursEnd: HourAndMinute? { get }
    var timeLimit: HourAndMinute? { get }
    var streetName: String { get }
    var streetNum: Int? { get }
    var path: [LatitudeLongitude] { get }
}
