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

struct RegisterView: View {
    @EnvironmentObject var userManager: UserManager
    @FocusState var nameFieldFocused: Bool

    var body: some View {
        VStack {
            Spacer()
            
            WelcomeMessageView()
            TextField("Type your name...", text: $userManager.profile.name)
                .focused($nameFieldFocused)
                .submitLabel(.done)
                .onSubmit(registerUser)
                .bordered()
            
            HStack{
                Spacer()
                
                Text("\(userManager.profile.name.count)")
                    .font(.caption)
                    .foregroundColor(
                        userManager.isUserNameValid() ? .green:.red
                    )
                    .padding(.trailing)
            }
            HStack{
                Spacer()
        
                Toggle(isOn: $userManager.settings.rememberUser) {
                    Text("Remember me")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                // Toogle을 적절한 사이즈로 만들어준다.
                // 없으면 Toggle의 content가 전체를 차지하게되서 "Remeber me" Text가 왼쪽끝으로 가게됨.
                .fixedSize()
            }
            Button(action: registerUser) {
                HStack{
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 16, height: 16, alignment: .center)
                    Text("OK")
                        .font(.body)
                        .bold()
                }
            }
            // isUserNameValid가 true이면 버튼이 활성화된다.
            .disabled(!userManager.isUserNameValid())
            .bordered()
            
            Spacer()
        }
        .background(WelcomeBackgroundImage())
        .padding()
    }
}

extension RegisterView{
    func registerUser(){
        nameFieldFocused = false
        // 사용자가 해당 내용을 기억할지 여부를 선택
        if userManager.settings.rememberUser{
            // profile 생성
            userManager.persistProfile()
        }else{
            // 사용자 기본값 초기화(삭제)
            userManager.clear()
        }
        
        // 설정을 저장하고, 사용자를 register되었다고 기록
        userManager.persistSettings()
        userManager.setRegistered()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static let user = UserManager(name: "Wimes")
    static var previews: some View {
        RegisterView()
            .environmentObject(user)
    }
}
