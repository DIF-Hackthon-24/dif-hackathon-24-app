enum MediaDownloadStatus {
  undefined,
  downloadEnqueued,
  downloadRunning,
  downloadComplete,
  downloadFailed,
  downloadCancelled,
  downloadPaused,
  enqueueFailed,    // To represent any error in the download enqueue.
  downloadPending,  // To mark an item to be downloaded in the next nun.
  deletePending,    // To mark item eligible for delete multimedia file associated with it.
  deleteDone,       // To mark item that multimedia file is deleted. So record in DB can also be deleted.
}