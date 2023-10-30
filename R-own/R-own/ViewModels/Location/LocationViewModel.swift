//
//  LocationViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 24/05/23.
//

import Foundation
import SwiftUI


class LocationViewModel: ObservableObject{
    
    @StateObject var locationService = LocationService()
    
//    func getCountry(globalVM: GlobalViewModel) {
//        locationService.getCountryList(globalVM: globalVM)
//    }
    
    
//    func getState(globalVM: GlobalViewModel, countryCode: String) {
//        locationService.getStateList(globalVM: globalVM, countryCode: countryCode)
//    }
    
    
//    func getCity(globalVM: GlobalViewModel, countryCode: String, stateCode: String) {
//        locationService.getCityList(globalVM: globalVM, countryCode: countryCode, stateCode: stateCode)
//    }
//
}
