import Foundation

// MARK: FileExtension
enum FileExtension: String {
    case png = "png"
    case jpg = "jpg"
    case mp4 = "mp4"
}

// MARK: DownloadModel Protocol
protocol DownloadModelProtocol: Identifiable {
    var title: String { get }
    var url: URL { get }
    var fileExtension: FileExtension { get }
}

// MARK: Movie
struct Movie: DownloadModelProtocol {
    var id = UUID()
    var title: String
    var url: URL
    var fileExtension: FileExtension = .mp4
}

// MARK: Image
struct Image: DownloadModelProtocol {
    var id = UUID()
    var title: String
    var url: URL
    var fileExtension: FileExtension = .png
}

// MARK: - DownloadTask model
class DownloadTask {
    let model: any DownloadModelProtocol
    var progress: Double = 0
    var isFinished: Bool = false
    var resumeData: Data? = nil
    var destinationURL: URL? = nil
    init(model: any DownloadModelProtocol) {
        self.model = model
    }
}

// MARK: - DownloadOperation
class DownloadOperation: Operation, @unchecked Sendable {
    private let task: DownloadTask
    private var urlSessionTask: URLSessionDownloadTask?
    private var session: URLSession?
    internal var downloadTask: DownloadTask { task }
    
    init(task: DownloadTask) {
        self.task = task
    }
    
    override func main() {
        if isCancelled { return }
        
        session = URLSession(configuration: .default)
        startDownload()
        
        /// Keep thread wait until task `completed or failed`
        while !task.isFinished && !isCancelled {
            RunLoop.current.run(mode: .default, before: Date(timeIntervalSinceNow: 0.1))
        }
    }
    
    private func startDownload() {
        if let resumeData = task.resumeData {
            urlSessionTask = session?.downloadTask(withResumeData: resumeData, completionHandler: handleCompletion)
        } else {
            urlSessionTask = session?.downloadTask(with: task.model.url, completionHandler: handleCompletion)
        }
        urlSessionTask?.resume()
    }
    
    private func handleCompletion(localURL: URL?, response: URLResponse?, error: Error?) {
        if let error = error as NSError?,
           error.domain == NSURLErrorDomain,
           error.code == NSURLErrorCancelled {
            return
        }
        
        guard let localURL = localURL else {
            print("❌ Failed: \(self.task.model.url)")
            self.task.isFinished = true
            return
        }
        
        /// File destination: `Application Support/Downloads`
        let downloadsDir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            .appendingPathComponent("Downloads", isDirectory: true)
        
        try? FileManager.default.createDirectory(at: downloadsDir, withIntermediateDirectories: true)
        
        //        let destinationURL = downloadsDir.appendingPathComponent(task.model.title + task.model.fileType.rawValue)
        let destinationURL = FileManager.downloadsDirectory
            .appendingPathComponent(task.model.title)
            .appendingPathExtension(task.model.fileExtension.rawValue)
        do {
            /// Delete file if existing
            try? FileManager.default.removeItem(at: destinationURL)
            try FileManager.default.moveItem(at: localURL, to: destinationURL)
            self.task.destinationURL = destinationURL
            print("✅ Saved to: \(destinationURL.path)")
        } catch {
            print("❌ Save failed: \(error.localizedDescription)")
        }
        
        self.task.isFinished = true
    }
    
    
    // MARK: - Control
    func pause() {
        urlSessionTask?.cancel { [weak self] data in
            self?.task.resumeData = data
        }
    }
    
    func resume() {
        guard task.resumeData != nil else { return }
        startDownload()
    }
    
    override func cancel() {
        super.cancel()
        urlSessionTask?.cancel()
    }
}

class DownloadManager {
    @MainActor static let shared = DownloadManager()
    
    private let queue: OperationQueue
    private var operations: [URL: DownloadOperation] = [:]
    
    private init() {
        queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3
    }
    
    func addDownload(model: any DownloadModelProtocol) {
        let task = DownloadTask(model: model)
        let op = DownloadOperation(task: task)
        operations[model.url] = op
        queue.addOperation(op)
    }
    
    func pauseDownload(url: URL) {
        operations[url]?.pause()
    }
    
    func resumeDownload(url: URL) {
        operations[url]?.resume()
    }
    
    func cancelAll() {
        queue.cancelAllOperations()
        operations.removeAll()
    }
    
    func getDownloadList() -> [DownloadTask] {
        return operations.values.map { $0.downloadTask }
    }
    
    func getDownloadedFiles() -> [URL] {
        let downloadsDir = FileManager.downloadsDirectory
        let files = (try? FileManager.default.contentsOfDirectory(
            at: downloadsDir,
            includingPropertiesForKeys: nil
        )) ?? []
        return files
    }
    
}

extension DownloadManager {
    /// Delete file base on `title`
    func deleteFile(model: any DownloadModelProtocol) {
        let fileURL = FileManager.downloadsDirectory
            .appendingPathComponent(model.title)
            .appendingPathExtension(model.fileExtension.rawValue)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(at: fileURL)
                print("🗑️ Deleted: \(fileURL.lastPathComponent)")
            } catch {
                print("❌ Delete failed: \(error.localizedDescription)")
            }
        } else {
            print("⚠️ File not found: \(model.title).\(model.fileExtension.rawValue)")
        }
    }
}


extension FileManager {
    static var downloadsDirectory: URL {
        let appSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let downloads = appSupport.appendingPathComponent("Downloads", isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: downloads.path) {
            try? FileManager.default.createDirectory(at: downloads, withIntermediateDirectories: true)
        }
        return downloads
    }
}

// MARK: TEST

let photo1 = Image(title: "Photo1", url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/%22_Shot_From_The_Sky%22_Army_Show_1945_Oak_Ridge_%2824971013612%29.jpg/1920px-%22_Shot_From_The_Sky%22_Army_Show_1945_Oak_Ridge_%2824971013612%29.jpg")!)
let photo2 = Image(title: "Photo2", url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/%22Office_politics%22_suggested_as_official_is_unable_to_account_for_presence_of_employee._Washington%2C_D.C.%2C_March_30._The_old_cry_of_%27Office_politics%27_was_raised_today_as_the_subject_of_a_LCCN2016875351.tif/lossy-page1-1920px-thumbnail.tif.jpg")!)
let photo3 = Image(title: "Photo3", url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/%2271%22_on_St._Patrick%27s_Day._Washington%2C_D.C.%2C_March_17._Justice_Pierce_Butler%2C_71_years_old_today_celebrates_his_birthday_by_taking_his_morning_walk%2C_snapped_while_leaving_his_home_on_19th_LCCN2016871374.jpg/1024px-thumbnail.jpg")!)

let downloadManager = DownloadManager.shared

@MainActor
func testDowloadFile() {
    let queue = DispatchQueue(label: "example.com.downloadQueue")
    
    queue.sync {
        downloadManager.addDownload(model: photo1)
    }
    
    queue.sync {
        downloadManager.addDownload(model: photo2)
    }
    
    queue.sync {
        downloadManager.addDownload(model: photo3)
    }
    
    queue.sync {
        print("\(downloadManager.getDownloadedFiles())")
    }
}

//testDowloadFile()

@MainActor
func testDeleteFile(model: any DownloadModelProtocol) {
    let queue = DispatchQueue(label: "example.deleteFileQueue")
    queue.sync {
        downloadManager.deleteFile(model: Movie(title: model.title, url: model.url, fileExtension: model.fileExtension))
    }
    queue.sync {
        let downloadedFiles = downloadManager.getDownloadedFiles()
        if downloadedFiles.isEmpty {
            print("🚨 Download folder is empty!")
        } else {
            print("List of downloaded files:")
            for file in downloadedFiles {
                print("📂 \(file.lastPathComponent)")
                print("📂 \(file.pathExtension)")
                print("📂 \(file.pathComponents)")
            }
        }
        
    }
}

testDeleteFile(model: Image(title: "Photo3", url: URL(string: "url")!))
