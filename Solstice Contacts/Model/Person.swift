//
//  Person.swift
//  Solstice Contacts
//
//  Created by Nilu on 2017-09-23.
//  Copyright © 2017 Nirali. All rights reserved.
//

import UIKit

class Person: NSObject {
    private var _name: String!
    private var _company: String?
    private var _isFavourite: Bool
    private var _smallImgURL: String?
    private var _largeImgURL: String?
    private var _email: String?
    private var _birthday: String?
    private var _phone: [String: String]?
    private var _address: String?
    
    var name: String {
        return _name
    }
    var company: String {
        if let companyname = _company{
            return companyname
        }else{
            return ""
        }
    }
    var isFavourite: Bool {
        get{
            return _isFavourite
        } set{
            _isFavourite = newValue
        }
    }
    var smallImgURL: String {
        if let smallImageURL = _smallImgURL {
            return smallImageURL
        }else {
            return "User Icon Small"
        }
    }
    var largeImgURL: String {
        if let largeImageURL = _largeImgURL {
            return largeImageURL
        }else{
          return "User — Large"
        }
    }
    var email:String {
        if let emailAdd = _email{
            return emailAdd
        }else{
            return ""
        }
    }
    var birthday:String {

        if let bday = _birthday{
            let dateString = bday
            let dateFormatterFromString = DateFormatter()
            dateFormatterFromString.dateFormat = "yyyy-MM-dd"
            let s = dateFormatterFromString.date(from:dateString)
            //CONVERT FROM NSDate to String
            let date = s!
            let dateFormatterFromDate = DateFormatter()
            dateFormatterFromDate.dateFormat = "MMMM dd, yyyy"
            return dateFormatterFromDate.string(from:date as Date)
        }else{
            return ""
        }
    }
    var phone: [String:String]{
        if let phoneNums = _phone{
            return phoneNums
        }else {
            return [:]
        }
    }
    var address: String {
        if let streetAddress = _address{
            return streetAddress
        }else{
            return ""
        }
    }
    init(contactDict: Dictionary<String,AnyObject>){
        if let name = contactDict["name"] as? String {
            self._name = name.capitalized
        }
        if let company = contactDict["companyName"] as? String {
            self._company = company.capitalized
        }
        if let isFavourite = contactDict["isFavorite"] as? Bool{
            self._isFavourite = isFavourite
        }else{
            self._isFavourite = false
        }
        if let smallImgURL = contactDict["smallImageURL"] as? String {
            self._smallImgURL = smallImgURL
        }
        if let largeImgURL = contactDict["largeImageURL"] as? String {
            self._largeImgURL = largeImgURL
        }
        if let emailaddress = contactDict["emailAddress"] as? String {
            self._email = emailaddress
        }
        if let birthday = contactDict["birthdate"] as? String {
            self._birthday = birthday
        }
        if let phoneDict = contactDict["phone"] as? Dictionary<String,String> {
            if phoneDict.count > 0 {
                self._phone = [:]
                if let workPhone = phoneDict["work"] {
                    self._phone!["work"] = workPhone
                }
                if let homePhone = phoneDict["home"] {
                    self._phone!["home"] = homePhone
                }
                if let mobilePhone = phoneDict["mobile"] {
                    self._phone!["mobile"] = mobilePhone
                }
            }
           
        }
        if let addressDict = contactDict["address"] as? Dictionary<String,String> {
            var theAddress = ""
            if let theStreet = addressDict["street"] {
                theAddress = theStreet
            }
            if let city = addressDict["city"] {
                theAddress += "\n \(city)"
            }
            if let state = addressDict["state"] {
                theAddress += ", \(state)"
            }
            if let country = addressDict["Country"] {
                theAddress += ", \(country)"
            }
            if let zipcode = addressDict["zipCode"] {
                theAddress += ", \(zipcode)"
            }
            self._address = theAddress
        }
    }
}
