# Scripts
To switch to the current home-manager configuration
```
./switch
```

To switch to the current NixOS configuration
```
./rebuild-switch
```

# Home
home-manager configuration is split into separate profiles between macOS and Linux
because macOS puts user directories into `/Users` instead of `/home`. Most of the
configuration lives in the `common` module which is used by both profiles which
introduce minor differences for their respective platforms.