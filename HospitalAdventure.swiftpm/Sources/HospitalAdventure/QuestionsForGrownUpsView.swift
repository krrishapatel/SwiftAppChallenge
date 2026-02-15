import SwiftUI

/// Questions parents can ask - Pedro-inspired collaboration with doctors
struct QuestionsForGrownUpsView: View {
    @State private var isExpanded: Bool = false
    
    private let questions = [
        "When can we go home?",
        "What will the medicine do?",
        "Can I stay with my child?",
        "What should we watch for after?",
        "When can they eat normally?"
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            Button {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text("Questions for Grown-Ups")
                        .font(AppFont.headline)
                        .foregroundStyle(AppColor.textPrimary)
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(AppColor.teal)
                }
                .padding(14)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.white.opacity(0.9))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(AppColor.teal.opacity(0.4), lineWidth: 1)
                        )
                )
            }
            .buttonStyle(.plain)
            
            if isExpanded {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Parents: you can ask the doctor:")
                        .font(AppFont.caption)
                        .foregroundStyle(AppColor.textSecondary)
                    
                    ForEach(questions, id: \.self) { q in
                        HStack(alignment: .top, spacing: 8) {
                            Text("•")
                                .foregroundStyle(AppColor.teal)
                            Text(q)
                                .font(AppFont.body)
                                .foregroundStyle(AppColor.textPrimary)
                        }
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(red: 0.95, green: 0.98, blue: 0.96))
                )
            }
        }
        .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
    }
}
