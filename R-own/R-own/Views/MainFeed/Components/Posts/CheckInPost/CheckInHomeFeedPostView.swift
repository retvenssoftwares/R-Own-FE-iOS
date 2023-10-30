//
//  CheckInHomeFeedPostView.swift
//  R-own
//
//  Created by Aman Sharma on 11/06/23.
//

import SwiftUI
import Shimmer

struct CheckInHomeFeedPostView: View {
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @State var post: NewFeedPost
    
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var showCommentSheet: Bool = false
    
    @State var likeStatus: Bool = false
    @State var saveStatus: Bool = false
    @State var savedStatus: String = "not saved"
    @State var likeAnimationToggle: Bool = false
    
    @State var mainFeedService = MainFeedService()
    @State var saveService = SaveElemetsIDService()
    @State var navigateToProfileView: Bool = false
    @State var navigateToHotelDetail: Bool = false
    
    @State var commentCounting: Int = 0
    
    @State private var currentUrl: URL?
    
    @State private var isExpanded = false
    @State private var totalLines: Int = 0
    
    var body: some View {
        NavigationStack{
            if post.fullName != "" {
                if post.hotelName != "" {
                    if post.role ?? "" != "" {
                        VStack{
                            VStack{
                                HStack{
                                    //profilepic
                                    NavigationLink(destination: {
                                        ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: post.role!, mainUser: false, userID: post.userID)
                                    }, label: {
                                        ProfilePictureView(profilePic: post.profilePic ?? "", verified: post.verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                                    })
                                    VStack(alignment: .leading) {
                                        //name
                                        NavigationLink(destination: {
                                            ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: post.role!, mainUser: false, userID: post.userID)
                                        }, label: {
                                            Text(post.fullName!)
                                                .foregroundColor(.black)
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .frame(alignment: .leading)
                                        })
                                        //profile
                                        if post.jobTitle != "" {
                                            Text(post.jobTitle == "" ? "" : post.jobTitle)
                                                .foregroundColor(.black)
                                                .font(.footnote)
                                                .fontWeight(.thin)
                                                .frame(alignment: .leading)
                                        }
                                        //location
                                        if post.location != "" {
                                            Text(post.location)
                                                .foregroundColor(.black)
                                                .font(.footnote)
                                                .fontWeight(.thin)
                                                .frame(alignment: .leading)
                                        }
                                    }
                                    Spacer()
                                    //time
                                    Text(relativeTime(from: post.dateAdded) ?? "")
                                        .foregroundColor(.black)
                                        .font(.footnote)
                                        .fontWeight(.thin)
                                        .padding(.leading, 30)
                                        .frame(alignment: .leading)
                                }
                                .padding(.horizontal, UIScreen.screenWidth - UIScreen.screenWidth/1.05)
                                
                            }
                            VStack{
                                HStack{
                                    Text("Hello all, I am here at \(post.hotelName ?? ""). Let’s Catch Up.")
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                        .padding(.vertical, UIScreen.screenHeight/90)
                                    Spacer()
                                }
                                
                                NavigationLink(destination: {
                                    ExploreHotelDetailView(globalVM: globalVM, hotelID: post.hotelID ?? "", savedStatus: $savedStatus)
                                }, label: {
                                    AsyncImage(url: currentUrl) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/2.5)
                                            .clipped()
                                            .cornerRadius(10)
                                            .onTapGesture {
                                                print("move to hotel screen")
                                                if post.hotelID ?? "" != "" {
                                                    navigateToHotelDetail.toggle()
                                                }
                                            }
                                    } placeholder: {
                                        //put your placeholder here
                                        Rectangle()
                                            .fill(lightGreyUi)
                                            .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/2.5)
                                            .cornerRadius(15)
                                            .shimmering(active: true)
                                    }
                                    .onAppear {
                                        if currentUrl == nil {
                                            DispatchQueue.main.async {
                                                currentUrl = URL(string: post.hotelCoverpicURL ?? "")
                                            }
                                        }
                                    }
                                })
                                
                            }
                            .padding(.vertical, UIScreen.screenHeight/90)
                            
                            
                            VStack{
                                if post.bookingengineLink ?? "" != "" {
                                    Link(destination: URL(string: validateURL(post.bookingengineLink ?? "") ?? "")!) {
                                        HStack{
                                            Text("Book Now")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                                .foregroundColor(greenUi)
                                                .padding(.vertical, UIScreen.screenHeight/60)
                                                .padding(.leading, UIScreen.screenWidth/30)
                                            Spacer()
                                        }
                                        .background(jobsDarkBlue)
                                    }
                                }
                                VStack{
                                    HStack(spacing: 5){
                                        VStack{
                                            Text(post.userName == "" ? post.fullName! : post.userName)
                                                .foregroundColor(.black)
                                                .font(.body)
                                                .fontWeight(.bold)
                                                .frame(alignment: .leading)
                                                .onTapGesture {
                                                    navigateToProfileView.toggle()
                                                }
                                            Spacer()
                                        }
                                        if post.caption != "" {
                                            HStack{
                                                VStack(alignment: .leading, spacing: 3) {
                                                    if totalLines <= 3 || isExpanded {
                                                        Text(post.caption )
                                                            .font(.body)
                                                            .foregroundColor(.black)
                                                            .multilineTextAlignment(.leading)
                                                            .lineLimit(isExpanded ? nil : 3)
                                                            .background(
                                                                GeometryReader { geometry in
                                                                    Color.clear.onAppear {
                                                                        totalLines = getNumberOfLines(for: post.caption, in: geometry.size, font: .systemFont(ofSize: UIScreen.screenHeight/80))
                                                                    }
                                                                    .onChange(of: post.caption) { _ in
                                                                        totalLines = getNumberOfLines(for: post.caption, in: geometry.size, font: .systemFont(ofSize: UIScreen.screenHeight/80))
                                                                    }
                                                                }
                                                            )
                                                    } else {
                                                        VStack(alignment: .leading, spacing: 4) {
                                                            ForEach(0..<3) { index in
                                                                Text(getTextForLine(at: index))
                                                                    .font(.body)
                                                            }
                                                        }
                                                        .font(.body)
                                                    }
                                                    
                                                    if totalLines > 3 {
                                                        Button(action: {
                                                            isExpanded.toggle()
                                                        }) {
                                                            Text(isExpanded ? "Read Less" : "Read More")
                                                                .font(.body)
                                                                .foregroundColor(.black)
                                                                .fontWeight(.bold)
                                                        }
                                                    }
                                                    Spacer()
                                                }
                                                Spacer()
                                            }
                                        }
                                        Spacer()
                                    }
                                    .frame(width: UIScreen.screenWidth/1.2)
                                }
                                .padding(.vertical, UIScreen.screenHeight/80)
                                Divider()
                                    .frame(width: UIScreen.screenWidth/1.3)
                                HStack(spacing: UIScreen.screenWidth/30){
                                    
                                    //likebutton
                                    
                                    Button(action: {
                                        if post.postID ?? "" != "" {
                                            if post.likeCount != nil {
                                                if post.like == "not liked" {
                                                    mainFeedService.likePost(loginData: loginData, postID: post.postID!, posterID: post.userID)
                                                    post.likeCount = post.likeCount! + 1
                                                    post.like = "liked"
                                                } else {
                                                    mainFeedService.likePost(loginData: loginData, postID: post.postID!, posterID: post.userID)
                                                    post.likeCount = post.likeCount! - 1
                                                    post.like = "not liked"
                                                }
                                            }
                                        }
                                    }, label: {
                                        VStack {
                                            Image(post.like == "not liked" ? "PostLikeBlack" : "PostLikedBlack" )
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                            if post.likeCount != nil {
                                                if post.likeCount! != 0 {
                                                    Text(String(post.likeCount!))
                                                        .foregroundColor(.black)
                                                        .font(.footnote)
                                                        .fontWeight(.regular)
                                                }
                                            }
                                            Spacer()
                                        }
                                    })
                                    //comment
                                    Button(action: {
                                        print("open comment screen")
                                        showCommentSheet = true
                                    }, label: {
                                        VStack {
                                            Image("PostCommentBlack")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenHeight/35, height: UIScreen.screenHeight/35)
                                            if post.commentCount != nil {
                                                if post.commentCount! != 0 {
                                                    Text(String(post.commentCount!))
                                                        .foregroundColor(.black)
                                                        .font(.footnote)
                                                        .fontWeight(.regular)
                                                }
                                            }
                                            Spacer()
                                        }
                                    })
                                    .sheet(isPresented: $showCommentSheet) {
                                        if post.postID ?? "" != "" {
                                            CommentBottomSheetView(globalVM: globalVM, postID: post.postID ?? "", posterID: post.userID, loginData: loginData, commentCount: $post.commentCount.toUnwrapped(defaultValue: 0))
                                                .presentationDetents([.medium])
                                                .presentationDragIndicator(.visible)
                                        }
                                    }
                                    Spacer()
                                }
                                .frame(width: UIScreen.screenWidth/1.2)
                            }
                        }
                        .padding(.vertical, UIScreen.screenHeight/70)
                        .background(.white)
                        .cornerRadius(15)
                        .clipped()
                        .padding(.vertical, UIScreen.screenHeight/70)
                        .frame(width: UIScreen.screenWidth)
                    }
                }
            }
        }
    }
    // Function to get the number of lines for a given text in a given size with a specified font
    func getNumberOfLines(for text: String, in size: CGSize, font: UIFont) -> Int {
        let boundingBox = text.boundingRect(with: CGSize(width: size.width, height: .greatestFiniteMagnitude),
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        let lineHeight = font.lineHeight
        return Int(boundingBox.height / lineHeight)
    }
    
    // Function to get the text content for a specific line index
    func getTextForLine(at index: Int) -> String {
        let lines = post.caption.split(separator: "\n")
        if index < lines.count {
            return String(lines[index])
        } else {
            return ""
        }
    }
}

//struct CheckInHomeFeedPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckInHomeFeedPostView()
//    }
//}
extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
