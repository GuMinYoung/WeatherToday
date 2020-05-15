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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = navigationTitle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        
        let jsonDecoder = JSONDecoder()
        guard let assetName = country, let dataAsset = NSDataAsset(name: assetName) else {return}
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let city = cities[indexPath.row]
        cell.imageView?.image = UIImage(named: "flag_kr")
        cell.textLabel?.text = city.name
        cell.detailTextLabel?.numberOfLines = 2
        cell.detailTextLabel?.text = city.fullTemperature + "강수확률 \(city.rainfallProbability)%"
        return cell
    }
}
