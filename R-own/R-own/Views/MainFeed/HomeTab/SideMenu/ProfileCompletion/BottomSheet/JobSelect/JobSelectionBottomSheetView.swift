//
//  JobSelectionBottomSheetView.swift
//  R-own
//
//  Created by Aman Sharma on 05/05/23.
//

import SwiftUI
import AlertToast

struct JobSelectionBottomSheetView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var jobTitleSearch: String = ""
        
    @State private var filteredDesignations: [Designation] = []
    
    @StateObject var userPCS = UserProfileCompletionService()
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @FocusState private var isKeyboardShowing: Bool
    @State var isLoading: Bool = false
    @State var alertFetchingJobRoles: Bool = false
    
    
    @State var offset : CGFloat = 0
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                        VStack(spacing: 20){
                            Text("Select your job title?")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            TextField("Search Job Profile", text: $jobTitleSearch)
                                .font(.body)
                                .frame(width: UIScreen.screenWidth/1.2)
                                .overlay(alignment: .trailing, content: {
                                    Image(systemName: "magnifyingglass")
                                })
                                .focused($isKeyboardShowing)
                                .padding()
                                .overlay{
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(lineWidth: 2)
                                        .foregroundColor(lightGreyUi)
                                }
                            
                            if isLoading {
                                //Location Array
                                if filteredDesignations.count > 0 {
                                    ScrollView{
                                        VStack{
                                            if filteredDesignations.count == 0 {
                                                Button(action: {
                                                    loginData.mainUserJobTitle = jobTitleSearch
                                                    loginData.showJobSheet = false
                                                }, label: {
                                                    HStack{
                                                        Text("Add \(jobTitleSearch)")
                                                            .foregroundColor(.black)
                                                            .padding(.vertical, 10)
                                                            .fontWeight(.medium)
                                                            .padding(.top, UIScreen.screenHeight/90)
                                                    }
                                                    .frame(width: UIScreen.screenWidth)
                                                })
                                                
                                            } else {
                                                ForEach(filteredDesignations, id: \.self){ designations in
                                                    Button(action: {
                                                        loginData.mainUserJobTitle = designations.designationName
                                                        loginData.showJobSheet = false
                                                    }, label: {
                                                        VStack{
                                                            Text(designations.designationName)
                                                                .font(.body)
                                                                .fontWeight(.medium)
                                                                .foregroundColor(.black)
                                                                .padding(.vertical, UIScreen.screenHeight/50)
                                                            Divider()
                                                        }
                                                    })
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    if jobTitleSearch != "" {
                                        Button(action: {
                                            loginData.mainUserJobTitle = jobTitleSearch
                                            loginData.showJobSheet = false
                                        }, label: {
                                            HStack{
                                                Text("Add \(jobTitleSearch)")
                                                    .foregroundColor(.black)
                                                    .padding(.vertical, 10)
                                                    .fontWeight(.medium)
                                                    .padding(.top, UIScreen.screenHeight/90)
                                            }
                                            .frame(width: UIScreen.screenWidth)
                                        })
                                    }
                                }
                            } else {
                                ProgressView()
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.3)
                        .onAppear{
                            isLoading = false
                            Task{
                                let res = await userPCS.getDesignationList(globalVM: globalVM)
                                if res == "Success"{
                                    isLoading = true
                                    filteredDesignations = globalVM.designationList
                                } else {
                                    alertFetchingJobRoles = true
                                    isLoading = true
                                    
                                }
                            }
                        }
                        .onChange(of: jobTitleSearch) { newValue in
                            if newValue.isEmpty {
                                filteredDesignations = globalVM.designationList
                            } else {
                                filteredDesignations = globalVM.designationList.filter { designation in
                                    designation.designationName.localizedCaseInsensitiveContains(newValue)
                                }
                            }
                        }
                        .toast(isPresenting: $alertFetchingJobRoles, duration: 2, tapToDismiss: true){
                            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Can't get jobs")
                        }
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .offset(y: loginData.showJobSheet ? 0 : UIScreen.main.bounds.height)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.showJobSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.showJobSheet.toggle()
                    }
                }
            )
    }
}

//struct JobSelectionBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        JobSelectionBottomSheetView()
//    }
//}
