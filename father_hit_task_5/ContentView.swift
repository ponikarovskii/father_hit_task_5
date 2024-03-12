//
//  ContentView.swift
//  father_hit_task_5
//
//  Created by Антон Поникаровский on 12.03.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var offset = CGSize.zero
    @State private var position = CGSize.zero
    @State private var blackDiff = 0.0
    @State private var whiteDiff = 0.0
    private var squareSize = 100.0
    @State private var bottomPoint = CGFloat.zero
    @State private var topPoint = CGFloat.zero
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 0.0) {
                    Rectangle()
                        .fill(.white)
                        .frame(height: geometry.size.height / 4.0)
                    Rectangle()
                        .fill(.pink)
                        .frame(height: geometry.size.height / 4.0)
                    Rectangle()
                        .fill(.yellow)
                        .frame(height: geometry.size.height / 4.0)
                    Rectangle()
                        .fill(.black)
                        .frame(height: geometry.size.height / 4.0)
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.black)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                        .clipShape(Rectangle().offset(y: blackDiff))
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                        .clipShape(Rectangle().offset(y: whiteDiff))
                }
                .offset(x: position.width + offset.width, y: position.height + offset.height)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                            if (position.height + offset.height + 50 > geometry.size.height/4 && position.height + offset.height - 50 <= geometry.size.height/4) {
                                blackDiff = -(position.height + offset.height + 50 - geometry.size.height/4)
                                whiteDiff = 100.0 + (geometry.size.height/4 - (position.height + offset.height + 50.0))
                                print(1)
                            } else if (position.height + offset.height + 50 >= -geometry.size.height/4 && position.height + offset.height - 50 < -geometry.size.height/4) {
                                blackDiff = -(position.height + offset.height + 50 + geometry.size.height/4)
                                whiteDiff = -geometry.size.height/4 - (position.height + offset.height - 50.0)
                                print(3)
                            } else if (position.height + offset.height + 50 >= 0 && position.height + offset.height - 50 <= 0) {
                                blackDiff = 50 - (position.height + offset.height)
                                whiteDiff = -(position.height + offset.height + 50.0)
                                print(2)
                            } else if (position.height + offset.height - 50 > geometry.size.height/4 || (position.height + offset.height + 50 < 0 && position.height + offset.height - 50 > -geometry.size.height/4)) {
                                blackDiff = 100.0
                                whiteDiff = 0.0
                                print(5)
                            }
                            else {
                                blackDiff = 0.0
                                whiteDiff = 100.0
                                print(4)
                            }
                        }
                        .onEnded { _ in
                            position.width += offset.width
                            position.height += offset.height
                            offset = CGSize.zero
                        }
                )
                
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
