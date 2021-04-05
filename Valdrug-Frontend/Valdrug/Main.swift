//
//  Main.swift
//  Valdrug
//
//  Created by MANI NAIR on 26/03/21.
//  Copyright © 2021 com.siddharthnair. All rights reserved.
//

import SwiftUI
import Combine


struct Main: View {
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State var showModal = false
    @State private var image: UIImage?
    @State var loading: String? = "No"
    @State var validity: String = ""
    @State var drugName: String = ""
//    var manager = HttpAuth()
    
    var body: some View {
        NavigationView {
            
            ZStack{
                
                LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1"),Color("Color2")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all).opacity(0.7)
                
            VStack {
                
                if(image != nil){
                    Image(uiImage: image!)
                    .resizable()
                    .frame(width: 300, height: 300)
                        .padding(.top, 40)

                    
                }
                else{
                    Image("camera-temp")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .padding(.top, 40)
                }
//                Image(uiImage: image ??)
//                    .resizable()
//                    .frame(width: 300, height: 300)
                
                
                Button(action: {
                        self.showSheet = true
                    }){
//                       Text("Press me")
                        Text("Select Image")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                    }
                .background(
                
                    LinearGradient(gradient: .init(colors: [Color("Color2"),Color("Color1"),Color("Color")]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(8)
                .offset(y: -40)
//                .padding(.bottom, -40)
                .shadow(radius: 15)
                .padding()
                    .padding(.top, 100)
//                    .padding(.bottom, 50)
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                            .default(Text("Photo Library")) {
                                self.showImagePicker = true
                                self.sourceType = .photoLibrary
                            },
                            .default(Text("Camera")) {
                                self.showImagePicker = true
                                self.sourceType = .camera
                            },
                            .cancel()
                        ])
                }
                
                
                
                
                
//                Button("Choose Picture") {
//                    self.showSheet = true
//                }.padding()
//                    .padding(.bottom, 40)
//                    .actionSheet(isPresented: $showSheet) {
//                        ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
//                            .default(Text("Photo Library")) {
//                                self.showImagePicker = true
//                                self.sourceType = .photoLibrary
//                            },
//                            .default(Text("Camera")) {
//                                self.showImagePicker = true
//                                self.sourceType = .camera
//                            },
//                            .cancel()
//                        ])
//                }
                
                Button(action: {
                    
                    print("Button Pressed")
//                    self.manager.checkDetails(image: self.image!)
                    self.loading = nil
                    
                    var uiImge: UIImage = self.image!
//                    if uiImge.size.width > uiImge.size.height{
                        uiImge = uiImge.rotate(radians: .pi/2 * -1)!
//                    }
                    let imageData: Data = uiImge.jpegData(compressionQuality: 0.1) ?? Data()
                    let imageStr: String = imageData.base64EncodedString()

                    guard let url: URL = URL(string: "http://localhost:5000/process") else {
                        print("Invalid url")
                        return
                    }



                    let paramStr: String = "image=\(imageStr)"
                    let paramData: Data = paramStr.data(using: .utf8) ?? Data()

                    var urlRequest: URLRequest = URLRequest(url: url)
                    urlRequest.httpMethod = "POST"
                    urlRequest.httpBody = paramData

                    urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

                    print(urlRequest.httpBody!)

                    URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in


//                        DispatchQueue.main.asyncAfter(deadline: .now() + 10){

                        guard let data = data else {
                            print("invalid data")
                            return
                        }



                            let responseStr: String = String(data: data, encoding: .utf8) ?? "ok"

                            print(responseStr)
                            let responseArray = responseStr.components(separatedBy: " ")
                            self.validity = responseArray[0]
                        self.drugName = responseArray[1]
                        let resp2valid = responseArray.indices.contains(2)
                        let resp3valid = responseArray.indices.contains(3)
                        
                        if(resp2valid && resp3valid){
                            self.drugName = self.drugName+responseArray[2]+responseArray[3]
                        }
                        
//                        if (responseArray[2] != "" && responseArray[3] != ""){
//                            self.drugName = self.drugName+responseArray[2]+responseArray[3]
//                        }
                            print(self.validity)
                            self.loading = "No"
                            self.showModal.toggle()
//                        }

    


                    })
                    .resume()
                    
                    
                },label: {
                    Text("Validate")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    
                })
                    .sheet(isPresented: $showModal){
                        ResultModalView(showModal: self.$showModal, validity: self.validity, drugName: self.drugName)
                }
                    .disabled(self.image == nil)
                    .background(
                    
                        LinearGradient(gradient: .init(colors: [Color("Color2"),Color("Color1"),Color("Color")]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(8)
                    .offset(y: -40)
                    .padding(.bottom, -40)
                    .shadow(radius: 15)
                .opacity(self.image == nil ? 0 : 1)
                    .padding(.top, 35)
                    
                
                
            }
                
                if self.loading == nil{
                    
                    GeometryReader{_ in
                        
                        Loader()
                    }.background(Color.black.opacity(0.45).edgesIgnoringSafeArea(.all))
                }
                
            }
                
                
            .navigationBarTitle("VALDRUG")
            
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
    }
    
}

extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}

//struct Main_Previews: PreviewProvider {
//    static var previews: some View {
//        Main()
//    }
//}
