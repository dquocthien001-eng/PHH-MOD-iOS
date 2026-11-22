import SwiftUI

struct ContentView: View {
    @State private var tab = "Aimbot"
    @State private var switches: [String: Bool] = [:]
    private let sections: [String: [String]] = [
        "Aimbot": ["Kích hoạt Aim", "Aim đầu", "Aim silent", "Aim Magnet", "Tâm kéo địch", "Aimkill V2.1"],
        "ESP": ["Kích hoạt ESP", "ESP Line", "ESP Box", "ESP Name", "ESP Distance", "ESP Health"],
        "Ẩn màn": ["Kích hoạt ẩn màn", "Ẩn giao diện", "Chế độ riêng tư"]
    ]
    private let cyan = Color(red: 0.04, green: 0.78, blue: 1)
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(red: 0.025, green: 0.035, blue: 0.075).ignoresSafeArea()
                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("PHH MOD").font(.system(size: 23, weight: .black, design: .rounded)).foregroundStyle(cyan)
                        Text("FAKE MENU • DEMO").font(.system(size: 9, weight: .semibold)).foregroundStyle(.gray)
                        Rectangle().fill(cyan.opacity(0.4)).frame(height: 1)
                        ForEach(["Aimbot", "ESP", "Ẩn màn"], id: \.self) { item in
                            Button { withAnimation(.easeInOut(duration: 0.2)) { tab = item } } label: {
                                HStack { Image(systemName: item == "Aimbot" ? "scope" : item == "ESP" ? "eye" : "eye.slash"); Text(item); Spacer() }
                                    .font(.system(size: 14, weight: .semibold)).padding(12)
                                    .background(tab == item ? cyan.opacity(0.2) : Color.clear)
                                    .foregroundStyle(tab == item ? cyan : .white)
                                    .clipShape(RoundedRectangle(cornerRadius: 9))
                            }.buttonStyle(.plain)
                        }
                        Spacer()
                        Text("PHH MOD 1.0.0").font(.system(size: 10)).foregroundStyle(.gray)
                    }
                    .padding(16).frame(width: min(200, geometry.size.width * 0.33))
                    Rectangle().fill(cyan.opacity(0.45)).frame(width: 1)
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text(tab.uppercased()).font(.system(size: 21, weight: .bold)).foregroundStyle(cyan)
                                Spacer()
                                Text("SIMULATION ONLY").font(.system(size: 9, weight: .bold)).foregroundStyle(.gray)
                            }
                            ForEach(sections[tab] ?? [], id: \.self) { name in
                                Toggle(isOn: Binding(get: { switches[name] ?? UserDefaults.standard.bool(forKey: "phh." + name) }, set: { newValue in
                                    switches[name] = newValue
                                    UserDefaults.standard.set(newValue, forKey: "phh." + name)
                                })) {
                                    Text(name).font(.system(size: 14, weight: .medium)).foregroundStyle(.white)
                                }.tint(cyan).padding(.horizontal, 14).padding(.vertical, 8)
                                    .background(Color.white.opacity(0.055))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            Text("Các nút chỉ thay đổi trạng thái giao diện, không tác động vào trò chơi.")
                                .font(.system(size: 10)).foregroundStyle(.gray)
                        }.padding(18)
                    }
                }.overlay(RoundedRectangle(cornerRadius: 14).stroke(cyan.opacity(0.5), lineWidth: 1))
                    .padding(8)
            }
        }
    }
}
