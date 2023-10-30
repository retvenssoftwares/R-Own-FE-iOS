//
//  StateBottomSheetView.swift
//  R-own
//
//  Created by Aman Sharma on 04/05/23.
//

import SwiftUI

struct StateBottomSheetView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var locationVM = LocationViewModel()
    
    @State var stateSearchText: String = ""
    @Binding var state: String
    @Binding var stateCode: String
    @State var countryCode: String
    
    @FocusState private var isKeyboardShowing: Bool
    
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var filteredStates: [StateModel] {
        stateSearchText.isEmpty ? globalVM.stateList : globalVM.stateList.filter { $0.name.localizedCaseInsensitiveContains(stateSearchText) }
    }
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                        VStack(spacing: 20){
                            Text("Select your state?")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            Text("Search your state below")
                                .foregroundColor(.black)
                                .font(.body)
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            TextField("Search State", text: $stateSearchText)
                                .font(.body)
                                .frame(width: UIScreen.screenWidth/1.2)
                                .overlay(alignment: .trailing, content: {
                                    Image(systemName: "magnifyingglass")
                                })
                                .focused($isKeyboardShowing)
//                                .toolbar {
//                                    ToolbarItemGroup(placement: .keyboard) {
//                                        Spacer()
//
//                                        Button("Done") {
//
//                                            isKeyboardShowing = false
//                                            globalVM.keyboardVisibility = false
//                                        }
//                                    }
//                                }
                                .padding()
                                .border(.black.opacity(0.5))
                            
                            
                            //Location Array
                            ScrollView{
                                VStack(alignment: .leading){
                                    if filteredStates.count > 0 {
                                        ForEach(filteredStates, id: \.self){ optState in
                                            Button(action: {
                                                state = optState.name
                                                stateCode = optState.stateCode
                                                loginData.showStateSheet = false
                                            }, label: {
                                                VStack{
                                                    Text(optState.name)
                                                        .font(.body)
                                                        .fontWeight(.semibold)
                                                        .padding(.vertical, 5)
                                                        .foregroundColor(.black)
                                                        .frame(width: UIScreen.screenWidth)
                                                    Divider()
                                                }
                                            })
                                        }
                                    }
                                }
                            }
                            .padding(.top, UIScreen.screenHeight/50)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.5)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: loginData.showStateSheet ? 0 : UIScreen.main.bounds.height)
            }
            .onChange(of: globalVM.keyboardVisibility) { newValue in
                
                            isKeyboardShowing = false
                            globalVM.keyboardVisibility = false
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(loginData.showStateSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        loginData.showStateSheet.toggle()
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
                    loginData.showStateSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}
//struct StateBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        StateBottomSheetView()
//    }
//}
