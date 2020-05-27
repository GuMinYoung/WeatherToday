//
//  Array+Subscript.swift
//  03WeatherToday
//
//  Created by 구민영 on 2020/05/27.
//  Copyright © 2020 구민영. All rights reserved.
//

import Foundation

// Index Out of Range 에러 방지
extension Array {
    subscript(safeIndex index: Int) -> Element? {
        return 0 <= index && index < self.count ? self[index] : nil
    }
}
