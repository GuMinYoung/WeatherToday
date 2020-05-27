//
//  CityCell.swift
//  03WeatherToday
//
//  Created by 구민영 on 2020/05/21.
//  Copyright © 2020 구민영. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    @IBOutlet weak var weatherImageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var temperatureLabel: UILabel?
    @IBOutlet weak var rainfallLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
