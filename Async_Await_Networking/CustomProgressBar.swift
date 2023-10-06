//
//  CustomProgressBar.swift
//  Async_Await_Networking
//
//  Created by Rashad Abdul-Salam on 8/19/23.
//

import SwiftUI

struct ProgressBarView: View {
    
    @State var progressValue: Int = 0
    @State var maxProgress: Int = 8
    
    var body: some View {
        VStack {
            CustomProgressBar(value: $progressValue, maxProgress: $maxProgress).frame(height: 20)
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
            
            SectionedProgressBar(progressValue: $progressValue, maxProgress: $maxProgress).frame(height: 20)

            Spacer()
        }.padding()
    }
    
    func startProgressBar() {
        if self.progressValue < self.maxProgress {
            self.progressValue += 1
        }
    }
    
    func resetProgressBar() {
        self.progressValue = 0
    }
}

struct SectionedProgressBar: View {
    
    @Binding var progressValue: Int
    @Binding var maxProgress: Int
    
    private var progressRatio: CGFloat {
        return CGFloat(progressValue)/CGFloat(maxProgress)
    }
    
    var body: some View {
        
        // MARK: - Broken ProgressBar
        GeometryReader { geo in
            ZStack {
                // Background
                HStack {
                    ForEach(progressValue..<maxProgress) { count in
                        
                        // Progress width fill for Rectangle
                        let singleFillWidth = geo.size.width / CGFloat(maxProgress)
                        
                        // Left Edge
                        if count == 0 {
                            if progressValue > 0 {
                                Rectangle()
                                    .frame(height: 20)
                                    .overlay(Rectangle()
                                        .fill(Color.blue).padding([.trailing], 1))  // << here !!
                                    .foregroundColor(.white)
                            } else {
                                Rectangle()
                                    .frame(height: 20)
                                    .overlay(Rectangle()
                                        .fill(Color.white).padding([.leading, .vertical], 2))  // << here !!
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        // Right Edge
                        else if count == maxProgress - 1 {
                            
                            if progressValue == maxProgress - 1 {
                                Rectangle()
                                    .frame(width: singleFillWidth, height: 20)
                                    .overlay(Rectangle()
                                        .fill(Color.blue).padding([.leading], 1))  // << here !!
                                    .foregroundColor(.white)
                            } else {
                                Rectangle()
                                    .frame(height: 20)
                                    .overlay(Rectangle()
                                        .fill(Color.white).padding([.vertical, .trailing], 2))  // << here !!
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        // Middle
                        else {
                            
                            if progressValue == count + 1 {
                                Rectangle()
                                    .frame(width: singleFillWidth, height: 20)
                                    .overlay(Rectangle()
                                        .fill(Color.blue).padding([.horizontal], 1))  // << here !!
                                    .foregroundColor(.white)
                            } else {
                                Rectangle()
                                    .frame(height: 20)
                                    .overlay(Rectangle()
                                        .fill(Color.white).padding([.vertical], 2))  // << here !!
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
        }
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
    
    @Binding var value: Int
    @Binding var maxProgress: Int
    
    private var progressRatio: CGFloat {
        return CGFloat(value)/CGFloat(maxProgress)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                
                Text("In transit to stop \(value) of \(maxProgress)")
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemTeal))
                    
//                    ZStack(alignment: .trailing) {
                        let geoWidth = min(progressRatio*geometry.size.width, geometry.size.width)
                        
//                        Rectangle().frame(width: geoWidth, height: geometry.size.height)
//                                .foregroundColor(Color(UIColor.systemBlue))
//                                .animation(.linear)
                        if self.value > 0 {
                                
                            VStack(alignment: .trailing) {
                                Text("IN TRANSIT")
                                    .font(.system(size: 10))
                                    .padding(.trailing, 8)
                                    .frame(width: geoWidth, height: geometry.size.height, alignment: .trailing)
                                    .background(.red)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
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
