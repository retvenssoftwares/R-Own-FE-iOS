//
//  NormalProfileFPPPollsView.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI

struct NormalProfileFPPPollsView: View {
    
    @State var post: Post434
    
    @State var role: String
    @State var mainUser: Bool
    @State var pollsSelected: String = "Hostels"
    
    @State var pollsOptionsNumber: Int = 2
    
    @State var navigateToVotersList: Bool = false
    @State var totalVotes: Int = 0
    
    
    @State var navigateToPollsListView: Bool = false
    @StateObject var profileService = ProfileService()
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var profileVM: ProfileViewModel
    @StateObject var mesiboVM: MesiboViewModel
    
    @State var showEditPost: Bool = false
    @State var showEditSheet: Bool = false
    @State var showDeletePost: Bool = false
    @StateObject var postService = PostsService()
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                HStack{
                    //profilepic
                    
                    ProfilePictureView(profilePic: post.profilePic, verified: post.verificationStatus == "true" ? true : false, height: UIScreen.screenHeight/20, width: UIScreen.screenHeight/20)
                    
                    VStack(alignment: .leading) {
                        //name
                        Text(post.fullName)
                            .foregroundColor(.black)
                            .font(.body)
                            .fontWeight(.bold)
                            .onTapGesture {
                                print("move to profile screen")
                            }
                        //profile
                        if post.jobTitle != "" {
                            Text(post.jobTitle)
                                .foregroundColor(.black)
                                .font(.footnote)
                                .fontWeight(.thin)
                        }
                        //location
                        if post.location != "" {
                            Text(post.location)
                                .foregroundColor(.black)
                                .font(.footnote)
                                .fontWeight(.thin)
                        }
                    }
                    
                    Spacer()
                    //time
                    Text(relativeTime(from: post.dateAdded) ?? "")
                        .foregroundColor(.black)
                        .font(.footnote)
                        .fontWeight(.thin)
                }
                .frame(maxWidth: UIScreen.screenWidth)
                .padding(.horizontal, UIScreen.screenWidth/30)
                    
                HStack{
                    Text(post.pollQuestion[0].question)
                        .font(.body)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.leading)
                        .padding(.vertical, UIScreen.screenHeight/60)
                    Spacer()
                }
                .frame(maxWidth: UIScreen.screenWidth)
                .padding(.horizontal, UIScreen.screenWidth/30)
                
                ForEach(0..<post.pollQuestion[0].options.count, id: \.self){ count in
                    if post.pollQuestion[0].options.count > 0{
                        NormalProfileFPPPollsTabStruct( poll: post.pollQuestion[0].options[count], loginData: loginData, totalVotes: $totalVotes, totalVotesDisplay: Float(totalVotes), postID: post.postID, pollSelection: $post.voted)
                            .frame(maxWidth: UIScreen.screenWidth/1.1)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                    } else{
                        Text("No option available")
                    }
                }
                
                if mainUser{
                    HStack{
                        Spacer()
                        NavigationLink(isActive: $navigateToPollsListView, destination: {
                            VotersListView(post: post, globalVM: globalVM, loginData: loginData, profileVM: profileVM, mesiboVM: mesiboVM)
                        }, label: {Text("")})
                        
                        Button(action: {
                            print("opening bottom sheet to check votes")
                            globalVM.getPollVotes = [PollVotesModel]()
                            profileService.getPollVotes(globalVM: globalVM, postID: post.postID)
                            navigateToPollsListView.toggle()
                        }, label: {
                            Text("Check Votes")
                                .font(.body)
                                .padding(.horizontal, UIScreen.screenWidth/25)
                                .padding(.vertical, UIScreen.screenHeight/70)
                                .foregroundColor(greenUi)
                                .background(jobsDarkBlue)
                                .cornerRadius(5)
                        })
                        .navigationDestination(isPresented: $navigateToPollsListView, destination: {
                            VotersListView(post: post, globalVM: globalVM, loginData: loginData, profileVM: profileVM, mesiboVM: mesiboVM)
                        })
                        
                        Spacer()
                    }
                }
            }
            .padding(.vertical, UIScreen.screenHeight/50)
            .frame(width: UIScreen.screenWidth/1.1)
            .background(.white)
            .cornerRadius(15)
            .clipped()
            .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
            .onLongPressGesture(perform: {
                if mainUser {
                    showEditSheet = true
                }
            })
            .sheet(isPresented: $showEditSheet, content: {
                VStack{
                    Button(action: {
                        showDeletePost = true
                    }, label: {
                        HStack{
                            Image("CommunityDeleteIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                            Text("Delete Post")
                                .font(.body)
                                .foregroundColor(.black)
                                .fontWeight(.medium)
                        }
                    })
                    .sheet(isPresented: $showDeletePost, content: {
                        VStack{
                            Text("Do you really want to delete this post?")
                                .font(.body)
                                .fontWeight(.medium)
                            
                            VStack{
                                Button(action: {
                                    Task{
                                        loginData.showLoader = true
                                        let res = await postService.deletePost(postID: post.postID, display_status: "0")
                                        if res == "Success"{
                                            showEditSheet = false
                                            showDeletePost = false
                                            loginData.showLoader = false
                                        }
                                    }
                                }, label: {
                                    Text("Yes, I'm sure")
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                        .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/30)
                                        .background(greenUi)
                                        .cornerRadius(10)
                                })
                                
                                Button(action: {
                                    showDeletePost = false
                                }, label: {
                                    Text("No")
                                        .font(.body)
                                        .fontWeight(.medium)
                                        .foregroundColor(greenUi)
                                        .frame(width: UIScreen.screenWidth/2, height: UIScreen.screenHeight/30)
                                        .background(jobsDarkBlue)
                                        .cornerRadius(10)
                                })
                                
                                
                            }
                        }
                    })
                }
            })
        }
        .onAppear{
            for i in 0..<post.pollQuestion[0].options.count {
                totalVotes += post.pollQuestion[0].options[i].votes!.count
            }
        }
    }
}
//
//struct NormalProfileFPPPollsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalProfileFPPPollsView()
//    }
//}
