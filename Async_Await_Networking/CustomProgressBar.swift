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
                .padding(.bottom, 30)
            
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
        //        for _ in 0...80 {
        //            self.progressValue += 0.015
        //        }
        self.progressValue += 0.15
    }
    
    func resetProgressBar() {
        self.progressValue = 0.0
    }
}

/**
 Abstract:
 Add'l features:
 1. "In Transit" and "Completed" text trailing-aligned to progress bar
 2. Change color from blue to gray
 3. Sectioning of each portion of the progress bar + label for proportional count of each section
 */
struct CustomProgressBar: View {
    
    @Binding var value: Float
    var totalProgress: Float = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                
                Text("5 of 25")
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemTeal))
                    
                    ZStack(alignment: .trailing) {
                            Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                                .foregroundColor(Color(UIColor.systemBlue))
                                .animation(.linear)
                        if self.value > 0.0 {
                                
                            Text("In Transit")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .padding(.trailing, 5)
                                
                        }
                    }
                }.cornerRadius(45.0)
            }
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView()
    }
}
