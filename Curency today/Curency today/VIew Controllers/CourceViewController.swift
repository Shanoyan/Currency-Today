//
//  CourceViewController.swift
//  Curency today
//
//  Created by Student on 02.07.25.
//
import UIKit

class CourceOption {
    var name: String
    var currency: String
    var course: String
    var backgroundColor: UIColor
    var backgroundImage: UIImage
   
    
    init(name: String, currency: String, course: String, backgroundColor: UIColor, backgroundImage: UIImage ) {
        self.name = name
        self.currency = currency
        self.course = course
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
     
    }
}

class CourceViewController: UIViewController {

    @IBOutlet weak var NavBar: UINavigationBar!
    
    @IBOutlet weak var TableView: UITableView!
    
    var models = [CourceOption]()
    var volues:[Double] = []
    var currencyCode:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        TableView.register(CourceTableViewCell.self, forCellReuseIdentifier: CourceTableViewCell.identifier)
        
        currentData()
        fetchJson()
        configure()
        
//        
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = view.bounds
//        gradientLayer.colors = [
//            UIColor.systemGray.cgColor ,
//            UIColor.systemCyan.cgColor ,
//        ]
//        view.layer.addSublayer(gradientLayer)
        
    }
    
    
    func currentData(){
        var now = Date()
        var nowComponents = DateComponents()
        let calendar = Calendar.current
        nowComponents.year = Calendar.current.component(.year, from: now)
        nowComponents.month = Calendar.current.component(.month, from: now)
        nowComponents.day = Calendar.current.component(.day, from: now)
        nowComponents.timeZone = NSTimeZone.local
        now = calendar.date(from: nowComponents)!
        NavBar.topItem?.title = "\(nowComponents.day!).\(nowComponents.month!).\(nowComponents.year!)"
    
    }
    
    func configure(){
        models.append(contentsOf: [
            CourceOption(name: "AMD", currency: "Armenia", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "ARM")!),
            CourceOption(name: "RUB", currency: "Russia", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "RUS")!),
            CourceOption(name: "USD", currency: "USA", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "USA")!),
            CourceOption(name: "EUR", currency: "Germany", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Germany")!),
            CourceOption(name: "GEL", currency: "Georgia", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Georgia")!),
            CourceOption(name: "GBP", currency: "United Kingdom", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "United Kingdom")!),
            CourceOption(name: "JPY", currency: "Japan", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Japan")!),
            CourceOption(name: "CNY", currency: "China", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "China")!),
            CourceOption(name: "CHF", currency: "Switzerland", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Switzerland")!),
            CourceOption(name: "CAD", currency: "Canada", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Canada")!),
            CourceOption(name: "AUD", currency: "Australia", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Australia")!),
            CourceOption(name: "INR", currency: "India", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "India")!),
            CourceOption(name: "BRL", currency: "Brazil", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Brazil")!),
            CourceOption(name: "MXN", currency: "Mexico", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Mexico")!),
            CourceOption(name: "UAH", currency: "Ukraine", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Ukraine")!),
            CourceOption(name: "DKK", currency: "Denmark", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Denmark")!),
            CourceOption(name: "ARS", currency: "Argentina", course: "1", backgroundColor: .darkGray, backgroundImage: UIImage(named: "Argentina")!),
        ])
    }
    
    func fetchJson() {
            guard let url = URL(string: "https://open.er-api.com/v6/latest/AMD") else { return }
            URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                guard let safeData = data else { return }
                
                do {
                    let rezults = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
                    self.currencyCode.append(contentsOf: rezults.rates.keys)
                    self.volues.append(contentsOf: rezults.rates.values)
                    rezults.rates.forEach {(key, value) in
                        self.models = self.models.map {
                            if $0.name == key {
                                let courseKey = (Double(models[0].course) ?? 0)/value
                                $0.course = "\(Double(round(100 * courseKey) / 100))"
                            }
                            return $0
                        }
                    }
                    DispatchQueue.main.async {
                        self.TableView.reloadData()
                    }
                }
                catch {
                    print(error)
                }
            }.resume()
        }
    

    @IBAction func convert(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ConvertViewController") as? ConvertViewController
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
    

}

extension CourceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = TableView.dequeueReusableCell(withIdentifier: CourceTableViewCell.identifier, for: indexPath) as?
        CourceTableViewCell
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
        self.TableView.deselectRow(at: indexPath, animated: true)
    }
    
}
