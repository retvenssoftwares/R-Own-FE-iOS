//
//  RequestDesignationBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct RequestDesignationBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var jobTitleSearch: String = ""
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @FocusState private var isKeyboardShowing: Bool
    
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
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            Text("Search your job below")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            TextField("Search Job Profile", text: $jobTitleSearch)
                                .font(.system(size: 14))
                                .frame(width: UIScreen.screenWidth/1.2)
                                .overlay(alignment: .trailing, content: {
                                    Image(systemName: "magnifyingglass")
                                })
                                .focused($isKeyboardShowing)
                                .padding()
                                .border(.black.opacity(0.5))
                            
                            
                            //Location Array
                            ScrollView{
                                VStack(alignment: .leading){
                                    if globalVM.designationnList.count > 0 {
                                        ForEach(0..<globalVM.designationnList.count, id: \.self){ count in
                                            VStack{
                                                Text(globalVM.designationnList[count].designationName)
                                                    .padding(.vertical, UIScreen.screenHeight/40)
                                                    .onTapGesture{
                                                        jobsVM.designationRequestedFor = globalVM.designationnList[count].designationName
                                                        jobsVM.requestedDesignationBottomSheet = false
                                                    }
                                                Divider()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.5)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .offset(y: jobsVM.requestedDesignationBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(jobsVM.requestedDesignationBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        jobsVM.requestedDesignationBottomSheet.toggle()
                    }
                }
            )
    }
}

//struct RequestDesignationBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestDesignationBottomSheet()
//    }
//}
