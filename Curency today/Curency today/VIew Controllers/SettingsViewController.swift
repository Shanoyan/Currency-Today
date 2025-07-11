//
//  SettingsViewController.swift
//  Curency today
//
//  Created by Student on 02.07.25.
//

import UIKit

class SettingsOption {
    var name: String
    var backgroundColor: UIColor
    var backgroundImage: UIImage
   
    
    init(name: String, backgroundColor: UIColor, backgroundImage: UIImage ) {
        self.name = name
        self.backgroundColor = backgroundColor
        self.backgroundImage = backgroundImage
     
    }
}

class SettingsViewController: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    var models = [SettingsOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        configure()
    }
    
    func configure(){
        models.append(contentsOf: [
            SettingsOption(name: "About program", backgroundColor: .darkGray, backgroundImage: UIImage(systemName: "gear")!),
            SettingsOption(name: "Share", backgroundColor: .darkGray, backgroundImage: UIImage(systemName: "square.and.arrow.up")!),
            SettingsOption(name: "Contact", backgroundColor: .darkGray, backgroundImage: UIImage(systemName: "person.badge.shield.checkmark")!),
            SettingsOption(name: "By", backgroundColor: .darkGray, backgroundImage: UIImage(systemName: "shareplay")!),
            
        ])
    }
            
    
    
    
    @IBAction func home(_ sender: Any) {
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CourceViewController") as? CourceViewController
            vc?.modalTransitionStyle = .crossDissolve
            vc?.modalPresentationStyle = .overFullScreen
            self.present(vc!, animated: true)
    
    }
    
  
    @IBAction func convert(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ConvertViewController") as? ConvertViewController
        vc?.modalTransitionStyle = .crossDissolve
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true)
    }
   

}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as?
                SettingsTableViewCell
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
        if(models[indexPath.item].name == "About program"){
            let actionSheet = UIAlertController(title: " Created in July 9,2025", message: nil, preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(actionSheet,animated: true)
            
        } else if(models[indexPath.item].name == "Share"){
            let  activityVc = UIActivityViewController(activityItems: [""], applicationActivities: nil)
            activityVc.popoverPresentationController?.sourceView = self.view
            self.present(activityVc,animated: true)
        }else if models[indexPath.item].name == "Contact" {
            let actionSheet = UIAlertController(title: "Facebook", message: nil, preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Facebook", style: .default, handler:{ (action) in
                UIApplication.shared.openURL(NSURL(string: "")! as URL)
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(actionSheet,animated: true)
        } else if(models[indexPath.item].name == "By"){
            let actionSheet = UIAlertController(title: "By Mari Shanoyan", message: nil, preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(actionSheet,animated: true)
            
        }
    }
}


