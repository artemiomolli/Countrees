//
//  ViewController.swift
//  AllCountries
//
//  Created by Артём Гуральник on 3/24/19.
//  Copyright © 2019 Guralnyk Artem. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var countrees = Array<Country>(){
        
        didSet {

            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isHidden = true
        
        SVProgressHUD.show()
        
        Alamofire.request("https://restcountries.eu/rest/v2/all").responseJSON { (response) in
        
            SVProgressHUD.dismiss()
            
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                
                guard let countreesArray = json.array else {return}
                
                for  country in countreesArray {
                    
                    var countryBorders = ""
                    
                    if let borders = country["borders"].array  {
                        
                        for string in borders {
                            
                            if let countryName = string.string {
                                
                                if countryBorders == "" {
                                   
                                    countryBorders = countryName
                                }else {
                                    countryBorders = countryBorders + " " + countryName
                                }
                            }
                        }
                    }
                    
                    guard let countryName = country["nativeName"].string else {return}
                    
                    let thisCountry = Country(name: countryName, borders: countryBorders)
                    
                    self.countrees.append(thisCountry)
                }
                
                self.tableView.isHidden = false
                
            case .failure(_): break
            }
        }
    }

}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        
        cell.textLabel?.text = countrees[indexPath.row].countryName
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countrees.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.bounds.size.height / 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let popupVC = PopupViewController()
        
        self.addChild(popupVC)
        view.addSubview(popupVC.view)
        
        if  countrees[indexPath.row].countryBorders != "" {
            
            popupVC.bordersLabel.text = countrees[indexPath.row].countryBorders
        }
        
    }
}
