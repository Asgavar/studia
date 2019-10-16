# Zadanie 1.
- wielkość bufora {za, wy}pisu -> {o, i}bs
  prawdopodobnie {In, Out}put Buffer Size
- `conv=fdatasync`
- `status=progress`
- `count=N`
- najpierw `bs=1`, potem `skip=N` w bajtach
- `truncate` vs `fallocate`
  - `coreutils` i `util-linux`
