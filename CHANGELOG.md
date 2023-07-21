# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
## [0.4.2] - 2023-07-21

### Fixed

- Backup files no longer hardcoded to personal directories.  


## [0.4.1] - 2023-06-15

### Fixed

- Dotfile backups actually function now
- Require correct permissions for each function call (here's hoping)
- make_banner actually makes a banner now (still can't set it to hostname though)
- Generally cleaned up codebase in terms of formatting, syntax, etc.

### Added

- BAK_DIR variable to allow for custom dotfile backup location

## [0.4.0] - 2023-06-14

### Added

- make_motd function
- make_neofetch function

### Changed

- Creating message of the day no longer done through separate .txt file
- Creating neofetch configuration no longer done through separate .txt file

### Deprecated

- neofetch.txt, ssh_banner.txt, motd

## [0.3.0] - 2023-06-10

### Added

- The following packages are now installed by default: zsh, figlet

### Fixed

- make_banner function actually functions

### Changed

- motd now contains a message

## [0.2.1] - 2023-05-20

### Fixed

- make_banner function added 
- removed unused .txt files

## [0.2.0] - 2023-05-20

### Added

- backups dir for all dotfiles that will get updated
- functionality to create necessary backups

## [0.1.0] - 2023-05-16

### Changed

- src/config/manifest changed to src/config/manifest.sh

### Added

- Functionality to determine which package manager is being used
- Functionality to install system packages
- List of packages to be installed in manifest.sh

## [0.0.2] - 2023-05-16

### Added

- Initial list of applications to be installed in manifest

### Changed

- Began to lay out the logic flow of the script in docs/plans

## [0.0.1] - 2023-05-16

### Added

- This CHANGELOG
- README 
- Boilerplate file structure (src, docs, and config directories)
