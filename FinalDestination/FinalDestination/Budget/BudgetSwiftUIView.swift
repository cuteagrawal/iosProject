//
//  BudgetSwiftUIView.swift
//  FinalDestination
//
//  Created by Jay Patel on 2024-04-09.
//

import SwiftUI
import Charts

// AppDelegate instance to get the viewBudget property
let mainDelegate = UIApplication.shared.delegate as! AppDelegate

// Destination value from the viewBudget property
let destination = mainDelegate.viewBudget?.destination

// A method to move from SwiftUI to ViewController
struct YourViewControllerViewWithStoryboard: UIViewControllerRepresentable {
    // Creates a UIViewController instance from the storyboard
    func makeUIViewController(context: Context) -> ViewController {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController") as? ViewController else {
            fatalError("ViewController not implemented in storyboard")
        }
        return viewController
    }

    // Updates the existing UIViewController instance with new data
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {

    }
}

// SwiftUI View representing the budget overview
struct BudgetSwiftUIView: View {
    
    // Data and logic related to the budget
    @StateObject var viewModel = BudgetViewModel()
    
    // Variable to control navigation to another view controller
    @State private var navigateToViewController = false

    var body: some View {

        NavigationView {
            VStack {
                // Text displaying the destination
                Text(destination ?? "")
                    .font(.title)
                // Pie Chart displaying budget data
                PieChartView(dataPoints: viewModel.pieChartData)
                    .frame(width: 400, height: 530)
                    .padding()
            }
            .navigationBarItems(
                leading: (
                    Button(action: {
                        // Action to set navigateToViewController to true
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
                // NavigationLink to navigate to another view
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

// Managing data and logic related to the budget
class BudgetViewModel: ObservableObject {
    // Property for storing pie chart data
    @Published var pieChartData: [(label: String, value: Double)] = []

    // Initializer
    init() {
        loadData()
        NotificationCenter.default.addObserver(self, selector: #selector(viewBudgetDidChange), name: NSNotification.Name("ViewBudgetDidChange"), object: nil)
    }

    // Deinitializer
    deinit {
        // Remove observer
        NotificationCenter.default.removeObserver(self)
    }

    // Selector method to handle viewBudget changes
    @objc func viewBudgetDidChange() {
        // Reload data
        loadData()
    }

    // Method to load budget data
    func loadData() {
        // Access viewBudget from AppDelegate
        if let budget = mainDelegate.viewBudget {
            // Populate pieChartData
            pieChartData = [
                ("Transport", budget.transportation ?? 0),
                ("Food", budget.food ?? 0),
                ("Accommodation", budget.accommodation ?? 0),
                ("Other", budget.other ?? 0)
            ]
        }
    }
}

// SwiftUI View representing a Pie Chart
struct PieChartView: View {
    // DataPoints for the Pie Chart
    var dataPoints: [(label: String, value: Double)]
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Draw Pie Chart
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
    
    // Calculate angle for a given data point index
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

// Shape representing a slice of a Pie Chart
struct PieSlice: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    // Create path for Pie Slice
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

// Array of colors for the Pie Chart
let colors: [Color] = [.blue, .green, .orange, .red, .purple, .yellow, .pink, .gray, .cyan]

// Extension for Angle to add angles and keep them within 360 degrees
extension Angle {
    func additiveRounded(degrees: Double) -> Angle {
        let newDegrees = (degrees + self.degrees).truncatingRemainder(dividingBy: 360)
        return Angle(degrees: newDegrees)
    }
}
