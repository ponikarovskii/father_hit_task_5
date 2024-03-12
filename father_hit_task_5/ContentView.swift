//
//  ContentView.swift
//  father_hit_task_5
//
//  Created by Антон Поникаровский on 12.03.2024.
//

import SwiftUI

struct Diff {
    var blackDiff: CGFloat = 0.0
    var whiteDiff: CGFloat = 0.0
}

struct ContentView: View {
    @State private var offset = CGSize.zero
    @State private var position = CGSize.zero
    @State private var blackDiff = 0.0
    @State private var whiteDiff = 0.0
    private var squareSize = 100.0
    @State var diff: Diff = Diff()
    
    
    func countOffset(positioniHeight: CGFloat, offsetHeight: CGFloat, geometryHeight: CGFloat) -> Diff {
        var diff: Diff = Diff()
        var topPoint: CGFloat = positioniHeight + offsetHeight - 50.0
        var bottomPoint: CGFloat = positioniHeight + offsetHeight + 50.0
        
        if (bottomPoint > geometryHeight/4 && topPoint <= geometryHeight/4) {
            diff.blackDiff = -(bottomPoint - geometryHeight/4)
            diff.whiteDiff = 100.0 + (geometryHeight/4 - (bottomPoint))
        } else if (bottomPoint >= -geometryHeight/4 && topPoint < -geometryHeight/4) {
            diff.blackDiff = -(bottomPoint + geometryHeight/4)
            diff.whiteDiff = -geometryHeight/4 - (topPoint)
        } else if (bottomPoint >= 0 && topPoint <= 0) {
            diff.blackDiff = 100 - bottomPoint
            diff.whiteDiff = -(bottomPoint)
        } else if (topPoint > geometryHeight/4 || (bottomPoint < 0 && topPoint > -geometryHeight/4)) {
            diff.blackDiff = 100.0
            diff.whiteDiff = 0.0
        }
        else {
            diff.blackDiff = 0.0
            diff.whiteDiff = 100.0
        }
        
        return diff
    }
    
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
                        .clipShape(Rectangle().offset(y: diff.blackDiff))
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                        .clipShape(Rectangle().offset(y: diff.whiteDiff))
                }
                .offset(x: position.width + offset.width, y: position.height + offset.height)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            offset = gesture.translation
                            diff = countOffset(positioniHeight: position.height, offsetHeight: offset.height, geometryHeight: geometry.size.height)
                        }
                        .onEnded { _ in
                            position.width += offset.width
                            position.height += offset.height
                            offset = CGSize.zero
                        }
                )
                
            }
            .onAppear() {
                diff = countOffset(positioniHeight: position.height, offsetHeight: offset.height, geometryHeight: geometry.size.height)
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
