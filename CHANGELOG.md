+# Change Log
+All notable changes to this project will be documented in this file.
+This project adheres to [Semantic Versioning](http://semver.org/).
+This changelog adheres to [Keep a
CHANGELOG](http://keepachangelog.com/).

## Unreleased

### Fixed
- [TT-3116] Fix case where scheme (http/https) not in ecom engine host
- [ROT-44] Manually serialise the payload parameters so we get a format that
  is compatible with rails (when using nested arrays)

## 0.4.0

### Added
- [TT-2897] Add a tag to retrieve javascript bundles

## 0.3.1

### Changed
- [TT-2781] Address the issue with HTTPS

## 0.3.0

### Added
- [TT-1945] Add search routes
- [DO-29] Add a tag for invalidating Javascript cache

## 0.2.0

### Changed
- [TT-1567] Hack for exclusive products fixed by storing additional details
  (Requires CMS to use ajax login)
- [TT-1583] Rename to radiant-ecom_engine-extension
  (requires ecom-engine)

### Removed
- [TT-938] Remove deprecated secure-pay url

### Updated
- [TT-1377] Maintain the files original status code when proxying
- [TT-1340] Proxy more content-types as file
