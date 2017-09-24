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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func upDateCellUI(name: String, company:String, imageURL:String, isFavourite: Bool){
        contactName.text = name
        contactCompany.text = company
        if isFavourite {
            favouriteImg.isHidden = false
            let favImage = "Favorite — True"
            favouriteImg.image = UIImage(named: favImage)
        } else {
            favouriteImg.isHidden = true
        }
        
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
              print("the small image failed to load")
            }
        }
    }
    // TODO: prepare for reuse cell
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
