//
//  CircularProgressView.swift
//  CWC MonthlyApp Hydration
//
//  Created by Quevin Bambasi on 6/3/23.
//

import SwiftUI

struct CircularProgressView: View {
    @State var progressValue: Float = 0.0
    
    var body: some View {
        VStack {
            ProgressBar(progress: self.$progressValue)
                .frame(width: 200.0, height: 200.0)
                .padding(20.0)
                .onAppear {
                    self.progressValue = 0.0
                }
            
            Button("Increment") {
                withAnimation(.easeInOut(duration: 0.5)) {
                    if(progressValue) < 1.0 {
                        self.progressValue += 0.10
                    } else {
                        progressValue -= 1.0
                    }
                }
            }
        }
    }
}

struct ProgressBar: View {
    @Binding var progress: Float
    var color: Color = Color.blue
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.20)
                .foregroundColor(.blue)
                .shadow(radius: 5)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
        }
    }
}

struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView()
    }
}
