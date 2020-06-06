//
//  CountryViewController.swift
//  03WeatherToday
//
//  Created by 구민영 on 2020/05/14.
//  Copyright © 2020 구민영. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet weak var tableView: UITableView?
    
    // MARK:- Properties
    let cellIdentifier = "countryCell"
    var countries = [Country]()
    var country: String?
    
    // MARK:- Methods
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initDelegate()
        
        self.navigationItem.title = "세계 날씨"
        
        setUpDataFromJson()
        tableView?.reloadData()
    }
    
    // MARK: Custom Method
    func initDelegate() {
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    func setUpDataFromJson() {
        let jsonDecoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "countries") else {return}
        
        do {
            self.countries = try jsonDecoder.decode([Country].self, from: dataAsset.data)
        } catch {
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let selectedIndexPath = tableView?.indexPathForSelectedRow else {return}
        tableView?.deselectRow(at: selectedIndexPath, animated: false)
    }
}

// MARK: UITableViewDataSource
extension CountryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        guard let country = countries[safeIndex: indexPath.row] else {
            let defaultCell = UITableViewCell()
            defaultCell.textLabel?.text = "데이터를 표시할 수 없습니다."
            return defaultCell
        }
        let koreanName = country.koreanName
        let assetName = "flag_" + country.assetName
        
        cell.imageView?.image = UIImage(named: assetName)
        cell.textLabel?.text = koreanName
        return cell
    }
}

// MARK: UITableViewDelegate
extension CountryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = "cityViewController"
        guard let nextViewController = storyboard?.instantiateViewController(withIdentifier: identifier) as? CityViewController,
        let country = countries[safeIndex: indexPath.row] else {
            print("화면 전환 불가: 올바른 인덱스가 아닙니다.")
            return
        }
        
        // MARK:- *코드리뷰
        // navigationTitle은 country 데이터 내부에 있는 koreanName이므로 CityViewController에서 country데이터에서 활용하는 것이 좋을 것 같습니다.
        //nextViewController.navigationTitle = country.koreanName
        //nextViewController.country = country.assetName
        nextViewController.country = country
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
