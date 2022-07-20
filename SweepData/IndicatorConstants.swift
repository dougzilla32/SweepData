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
    
    public static let ImageSizeFactorWidth = DefaultLineWidth * 2.5 * 1.2
    public static let ImageSizeFactorHeight = DefaultLineWidth * 2.5
    public static let ImageScaleFactor = 10.0
//    public static let ImageSize = 36.0
//    public static let ImageScaledSize = ImageSize * 10
//    public static let ImageScaleMultiplier = Size / ImageScaledSize
//    public static let ImageBoxWidth = DefaultLineWidth * 2.5
//    public static let ImageBoxHeight = DefaultLineWidth * 2.5

    public static let Opaque: Float = 0.8
    public static let Standard: Float = 0.55
}
