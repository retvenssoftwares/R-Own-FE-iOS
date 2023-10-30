//
//  ExploreEmoloyeesView.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct ExploreEmoloyeesView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @State var appliedJob: Bool = false
    
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        VStack {
                VStack{
                    //Search Field
                    TextField("Search", text: $jobsVM.jobsSearchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.default)
                        .padding()
                        .frame(width: UIScreen.screenWidth/1.2)
                        .cornerRadius(5)
                        .overlay{
                            Image("ExploreSearchIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                .offset(x: UIScreen.screenWidth/2.9)
                        }
                        .focused($isKeyboardShowing)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    isKeyboardShowing = false
                                }
                            }
                        }
                    
                    //Filter
                    HStack{
                        
                        //Filter Icon
                        Button(action: {
                            jobsVM.filterBottomSheet.toggle()
                        }, label: {
                            Image("JobsFilterIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                .padding(.horizontal ,UIScreen.screenHeight/50)
                                .padding(.vertical, UIScreen.screenHeight/90)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black.opacity(0.5), lineWidth: 1))
                                .shadow(radius: 10)
                        })
                        .padding(.leading, 10)
                        
                        
                        //Filter Tabs
                        ScrollView(.horizontal){
                            HStack{
                                //Tabs
                                ForEach(1...10, id: \.self) {_ in
                                    
                                    //Card
                                    FilterCard()
                                    
                                }
                            }
                        }
                        
                    }
                    
                    ScrollView{
                        //Tabs
                        VStack {
                            ForEach(1...10, id: \.self) {_ in
                                
                                //Card
                                VStack{
                                    HStack{
                                        ProfilePictureView(profilePic: "", verified: false, height: UIScreen.screenHeight/20, width: UIScreen.screenHeight/20)
                                        VStack{
                                            Text("ShivamTiwari")
                                                .font(.system(size: UIScreen.screenHeight/70))
                                                .fontWeight(.bold)
                                            Text("Project Manager . 4Y . Indore")
                                                .font(.system(size: UIScreen.screenHeight/100))
                                                .fontWeight(.thin)
                                        }
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                        Spacer()
                                        Button(action: {
                                            
                                        }, label: {
                                            Text("View")
                                                .font(.system(size: UIScreen.screenHeight/100))
                                                .fontWeight(.thin)
                                                .padding(.horizontal, UIScreen.screenWidth/35)
                                                .padding(.vertical, UIScreen.screenHeight/80)
                                                .background(jobsBrightGreen)
                                                .cornerRadius(15)
                                                .shadow(radius: 5)
                                                .padding(5)
                                        })
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth/10)
                                }
                                
                            }
                        }
                    }
                    .padding(.top, UIScreen.screenHeight/70)
                }
                .padding(.leading, UIScreen.screenWidth/15)
        }
        .padding(.top, UIScreen.screenHeight/60)
        .padding(.bottom, UIScreen.screenHeight/10)
    }
}

//struct ExploreEmoloyeesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreEmoloyeesView()
//    }
//}
