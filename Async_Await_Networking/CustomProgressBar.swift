//
//  CustomProgressBar.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salam on 8/19/23.
//

import SwiftUI

struct ProgressBarView: View {
    
    @State var progressValue: Float = 0.0
    
    var body: some View {
        VStack {
            CustomProgressBar(value: $progressValue).frame(height: 20)
            
            Button {
                self.startProgressBar()
            } label: {
                Text("Start Progress")
            }.padding()
            
            Button {
                self.resetProgressBar()
            } label: {
                Text("Reset")
            }

            Spacer()
        }.padding()
    }
    
    func startProgressBar() {
        for _ in 0...80 {
            self.progressValue += 0.015
        }
    }
    
    func resetProgressBar() {
        self.progressValue = 0.0
    }
}

struct CustomProgressBar: View {
    
    @Binding var value: Float
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.systemBlue))
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView()
    }
}
