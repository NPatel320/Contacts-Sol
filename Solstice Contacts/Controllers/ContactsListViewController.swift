//
//  ContactsListViewController.swift
//  Solstice Contacts
//
//  Created by Nilu on 2017-09-22.
//  Copyright © 2017 Nirali. All rights reserved.
//

import UIKit
import Alamofire
class ContactsListViewController: UITableViewController {
   
    
    var persons = [Person]()
    var farvourites = [Person]()
    var otherContacts = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloadContactsData {
            self.sortContacts(Contacts: self.persons)
            self.tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.sortContacts(Contacts: persons)
        tableView.reloadData()
    }
    func downloadContactsData(completed: @escaping DownloadComplete)  {
        let contactsURL = URL(string: baseURL)
        Alamofire.request(contactsURL!).responseJSON { response in
            let result = response.result
            if let contacts = result.value as? [Dictionary<String, AnyObject>]{
                for contact in contacts{
                    let person = Person(contactDict: contact)
                    self.persons.append(person)
                }
                
            }
            completed()
        }
       
    }
    func sortContacts(Contacts: [Person]){
        farvourites = []
        otherContacts = []
        let sortedcontacts = self.persons.sorted{ $0.name < $1.name}
        for person in sortedcontacts {
            if person.isFavourite == true {
                self.farvourites.append(person)
            }else{
                self.otherContacts.append(person)
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return farvourites.count
        default:
            return otherContacts.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDetailCell", for: indexPath) as? ContactCell{
        switch indexPath.section {
        case 0:
            let contact = farvourites[indexPath.row]
            cell.upDateCellUI(name: contact.name, company: contact.company, imageURL: contact.smallImgURL, isFavourite: contact.isFavourite)
            return cell
        default:
            let contact = otherContacts[indexPath.row]
            cell.upDateCellUI(name: contact.name, company: contact.company, imageURL: contact.smallImgURL, isFavourite: contact.isFavourite)
            return cell
            }
        } else {
            return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionTitle: String
        switch section {
        case 0:
            sectionTitle = " Favorite Contacts"
        default:
            sectionTitle = " Other Contacts"
        }
        return sectionTitle
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let contact = farvourites[indexPath.row]
           performSegue(withIdentifier: "contactDetails", sender: contact)
        }else{
            let contact = otherContacts[indexPath.row]
            performSegue(withIdentifier: "contactDetails", sender: contact)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ContactDetailViewController {
            if let contact = sender as? Person {
                destination.contact = contact
            }
        }
    }
}
