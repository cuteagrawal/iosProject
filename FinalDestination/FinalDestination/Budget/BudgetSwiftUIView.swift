//
//  BudgetSwiftUIView.swift
//  FinalDestination
//
//  Created by Jay Patel on 2024-04-09.
//

import SwiftUI
import Charts

let mainDelegate = UIApplication.shared.delegate as! AppDelegate
let destination = mainDelegate.viewBudget?.destination

struct YourViewControllerViewWithStoryboard: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController") as? ViewController else {
            fatalError("ViewController not implemented in storyboard")
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: ViewController, context: Context) {

    }
}

struct BudgetSwiftUIView: View {
    @StateObject var viewModel = BudgetViewModel()
    @State private var navigateToViewController = false

    var body: some View {
        let destination = mainDelegate.viewBudget?.destination
        
        return NavigationView {
            VStack {
                Text(destination ?? "")
                    .font(.title)
                // Pie Chart
                PieChartView(dataPoints: viewModel.pieChartData)
                    .frame(width: 400, height: 530)
                    .padding()
            }
            .navigationBarItems(
                leading: (
                    Button(action: {
                        self.navigateToViewController = true
                    }) {
                        Text("Back")
                            .foregroundColor(.blue)
                    }
                ),
                trailing: EmptyView()
            )
            .navigationBarTitle(Text("Budget Overview"), displayMode: .inline)
            .background(
                NavigationLink(destination: YourViewControllerViewWithStoryboard()
                                   .navigationBarBackButtonHidden(true), // Hide back button for this destination
                               isActive: $navigateToViewController) {
                    EmptyView()
                }
                .isDetailLink(false)
            )
            .id(navigateToViewController) // Reset view when navigateToViewController changes
        }
        .onAppear {
            // Load data when the view appears
            viewModel.loadData()
        }
        .onChange(of: navigateToViewController) { _ in
            // Reset view and reload data when navigateToViewController changes
            viewModel.loadData()
        }
    }
}
    
class BudgetViewModel: ObservableObject {
    @Published var pieChartData: [(label: String, value: Double)] = []

    init() {
        loadData()
        NotificationCenter.default.addObserver(self, selector: #selector(viewBudgetDidChange), name: NSNotification.Name("ViewBudgetDidChange"), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func viewBudgetDidChange() {
        loadData()
    }

    func loadData() {
        if let budget = mainDelegate.viewBudget {
            pieChartData = [
                ("Transport", budget.transportation ?? 0),
                ("Food", budget.food ?? 0),
                ("Accommodation", budget.accommodation ?? 0),
                ("Other", budget.other ?? 0)
            ]
        }
    }
}

struct PieChartView: View {
    var dataPoints: [(label: String, value: Double)]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    ForEach(0..<dataPoints.count, id: \.self) { index in
                        PieSlice(startAngle: angle(for: index, dataPoints: dataPoints), endAngle: angle(for: index + 1, dataPoints: dataPoints))
                            .foregroundColor(colors[index % colors.count])
                    }
                }
                .aspectRatio(1, contentMode: .fit)
                .padding(30)
                .frame(width: min(geometry.size.width, geometry.size.height),
                       height: min(geometry.size.width, geometry.size.height))
                
                // Legend with values
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(0..<dataPoints.count, id: \.self) { index in
                        HStack {
                            Circle()
                                .fill(colors[index % colors.count])
                                .frame(width: 10, height: 10)
                            Text("\(dataPoints[index].label): \(String(format: "%.2f", dataPoints[index].value))")
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        .padding(.top, 20)
    }
    
    private func angle(for index: Int, dataPoints: [(label: String, value: Double)]) -> Angle {
        guard !dataPoints.isEmpty else { return .zero }
        
        let total = dataPoints.reduce(0) { $0 + $1.value }
        let normalizedIndex = index % dataPoints.count
        
        var startAngle: Double = 0
        for i in 0..<normalizedIndex {
            startAngle += dataPoints[i].value / total * 360
        }
        
        return Angle(degrees: startAngle)
    }
}

struct PieSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: min(rect.width, rect.height) / 2,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        path.closeSubpath()
        return path
    }
}

let colors: [Color] = [.blue, .green, .orange, .red, .purple, .yellow, .pink, .gray, .cyan]

extension Angle {
    func additiveRounded(degrees: Double) -> Angle {
        let newDegrees = (degrees + self.degrees).truncatingRemainder(dividingBy: 360)
        return Angle(degrees: newDegrees)
    }
}
