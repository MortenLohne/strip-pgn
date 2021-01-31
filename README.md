# strip-pgn
Remove unnecessary information from [PGN](https://en.wikipedia.org/wiki/Portable_Game_Notation) files.

# Usage

## Synopsis
```
strip-pgn {--strip-comments|--move-list|--move-strings| }
```
## Description

`strip-pgn` operates in 3 different modes, depending on the command-line argument.

The PGN itself is read from standard input.

* `--strip-comments`: Remove all comments.
* `--move-list`: Remove all comments, move numbers and tag pairs, leaving only the move list.
* `--move-strings`: The same as `--move-list`, but encloses each move in quotation marks, and separates them by commas.

# Build

Using [GHC](https://www.haskell.org/ghc/):
```
ghc strip-pgn.hs -O2
```
