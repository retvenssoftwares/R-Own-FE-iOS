//
//  CropView.swift
//  R-own
//
//  Created by Aman Sharma on 08/04/23.
//

//import SwiftUI
//
//struct CropView: View {
//    
//    var crop: Crop
//    var image: UIImage?
//    var onCrop: (UIImage?, Bool)->()
//    
//    @Environment(\.dismiss) private var dismiss
//    
//    //gesture-properties
//    @State private var scale: CGFloat = 1
//    @State private var lastScale: CGFloat = 0
//    @State private var offset: CGSize = .zero
//    @State private var lastStoredOffset: CGSize = .zero
//    @GestureState private var isInteracting: Bool = false
//    
//    var body: some View {
//        NavigationStack{
//            VStack{
//                ImageView()
//                    .navigationTitle("Crop View")
//                    .navigationBarTitleDisplayMode(.inline)
//                    .toolbarBackground(.visible, for: .navigationBar)
//                    .toolbarBackground(Color.black, for: .navigationBar)
//                    .toolbarColorScheme(.dark, for: .navigationBar)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .background{
//                        Color.black
//                            .ignoresSafeArea()
//                    }
//                    .toolbar{
//                        ToolbarItem(placement: .navigationBarTrailing){
//                            Button {
//                                let renderrer = ImageRenderer(content: ImageView(true))
//                                renderrer.proposedSize = .init(crop.size())
//                                if let image = renderrer.uiImage{
//                                    
//                                    onCrop(image, true)
//                                }else{
//                                    onCrop(nil, false)
//                                }
//                                dismiss()
//                            } label: {
//                                Image(systemName: "checkmark")
//                                    .font(.callout)
//                                    .fontWeight(.semibold)
//                            }
//                        }
//                    }
//                    .toolbar{
//                        ToolbarItem(placement: .navigationBarLeading){
//                            Button{
//                                dismiss()
//                            } label: {
//                                Image(systemName: "xmark")
//                                    .font(.callout)
//                                    .fontWeight(.semibold)
//                            }
//                        }
//                    }
//            }
//        }
//    }
//    @ViewBuilder
//    func ImageView(_ hideGrids: Bool = false)->some View{
//        
//        let cropSize = crop.size()
//        
//        GeometryReader{
//            let size = $0.size
//            
//            if let image{
//                Image(uiImage: image)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .overlay(content: {
//                        GeometryReader{ proxy in
//                            let rect = proxy.frame(in: .named("CROPVIEW"))
//                            
//                            Color.clear
//                                .onChange(of: isInteracting){newValue in
//                                    //true-dragging
//                                    //false-stopped-dragging
//                                    //With help of geometry reader
//                                    //We can now read minXY, maxXY of img
//                                    
//                                    withAnimation(.easeInOut(duration: 0.2)){
//                                        if rect.minX > 0{
//                                            offset.width = (offset.width - rect.minX)
//                                            haptics(.medium)
//                                        }
//                                        if rect.minY > 0{
//                                            offset.height = (offset.height - rect.minY)
//                                            haptics(.medium)
//                                        }
//                                        
//                                        
//                                        if rect.maxX > size.width{
//                                            offset.width = (rect.minX - offset.width)
//                                            haptics(.medium)
//                                        }
//                                        if rect.maxY > size.height{
//                                            offset.height = (rect.minY - offset.height)
//                                            haptics(.medium)
//                                        }
//                                    }
//                                    
//                                    if !newValue{
//                                        lastStoredOffset = offset
//                                    }
//                                }
//                        }
//                    })
//                    .frame(size)
//            }
//        }
//        .offset(offset)
//        .scaleEffect(scale)
//        .overlay(content:{
//            if !hideGrids{
//                Grids()
//            }
//        })
//        .coordinateSpace(name: "CROPVIEW")
//        .gesture(
//            DragGesture()
//                .updating($isInteracting, body: { _, out, _ in
//                    out = true
//                }).onChanged({value in
//                    let translation = value.translation
//                    offset = CGSize(width: translation.width + lastStoredOffset.width, height: translation.height + lastStoredOffset.height)
//                })
//        )
//        .gesture(
//            MagnificationGesture()
//                .updating($isInteracting, body: { _, out, _ in
//                    out = true
//                }).onChanged({value in
//                    let updatedScale = value + lastScale
//                  
//                    //Limiting Beyong 1
//                    scale = (updatedScale < 1 ? 1 : updatedScale)
//                }).onEnded({ value in
//                    withAnimation(.easeInOut(duration: 0.2)){
//                        if scale < 1{
//                            scale = 1
//                            lastScale = 0
//                        } else {
//                            lastScale = scale - 1
//                        }
//                    }
//                })
//        )
//        .frame(cropSize)
//        .cornerRadius(crop == .circle ? cropSize.height / 2 : 0)
//    }
//    
//    @ViewBuilder
//    func Grids()->some View{
//        ZStack{
//            HStack{
//                ForEach(1...5,id: \.self){_ in
//                    Rectangle()
//                        .fill(.white.opacity(0.7))
//                        .frame(width: 1)
//                        .frame(maxWidth: .infinity)
//                }
//            }
//            VStack{
//                ForEach(1...8,id: \.self){_ in
//                    Rectangle()
//                        .fill(.white.opacity(0.7))
//                        .frame(height: 1)
//                        .frame(maxHeight: .infinity)
//                }
//            }
//        }
//    }
//}

//struct CropView_Previews: PreviewProvider {
//    static var previews: some View {
//        CropView()
//    }
//}
