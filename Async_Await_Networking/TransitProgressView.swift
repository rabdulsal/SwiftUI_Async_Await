//
//  TransitProgressView.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salaam on 9/12/23.
//

import SwiftUI

struct TransitProgressView: View {
    
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemTeal))
                    
                    Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(Color(UIColor.systemBlue))
                        .animation(.linear)
                }.cornerRadius(45.0)
                
                Button(action: {
                    self.startProgressBar()
                }) {
                    Text("Start Progress")
                }.padding()
                
                Button(action: {
                    self.resetProgressBar()
                }) {
                    Text("Reset")
                }
                
            }
        }
        Spacer()
    }
    
    func startProgressBar() {
        for _ in 0...80 {
            self.value += 0.015
        }
    }
    
    func resetProgressBar() {
        self.value = 0.0
    }
}
//        struct ContentView: View {
//            @State var progressValue: Float = 0.0
//
//            var body: some View {
//                VStack {
//                    ProgressBar(value: $progressValue).frame(height: 20)
//
//                    Button(action: {
//                        self.startProgressBar()
//                    }) {
//                        Text("Start Progress")
//                    }.padding()
//
//                    Button(action: {
//                        self.resetProgressBar()
//                    }) {
//                        Text("Reset")
//                    }
//
//                    Spacer()
//                }.padding()
//            }
//
//            func startProgressBar() {
//                for _ in 0...80 {
//                    self.progressValue += 0.015
//                }
//            }
//
//            func resetProgressBar() {
//                self.progressValue = 0.0
//            }
//        }
//    }
//}

struct TransitProgressView_Previews: PreviewProvider {
    @State static var progressValue: Float = 0.0
    
    static var previews: some View {
        TransitProgressView(value: $progressValue).frame(height: 20)
    }
}
