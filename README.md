# Arkitekt

Arkitekt is a bash script for installing and configuring a new Linux
installation.

## Installation

Clone the repo.

```bash
git clone https://github.com/notoriouslogank/arkitekt.git
```

## Usage

### Note 
Arkitekt should be run with administrator priveleges.  However, you use arkitekt at your own risk.  While arkitekt strives to backup all of the config files before it writes new ones, no guarantee can be made that your installation in particular won't get borked.  If you want to ensure you won't lose a config file, we recommend manually backing up said files.

### Running

```bash
cd src

sudo bash arkitekt.sh
```
Script will run from there without user input.

### How Does It Work?



### Functions

#### pkg_check_and_install
Will attempt to first determine the package manager for the current system, then attempts to pull and install packages in manifest.sh.

#### backup_dotfiles
Attempt to created a file.bak copy of each relevant configuration file (whether or not they be true 'dotfiles'); save each .bak into backups directory.

#### make_dotfiles
Create each new configuration file from provided .txt templates.

## Contributing

Pull requests are welcome.  For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)
