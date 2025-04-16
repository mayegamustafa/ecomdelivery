class FileDownloaderQueue {
  const FileDownloaderQueue({
    required this.id,
    required this.url,
    required this.progress,
    required this.downloadPath,
  });

  final String downloadPath;
  final int id;
  final double? progress;
  final String url;

  FileDownloaderQueue updateProgress(double? progress) {
    return FileDownloaderQueue(
      id: id,
      url: url,
      downloadPath: downloadPath,
      progress: progress,
    );
  }

  FileDownloaderQueue copyWith({
    int? id,
    String? url,
    double? progress,
    String? downloadPath,
  }) {
    return FileDownloaderQueue(
      id: id ?? this.id,
      url: url ?? this.url,
      progress: progress ?? this.progress,
      downloadPath: downloadPath ?? this.downloadPath,
    );
  }
}
