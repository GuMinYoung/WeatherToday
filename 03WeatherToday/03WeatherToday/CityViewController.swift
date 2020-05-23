//
//  CityViewController.swift
//  03WeatherToday
//
//  Created by 구민영 on 2020/05/14.
//  Copyright © 2020 구민영. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView?
    
    // MARK:- Properties
    let cellIdentifier = "cityCell"
    var cities = [City]()
    var navigationTitle: String?
    var country: String?
    
    // MARK:- Methods
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.dataSource = self
        tableView?.delegate = self
        
        self.navigationItem.title = navigationTitle
        
        let jsonDecoder = JSONDecoder()
        guard let assetName = country,
            let dataAsset = NSDataAsset(name: assetName) else {return}
        
        do {
            self.cities = try jsonDecoder.decode([City].self, from: dataAsset.data)
        } catch {
            print(error)
        }
        
        tableView?.reloadData()
    }
}

// MARK: UITableViewDataSource
extension CityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CityCell else {return UITableViewCell()}
        let city = cities[indexPath.row]
        cell.weatherImageView?.image = city.weatherAndImage.image
        cell.nameLabel?.text = city.name
        cell.temperatureLabel?.text = city.fullTemperature
        cell.rainfallLabel?.text = "강수확률 \(city.rainfallProbability)%"
        return cell
    }
}

// MARK: UITableViewDelegate
extension CityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let identifier = "detailViewController"
        guard let nextViewController = storyboard?.instantiateViewController(withIdentifier: identifier) as? DetailViewController else {return}
        
        nextViewController.navigationTitle = cities[indexPath.row].name
        nextViewController.city = cities[indexPath.row]
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
