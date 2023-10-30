//
//  JobFilterBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct JobFilterBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    
    @State var serviceSearch: String = ""
    @State var serviceSelected: Bool = false
    
    @FocusState private var isKeyboardShowing: Bool
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                    VStack(alignment: .leading){
                            HStack{
                                Text("Filter")
                                    .font(.system(size: UIScreen.screenHeight/50))
                                    .fontWeight(.bold)
                                Spacer()
                                Text("Reset")
                                    .font(.system(size: UIScreen.screenHeight/50))
                                    .fontWeight(.bold)
                                    .foregroundColor(jobsBrightGreen)
                            }
                            .padding(.bottom, UIScreen.screenHeight/40)
                            VStack(alignment: .leading){
                                Text("Job Categories")
                                    .font(.system(size: UIScreen.screenHeight/90))
                                    .fontWeight(.bold)
                                
                                TextField("Select Job Categories", text: $jobsVM.jobsCategoryFilter)
                                    .disabled(true)
                                    .padding()
                                    .cornerRadius(7)
                                    .overlay{
                                        // apply a rounded border
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(.gray, lineWidth: 0.5)
                                        
                                    }
                                    .onTapGesture {
                                        jobsVM.jobCategoryFilterBottomSheet.toggle()
                                    }
                            }
                            VStack(alignment: .leading){
                                Text("Job Type")
                                    .font(.system(size: UIScreen.screenHeight/90))
                                    .fontWeight(.bold)
                                
                                TextField("Select Job Type", text: $jobsVM.jobsTypeFilter)
                                    .disabled(true)
                                    .padding()
                                    .cornerRadius(7)
                                    .overlay{
                                        // apply a rounded border
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(.gray, lineWidth: 0.5)
                                        
                                    }
                                    .onTapGesture {
                                        jobsVM.jobTypeFilterBottomSheet.toggle()
                                    }
                            }
                            VStack(alignment: .leading){
                                Text("Location")
                                    .font(.system(size: UIScreen.screenHeight/90))
                                    .fontWeight(.bold)
                                
                                TextField("Select Job Location", text: $jobsVM.jobsLocationFilter)
                                    .disabled(true)
                                    .padding()
                                    .cornerRadius(7)
                                    .overlay{
                                        // apply a rounded border
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(.gray, lineWidth: 0.5)
                                        
                                    }
                                    .onTapGesture {
                                        jobsVM.jobLocationFilterBottomSheet.toggle()
                                    }
                            }
                            VStack(alignment: .leading){
                                Text("Salary")
                                    .font(.system(size: UIScreen.screenHeight/90))
                                    .fontWeight(.bold)
                                
                                HStack{
                                    VStack(alignment: .leading){
                                        TextField("Select Min Salary", text: $jobsVM.jobsMinSalaryFilter)
                                            .padding()
                                            .cornerRadius(7)
                                            .overlay{
                                                // apply a rounded border
                                                RoundedRectangle(cornerRadius: 6)
                                                    .stroke(.gray, lineWidth: 0.5)
                                                
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
                                        Text("Min. Salary")
                                            .font(.system(size: UIScreen.screenHeight/100))
                                            .fontWeight(.light)
                                    }
                                    .padding(.trailing, UIScreen.screenWidth/50)
                                    VStack(alignment: .leading){
                                        TextField("Select Max. Salary", text: $jobsVM.jobsMaxSalaryFilter)
                                            .padding()
                                            .cornerRadius(7)
                                            .overlay{
                                                // apply a rounded border
                                                RoundedRectangle(cornerRadius: 6)
                                                    .stroke(.gray, lineWidth: 0.5)
                                                
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
                                        Text("Min. Salary")
                                            .font(.system(size: UIScreen.screenHeight/100))
                                            .fontWeight(.light)
                                    }
                                }
                            }
                            //button post
                        HStack{
                            Spacer()
                            Button(action: {
                            }) {
                                Text("Show Result")
                                    .foregroundColor(.black)
                                    .font(.system(size: UIScreen.screenHeight/70))
                                    .fontWeight(.bold)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, UIScreen.screenWidth/7)
                                    .background(greenUi)
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
                            .padding(.horizontal, UIScreen.screenHeight/40)
                            .padding(.vertical, UIScreen.screenHeight/40)
                            Spacer()
                        }
                        .padding(.top, UIScreen.screenHeight/50)
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .padding(.bottom, UIScreen.screenHeight/10)
                    .padding(.bottom,edges?.bottom)
                    .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.3)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: jobsVM.filterBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(jobsVM.filterBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        jobsVM.filterBottomSheet.toggle()
                    }
                }
            )
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
                    jobsVM.filterBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct JobFilterBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        JobFilterBottomSheet()
//    }
//}
