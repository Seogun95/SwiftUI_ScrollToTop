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
    
    // 5.
    // 정확한 오프셋을 얻기 위해 startOffset을 가져옴
    @State private var startOffset: CGFloat = 0
    
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
                    
                    //6.
                    DispatchQueue.main.async {
                        //startOffset을 정해줌
                        if startOffset == 0 {
                            self.startOffset = proxy.frame(in: .global).minY
                        }
                        let offset = proxy.frame(in: .global).minY
                        self.ScrollViewOffset = offset - startOffset
                        
                        print(self.ScrollViewOffset)
                    }
                    
                    
                    return Color.clear
                }
                .frame(width: 0, height: 0)
                ,alignment: .top
            )
        })
        // 7.
        // 만약 offset이 450보다 작으면 아래쪽에 버튼을 나타나게함
        .overlay(
            
            // 7-1
            Button(action: {}, label: {
                Image(systemName: "arrow.up")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
            })
            // 7-3
            .padding(.trailing)
            //베젤이 있는 기종이면 패딩 12, 아니라면 0
            .padding(.bottom,getSafeArea().bottom == 0 ? 12 : 0)
           
            //이렇게도 사용가능
            //            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 12 : 0)
            
            // 7-4
            // 만약 scrollViewOffset이 450보다 작으면 투명도를 적용
            .opacity(-ScrollViewOffset > 450 ? 1 : 0)
            .animation(.easeIn)
            
            // 버튼을 오른쪽 하단에 고정
            ,alignment: .bottomTrailing
        )
    }
}

// 7-2
// 베젤이 있는 기종과 없는 고정의 safeAtrea 지정 extension
extension View {
    func getSafeArea()->UIEdgeInsets{
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
