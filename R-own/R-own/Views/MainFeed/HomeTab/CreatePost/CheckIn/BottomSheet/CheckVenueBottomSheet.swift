//
//  CheckVenueBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI
import Shimmer

struct CheckVenueBottomSheet: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Create Post Var
    @StateObject var createPostVM: CreatePostViewModel
    
    @StateObject var globalVM: GlobalViewModel
    
    @State var venueSearchText: String = ""
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    @FocusState private var isKeyboardShowing: Bool
    
    @StateObject var exploreService = ExploreService()
    
    
    @State var counter1: Int = 1
    @State var counter2: Int = 1
    
    @State private var currentUrl1: URL?
    @State private var currentUrl2: URL?
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                        VStack(spacing: 20){
                            Text("Select your venue?")
                                .foregroundColor(.black)
                                .font(.headline)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top, UIScreen.screenHeight/50)
                            
                            TextField("Search Venue", text: $venueSearchText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.default)
                                .padding()
                                .frame(width: UIScreen.screenWidth/1.1)
                                .cornerRadius(5)
                                .overlay{
                                    Image("ExploreSearchIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                        .offset(x: UIScreen.screenWidth/2.9)
                                }
                                .onChange(of: venueSearchText) { newValue in
                                    searchPost()
                                }
                                .focused($isKeyboardShowing)
                            
                            //Location Array
                            ScrollView{
                                if venueSearchText != "" {
                                    LazyVStack (alignment: .leading){
                                        if globalVM.exploreSearchHotelList[0].posts.count > 0 {
                                            ForEach(0..<globalVM.exploreSearchHotelList[0].posts.count, id: \.self) { x in
                                                if globalVM.exploreSearchHotelList[0].posts[x].displayStatus == "1" {
                                                    Button(action: {
                                                        isKeyboardShowing = false
                                                        globalVM.keyboardVisibility = false
                                                        createPostVM.checkinHotelName = globalVM.exploreSearchHotelList[0].posts[x].hotelName
                                                        createPostVM.checkinHotelID = globalVM.exploreSearchHotelList[0].posts[x].hotelID
                                                        createPostVM.checkinHotelRating = globalVM.exploreSearchHotelList[0].posts[x].hotelRating
                                                        createPostVM.checkinHotelAddress = globalVM.exploreSearchHotelList[0].posts[x].hotelAddress
                                                        createPostVM.checkinHotelCoverPic = globalVM.exploreSearchHotelList[0].posts[x].hotelCoverpicURL
                                                        createPostVM.checkinHotelLogo = globalVM.exploreSearchHotelList[0].posts[x].hotelLogoURL
                                                        createPostVM.venuePostBottomSheet.toggle()
                                                    }, label: {
                                                        VStack (alignment: .leading){
                                                            HStack{
                                                                
                                                                AsyncImage(url: currentUrl1) { image in
                                                                    image
                                                                        .resizable()
                                                                        .scaledToFit()
                                                                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                        .clipShape(Circle())
                                                                        .padding(.horizontal, UIScreen.screenWidth/60)
                                                                } placeholder: {
                                                                    Rectangle()
                                                                        .fill(lightGreyUi)
                                                                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                        .padding(.horizontal, UIScreen.screenWidth/60)
                                                                        .shimmering(active: true)
                                                                }
                                                                .onAppear {
                                                                    if currentUrl1 == nil {
                                                                        DispatchQueue.main.async {
                                                                            currentUrl1 = URL(string: globalVM.exploreSearchHotelList[0].posts[x].hotelLogoURL)
                                                                        }
                                                                    }
                                                                }
                                                                
                                                                VStack (alignment: .leading){
                                                                    Text(globalVM.exploreSearchHotelList[0].posts[x].hotelName )
                                                                        .font(.body)
                                                                        .foregroundColor(.black)
                                                                        .fontWeight(.regular)
                                                                    
                                                                    Text(globalVM.exploreSearchHotelList[0].posts[x].hotelAddress )
                                                                        .font(.footnote)
                                                                        .foregroundColor(.black)
                                                                        .fontWeight(.thin)
                                                                }
                                                            }
                                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                                            .padding(.vertical, UIScreen.screenHeight/90)
                                                            Divider()
                                                        }
                                                    })
                                                    .onAppear{
                                                        print(x)
                                                        if x == globalVM.exploreSearchHotelList[0].posts.count - 2 {
                                                            counter2 = counter2 + 1
                                                            print("Fetching hotel via pagination")
                                                            exploreService.getExploreSearchHotel(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(counter2), keyword: venueSearchText)
                                                        }
                                                    }
                                                }
                                                
                                            }
                                        }
                                    }
                                } else {
                                    LazyVStack (alignment: .leading){
                                        if globalVM.exploreHotelList[0].posts.count > 0 {
                                            ForEach(0..<globalVM.exploreHotelList[0].posts.count, id: \.self) { x in
                                                if globalVM.exploreHotelList[0].posts[x].displayStatus == "1" {
                                                    Button(action: {
                                                        isKeyboardShowing = false
                                                        globalVM.keyboardVisibility = false
                                                        createPostVM.checkinHotelName = globalVM.exploreHotelList[0].posts[x].hotelName
                                                        createPostVM.checkinHotelID = globalVM.exploreHotelList[0].posts[x].hotelID
                                                        createPostVM.checkinHotelRating = globalVM.exploreHotelList[0].posts[x].hotelRating
                                                        createPostVM.checkinHotelAddress = globalVM.exploreHotelList[0].posts[x].hotelAddress
                                                        createPostVM.checkinHotelCoverPic = globalVM.exploreHotelList[0].posts[x].hotelCoverpicURL
                                                        createPostVM.checkinHotelLogo = globalVM.exploreHotelList[0].posts[x].hotelLogoURL
                                                        createPostVM.venuePostBottomSheet.toggle()
                                                    }, label: {
                                                        VStack (alignment: .leading){
                                                            HStack{
                                                                AsyncImage(url: currentUrl2) { image in
                                                                    image
                                                                        .resizable()
                                                                        .scaledToFit()
                                                                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                        .clipShape(Circle())
                                                                        .padding(.horizontal, UIScreen.screenWidth/60)
                                                                } placeholder: {
                                                                    Rectangle()
                                                                        .fill(lightGreyUi)
                                                                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                                                        .padding(.horizontal, UIScreen.screenWidth/60)
                                                                        .shimmering(active: true)
                                                                }
                                                                .onAppear {
                                                                    print(x)
                                                                    if currentUrl2 == nil {
                                                                        DispatchQueue.main.async {
                                                                            currentUrl2 = URL(string: globalVM.exploreHotelList[0].posts[x].hotelLogoURL)
                                                                        }
                                                                    }
                                                                }
                                                                VStack (alignment: .leading){
                                                                    Text(globalVM.exploreHotelList[0].posts[x].hotelName )
                                                                        .font(.body)
                                                                        .foregroundColor(.black)
                                                                        .fontWeight(.regular)
                                                                    
                                                                    Text(globalVM.exploreHotelList[0].posts[x].hotelAddress )
                                                                        .font(.subheadline)
                                                                        .foregroundColor(.black)
                                                                        .fontWeight(.thin)
                                                                }
                                                            }
                                                            .padding(.horizontal, UIScreen.screenWidth/40)
                                                            .padding(.vertical, UIScreen.screenHeight/90)
                                                            Divider()
                                                        }
                                                    })
                                                    .onAppear{
                                                        print(x)
                                                        print(globalVM.exploreHotelList[0].posts.count)
                                                        if x == globalVM.exploreHotelList[0].posts.count - 6 {
                                                            print(counter1)
                                                            counter1 = counter1 + 1
                                                            exploreService.getExploreHotel(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(counter1))
                                                        }
                                                    }
                                                }
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.5)
                        .onAppear {
                            counter1 = 0
                            counter2 = 0
                            globalVM.exploreHotelList = [ExploreHotelModel(page: 0, pageSize: 0, posts: [ExploreHotelPost]())]
                            globalVM.exploreSearchHotelList = [ExploreHotelModel(page: 0, pageSize: 0, posts: [ExploreHotelPost]())]
                            exploreService.getExploreHotel(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: "1")
                        }
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: createPostVM.venuePostBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(createPostVM.venuePostBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        createPostVM.venuePostBottomSheet.toggle()
                    }
                }
            )
    }
    
    func onChanged(value: DragGesture.Value){
        if value.translation.height > 0{
            offset = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value){
        if value.translation.height > 0{
            withAnimation(Animation.easeInOut(duration: 0.2)){
                
                //onChecking
                
                let height = UIScreen.screenHeight/3
                
                if value.translation.height > height/1.5 {
                    createPostVM.venuePostBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
    
    func searchPost() {
        globalVM.exploreSearchHotelList = [ExploreHotelModel(page: 0, pageSize: 0, posts: [ExploreHotelPost]())]
        exploreService.getExploreSearchHotel(globalVM: globalVM, userID: loginData.mainUserID, pageNumber: String(1), keyword: venueSearchText)
    }
}

//struct CheckVenueBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckVenueBottomSheet()
//    }
//}
