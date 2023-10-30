//
//  JobsViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 06/05/23.
//

import Foundation


class JobsViewModel: ObservableObject{
    
    @Published var showLocationBottomSheet: Bool = false
    @Published var showCompanyNameBottomSheet: Bool = false
    @Published var shoJobPostJobTypeBottomSheet: Bool = false
    
    
    @Published var jobsUserTabSelected: String = "Jobs Explore"
    @Published var jobsDetailTabSelected: String = "Description"
    @Published var jobsHotelierTabSelected: String = "Job Posted"
    @Published var jobsSearchText: String = ""
    @Published var jobsCategoryFilter: String = ""
    @Published var jobsTypeFilter: String = ""
    @Published var jobsLocationFilter: String = ""
    @Published var jobsCountryFilter: String = ""
    @Published var jobsStateFilter: String = ""
    @Published var jobsCityFilter: String = ""
    @Published var jobsMinSalaryFilter: String = ""
    @Published var jobsMaxSalaryFilter: String = ""
    @Published var jobApplied: Bool = true
    
    
    @Published var departmentRequestedFor: String = ""
    @Published var designationRequestedFor: String = ""
    @Published var employmentTypeRequestedFor: String = ""
    @Published var jobLocationRequestedFor: String = ""
    @Published var noticePeriodRequestedFor: String = ""
    @Published var expectedCTCRequestedFor: String = ""
    
    @Published var filterBottomSheet: Bool = false
    @Published var jobCategoryFilterBottomSheet: Bool = false
    @Published var jobTypeFilterBottomSheet: Bool = false
    @Published var jobLocationFilterBottomSheet: Bool = false
    
    @Published var requestedLocationBottomSheet: Bool = false
    @Published var requestedCountryBottomSheet: Bool = false
    @Published var requestedStateBottomSheet: Bool = false
    @Published var requestedCityBottomSheet: Bool = false
    @Published var requestedDepartmentBottomSheet: Bool = false
    @Published var requestedDesignationBottomSheet: Bool = false
    @Published var requestedEmploymentBottomSheet: Bool = false
    @Published var requestedNoticePeriodBottomSheet: Bool = false
    @Published var requestedCTCBottomSheet: Bool = false
    
    @Published var applyJobBottomSheet: Bool = false
    
    @Published var requestedLocationField: String = ""
    @Published var requestedCountryField: String = ""
    @Published var requestedStateField: String = ""
    @Published var requestedCityField: String = ""
    @Published var requestedDepartmentField: String = ""
    @Published var requestedDesignationField: String = ""
    @Published var requestedEmploymentField: String = ""
    @Published var requestedNoticePeriodField: String = ""
    @Published var requestedCTCField: String = ""
    
    @Published var bookmarkedJob: Bool = false
    
    
    @Published var postAjobTitle: String = ""
    @Published var postAcompany: String = ""
    @Published var postAcompanyID: String = ""
    @Published var postAJobDesignation: String = ""
    @Published var postAworkplaceType: String = ""
    @Published var postAjobType: String = ""
    @Published var postAminSalary: String = ""
    @Published var postAmaxSalary: String = ""
    @Published var postAjobLocation: String = ""
    @Published var postAjobDescription: String = ""
    @Published var postAskillRecquired: String = ""
    @Published var postAJobNoticePeriod: String = ""
    
}
