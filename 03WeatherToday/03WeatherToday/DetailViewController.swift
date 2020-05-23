//
//  DetailViewController.swift
//  03WeatherToday
//
//  Created by 구민영 on 2020/05/14.
//  Copyright © 2020 구민영. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet weak var weatherImageView: UIImageView?
    @IBOutlet weak var weatherLabel: UILabel?
    @IBOutlet weak var temperatureLabel: UILabel?
    @IBOutlet weak var rainfallLabel: UILabel?
    
    // MARK:- Properties
    var city: City?
    var navigationTitle: String?
    
    // MARK:- Methods
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let city = city,
            let title = navigationTitle else {return}
        
        self.navigationItem.title = title
        
        weatherImageView?.image = city.weatherAndImage.image
        weatherLabel?.text = city.weatherAndImage.weather
        temperatureLabel?.text = city.fullTemperature
        rainfallLabel?.text = "강수확률 \(city.rainfallProbability)%"
    }
}
