//
//  PostTypeBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI

struct PostTypeBottomSheet: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Create Post Var
    @StateObject var createPostVM: CreatePostViewModel
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @State var hotelSearch: String = ""
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    @State var navigateToClicknShare: Bool = false
    @State var navigateToShareSomeMedia: Bool = false
    @State var navigateToupdateEvent: Bool = false
    @State var navigateToCheckIn: Bool = false
    @State var navigateToPolls: Bool = false
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                    
                    VStack(alignment: .leading){
                        Text("What type of post you would like to send?")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.horizontal, UIScreen.screenWidth/20)
                            .padding(.vertical, UIScreen.screenHeight/70)
                        
                        VStack(alignment: .leading){
                            HStack{
                                Image("PostClickandShareIcon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                    .padding(.trailing, UIScreen.screenWidth/50)
                                VStack(alignment: .leading){
                                    Text("Click and share")
                                        .font(.body)
                                        .fontWeight(.bold)
                                    
                                    Text("Discovered something ? Take a picture and share with your community")
                                        .font(.footnote)
                                        .fontWeight(.thin)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            .padding(.horizontal, UIScreen.screenWidth/20)
                            .onTapGesture(perform: {
                                navigateToClicknShare.toggle()
                                print("navigate")
                            })
                            .onAppear{
                                navigateToClicknShare = false
                            }
                            .navigationDestination(isPresented: $navigateToClicknShare, destination: {
                                ClickNShareView(loginData: loginData, createPostVM: createPostVM, globalVM: globalVM)
                            })
                            Divider()
                        }
                        NavigationLink(isActive: $navigateToClicknShare, destination: {ClickNShareView(loginData: loginData, createPostVM: createPostVM, globalVM: globalVM)}, label: {Text("")})
                        
                        VStack(alignment: .leading){
                            HStack{
                                Image("PostsSharenMedia")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                    .padding(.trailing, UIScreen.screenWidth/50)
                                VStack(alignment: .leading){
                                    Text("Share some medias")
                                        .font(.body)
                                        .fontWeight(.bold)
                                    
                                    Text("Found something interesting ? Upload and share with your community")
                                        .font(.footnote)
                                        .fontWeight(.thin)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            .padding(.horizontal, UIScreen.screenWidth/20)
                            .onTapGesture{
                                navigateToShareSomeMedia.toggle()
                            }
                            .onAppear{
                                navigateToShareSomeMedia = false
                            }
                            .navigationDestination(isPresented: $navigateToShareSomeMedia, destination: {
                                ShareSomeMediaView(loginData: loginData, createPostVM: createPostVM, globalVM: globalVM)
                            })
                            Divider()
                        }
                        NavigationLink(isActive: $navigateToShareSomeMedia, destination: {
                            ShareSomeMediaView(loginData: loginData, createPostVM: createPostVM, globalVM: globalVM)
                        }, label: {Text("")})
                        
                        if loginData.isHiddenKPI{
                            VStack(alignment: .leading){
                                HStack{
                                    Image("PostUpdateEvent")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                        .padding(.trailing, UIScreen.screenWidth/50)
                                    VStack(alignment: .leading){
                                        Text("Update about an event")
                                            .font(.body)
                                            .fontWeight(.bold)
                                        
                                        Text("Attending an event ? Share, so that your community can join.")
                                            .font(.footnote)
                                            .fontWeight(.thin)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                                .padding(.horizontal, UIScreen.screenWidth/20)
                                .onTapGesture{
                                    navigateToupdateEvent.toggle()
                                }
                                .onAppear{
                                    navigateToupdateEvent = false
                                }
                                .navigationDestination(isPresented: $navigateToupdateEvent, destination: {
                                    UpdateEventView(loginData: loginData, createPostVM: createPostVM, profileVM: profileVM, globalVM: globalVM)
                                })
                                Divider()
                            }
                        }
                        NavigationLink(isActive: $navigateToupdateEvent, destination: {
                            UpdateEventView(loginData: loginData, createPostVM: createPostVM, profileVM: profileVM, globalVM: globalVM)
                        }, label: {Text("")})
                        
                        VStack(alignment: .leading){
                            HStack{
                                Image("PostCheckIn")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                    .padding(.trailing, UIScreen.screenWidth/50)
                                VStack(alignment: .leading){
                                    Text("Check-In")
                                        .font(.body)
                                        .fontWeight(.bold)
                                    
                                    Text("Are you somewhere specific ? Share, so that your community can meet you.")
                                        .font(.footnote)
                                        .fontWeight(.thin)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            .padding(.horizontal, UIScreen.screenWidth/20)
                            .onTapGesture{
                                navigateToCheckIn.toggle()
                            }
                            .onAppear{
                                navigateToCheckIn = false
                            }
                            .navigationDestination(isPresented: $navigateToCheckIn, destination: {
                                CheckInView(loginData: loginData, createPostVM: createPostVM)
                            })
                            Divider()
                        }
                        NavigationLink(isActive: $navigateToCheckIn, destination: {
                            CheckInView(loginData: loginData, createPostVM: createPostVM)
                        }, label: {Text("")})
                        
                        VStack(alignment: .leading){
                            HStack{
                                Image("PostsPolls")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                    .padding(.trailing, UIScreen.screenWidth/50)
                                VStack(alignment: .leading){
                                    Text("Polls")
                                        .font(.body)
                                        .fontWeight(.bold)
                                    
                                    Text("Are you looking for an opinion on something ? Ask your audience for it.")
                                        .font(.footnote)
                                        .fontWeight(.thin)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                            .padding(.horizontal, UIScreen.screenWidth/20)
                            .onTapGesture{
                                navigateToPolls.toggle()
                            }
                            .onAppear{
                                navigateToPolls = false
                            }
                            .navigationDestination(isPresented: $navigateToPolls, destination: {
                                PollsView(loginData: loginData, createPostVM: createPostVM, globalVM: globalVM, profileVM: profileVM)
                            })
                            Spacer()
                            NavigationLink(isActive: $navigateToPolls, destination: {
                                PollsView(loginData: loginData, createPostVM: createPostVM, globalVM: globalVM, profileVM: profileVM)
                            }, label: {Text("")})
                        }
                    }
                    .padding(.bottom)
                    .padding(.bottom,edges?.bottom)
                    .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/2)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: createPostVM.postTypeBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(createPostVM.postTypeBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        createPostVM.postTypeBottomSheet.toggle()
                    }
                }
            )
            .onAppear{
                navigateToClicknShare = false
                navigateToShareSomeMedia = false
                navigateToupdateEvent = false
                navigateToCheckIn = false
                navigateToPolls = false
            }
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
                    createPostVM.postTypeBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}
//struct PostTypeBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        PostTypeBottomSheet()
//    }
//}
