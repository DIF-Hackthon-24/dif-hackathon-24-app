enum DocumentMaxSizes {
  KYB_MAX_DOCUMENT_SIZE,
  KYC_MAX_DOCUMENT_SIZE,
  ORGANIZATION_IMAGE_LOGO_MAX_SIZE,
}

extension DocumentMaxSizesInfo on DocumentMaxSizes {
  int value() {
    switch (this) {
      case DocumentMaxSizes.KYB_MAX_DOCUMENT_SIZE:
        return 50000000; // 50MB (in bytes)
      case DocumentMaxSizes.KYC_MAX_DOCUMENT_SIZE:
        return 10000000; // 10MB (in bytes)
      case DocumentMaxSizes.ORGANIZATION_IMAGE_LOGO_MAX_SIZE:
        return 1000000; // 1MB (in bytes)
    }
  }
}
