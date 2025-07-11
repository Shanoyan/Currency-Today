//
//  ConvertViewController.swift
//  Curency today
//
//  Created by Student on 02.07.25.
//

import UIKit

class ConvertOption {
    var name: String
    var backgroundColor: UIColor
    var backgroundImage: UIImage
    var api: String
   
    
    init(name: String, backgroundColor: UIColor, backgroundImage: UIImage , api: String) {
        self.name = name
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
        self.api = api
     
    }
}

class ConvertViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var models = [ConvertOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ConvertTableViewCell.self, forCellReuseIdentifier: ConvertTableViewCell.identifier)
        configure()
    }
    
    func configure(){
        models.append(contentsOf: [
            ConvertOption(name: "AMD", backgroundColor: .darkGray, backgroundImage: UIImage(named: "ARM")!, api: "https://open.er-api.com/v6/latest/AMD"),
            ConvertOption(name: "RUB", backgroundColor: .darkGray, backgroundImage: UIImage(named:  "RUS")!, api: "https://open.er-api.com/v6/latest/RUB"),
            ConvertOption(name: "USD", backgroundColor: .darkGray, backgroundImage: UIImage(named: "USA")!, api: "https://open.er-api.com/v6/latest/USD"),
            ConvertOption(name: "EUR", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Germany")!, api: "https://open.er-api.com/v6/latest/EUR"),
            ConvertOption(name: "GEL", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Georgia")!, api: "https://open.er-api.com/v6/latest/GEL"),
            ConvertOption(name: "GBP", backgroundColor: .darkGray, backgroundImage: UIImage(named: "United Kingdom")!, api: "https://open.er-api.com/v6/latest/GBP"),
            ConvertOption(name: "JPY", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Japan")!, api: "https://open.er-api.com/v6/latest/JPY"),
            ConvertOption(name: "CNY", backgroundColor: .darkGray, backgroundImage: UIImage(named: "China")!, api: "https://open.er-api.com/v6/latest/CNY"),
            ConvertOption(name: "CHF", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Switzerland")!, api: "https://open.er-api.com/v6/latest/CHF"),
            ConvertOption(name: "CAD", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Canada")!, api: "https://open.er-api.com/v6/latest/CAD"),
            ConvertOption(name: "AUD", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Australia")!, api: "https://open.er-api.com/v6/latest/AUD"),
            ConvertOption(name: "INR", backgroundColor: .darkGray, backgroundImage: UIImage(named: "India")!, api: "https://open.er-api.com/v6/latest/INR"),
            ConvertOption(name: "BRL", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Brazil")!, api: "https://open.er-api.com/v6/latest/BRL"),
            ConvertOption(name: "MXN", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Mexico")!, api: "https://open.er-api.com/v6/latest/MXN"),
            ConvertOption(name: "UAH", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Ukraine")!, api: "https://open.er-api.com/v6/latest/UAH"),
            ConvertOption(name: "DKK", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Denmark")!, api: "https://open.er-api.com/v6/latest/DKK"),
            ConvertOption(name: "ARS", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Argentina")!, api: "https://open.er-api.com/v6/latest/ARS"),
            

            
     
        ])
    }
    
    @IBAction func home(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CourceViewController") as? CourceViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    
    }
    
  
    
    
   
    @IBAction func settings(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
            vc?.modalTransitionStyle = .crossDissolve
            vc?.modalPresentationStyle = .overFullScreen
            self.present(vc!, animated: true)
    }

 
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ConvertViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConvertTableViewCell.identifier, for: indexPath) as?
        ConvertTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if models[indexPath.item].name != ""{
            let vc = storyboard?.instantiateViewController(withIdentifier:"ComvertViewController") as!
            ComvertViewController
            vc.ap = models[indexPath.item].api
            vc.text = models[indexPath.item].name
            self.present(vc, animated: true)
        }
    }
}
