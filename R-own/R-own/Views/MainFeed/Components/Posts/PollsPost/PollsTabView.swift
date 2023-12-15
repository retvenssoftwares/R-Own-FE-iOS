//
//  PollsListTabView.swift
//  R-own
//
//  Created by Aman Sharma on 16/05/23.
//

import SwiftUI

struct PollsTabView: View {
    
    @State var post: Post535
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    @State var pollSelection: String
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var pollsSelected: String = "Hostels"
    
    @State var pollsOptionsNumber: Int = 2
    
    @State var navigateToVotersList: Bool = false
    @State var totalVotes: Int = 0
    
    @State var navigateToProfileView: Bool = false
    var body: some View {
        NavigationStack{
            if post.pollQuestion.count != 0 {
                VStack{
                    HStack{
                        //profilepic
                        ProfilePictureView(profilePic: post.profilePic, verified: post.verificationStatus == "false" ? false : true, height: UIScreen.screenHeight/30, width: UIScreen.screenHeight/30)
                            .onTapGesture {
                                navigateToProfileView = true
                                print("move to profile screen")
                            }
                            .navigationDestination(isPresented: $navigateToProfileView, destination: {
                                ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: post.role, mainUser: false, userID: post.userID)
                            })
                        NavigationLink(isActive: $navigateToProfileView, destination: {
                            ProfileView(loginData: loginData, profileVM: profileVM, globalVM: globalVM, mesiboVM: mesiboVM, role: post.role, mainUser: false, userID: post.userID)
                        }, label: {
                            Text("")
                        })
                        VStack(alignment: .leading) {
                            //name
                            Text(post.fullName)
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.bold)
                                .padding(.leading, 30)
                                .frame(alignment: .leading)
                                .onTapGesture {
                                    print("move to profile screen")
                                }
                            //profile
                            if post.jobTitle == "" {
                                Text(post.jobTitle)
                                    .foregroundColor(.black)
                                    .font(.footnote)
                                    .fontWeight(.thin)
                                    .padding(.leading, 30)
                                    .frame(alignment: .leading)
                            }
                            //location
                            if post.location == "" {
                                Text(post.location)
                                    .foregroundColor(.black)
                                    .font(.footnote)
                                    .fontWeight(.thin)
                                    .padding(.leading, 30)
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
                    HStack{
                        Text(post.pollQuestion[0].question)
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.thin)
                            .padding(.vertical, UIScreen.screenHeight/80)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                        Spacer()
                    }
                    
                    if post.pollQuestion[0].options.count > 0 {
                        ForEach(0..<post.pollQuestion[0].options.count, id: \.self){ count in
                            PollsOptionView(poll: post.pollQuestion[0].options[count], totalVotes: $totalVotes, totalVotesDisplay: Float(totalVotes), pollSelection: $pollSelection, postID: post.postID, loginData: loginData)
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
                .background(.white)
                .cornerRadius(15)
                .clipped()
                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                .padding(.horizontal, UIScreen.screenWidth/50)
                .padding(.vertical, UIScreen.screenHeight/70)
            }
        }
        .onAppear{
            navigateToProfileView = false
            if post.pollQuestion.count != 0 {
                for i in 0..<post.pollQuestion[0].options.count {
                    totalVotes += post.pollQuestion[0].options[i].votes.count
                }
            }
        }
    }
}

//struct PollsListTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        PollsListTabView()
//    }
//}
