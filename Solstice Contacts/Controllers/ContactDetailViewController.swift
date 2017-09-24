//
//  ViewController.swift
//  Solstice Contacts
//
//  Created by Nilu on 2017-09-22.
//  Copyright © 2017 Nirali. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    private var _contact: Person!
    private var contactPhone:[String:String] = [:]
    private var contactInfo: [String:String] = [:]
    var contact: Person!{
        get{
            return _contact
        } set{
            _contact = newValue
        }
    }
    
    @IBOutlet weak var favouriteImage: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contactLargeImg: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactCompany: UILabel!
    @IBAction func favouriteButton(_ sender: Any) {
        contact.isFavourite = !contact.isFavourite
        updateFavouriteImage(isFavourite: contact.isFavourite)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewUI(contact: contact)
        prepareContactfortable(contact: contact)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let phoneNib = UINib(nibName: "PhoneCell", bundle: nil)
        let twoLabelNib = UINib(nibName: "TwoLabelCell", bundle: nil)
        tableView.register(phoneNib, forCellReuseIdentifier: "PhoneCell")
        tableView.register(twoLabelNib, forCellReuseIdentifier: "twoLabelCell")
    }
  
    func updateViewUI(contact:Person){
        contactName.text = contact.name
        contactCompany.text = contact.company
        updateFavouriteImage(isFavourite: contact.isFavourite)
        let imgURL = URL(string:contact.largeImgURL)!
        self.contactLargeImg.image = UIImage(named: "User — Large")
        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: imgURL)
                DispatchQueue.main.async {
                    self.contactLargeImg.image = UIImage(data: data)
                }
            } catch {
                // use default image istead
            }
        }
    }
    func updateFavouriteImage(isFavourite: Bool){
        let favImage = isFavourite ? "Favorite — True" : "Favorite — False"
        favouriteImage.image = UIImage(named: favImage)
    }
    
    func prepareContactfortable(contact: Person){
   
        if !contact.address.isEmpty {
            contactInfo["Address"] = contact.address
        }
        if !contact.birthday.isEmpty {
            contactInfo["Birthdate"] = contact.birthday
        }
        if !contact.email.isEmpty {
            contactInfo["Email"] = contact.email
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PhoneCell", for: indexPath) as? PhoneCell{
                let contactPhone = Array(contact.phone).sorted(by: { $0.0 < $1.0 })
                cell.phonenumber.text = contactPhone[indexPath.row].value
                cell.phoneType.text = contactPhone[indexPath.row].key
                return cell
            }else{
                return UITableViewCell()
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "twoLabelCell", for: indexPath) as? TwoLabelCell{
                let contactInfo = Array(self.contactInfo).sorted(by: { $0.0 < $1.0})
                cell.topLabel.text = contactInfo[indexPath.row].key
                cell.bottomLabel.text = contactInfo[indexPath.row].value
                return cell
            }else{
                return UITableViewCell()
            }
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return contact.phone.count
        default:
            return contactInfo.count
        }
    }


}

