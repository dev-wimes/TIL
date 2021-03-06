/// Copyright (c) 2022 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI


struct NeuButtonStyle: ButtonStyle{
    let width: CGFloat
    let height: CGFloat
    
    // ButtonStyle은 Button의 label과 사용자가 버튼을 눌렀을 때 Configuration을 통해 label과 Bool값(눌렀으니 true)을 전달한다.
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .opacity(configuration.isPressed ? 0.2:1)
            .foregroundColor(Color(UIColor.systemBlue))
            .background(
                // SwiftUI의 container Group은 무언가를 수행하는 것이 아님.
                // View content를 위한 affordance(행동유동성)임.
                // 예를 들어 VStack에 11개 이상의 View가 있다면 Error남.
                // 이때 Group을 이용해서 10개를 한 그룹, 나머지 1개를 한 그룹으로 만들어서 사용함.
                // 여러개의 content type의 instance들을 단일 unit으로 만들어준다.
                Group{
                    if configuration.isPressed{
                        Capsule()
                            .fill(Color.element)
                            .southEastShadow()
                    }else{
                        Capsule()
                            .fill(Color.element)
                            .northWestShadow()
                    }
                }
            )
    }
}
