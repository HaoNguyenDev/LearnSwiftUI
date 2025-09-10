//
//  DownloadView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 9/9/25.
//

import SwiftUI

// MARK: - DownloadView

/// SwiftUI user interface for displaying the list of downloads.
struct DownloadView: View {
    
    @StateObject private var viewModel = DownloadViewModel()
    @State private var urlString = ""
    @State private var showInvalidURLAlert = false
    @State private var taskToDelete: DownloadTask? // To confirm deletion
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter URL to download", text: $urlString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button("Download") {
                        if URL(string: urlString) != nil {
                            viewModel.startDownload(urlString: urlString)
                            urlString = ""
                        } else {
                            showInvalidURLAlert = true
                        }
                    }
                    .padding(.horizontal)
                    .buttonStyle(.borderedProminent)
                }
                .padding(.top)
                
                if viewModel.downloadTasks.isEmpty {
                    Text("No download tasks available.")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.downloadTasks.reversed()) { task in
                            DownloadRow(task: task, onDelete: {
                                taskToDelete = task
                            })
                            .environmentObject(viewModel)
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Download Manager")
            .alert("Invalid URL", isPresented: $showInvalidURLAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please enter a valid URL to download.")
            }
            .confirmationDialog("Confirm Deletion", isPresented: Binding(
                get: { taskToDelete != nil },
                set: { if !$0 { taskToDelete = nil } }
            )) {
                Button("Delete", role: .destructive) {
                    if let task = taskToDelete {
                        viewModel.deleteDownload(for: task)
                    }
                    taskToDelete = nil
                }
                Button("Cancel", role: .cancel) {
                    taskToDelete = nil
                }
            } message: {
                Text("Are you sure you want to delete this task?")
            }
            .onAppear {
                // No need to loadTasks as DownloadManager loads them in init
            }
        }
    }
}

// MARK: - DownloadRow

/// A single row in the download list.
struct DownloadRow: View {
    @ObservedObject var task: DownloadTask
    @EnvironmentObject var viewModel: DownloadViewModel
    let onDelete: () -> Void // Callback to trigger confirmationDialog
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(task.fileName)
                .font(.headline)
                .fontWeight(.medium)
            
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
                } else if task.downloadedBytes <= 0 {
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
                    Text("Pause")
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                
                Button(action: {
                    viewModel.cancelDownload(for: task)
                }) {
                    Text("Cancel")
                        .font(.caption)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            } else if task.state == .paused {
                Button(action: {
                    viewModel.resumeDownload(for: task)
                }) {
                    Text("Resume")
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                
                Button(action: {
                    viewModel.cancelDownload(for: task)
                }) {
                    Text("Cancel")
                        .font(.caption)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            } else if task.state == .pending {
                Button(action: {
                    viewModel.cancelDownload(for: task)
                }) {
                    Text("Cancel")
                        .font(.caption)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            } else if task.state == .completed || task.state == .cancelled {
                Button(action: {
                    onDelete()
                }) {
                    Text("Delete")
                        .font(.caption)
                        .foregroundColor(.purple)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            } else if task.state == .failed {
                Button(action: {
                    viewModel.resumeDownload(for: task)
                }) {
                    Text("Retry")
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                
                Button(action: {
                    onDelete()
                }) {
                    Text("Delete")
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
