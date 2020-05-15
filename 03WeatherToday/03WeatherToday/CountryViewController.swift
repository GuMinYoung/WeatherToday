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

        tableView?.dataSource = self
        tableView?.delegate = self
        self.navigationItem.title = "세계 날씨"
        
        let jsonDecoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "countries") else {return}
        
        do {
            self.countries = try jsonDecoder.decode([Country].self, from: dataAsset.data)
        } catch {
            print(error)
        }
        
        tableView?.reloadData()
    }
}

// MARK: UITableViewDataSource
extension CountryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let koreanName = countries[indexPath.row].koreanName
        let assetName = "flag_" + countries[indexPath.row].assetName
        
        cell.imageView?.image = UIImage(named: assetName)
        cell.textLabel?.text = koreanName
        return cell
    }
}

// MARK: UITableViewDelegate
extension CountryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = "cityViewController"
        guard let nextViewController = storyboard?.instantiateViewController(withIdentifier: identifier) as? CityViewController else {return}
        
        nextViewController.navigationTitle = countries[indexPath.row].koreanName
        nextViewController.country = countries[indexPath.row].assetName
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// 추가
// 1. Index Out of Range 체크
// 2. 다음 화면으로 갔다가 돌아왔을 때 셀 선택 해제하기
// 3. viewDidLoad 정리
