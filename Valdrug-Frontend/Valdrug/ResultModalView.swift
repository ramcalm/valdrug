//
//  ResultModalView.swift
//  Valdrug
//
//  Created by MANI NAIR on 27/03/21.
//  Copyright © 2021 com.siddharthnair. All rights reserved.
//

import SwiftUI

struct ResultModalView: View {
    @Binding var showModal: Bool
    @State var validity: String
    @State var drugName: String
    
    @State private var showThumb = 1
    @State private var drawRing = 1/99
    @State private var showCircle = 0
    @State private var showCheckmark = -200
    
    var body: some View {
//        Text(self.validity)
        ZStack{
            LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1"),Color("Color2")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all).opacity(0.65)
            
        VStack(alignment: .center){
            
            VStack{
                if(self.validity == "Valid"){
            Text("The drug \(self.drugName) is \(self.validity)")
                .font(.title)
//                .lineLimit(4)
//                .padding(.bottom, 30)
                .padding()
            .foregroundColor(.white)
                }
                else{
                    Text("The drug \(self.drugName) is Counterfeit")
                                    .font(.title)
                    //                .lineLimit(4)
                    //                .padding(.bottom, 30)
                                    .padding()
                                .foregroundColor(.white)
                    
                }
                
                
            }
            .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            .background(
                            
                                LinearGradient(gradient: .init(colors: [Color("Color2"),Color("Color1"),Color("Color")]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(8)
                            .offset(y: -40)
            //                .padding(.bottom, -40)
                            .shadow(radius: 15)
                            .padding()
//                .padding(.bottom, 40)
            .padding(.top, 40)
            
            if self.validity == "Valid"{
            ZStack{
                
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    .frame(width: 326, height: 326, alignment: .center)
                    .foregroundColor(Color(.systemGray3))
                
                Circle()
                .trim(from: 0, to: CGFloat(drawRing))
                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    .frame(width: 326, height: 326, alignment: .center)
                    .rotationEffect(.degrees(-90))
                    .foregroundColor(Color(.systemGreen))
                    .animation(Animation.easeInOut(duration: 1).delay(1))
                
//                Image(systemName: "touchid")
//                    .font(.system(size: 80))
//                    .foregroundColor(Color(.systemGray3))
//
//                Image(systemName: "touchid")
//                .font(.system(size: 80))
//                    .clipShape(Rectangle().offset(y: CGFloat(showThumb)))
//                    .foregroundColor(Color(.systemPink))
//                    .animation(Animation.easeInOut(duration: 1))
                
                Circle()
                .frame(width: 310, height: 310, alignment: .center)
                .foregroundColor(Color(.systemGreen))
                .scaleEffect(CGFloat(showCircle))
                    .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(2))
                
                Image(systemName: "checkmark")
                .font(.system(size: 200))
                    .clipShape(Rectangle().offset(x: CGFloat(showCheckmark)))
                    .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(2.5))
                
                

                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {

                self.showThumb = 0
                self.drawRing = 1
                self.showCircle = 1
                self.showCheckmark = 1
                }
            }
                VStack{
                Text("SIDE EFFECTS")
                .font(.title)
                .padding(.top, 20)
                    .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 50)
                
                Text("Headache, Dizziness, Nausea and Constipation")
                    .font(.headline)
                .padding(.top, 40)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.bottom, 30)
                .frame(width: UIScreen.main.bounds.width - 50)
                }
                .multilineTextAlignment(.center)
                .background(
                                
                                    LinearGradient(gradient: .init(colors: [Color("Color2"),Color("Color1"),Color("Color")]), startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(8)
                                .offset(y: -40)
                //                .padding(.bottom, -40)
                                .shadow(radius: 15)
                                .padding()
                    .padding(.top, 70)
            }
            
            else{
                
                ZStack{
                    // 126
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                        .frame(width: 326, height: 326, alignment: .center)
                        .foregroundColor(Color(.systemGray3))
                    
                    //126
                    Circle()
                        .trim(from: 0, to: CGFloat(drawRing))
                        .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                        .frame(width: 326, height: 326, alignment: .center)
                        .rotationEffect(.degrees(-90))
                        .foregroundColor(Color(.systemRed))
                        .animation(Animation.easeInOut(duration: 1).delay(1))
                    
                    //110
                    Circle()
                        .frame(width: 310, height: 310, alignment: .center)
                        .foregroundColor(Color(.systemRed))
                        .scaleEffect(CGFloat(showCircle))
                        .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(2))
                    
                    // 60
                    Image(systemName: "xmark")
                        .font(.system(size: 200))
                        .clipShape(Rectangle().offset(x: CGFloat(showCheckmark)))
                        .animation(Animation.interpolatingSpring(stiffness: 170, damping: 15).delay(2.5))
                    
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        
                        self.showThumb = 0
                        self.drawRing = 1
                        self.showCircle = 1
                        self.showCheckmark = 1
                    }
                }
                
                VStack{
                Text("ALTERNATIVES")
                .font(.title)
                .padding(.top, 20)
                    .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 50)
                
                Text("Ospamox 500, Oromox 500, Trimox 500, Moxikind 500")
                    .font(.headline)
                .padding(.top, 40)
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                    .padding(.bottom, 30)
                .frame(width: UIScreen.main.bounds.width - 50)
                    .lineLimit(2)
                }
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .background(
                                
                                    LinearGradient(gradient: .init(colors: [Color("Color2"),Color("Color1"),Color("Color")]), startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(8)
                                .offset(y: -40)
                //                .padding(.bottom, -40)
                                .shadow(radius: 15)
                                .padding()
                    .padding(.top, 70)
                
            }
        }
        }
        
        
    }
}

//struct ResultModalView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultModalView()
//    }
//}
