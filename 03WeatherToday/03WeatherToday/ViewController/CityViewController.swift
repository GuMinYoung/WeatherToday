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
    var country: Country?
    
    // MARK:- Methods
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegate()
        self.navigationItem.title = country?.koreanName
        setUpDataFromJson()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let selectedIndexPath = tableView?.indexPathForSelectedRow else {return}
        tableView?.deselectRow(at: selectedIndexPath, animated: false)
    }
    
    // MARK: Custom Method
    func initDelegate() {
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    func setUpDataFromJson() {
        let jsonDecoder = JSONDecoder()
        guard let assetName = country?.assetName,
            let dataAsset = NSDataAsset(name: assetName) else {return}
        
        do {
            self.cities = try jsonDecoder.decode([City].self, from:
                dataAsset.data)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CityCell,
            let city = cities[safeIndex: indexPath.row] else {
            let defaultCell = UITableViewCell()
            defaultCell.textLabel?.text = "데이터를 표시할 수 없습니다."
            return defaultCell
        }
        
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
        guard let nextViewController = storyboard?.instantiateViewController(withIdentifier: identifier) as? DetailViewController,
        let city = cities[safeIndex: indexPath.row] else {
            print("화면 전환 불가: 올바른 인덱스가 아닙니다.")
            return
        }
        
        nextViewController.city = city
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
