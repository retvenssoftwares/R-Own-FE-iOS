//
//  JobCategoryFilterBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct JobCategoryFilterBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    
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
                            Text("Select your job category?")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            Text("Search your job category below")
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
                                    VStack{
                                        Text("Assistant")
                                            .padding(.vertical, UIScreen.screenHeight/40)
                                            .onTapGesture{
                                                jobsVM.jobsCategoryFilter = "Assistant"
                                                jobsVM.jobCategoryFilterBottomSheet = false
                                            }
                                        Divider()
                                    }
                                    VStack{
                                        Text("Revenue Manager")
                                            .padding(.vertical, UIScreen.screenHeight/40)
                                            .onTapGesture{
                                                jobsVM.jobsCategoryFilter = "Revenue Manager"
                                                jobsVM.jobCategoryFilterBottomSheet = false
                                            }
                                        Divider()
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
                .offset(y: jobsVM.jobCategoryFilterBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(jobsVM.jobCategoryFilterBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        jobsVM.jobCategoryFilterBottomSheet.toggle()
                    }
                }
            )
    }
}

//struct JobCategoryFilterBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        JobCategoryFilterBottomSheet()
//    }
//}
