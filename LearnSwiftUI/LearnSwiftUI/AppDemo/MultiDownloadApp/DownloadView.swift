//
//  DownloadView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/9/25.
//

import SwiftUI

// MARK: - DownloadView

/// Giao diện người dùng SwiftUI để hiển thị danh sách tải xuống.
struct DownloadView: View {
    
    @StateObject private var viewModel = DownloadViewModel()
    @State private var urlString = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Nhập URL để tải xuống", text: $urlString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button("Tải") {
                        viewModel.startDownload(urlString: urlString)
                        urlString = ""
                    }
                    .padding(.horizontal)
                    .buttonStyle(.borderedProminent)
                }
                .padding(.top)
                
                List {
                    ForEach(viewModel.downloadTasks.reversed()) { task in
                        DownloadRow(task: task)
                            .environmentObject(viewModel)
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Quản lý Tải xuống")
            .onAppear {
                viewModel.loadTasks()
            }
        }
    }
}

// MARK: - DownloadRow

/// Một hàng riêng lẻ trong danh sách tải xuống.
struct DownloadRow: View {
    @ObservedObject var task: DownloadTask
    @EnvironmentObject var viewModel: DownloadViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(task.url.lastPathComponent)
                .font(.headline)
            
            if task.state == .downloading || task.state == .paused || task.state == .pending {
                HStack {
                    ProgressView(value: min(max(task.progress, 0), 1))
                        .progressViewStyle(.linear)
                    Text(String(format: "%.0f%%", min(max(task.progress, 0), 1) * 100))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            HStack {
                Text(task.state.rawValue)
                    .font(.caption)
                    .foregroundColor(colorForState(task.state))
                
                Spacer()
                
                if task.state == .downloading || task.state == .paused || task.state == .pending {
                    Text(task.downloadedProgressFormatted)
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else if task.state == .completed {
                    Text(task.fileSizeFormatted)
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else if task.totalBytes <= 0 {
                    Text("Unknown size")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            actionButtons
        }
        .padding(.vertical, 8)
    }
    
    @ViewBuilder
    private var actionButtons: some View {
        HStack {
            if task.state == .downloading {
                Button(action: {
                    viewModel.pauseDownload(for: task)
                }) {
                    Text("Tạm dừng")
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                
                Button(action: {
                    viewModel.cancelDownload(for: task)
                }) {
                    Text("Hủy")
                        .font(.caption)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            } else if task.state == .paused {
                Button(action: {
                    viewModel.resumeDownload(for: task)
                }) {
                    Text("Tiếp tục")
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                
                Button(action: {
                    viewModel.cancelDownload(for: task)
                }) {
                    Text("Hủy")
                        .font(.caption)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            } else if task.state == .pending {
                Button(action: {
                    viewModel.cancelDownload(for: task)
                }) {
                    Text("Hủy")
                        .font(.caption)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            } else if task.state == .completed || task.state == .cancelled {
                Button(action: {
                    viewModel.deleteDownload(for: task)
                }) {
                    Text("Xóa")
                        .font(.caption)
                        .foregroundColor(.purple)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            } else if task.state == .failed {
                Button(action: {
                    viewModel.resumeDownload(for: task) // Retry bằng resume nếu có data, else start new
                }) {
                    Text("Thử lại")
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                
                Button(action: {
                    viewModel.deleteDownload(for: task)
                }) {
                    Text("Xóa")
                        .font(.caption)
                        .foregroundColor(.purple)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }
        }
    }
    
    private func colorForState(_ state: DownloadState) -> Color {
        switch state {
        case .downloading:
            return .blue
        case .completed:
            return .green
        case .paused:
            return .orange
        case .failed:
            return .red
        case .cancelled:
            return .gray
        case .pending:
            return .secondary
        }
    }
}

// Preview
struct DownloadView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadView()
    }
}
