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
    let name: String
    let state: Int                  // 날씨 상태
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
        return "섭씨 \(self.celsius)도 / " + "화씨 " + fahrenheitToString + "도\n"
    }
    
    enum CodingKeys: String, CodingKey {
        case state, celsius
        case name = "city_name"
        case rainfallProbability = "rainfall_probability"
    }
}
