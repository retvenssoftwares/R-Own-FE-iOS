//
//  NewFeedPollsView.swift
//  R-own
//
//  Created by Aman Sharma on 28/07/23.
//

import SwiftUI

struct NewFeedPollsView: View {
    
    @State var post: NewFeedPost
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var pollsSelected: String = ""
    
    @State var pollsOptionsNumber: Int = 2
    
    @State var navigateToVotersList: Bool = false
    @State var totalVotes: Int = 0
    
    @State var navigateToProfileView: Bool = false
    var body: some View {
        NavigationStack{
            if post.fullName ?? "" != "" {
                if post.pollQuestion.count != 0 {
                    VStack{
                        HStack{
                            //profilepic
                            ProfilePictureView(profilePic: post.profilePic ?? "", verified: post.verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                                .onTapGesture {
                                    navigateToProfileView.toggle()
                                    print("move to profile screen")
                                }
                                .navigationDestination(isPresented: $navigateToProfileView, destination: {
                                    if post.role ?? "" != "" {
                                        ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: post.role!, mainUser: false, userID: post.userID)
                                    }
                                })
                            VStack(alignment: .leading) {
                                //name
                                Text(post.fullName!)
                                    .foregroundColor(.black)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(alignment: .leading)
                                    .onTapGesture {
                                        navigateToProfileView.toggle()
                                        print("move to profile screen")
                                    }
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
                        .frame(width: UIScreen.screenWidth/1.1)
                        
                        HStack{
                            Text(post.pollQuestion[0].question)
                                .font(.headline)
                                .foregroundColor(.black)
                                .fontWeight(.regular)
                                .padding(.vertical, UIScreen.screenHeight/80)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .frame(width: UIScreen.screenWidth/1.1)
                        
                        if post.pollQuestion[0].options.count > 0 {
                            ForEach(0..<post.pollQuestion[0].options.count, id: \.self){ count in
                                if post.postID ?? "" != "" {
                                    NewFeedPollsOptionView(poll: post.pollQuestion[0].options[count], totalVotes: $totalVotes, totalVotesDisplay: Float(totalVotes), postID: post.postID!, loginData: loginData)
                                }
                            }
                        }
                        
                        //            Button(action: {
                        //                navigateToVotersList.toggle()
                        //            }, label: {
                        //                Text("Check Votes")
                        //                    .font(.system(size: UIScreen.screenHeight/70))
                        //                    .fontWeight(.bold)
                        //                    .foregroundColor(greenUi)
                        //                    .padding(.horizontal, UIScreen.screenWidth/30)
                        //                    .padding(.vertical, UIScreen.screenHeight/50)
                        //            })
                        //            .navigationDestination(isPresented: $navigateToVotersList, destination: {
                        //                VotersListView()
                        //            })
                    }
                    .padding(.vertical, UIScreen.screenHeight/40)
                    .frame(width: UIScreen.screenWidth)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                }
            }
        }
        .onAppear{
            if post.pollQuestion.count != 0 {
                for i in 0..<post.pollQuestion[0].options.count {
                    totalVotes += post.pollQuestion[0].options[i].votes.count
                }
            }
        }
    }
}

//struct NewFeedPollsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewFeedPollsView()
//    }
//}
