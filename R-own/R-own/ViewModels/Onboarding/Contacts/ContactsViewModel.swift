//
//  ContactsViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 22/04/23.
//

import SwiftUI
import Contacts

class ContactsViewModel: ObservableObject{
    
    @StateObject var contactService = ContactService()
    func fetchContactsFromPhone(loginData: LoginViewModel, globalVM: GlobalViewModel) async -> String {
        var email = ""
        var organisation = ""
        var name = ""
        
        //Run this is bg async
        
        //Get Access to the contacts store
        let store = CNContactStore()
        
        //Specify which datakeys we want to fetch
        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey, CNContactOrganizationNameKey] as [CNKeyDescriptor]
        
        //Create fetch request
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        
        //Call method to fetch all contacts
        do {
            try await store.enumerateContacts(with: fetchRequest) { contact, result in
                //Logic for retrieved contact usage
                if !contact.givenName.isEmpty {
                    name = contact.givenName
                }
                organisation = contact.organizationName
                
                for number in contact.phoneNumbers {
                    switch number.label {
                    case CNLabelPhoneNumberMobile:
                        if !number.value.stringValue.isEmpty {
                            loginData.contactPhoneNumber = number.value.stringValue
                        }
                    default:
                        if !number.value.stringValue.isEmpty {
                            if loginData.contactPhoneNumber == "" {
                                loginData.contactPhoneNumber = number.value.stringValue
                            }
                        }
                    }
                }
                
                loginData.contactsList.append(["Name": contact.givenName, "Number": loginData.contactPhoneNumber, "Email": "", "Company_Name": contact.organizationName])
                loginData.contactPhoneNumber = ""
            }
            
            //posting the data on the server
            let res = await contactService.pushContactInServer(loginData: loginData, contacts: loginData.contactsList, globalVM: globalVM, contactService: contactService)
            if res == "Success"{
                return "Success Uploaded"
            } else {
                return "Sucessfully Fetched"
            }
        } catch {
            //handle any errors here
            print("Error: \(error)")
            loginData.showLoader = false
            loginData.contactsUploadDenied = true
            loginData.contactsNotAvailable = true
            return "Failure: \(error.localizedDescription)"
        }
    }

    
    func fetchSpecificContacts() async {
        
        //Run this is bg async
        
        //Get Access to the contacts store
        let store = CNContactStore()
        
        //Specify which datakeys we want to fetch
        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactEmailAddressesKey, CNContactOrganizationNameKey ] as [CNKeyDescriptor]
        
        //Search Criteria
        let predicate = CNContact.predicateForContacts(matchingName: "This can be any name" )
        
        do {
            //Perform Fetch
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keys as [CNKeyDescriptor])
            
            print(contacts)
        }
        catch {
            //Error
            print("Error")
        }
        
    }
    
}
