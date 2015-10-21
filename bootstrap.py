#! /usr/bin/python

# (source, destination)
dot_files = [
  ('bashrc', '.bashrc'),
  ('bash_profile', '.bash_profile'),
  ('git/gitconfig', '.gitconfig'),
  ('git/git-completion.sh', '.git-completion.sh'),
  ('git/git-completion.bash', '.git-completion.bash'),
  ('emacs.d', '.emacs.d'),
]

def main():
  from os.path import exists, join, abspath, dirname
  from os.path import isfile, isdir, islink, basename, realpath
  from os import getenv, rename, makedirs, symlink, unlink
  from time import gmtime, strftime

  __dirname = dirname(realpath(__file__))
  __home = getenv('HOME')
  __backup_folder = join(
    __home,
    strftime('.backup_dotfiles_%Y%m%d_%H%M%S', gmtime()))

  files = [
    (join(__dirname, src), join(__home, dest))
    for src, dest in
    dot_files
  ]

  needs_backup = [
    dest for _, dest in
    files
    if isfile(dest) or isdir(dest)
  ]

  # make backup folder if not exists:
  if not exists(__backup_folder):
    makedirs(__backup_folder)

  # move files or folders to backups folder
  for f in needs_backup:
    if islink(f):
      unlink(f)
    else:
      rename(f, join(__backup_folder, basename(f)))

  # make symlinks
  for src, dest in files:
    symlink(src, dest)

if __name__ == '__main__':
  main()
