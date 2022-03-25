import SwiftUI

struct ExampleView {
  @State var isAnimating: Bool = false
  @State var amount: CGFloat = 0
}

extension ExampleView: View {
  var body: some View {
    VStack {
      HStack {

        Rectangle()
          .stroke(lineWidth: 2)
          .frame(width: 50, height: 50)

        Rectangle()
          .inflate(scale: 1.2, amount: amount)
          .stroke(lineWidth: 2)
          .frame(width: 50, height: 50)
          //.animation(.easeInOut(duration: 3), value: amount)
      }
      .padding()

//      Button {
//        withAnimation {
//          //isAnimating.toggle()
//          amount = 1.0
//        }
//      } label: {
//        Text("Animate")
//      }

      Slider(value: $amount, in: 0...1)


    }
  }
}

struct ExampleView_Previews: PreviewProvider {
  static var previews: some View {
      ExampleView()
  }
}
