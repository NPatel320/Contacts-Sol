//
//  Person.swift
//  Solstice Contacts
//
//  Created by Nilu on 2017-09-23.
//  Copyright © 2017 Nirali. All rights reserved.
//

import UIKit

class Person {
    private var _name: String!
    private var _company: String?
    private var _isFavourite: Bool
    private var _smallImgURL: String?
    private var _largeImgURL: String?
    private var _email: String?
    private var _birthday: String?
    private var _phone: [String: String] = [:]
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
            return _phone
    }
    var address: String {
        if let streetAddress = _address{
            return streetAddress
        }else{
            return ""
        }
    }
    init(contactDict: Dictionary<String,AnyObject>){
        // this should have been done using swiftyJSON however, I was having trouble integreting it with xcode 9
        if let isFavourite = contactDict["isFavorite"] as? Bool{
            self._isFavourite = isFavourite
        }else{
            self._isFavourite = false
        }
        self._name = updatepersonInfo(key: "name", fromDict: contactDict)?.capitalized
        self._company = updatepersonInfo(key: "companyName", fromDict: contactDict)?.capitalized
        self._smallImgURL = updatepersonInfo(key: "smallImageURL", fromDict: contactDict)
        self._largeImgURL = updatepersonInfo(key: "largeImageURL" , fromDict: contactDict)
        self._email = updatepersonInfo(key: "emailAddress", fromDict: contactDict)
        self._birthday = updatepersonInfo(key: "birthdate", fromDict: contactDict)
        
        if let phoneDict = contactDict["phone"] as? Dictionary<String,String> {
                addPhoneNumb(phoneType: "work", phoneDict: phoneDict)
                addPhoneNumb(phoneType: "home", phoneDict: phoneDict)
                addPhoneNumb(phoneType: "mobile", phoneDict: phoneDict)
        }
        if let addressDict = contactDict["address"] as? Dictionary<String,String> {
            var theAddress = ""
            if let theStreet = addressDict["street"] {
                theAddress = theStreet
            }
            if let city = addressDict["city"] {
                theAddress += "\n\(city)"
            }
            theAddress += addStateCountryZip(toAddress: "state", fromAddress: addressDict)
            theAddress += addStateCountryZip(toAddress: "Country", fromAddress: addressDict)
            theAddress += addStateCountryZip(toAddress: "zipCode", fromAddress: addressDict)
            self._address = theAddress
        }
    }
    
    private func addPhoneNumb (phoneType: String, phoneDict: [String:String]){
        if let phone = phoneDict[phoneType]{
            if !phone.isEmpty{
                self._phone[phoneType.capitalized] = phone
            }
        }
    }
    private func addStateCountryZip(toAddress: String, fromAddress: [String:String]) -> String{
        if let address = fromAddress[toAddress]{
            if !address.isEmpty{
                return ", \(address)"
            }
        }
            return ""
    }
    private func updatepersonInfo(key: String, fromDict:Dictionary<String,AnyObject>) -> String?{
        if let emailaddress = fromDict[key] as? String {
            return emailaddress
        }
        return nil
    }
}
