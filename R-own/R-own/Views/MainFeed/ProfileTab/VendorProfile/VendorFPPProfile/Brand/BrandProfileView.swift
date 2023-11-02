//
//  BrandProfileView.swift
//  R-own
//
//  Created by Aman Sharma on 19/06/23.
//

import SwiftUI
import Shimmer

struct BrandProfileView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @State var userID: String
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
//    @State var brandName: String
//    @State var brandPic: String
//    @State var serviceArray: String
//    @State var vendorDescp: String
    
    @State var navigateToProfileView: Bool = false
    
    @State var navigateToPortFolio: Bool = false
    
    @State var isLoading: Bool = false
    @StateObject var profileService = ProfileService()
    @State var mainUser: Bool
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let columns2Object = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @Environment(\.dismiss) private var dismiss
    
    @State private var currentUrl1: URL?
    @State private var currentUrl2: URL?
    @State private var currentUrl3: URL?
    @State private var currentUrl4: URL?
    
    var body: some View {
        NavigationStack{
            if isLoading {
                VStack{
                    
                    VStack{
                        //Navbar
                        HStack{
                            //button
                            Spacer()
                            //text
                            Text("Vendor's Brand")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(greenUi)
                            
                            Spacer()
                            
                        }
                        .padding(.horizontal, UIScreen.screenWidth/40)
                        .padding(.vertical, UIScreen.screenHeight/70)
                        .background(jobsDarkBlue)
                        .border(width: 1, edges: [.bottom], color: .black)
                        .overlay{
                            HStack{
                                Button(action: {
                                    dismiss()
                                }, label: {
                                    Image(systemName: "chevron.backward")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                        .foregroundColor(greenUi)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                })
                                Spacer()
                            }
                        }
                    }
                    ScrollView{
                        VStack{
                            
                            VStack{
                                
                                AsyncImage(url: currentUrl1) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: UIScreen.screenHeight/6, height: UIScreen.screenHeight/6)
                                        .cornerRadius(10)
                                        .clipShape(Circle())
                                        .padding(.vertical, UIScreen.screenHeight/50)
                                } placeholder: {
                                    Circle()
                                        .fill(lightGreyUi)
                                        .frame(width: UIScreen.screenHeight/6, height: UIScreen.screenHeight/6)
                                        .shimmering(active: true)
                                        .padding(.vertical, UIScreen.screenHeight/50)
                                }
                                .onAppear {
                                    if currentUrl1 == nil {
                                        DispatchQueue.main.async {
                                            currentUrl1 = URL(string: globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorImage)
                                        }
                                    }
                                }
                                
                                VStack{
                                    Text(globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorName)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    Text(globalVM.getVendorProfileHeader.roleDetails.fullName)
                                        .font(.body)
                                        .fontWeight(.bold)
                                    VStack{
                                        if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorServices.count > 1 {
                                            
                                            LazyVGrid(columns: globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorServices.count == 2 ? columns2Object : columns, spacing: 10) {
                                                ForEach(0..<globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorServices.count, id: \.self){ count in
                                                    if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorServices[count].serviceName ?? "" != "" {
                                                        Text(globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorServices[count].serviceName!)
                                                            .font(.body)
                                                            .fontWeight(.thin)
                                                            .foregroundColor(.black)
                                                            .padding()
                                                            .overlay{
                                                                RoundedRectangle(cornerRadius: 10)
                                                                    .stroke(Color.black, lineWidth: 1)
                                                            }
                                                    }
                                                }
                                            }
                                        } else if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorServices.count == 1 {
                                            if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorServices[0].serviceName ?? "" != "" {
                                                Text(globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorServices[0].serviceName ?? "")
                                                    .font(.body)
                                                    .fontWeight(.thin)
                                                    .foregroundColor(.black)
                                                    .padding()
                                                    .overlay{
                                                        RoundedRectangle(cornerRadius: 10)
                                                            .stroke(Color.black, lineWidth: 1)
                                                    }
                                            }
                                        } else {
                                            Text("No services registered yet")
                                                .font(.body)
                                                .fontWeight(.thin)
                                                .foregroundColor(.black)
                                                .padding()
                                                .overlay{
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.black, lineWidth: 1)
                                                }
                                        }
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/60)
                                }
                            }
                            
                            VStack{
                                HStack{
                                    VStack(alignment: .leading, spacing: 2){
                                        Text("Vendor Description")
                                            .font(.footnote)
                                            .fontWeight(.semibold)
                                            .padding(.vertical, UIScreen.screenHeight/70)
                                        Text(globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorDescription)
                                            .font(.body)
                                            .fontWeight(.regular)
                                            .multilineTextAlignment(.leading)
                                    }
                                    Spacer()
                                }
                                Divider()
                            }
                            .padding(.horizontal, UIScreen.screenWidth/40)
                            .padding(.vertical, UIScreen.screenHeight/70)
                            .frame(width: UIScreen.screenWidth)
                            .background(.white)
                            
                            HStack{
                                VStack(alignment: .leading, spacing: 2){
                                    Text("Vendor's Portfolio")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, UIScreen.screenHeight/70)
                                    
                                        if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink.count > 0 {
                                            
                                            HStack{
                                                if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image1 != "" {
                                                        VStack{
                                                            AsyncImage(url: currentUrl2) { image in
                                                                image
                                                                    .resizable()
                                                                    .scaledToFill()
                                                                    .frame(width: UIScreen.screenHeight/10, height: UIScreen.screenHeight/10)
                                                            } placeholder: {
                                                                RoundedRectangle(cornerRadius: 10)
                                                                    .fill(lightGreyUi)
                                                                    .frame(width: UIScreen.screenHeight/10, height: UIScreen.screenHeight/10)
                                                                    .shimmering(active: true)
                                                            }
                                                            .onAppear {
                                                                if currentUrl2 == nil {
                                                                    DispatchQueue.main.async {
                                                                        currentUrl2 = URL(string: globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image1)
                                                                    }
                                                                }
                                                            }
                                                            .onTapGesture {
                                                                navigateToPortFolio.toggle()
                                                            }
                                                        }
                                                        
                                                    } else {
                                                        Text("\(globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorName) hasn't uploaded the portfolio yet")
                                                            .font(.body)
                                                            .fontWeight(.regular)
                                                    }
                                                    if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image2 != "" {
                                                        VStack{
                                                            AsyncImage(url: currentUrl3) { image in
                                                                image
                                                                    .resizable()
                                                                    .scaledToFill()
                                                                    .frame(width: UIScreen.screenHeight/10, height: UIScreen.screenHeight/10)
                                                            } placeholder: {
                                                                RoundedRectangle(cornerRadius: 10)
                                                                    .fill(lightGreyUi)
                                                                    .frame(width: UIScreen.screenHeight/10, height: UIScreen.screenHeight/10)
                                                                    .shimmering(active: true)
                                                            }
                                                            .onAppear {
                                                                if currentUrl3 == nil {
                                                                    DispatchQueue.main.async {
                                                                        currentUrl3 = URL(string: globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image2)
                                                                    }
                                                                }
                                                            }
                                                            .onTapGesture {
                                                                navigateToPortFolio.toggle()
                                                            }
                                                        }
                                                    }
                                                    if globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image3 != "" {
                                                        VStack{
                                                            AsyncImage(url: currentUrl4) { image in
                                                                image
                                                                    .resizable()
                                                                    .scaledToFill()
                                                                    .frame(width: UIScreen.screenHeight/10, height: UIScreen.screenHeight/10)
                                                            } placeholder: {
                                                                RoundedRectangle(cornerRadius: 10)
                                                                    .fill(lightGreyUi)
                                                                    .frame(width: UIScreen.screenHeight/10, height: UIScreen.screenHeight/10)
                                                                    .shimmering(active: true)
                                                            }
                                                            .onAppear {
                                                                if currentUrl4 == nil {
                                                                    DispatchQueue.main.async {
                                                                        currentUrl4 = URL(string: globalVM.getVendorProfileHeader.roleDetails.vendorInfo.portfolioLink[0].image3)
                                                                    }
                                                                }
                                                            }
                                                            .onTapGesture {
                                                                navigateToPortFolio.toggle()
                                                            }
                                                        }
                                                    }
                                            }
                                            .navigationDestination(isPresented: $navigateToPortFolio, destination: {
                                                VendorPortfolioImageVIew(globalVM: globalVM)
                                            })
                                            
                                            NavigationLink(isActive: $navigateToPortFolio, destination: {
                                                VendorPortfolioImageVIew(globalVM: globalVM)
                                            }, label: {Text("")})
                                        } else {
                                            Text("\(globalVM.getVendorProfileHeader.roleDetails.vendorInfo.vendorName) hasn't uploaded the portfolio yet")
                                                .font(.body)
                                        }
                                }
                                Spacer()
                            }
                            .padding(.horizontal, UIScreen.screenWidth/40)
                            .padding(.vertical, UIScreen.screenHeight/70)
                            .background(.white)
                            
                            if loginData.isHiddenKPI{
                                VStack{
                                    HStack{
                                        Button(action: {
                                            
                                        }, label: {
                                            Text("Add a review")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .padding(.horizontal, UIScreen.screenWidth/20)
                                                .padding(.vertical, UIScreen.screenHeight/100)
                                                .background(greenUi)
                                                .cornerRadius(15)
                                        })
                                        Button(action: {
                                            
                                        }, label: {
                                            Text("Message")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .padding(.horizontal, UIScreen.screenWidth/20)
                                                .padding(.vertical, UIScreen.screenHeight/100)
                                                .background(.white)
                                                .overlay{
                                                    RoundedRectangle(cornerRadius: 15)
                                                        .stroke(.black, lineWidth: 1)
                                                }
                                        })
                                        
                                    }
                                }
                                VStack{
                                    HStack{
                                        Image("ReviewStar")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                        VStack(alignment: .leading, spacing: 5){
                                            Text("Rate 3.0")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .fontWeight(.semibold)
                                            Text("3.2K review and ratings")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .fontWeight(.thin)
                                        }
                                        Spacer()
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth/20)
                                    .padding(.vertical, UIScreen.screenHeight/30)
                                    .background(.white)
                                    .frame(width: UIScreen.screenWidth/1.3)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(lightGreyUi, lineWidth: 1)
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/60)
                                    
                                    HStack(spacing: 10){
                                        VStack{
                                            Image("ReviewStar")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                            Text("Great Behaviour")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                            Text("1.5K review and ratings")
                                                .font(.body)
                                                .fontWeight(.thin)
                                        }
                                        .padding(.horizontal, UIScreen.screenWidth/20)
                                        .padding(.vertical, UIScreen.screenHeight/30)
                                        .background(.white)
                                        .frame(width: UIScreen.screenHeight/5, height: UIScreen.screenHeight/5)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(lightGreyUi, lineWidth: 1)
                                        }
                                        VStack{
                                            Image("ReviewTime")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                            Text("Attentive staff")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                            Text("1.5K review and ratings")
                                                .font(.body)
                                                .fontWeight(.thin)
                                        }
                                        .padding(.horizontal, UIScreen.screenWidth/20)
                                        .padding(.vertical, UIScreen.screenHeight/30)
                                        .background(.white)
                                        .frame(width: UIScreen.screenHeight/5, height: UIScreen.screenHeight/5)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(lightGreyUi, lineWidth: 1)
                                        }
                                        VStack{
                                            Image("ReviewMoney")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                            Text("Worth the money")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                            Text("1.5K review and ratings")
                                                .font(.body)
                                                .fontWeight(.thin)
                                        }
                                        .padding(.horizontal, UIScreen.screenWidth/20)
                                        .padding(.vertical, UIScreen.screenHeight/30)
                                        .background(.white)
                                        .frame(width: UIScreen.screenHeight/5, height: UIScreen.screenHeight/5)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(lightGreyUi, lineWidth: 1)
                                        }
                                    }
                                    
                                    HStack{
                                        Text("All Reviews")
                                            .font(.body)
                                            .fontWeight(.semibold)
                                        
                                        Spacer()
                                    }
                                    .padding(.leading, UIScreen.screenWidth/10)
                                    .padding(.top, UIScreen.screenHeight/30)
                                    
                                    VStack{
                                        ForEach(0...5, id: \.self){ count in
                                            
                                            HStack(spacing: UIScreen.screenWidth/30){
                                                VStack{
                                                    ProfilePictureView(profilePic: "", verified: false, height: UIScreen.screenHeight/20, width: UIScreen.screenHeight/20)
                                                    Spacer()
                                                }
                                                VStack(alignment: .leading){
                                                    Text("User Name")
                                                        .font(.body)
                                                        .fontWeight(.semibold)
                                                        .padding(.bottom, UIScreen.screenHeight/70)
                                                    Text("Ordered on 28 June 2021")
                                                        .font(.body)
                                                        .fontWeight(.thin)
                                                    Text("I received the works before the deadline. Totally satisfied..!!")
                                                        .font(.body)
                                                        .fontWeight(.regular)
                                                        .padding(.vertical, UIScreen.screenHeight/70)
                                                }
                                                VStack{
                                                    HStack{
                                                        Image("FeedStaysStarFilled")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                                        Text("4.6")
                                                            .font(.body)
                                                            .fontWeight(.regular)
                                                            .foregroundColor(.black)
                                                    }
                                                    Spacer()
                                                }
                                            }
                                            .padding(.horizontal, UIScreen.screenWidth/10)
                                            .padding(.vertical, UIScreen.screenHeight/40)
                                            .overlay{
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(greyUi, lineWidth: 1 )
                                            }
                                            
                                        }
                                    }
                                }
                            }
                            
                            NavigationLink(isActive: $navigateToProfileView, destination: {
                                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: "Business Vendor / Freelancer", mainUser: false, userID: userID)
                            }, label: {Text("")})
                            if !mainUser{
                                Button(action: {
                                    navigateToProfileView.toggle()
                                }, label: {
                                    Text("Hire")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .foregroundColor(jobsDarkBlue)
                                        .padding(.horizontal, UIScreen.screenWidth/50)
                                        .padding(.vertical, UIScreen.screenHeight/90)
                                        .frame(width: UIScreen.screenWidth/1.2)
                                        .background(greenUi)
                                        .cornerRadius(10)
                                        .shadow(color: .black.opacity(0.2), radius: 1,x: 1, y: 1)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                        .padding(.vertical, UIScreen.screenHeight/80)
                                })
                                .navigationDestination(isPresented: $navigateToProfileView, destination: {
                                    ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: "Business Vendor / Freelancer", mainUser: false, userID: userID)
                                })
                            }
                        }
                    }
                }
            } else {
                ProgressView()
            }
        }
        .navigationBarHidden(true)
        .onAppear{
            Task{
                globalVM.getVendorProfileHeader = VendorProfileHeaderModel(roleDetails: RoleDetails321(vendorInfo: VendorInfo321(vendorImage: "", vendorName: "", vendorDescription: "", websiteLink: "", vendorServices: [VendorService321](), portfolioLink: [PortfolioLink321]()), id: "", fullName: "", profilePic: "", mesiboAccount: [MesiboAccount](), verificationStatus: "", userBio: "", createdOn: "", userName: "", location: "", role: "", postCount: [JSONAny]()), postcount: 0, connectioncount: 0, requestcount: 0, connectionStatus: "")
                Task{
                    let res = await profileService.getVendorProfileHeader(globalVM: globalVM, userID: userID, connectionUserID: loginData.mainUserID)
                    if res == "Success" {
                        isLoading.toggle()
                    } else {
                    }
                }
            }
        }
    }
}

//struct BrandProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        BrandProfileView()
//    }
//}
