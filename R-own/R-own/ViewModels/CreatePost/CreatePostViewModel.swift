//
//  CreatePostViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import Foundation


class CreatePostViewModel: ObservableObject{
    
    @Published var postCaption: String = ""
    
    @Published var postLoction: String = ""
    
    @Published var canCommentAudienceBottomSheet: Bool = false
    @Published var canSeeAudienceBottomSheet: Bool = false
    @Published var postTypeBottomSheet: Bool = false
    
    @Published var postLocation: String = ""
    @Published var postCountry: String = ""
    @Published var postState: String = ""
    @Published var postCity: String = ""
    @Published var postVenue: String = ""
    @Published var postEvent: String = ""
    
    @Published var checkinCountry: String = ""
    @Published var checkinState: String = ""
    @Published var checkinCity: String = ""
    @Published var checkinHotelID: String = ""
    @Published var checkinHotelName: String = ""
    @Published var checkinHotelAddress: String = ""
    @Published var checkinHotelRating: String = ""
    @Published var checkinHotelCoverPic: String = ""
    @Published var checkinHotelLogo: String = ""
    
    @Published var checkinLocationBottomSheet: Bool = false
    @Published var venuePostBottomSheet: Bool = false
    
    @Published var updateEventLocationBottomSheet: Bool = false
    @Published var updateEventBottomSheet: Bool = false
    @Published var selectedEventID: String = ""
    
    @Published var pollStatement: String = ""
    @Published var pollOpinions = [String]()
    
    
    @Published var canSeeAudienceName: String = ""
    @Published var canCommentAudienceName: String = ""
    
}
