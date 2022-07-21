//
//  IndicatorConstants.swift
//  SweepData
//
//  Created by Doug on 6/29/22.
//

public struct IndicatorConstants {
    public static let DefaultLineWidth = 1.025 / 25000.0
    public static let FontSizeFactor = DefaultLineWidth * 3.5

    public static let FontSize = 36.0
    public static let FontScaledSize = 36.0 * 10
    public static let FontTransformMultiplier = FontSizeFactor / FontSize
    public static let FontScaleMultiplier = FontSizeFactor / FontScaledSize
    public static let FontBoxWidth = FontSizeFactor
    public static let FontBoxHeight = FontSizeFactor
    
    public static let ImageSizeFactor = DefaultLineWidth * 4

    public static let Opaque: Float = 0.8
    public static let Standard: Float = 0.55
}
