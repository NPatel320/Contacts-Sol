//
//  ContactCell.swift
//  Solstice Contacts
//
//  Created by Nilu on 2017-09-23.
//  Copyright © 2017 Nirali. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    @IBOutlet weak var contactImgSmall: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var favouriteImg: UIImageView!
    @IBOutlet weak var contactCompany: UILabel!
    
    func upDateCellUI(name: String, company:String, imageURL:String, isFavourite: Bool){
        contactName.text = name
        contactCompany.text = company
        let favImage = "Favorite — True"
        favouriteImg.image = UIImage(named: favImage)
        favouriteImg.isHidden = !isFavourite
        
        // cell will use default image while it waits for image to load
        let smallImgURL = URL(string:imageURL)!
        self.contactImgSmall.image = UIImage(named: "User Icon Small")
        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: smallImgURL)
                DispatchQueue.main.async {
                    self.contactImgSmall.image = UIImage(data: data)
                }
            } catch {
                // will use default image
            }
        }
    }
    override func prepareForReuse() {
        favouriteImg.isHidden = false
    }
}
