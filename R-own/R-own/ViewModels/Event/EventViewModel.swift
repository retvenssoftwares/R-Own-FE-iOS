//
//  EventViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import Foundation


class EventViewModel: ObservableObject{
    
    @Published var showEventLocationBottomSheet: Bool = false
    @Published var eventLocationLocation: String = ""
    @Published var eventLocationCountry: String = ""
    @Published var eventLocationState: String = ""
    @Published var eventLocationCity: String = ""
    
    @Published var eventSearchText: String = ""
    
    @Published var selectedVenue: String = ""
    @Published var selectedVenueID: String = ""
    @Published var eventTitle: String = ""
    @Published var eventDescription: String = ""
    @Published var eventSupportEmail: String = ""
    @Published var eventPhoneNumber: String = ""
    @Published var eventWebsite: String = ""
    @Published var eventBookingLink: String = ""
    @Published var eventThumbnail: String = ""
    @Published var eventStartDate: Date = Date.now
    @Published var eventStartTime: Date = Date.now
    @Published var eventEndDate: Date = Date.now
    @Published var eventEndTime: Date = Date.now
    @Published var eventRegistrationStartDate: Date = Date.now
    @Published var eventRegistrationStartTime: Date = Date.now
    @Published var eventRegistrationEndDate: Date = Date.now
    @Published var eventRegistrationEndTime: Date = Date.now
    @Published var eventPrice: String = ""
    @Published var eventCategory: String = ""
    @Published var eventCategoryID: String = ""
    
    
    @Published var selectedEventCategoryFilter: String = ""
    
    @Published var showAddEventBottomSheet: Bool = false
    @Published var showVenueBottomSheet: Bool = false
}

