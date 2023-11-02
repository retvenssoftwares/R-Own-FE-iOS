//
//  PollsView.swift
//  R-own
//
//  Created by Aman Sharma on 10/05/23.
//

import SwiftUI
import AlertToast

struct PollsView: View {
    
    //Login Var
    @StateObject var loginData: LoginViewModel
    
    //Create Post Var
    @StateObject var createPostVM: CreatePostViewModel
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var profileVM: ProfileViewModel
    
    @State var navigateToHomeView: Bool = false
    
    @State var totalOpinions: Int = 2
    
    @State var postType: String = "Polls"
    @StateObject var postService = PostsService()
    
    @State var postPoll: PostPollsModel = PostPollsModel(Question: "", Options: [PollOptions(Option: ""), PollOptions(Option: "")] )
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var alertPollQuestionEmpty: Bool = false
    @State var alertPollOpinionEmpty: Bool = false
    @State var alertCantPost: Bool = false
    @State var emptyOpinon: Int = 0
    @State var noPollEmpty: Bool = true
    
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    //nav
                    HStack{
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.black)
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                        })
                        
                        Spacer()
                        
                        Text("Create A Poll")
                        
                        Spacer()
                        
                        Button(action: {
                            
                            if postPoll.Question == "" {
                                alertPollQuestionEmpty = true
                            } else {
                                for i in 0..<postPoll.Options.count {
                                    if postPoll.Options[i].Option == ""{
                                        emptyOpinon = i
                                        alertPollOpinionEmpty = true
                                    } else {
                                        noPollEmpty = true
                                    }
                                }
                            }
                            if areAllOptionsFilled() {
                                Task{
                                    let res: String = await postService.postPollsService(loginData: loginData, postType: postType, poll: postPoll)
                                    if res == "Success" {
                                        dismiss()
                                    } else if res == "Failure" {
                                        alertCantPost = true
                                    }
                                }
                            }
                        }, label: {
                            Text("Share")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.horizontal, UIScreen.screenWidth/40)
                                .padding(.vertical, UIScreen.screenHeight/80)
                                .background(greenUi)
                                .cornerRadius(10)
                        })
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/15)
                    .background(.white)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                    
                    ScrollView{
                        VStack{
                            HStack{
                                
                                Text("Question")
                                    .font(.body)
                                    .fontWeight(.light)
                                    .padding(.leading, UIScreen.screenWidth/30)
                                    .padding(.top, UIScreen.screenHeight/50)
                                
                                Spacer()
                            }
                            
                            VStack{
                                TextField("Add Statement", text: $postPoll.Question)
                                    .padding()
                                    .cornerRadius(7)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(.gray, lineWidth: 0.5)
                                    }
                                    .overlay{
                                        // apply a rounded border
                                        VStack{
                                            HStack{
                                                Text("Statement")
                                                    .font(.body)
                                                    .foregroundColor(.black)
                                                    .background(Color.white)
                                                    .fontWeight(.ultraLight)
                                                    .padding(.horizontal, UIScreen.screenWidth/30)
                                                    .offset(y: -10)
                                                Spacer()
                                            }
                                            Spacer()
                                        }
                                    }
                                    .focused($isKeyboardShowing)
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                            Spacer()

                                            Button("Done") {
                                                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
                                            }
                                        }
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/50)
                                    .padding(.horizontal, UIScreen.screenWidth/30)
                            }
                            
                            HStack{
                                
                                Text("Options")
                                    .font(.body)
                                    .fontWeight(.light)
                                    .padding(.leading, UIScreen.screenWidth/30)
                                    .padding(.top, UIScreen.screenHeight/50)
                                
                                Spacer()
                            }
                            
                            if postPoll.Options.count > 0 {
                                ForEach(0..<postPoll.Options.count, id: \.self){ id in
                                    HStack{
                                        PollsOpinionTab(pollOption: $postPoll.Options[id].Option, opinionTab: id+1, globalVM: globalVM)
                                        if id > 1{
                                            Button(action: {
                                                print(postPoll.Options.count)
                                                print("deleting at \(id)")
                                                postPoll.Options.remove(at: id)
                                            }, label: {
                                                Image("DeleteIcon")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                            })
                                        }
                                    }
                                    
                                }
                            }
                            
                            //venue
                            if postPoll.Options.count < 5 {
                                Button(action: {
                                    postPoll.Options.append(PollOptions(Option: ""))
                                    print(postPoll.Options.count)
                                }, label: {
                                    Text("Add Opinion Field")
                                        .font(.body)
                                        .fontWeight(.bold)
                                        .padding(.horizontal, UIScreen.screenWidth/50)
                                        .padding(.vertical, UIScreen.screenHeight/80)
                                        .foregroundColor(.white)
                                        .background(greenUi)
                                        .cornerRadius(5)
                                })
                            }
                        }
                        .padding(.horizontal, UIScreen.screenWidth/20)
                    }
                    Spacer()
                }
            }
        }
        .onChange(of: globalVM.keyboardVisibility) { newValue in
            
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
        }
        .toast(isPresenting: $alertCantPost, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try again!", subTitle: ("Unable to post"))
        }
        .toast(isPresenting: $alertPollOpinionEmpty, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "\(emptyOpinon) opinion is empty!", subTitle: ("Fill opinion tab or delete it"))
        }
        .toast(isPresenting: $alertPollQuestionEmpty, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Question is empty!", subTitle: ("Fill question tab"))
        }
        .navigationBarBackButtonHidden()
    }
    func areAllOptionsFilled() -> Bool {
        for option in postPoll.Options {
            if option.Option == "" {
                    return false
                }
            }
        return true
    }
}

//struct PollsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PollsView()
//    }
//}
