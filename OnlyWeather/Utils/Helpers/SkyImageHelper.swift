//
//  SkyImageHelper.swift
//  OnlyWeather
//
//  Created by Olga Lidman on 27.01.2020.
//  Copyright © 2020 Home. All rights reserved.
//

import Foundation
import UIKit

class SkyImageHelper: NSObject {
    
    //MARK: - setWindDirectionImage
    static func setWindDirectionImage(degree: Double) -> UIImage {
        switch degree {
        case 0...15, 345.1...361:
            return #imageLiteral(resourceName: "wind-north")
        case 15.1...75:
            return #imageLiteral(resourceName: "wind-north-east")
        case 75.1...105:
            return #imageLiteral(resourceName: "wind-east")
        case 105.1...165:
            return #imageLiteral(resourceName: "wind-south-east")
        case 165.1...195:
            return #imageLiteral(resourceName: "wind-south")
        case 195.1...255:
            return #imageLiteral(resourceName: "wind-south-west")
        case 255.1...285:
            return #imageLiteral(resourceName: "wind-west")
        case 285.1...345:
            return #imageLiteral(resourceName: "wind-north-west")
        default:
            return UIImage()
        }
    }
    
    //MARK: - setSkyImageDay
    static func setSkyImageDay(skyDescription: String) -> UIImage {
        switch skyDescription {
        case "Clouds":
            return #imageLiteral(resourceName: "046-cloudy")
        case "Clear":
            return #imageLiteral(resourceName: "009-sun-1")
        case "Rain":
            return #imageLiteral(resourceName: "022-rain-1")
        case "Drizzle":
            return #imageLiteral(resourceName: "029-storm-1")
        case "Snow":
            return #imageLiteral(resourceName: "020-snow")
        case "Thunderstorm":
            return #imageLiteral(resourceName: "011-storm-5")
        case "Mist", "Smoke", "Haze", "Dust", "Fog", "Sand", "Ash":
            return #imageLiteral(resourceName: "039-foggy-1")
        case "Tornado":
            return #imageLiteral(resourceName: "026-hurricane")
        case "Squall":
            return #imageLiteral(resourceName: "002-windy-1")
        default:
            return #imageLiteral(resourceName: "046-cloudy")
        }
    }
    
    //MARK: - setSkyImageNight
    static func setSkyImageNight(skyDescription: String) -> UIImage {
        switch skyDescription {
        case "Clouds":
            return #imageLiteral(resourceName: "045-cloudy-1")
        case "Clear":
            return #imageLiteral(resourceName: "048-night")
        case "Rain":
            return #imageLiteral(resourceName: "021-rain-2")
        case "Drizzle":
            return #imageLiteral(resourceName: "028-storm-2")
        case "Snow":
            return #imageLiteral(resourceName: "018-snowy")
        case "Thunderstorm":
            return #imageLiteral(resourceName: "013-storm-3")
        case "Mist", "Smoke", "Haze", "Dust", "Fog", "Sand", "Ash":
            return #imageLiteral(resourceName: "038-foggy-2")
        case "Tornado":
            return #imageLiteral(resourceName: "026-hurricane")
        case "Squall":
            return #imageLiteral(resourceName: "001-windy-2")
        default:
            return #imageLiteral(resourceName: "045-cloudy-1")
        }
    }
    
    //MARK: - setSkyImage
    static func setSkyImage(model: HourWeatherRowModel, cell: HourWeatherCollectionCell, day: Int?, night: Int?) {
        if model.timeInt > night ?? 21 || model.timeInt <= day ?? 6 {
            cell.timeLabel.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            cell.tempLabel.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            cell.descriptionLabel.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            switch model.sky {
            case "Clouds":
                cell.skyImageView.image = #imageLiteral(resourceName: "sky-clouds-night")
            case "Clear":
                cell.skyImageView.image = #imageLiteral(resourceName: "sky-clear-night")
            case "Rain":
                cell.skyImageView.image = #imageLiteral(resourceName: "sky-rain-night")
            case "Snow":
                cell.skyImageView.image = #imageLiteral(resourceName: "sky-snow-night")
            default:
                cell.skyImageView.image = #imageLiteral(resourceName: "sky-clouds-night")
            }
        } else {
            cell.timeLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            cell.tempLabel.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            cell.descriptionLabel.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            switch model.sky {
            case "Clouds":
                cell.skyImageView.image = #imageLiteral(resourceName: "sky-clouds-day")
            case "Clear":
                cell.skyImageView.image = #imageLiteral(resourceName: "sky-clear-day")
            case "Rain":
                cell.skyImageView.image = #imageLiteral(resourceName: "sky-rain-day")
            case "Snow":
                cell.skyImageView.image = #imageLiteral(resourceName: "sky-snow-day")
            default:
                cell.skyImageView.image = #imageLiteral(resourceName: "sky-clouds-day")
            }
        }
    }
}
