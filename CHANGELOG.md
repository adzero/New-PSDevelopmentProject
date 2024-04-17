# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## In progress

### Fixed

- Fixed default format.ps1xml file which was filed with empty type.ps1xml content.

### Changed

- Changed script structure, deleting function to avoid declaring parameters twice.
- Changed name of git primary branch from master to main. 

### Added

- Added Enums and Classes folders to module source folder. 
- FormatFile and TypeFile switch parameters to add custom display format or type definition files to the project.

## 1.1.0 - 2021-03-02

### Added

- Option to disable automatic inclusion of the root folder corresponding to chosen project type.
- Export of private functions for a module if ExportPrivate variable is set to true at module import.
- Added script comment based help.

### Changed

- Git repository 'dev' branch name changed with 'develop'.

## 1.0.0 - 2018-06-16

First version.