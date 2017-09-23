//
//  ViewController.swift
//  Solstice Contacts
//
//  Created by Nilu on 2017-09-22.
//  Copyright © 2017 Nirali. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nameNib = UINib(nibName: "NameCell", bundle: nil)
        let phoneNib = UINib(nibName: "PhoneCell", bundle: nil)
        let twoLabelNib = UINib(nibName: "TwoLabelCell", bundle: nil)
        tableView.register(nameNib, forCellReuseIdentifier: "nameCell")
        tableView.register(phoneNib, forCellReuseIdentifier: "phoneCell")
        tableView.register(twoLabelNib, forCellReuseIdentifier: "twoLabelCell")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! NameCell
//        cell.contactName.text = "Nili"
//        cell.contactCompany.text = "rbc"
////        cell.contactImage.image = UIImage(named:"User — Large.png")
//        let cell = tableView.dequeueReusableCell(withIdentifier: "phoneCell", for: indexPath) as! PhoneCell
//        cell.phonenumber.text  = "905-216-6030"
//        cell.phoneType.text = "Home"
        let cell = tableView.dequeueReusableCell(withIdentifier: "twoLabelCell", for: indexPath) as! TwoLabelCell
        cell.topLabel.text = "Address"
        cell.bottomLabel.text = "51 Blackberry Valley Crescent \nCaledon, Ontario L6R 2Z7"
        
        return cell
 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }


}

