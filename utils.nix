rec {
  forEachPlatform = block: (forEachPlatformImpl mkPlatformName ({ platform, ... }: block platform));

  forEachPlatformImpl =
    prefixFn: block:
    (forEachLinuxPlatformImpl prefixFn block) // (forEachDarwinPlatformImpl prefixFn block);

  forEachLinuxPlatformImpl = prefixFn: block: {
    "${prefixFn "x86_64" "linux"}" = block {
      arch = "x86_64";
      system = "linux";
      platform = "x86_64-linux";
    };
    "${prefixFn "aarch64" "linux"}" = block {
      arch = "aarch64";
      system = "linux";
      platform = "aarch64-linux";
    };
  };

  forEachDarwinPlatformImpl = prefixFn: block: {
    "${prefixFn "x86_64" "darwin"}" = block {
      arch = "x86_64";
      system = "darwin";
      platform = "x86_64-darwin";
    };
    "${prefixFn "aarch64" "darwin"}" = block {
      arch = "aarch64";
      system = "darwin";
      platform = "aarch64-darwin";
    };
  };

  mkPlatformName = arch: system: "${arch}-${system}";
}
