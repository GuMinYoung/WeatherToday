//
//  City.swift
//  03WeatherToday
//
//  Created by 구민영 on 2020/05/14.
//  Copyright © 2020 구민영. All rights reserved.
//

import Foundation
import UIKit

/*
 {
    "city_name":"베를린",
    "state":12,
    "celsius":10.8,
    "rainfall_probability":60
 }
*/

struct City: Codable {
    // MARK:- *코드리뷰
    // 이런 경우는 보통 struct가 아닌 enum을 사용하는 편이 좋습니다.
    /*
    struct WeatherAndImage {
        static let sunny = ("맑음", UIImage(named: "sunny"))
        static let cloudy = ("구름", UIImage(named: "cloudy"))
        static let rainy = ("비", UIImage(named: "rainy"))
        static let snowy = ("눈", UIImage(named: "snowy"))
    }
    */
    enum Weather: String {
        case sunny = "맑음"
        case cloudy = "구름"
        case rainy = "비"
        case snowy = "눈"
        
        var image: UIImage? {
            switch self {
            case .sunny:
                return UIImage(named: "sunny")
            case .cloudy:
                return UIImage(named: "cloudy")
            case .rainy:
                return UIImage(named: "rainy")
            case .snowy:
                return UIImage(named: "snowy")
            }
        }
    }
    
    let name: String
    let state: Int                   // 날씨 상태
    let celsius: Double              // 섭씨
    let rainfallProbability: Int    // 강수 확률
    
    var fullTemperature: String {
        // 1. 섭씨를 화씨로 변환
        let fahrenheit =  self.celsius * 1.8 + 32
        // 2. 화씨를 소수점 첫째 자리까지만 표시
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1
        guard let fahrenheitToString = numberFormatter.string(for: fahrenheit) else {return ""}
        // 3. 섭씨와 화씨 문자열 리턴
        return "섭씨 \(self.celsius)도 / " + "화씨 " + fahrenheitToString + "도"
    }
    
    var weatherAndImage: (weather: String, image: UIImage?) {
        switch self.state {
        case 10:
            return (Weather.sunny.rawValue, Weather.sunny.image)
        case 11:
            return (Weather.cloudy.rawValue, Weather.cloudy.image)
        case 12:
            return (Weather.rainy.rawValue, Weather.rainy.image)
        case 13:
            return (Weather.snowy.rawValue, Weather.snowy.image)
        default:
            return ("정보 없음", nil)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case state, celsius
        case name = "city_name"
        case rainfallProbability = "rainfall_probability"
    }
}
