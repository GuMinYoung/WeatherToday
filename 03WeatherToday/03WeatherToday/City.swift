//
//  City.swift
//  03WeatherToday
//
//  Created by 구민영 on 2020/05/14.
//  Copyright © 2020 구민영. All rights reserved.
//

import Foundation

/*
 {
    "city_name":"베를린",
    "state":12,
    "celsius":10.8,
    "rainfall_probability":60
 }
*/

struct City: Codable {
    let cityName: String
    let state: Int                  // 날씨 상태
    let celsius: Float              // 섭씨
    let rainfallProbability: Int    // 강수 확률
    
    /*
    var fahrenheit: Float {         // 화씨
        return
    }
 */
    
    enum CodingKeys: String, CodingKey {
        case state, celsius
        case cityName = "city_name"
        case rainfallProbability = "rainfall_probability"
    }
}
