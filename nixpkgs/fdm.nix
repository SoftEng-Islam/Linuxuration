pkgs.stdenv.mkDerivation {
  pname = "freedownloadmanager";
  version = "6.24.2"; # Update to the version you're using
  src = pkgs.fetchurl {
    url = "https://files2.freedownloadmanager.org/6/latest/freedownloadmanager.deb"; # Update this URL if necessary
    sha256 = "1apsy8j7qbb81r09gggkrdfa8k04s0habsk0gncmwwqq283k15f3"; # Replace with the correct hash
  };
  nativeBuildInputs = [ pkgs.dpkg ];
  installPhase = ''
    mkdir -p $out/bin
    # Extract the .deb file
    dpkg -x $src $out
    # Copy the binary to the bin directory
    cp -r $out/usr/bin/* $out/bin/
  '';
}
