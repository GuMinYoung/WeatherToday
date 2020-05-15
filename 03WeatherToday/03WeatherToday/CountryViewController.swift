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
    
    // MARK:- Methods
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.dataSource = self
        self.navigationItem.title = "세계 날씨"
        
        let jsonDecoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "countries") else {return}
        
        do {
            // dataAsset.data를 [Friend] 타입으로 디코딩
            self.countries = try jsonDecoder.decode([Country].self, from: dataAsset.data)
        } catch {
            print(error)
        }
        
        tableView?.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let cityViewController = segue.destination as? CityViewController, let cell = sender as? UITableViewCell  else {return}
        cityViewController.navigationTitle = cell.textLabel?.text
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

// 추가
// 1. Index Out of Range 체크
// 2. 다음 화면으로 갔다가 돌아왔을 때 셀 선택 해제하기
// 3. viewDidLoad 정리
