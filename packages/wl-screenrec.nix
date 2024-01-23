{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  ffmpeg,
  wayland,
  libdrm,
  ...
}:
rustPlatform.buildRustPackage rec {
  pname = "wl-screenrec";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "russelltg";
    repo = pname;
    rev = "v0.1.2";
    hash = "sha256-Ol4/e/EETA8MXqiyCzcV6s4DjFf6ldUortOrzJ80/Ko=";
  };

  cargoHash = "sha256-9pITjj01pLCxlVgOPWguP/20P257fxdegOfmoSSW4p0=";

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    ffmpeg
    wayland
    libdrm
  ];

  doCheck = false;

  meta = with lib; {
    description = "High performance screen recorder for wlroots Wayland.";
    homepage = "https://github.com/russellth/wl-screenrec";
    license = licenses.asl20;
    platforms = platforms.linux;
    mainProgram = pname;
    maintainers = [];
  };
}
