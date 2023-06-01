import Foundation
import SwiftUI
import FLAnimatedImage

//MARK: GIF Background

struct GifView: UIViewRepresentable {
  let animatedView = FLAnimatedImageView()
  var fileName: String

  func makeUIView(context: UIViewRepresentableContext<GifView>) -> UIView {
    let view = UIView()

    let path: String = Bundle.module.path(forResource: fileName, ofType: "gif")!
    let url = URL(fileURLWithPath: path)
    let gifData = try! Data(contentsOf: url)
    let gif = FLAnimatedImage(animatedGIFData: gifData)

    animatedView.animatedImage = gif

    animatedView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(animatedView)

    NSLayoutConstraint.activate(
      [
        animatedView.heightAnchor.constraint(equalTo: view.heightAnchor),
        animatedView.widthAnchor.constraint(equalTo: view.widthAnchor),
      ]
    )

    return view
  }

  func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<GifView>) { }
}

//MARK: SwiftUI animated Background

struct Star: Shape {
    let numberOfLines: Int
    let lineLength: CGFloat
    let lineSpacing: CGFloat
    let fadeLength: CGFloat

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        var path = Path()

        for index in 0..<numberOfLines {
            let yOffset = CGFloat(index) * (lineLength + lineSpacing)
            let startPoint = CGPoint(x: center.x, y: center.y + yOffset)
            let endPoint = CGPoint(x: center.x, y: center.y + yOffset + lineLength)
            let gradient = Gradient(colors: [.clear, .black.opacity(1 - (yOffset / fadeLength))])
            let lineWidth = (fadeLength - yOffset) / fadeLength * 2

            path.move(to: startPoint)
            path.addLine(to: endPoint)
//                .trim(from: 0, to: lineWidth)
//                .stroke(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom), lineWidth: lineWidth)
        }

        return path
    }
}


struct FallingStar: View {
    @State private var isFalling = false
    let delay: Double

    var body: some View {
      Star(numberOfLines: 2, lineLength: 5, lineSpacing: 5, fadeLength: 5)
            .stroke(Color.white, lineWidth: 2)
            .frame(width: 50, height: 50)
            .offset(y: isFalling ? UIScreen.main.bounds.height : -50)
            .animation(Animation.linear(duration: 0.2).repeatForever(autoreverses: false), value: isFalling)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    self.isFalling = true
                }
            }
    }
}

struct StarField: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            ForEach(0..<50) { _ in
                FallingStar(delay: Double.random(in: 0...2))
                    .position(x: CGFloat.random(in: 0..<UIScreen.main.bounds.width),
                              y: CGFloat.random(in: 0..<UIScreen.main.bounds.height))
            }
        }
    }
}
