//
//  ContentView.swift
//  SwiftUI_ScrollToTop
//
//  Created by 김선중 on 2021/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationTitle("티스토리")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    // 3.
    @State private var ScrollViewOffset: CGFloat = 0
    
    var body: some View {
        // 1.
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack(spacing: 20) {
                ForEach(1...20, id:\.self) { i in
                    // 샘플 row 생성
                    HStack(spacing: 10) {
                        Circle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 70, height: 70)
                        VStack(alignment:.leading, spacing: 5) {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 20)
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 20)
                                .padding(.trailing, 150)
                        }
                        
                    }
                }
                
            }
            .padding()
            // 2.
            //ScrollView offset 가져오기
            .overlay(
               
                // 4.
                //GeometrtReader를 사용하여 ScrollView offset 값을 가져옴
                GeometryReader{ proxy -> Color in
                    
                    let offset = proxy.frame(in: .global).minY
                    
                    print(offset)
                    
                    return Color.clear
                }
                .frame(width: 0, height: 0)
                ,alignment: .top
            )
        })
    }
}
