//
//  animation.swift
//  FoodApi
//
//  Created by zayn on 11/05/25.
//

import SwiftUI

struct RectangleLoaderView: View {
    
    // MARK:- variables
    @State var yOffset: CGFloat = 0
    @State var rectangleHeight: CGFloat = 12
    
    // MARK:- views
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear
                    .edgesIgnoringSafeArea(.all)
                HStack(alignment: .center, spacing: 8) {
                    Rectangle()
                        .frame(width: 12, height: rectangleHeight)
                        .offset(x: 0, y: yOffset)
                        .animation(Animation.easeOut.delay(0))
                    Rectangle()
                        .frame(width: 12, height: rectangleHeight)
                        .offset(x: 0, y: yOffset)
                        .animation(Animation.easeOut.delay(0.2))
                    Rectangle()
                        .frame(width: 12, height: rectangleHeight)
                        .offset(x: 0, y: yOffset)
                        .animation(Animation.easeOut.delay(0.4))
                    Rectangle()
                        .frame(width: 12, height: rectangleHeight)
                        .offset(x: 0, y: yOffset)
                        .animation(Animation.easeOut.delay(0.6))
                }.onAppear() {
                    rectangleHeight = geometry.size.width * 0.25
                    animateRectangles(in: geometry)
                    Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                        animateRectangles(in: geometry)
                    }
                }
            }
        }
    }
    
    // MARK:- functions
    func animateRectangles(in geometry: GeometryProxy) {
        rectangleHeight = geometry.size.width * 0.25
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            rectangleHeight = geometry.size.width * 0.1
        }
    }
}

struct TextWithAnimation: View {
    let txt = Array("Search a Food...")
    @State private var flipAngle = 0.0

    var body: some View {
        VStack(spacing: 32) {
            HStack(spacing: 0) {
                ForEach(0..<txt.count, id: \.self) { flip in
                    Text(String(txt[flip]))
                        .font(.largeTitle)
                        .rotation3DEffect(.degrees(flipAngle), axis: (x: 1, y: 0, z: 1))
                        .animation(
                            .default.delay(Double(flip) * 0.1),
                            value: flipAngle
                        )
                }
            }
        }
        .padding()
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
                withAnimation {
                    flipAngle = (flipAngle == 0) ? 360 : 0
                }
            }
        }
    }
}


#Preview {
    TextWithAnimation()
}
