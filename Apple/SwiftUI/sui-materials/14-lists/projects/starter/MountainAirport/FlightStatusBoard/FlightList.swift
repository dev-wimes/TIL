/// Copyright (c) 2021 Razeware LLC
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
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct FlightList: View {
  var flights: [FlightInformation]
  var nextFlightId: Int{
    // 현지 시간이 현재 시간 또는 그 이후인 첫 번째 항공편을 찾는다.
    guard let flight = flights.first(
      where: {
        $0.localTime >= Date()
      }
    )else{
      // 존재하지 않는 경우 해당 날짜의 마지막 비행 id를 반환
      return flights.last!.id
    }
    return flight.id
  }

  var body: some View {
    ScrollViewReader { scrollProxy in
      List(flights){ flight in
        NavigationLink(
          destination: FlightDetails(flight: flight)) {
          FlightRow(flight: flight)
        }
      }
      .onAppear {
        // 0.05초 delay, onAppear의 내부 위치를 설정이 되는 것을 기다려야 하기 때문
        // 안하면 스크롤 위치가 제대로 안되는 경우가 많음.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
          // ScrollViewProxy의 scrollTo(_:)를 호출하여 다음 항공편의 ID로 스크롤한다.
          // View 중간에 배치하는 것이 보기에 좋으므로 anchor를 center로 설정해준다.
          scrollProxy.scrollTo(nextFlightId, anchor: .center)
        }
      }
    }
  }
}

struct FlightList_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FlightList(
        flights: FlightData.generateTestFlights(date: Date())
      )
    }
  }
}
