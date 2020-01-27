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
    
    func setWindDirectionImage(degree: Double, imageView: UIImageView) {
        switch degree {
        case 0...15:
            imageView.image = #imageLiteral(resourceName: "wind-north")
        case 15.1...75:
            imageView.image = #imageLiteral(resourceName: "wind-north-east")
        case 75.1...105:
            imageView.image = #imageLiteral(resourceName: "wind-east")
        case 105.1...165:
            imageView.image = #imageLiteral(resourceName: "wind-south-east")
        case 165.1...195:
            imageView.image = #imageLiteral(resourceName: "wind-south")
        case 195.1...255:
            imageView.image = #imageLiteral(resourceName: "wind-south-west")
        case 255.1...285:
            imageView.image = #imageLiteral(resourceName: "wind-west")
        case 285.1...345:
            imageView.image = #imageLiteral(resourceName: "wind-north-west")
        case 345.1...361:
            imageView.image = #imageLiteral(resourceName: "wind-north")
        default:
            break
        }
    }
    
    func setSkyImageDay(skyDescription: String, imageView: UIImageView) {
        switch skyDescription {
        case "Clouds":
            imageView.image = #imageLiteral(resourceName: "046-cloudy")
        case "Clear":
            imageView.image = #imageLiteral(resourceName: "009-sun-1")
        case "Rain":
            imageView.image = #imageLiteral(resourceName: "029-storm-1")
        case "Snow":
            imageView.image = #imageLiteral(resourceName: "020-snow")
        case "Thunderstorm":
            imageView.image = #imageLiteral(resourceName: "011-storm-5")
        case "Drizzle":
            imageView.image = #imageLiteral(resourceName: "029-storm-1")
        case "Mist":
            imageView.image = #imageLiteral(resourceName: "039-foggy-1")
        case "Smoke":
            imageView.image = #imageLiteral(resourceName: "039-foggy-1")
        case "Haze":
            imageView.image = #imageLiteral(resourceName: "039-foggy-1")
        case "Dust":
            imageView.image = #imageLiteral(resourceName: "039-foggy-1")
        case "Fog":
            imageView.image = #imageLiteral(resourceName: "039-foggy-1")
        case "Sand":
            imageView.image = #imageLiteral(resourceName: "039-foggy-1")
        case "Tornado":
            imageView.image = #imageLiteral(resourceName: "026-hurricane")
        case "Ash":
            imageView.image = #imageLiteral(resourceName: "039-foggy-1")
        case "Squall":
            imageView.image = #imageLiteral(resourceName: "005-wind-sign")
        default:
            imageView.image = #imageLiteral(resourceName: "046-cloudy")
        }
    }
    
    
    func setSkyImageNight(skyDescription: String, imageView: UIImageView) {
        switch skyDescription {
        case "Clouds":
            imageView.image = #imageLiteral(resourceName: "045-cloudy-1")
        case "Clear":
            imageView.image = #imageLiteral(resourceName: "048-night")
        case "Rain":
            imageView.image = #imageLiteral(resourceName: "028-storm-2")
        case "Snow":
            imageView.image = #imageLiteral(resourceName: "018-snowy")
        case "Thunderstorm":
            imageView.image = #imageLiteral(resourceName: "013-storm-3")
        case "Drizzle":
            imageView.image = #imageLiteral(resourceName: "028-storm-2")
        case "Mist":
            imageView.image = #imageLiteral(resourceName: "038-foggy-2")
        case "Smoke":
            imageView.image = #imageLiteral(resourceName: "038-foggy-2")
        case "Haze":
            imageView.image = #imageLiteral(resourceName: "038-foggy-2")
        case "Dust":
            imageView.image = #imageLiteral(resourceName: "038-foggy-2")
        case "Fog":
            imageView.image = #imageLiteral(resourceName: "038-foggy-2")
        case "Sand":
            imageView.image = #imageLiteral(resourceName: "038-foggy-2")
        case "Tornado":
            imageView.image = #imageLiteral(resourceName: "026-hurricane")
        case "Ash":
            imageView.image = #imageLiteral(resourceName: "038-foggy-2")
        case "Squall":
            imageView.image = #imageLiteral(resourceName: "005-wind-sign")
        default:
            imageView.image = #imageLiteral(resourceName: "045-cloudy-1")
        }
    }
    
    func setSkyImage(weather: Weather, cell: HourWeatherCell, day: Int?, night: Int?) {
        if weather.time > night ?? 21 || weather.time <= day ?? 6 {
            cell.dateLabel.textColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            cell.tempLabel.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            cell.skyLabel.textColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            switch weather.sky {
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
            cell.dateLabel.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            cell.tempLabel.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            cell.skyLabel.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            switch weather.sky {
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
