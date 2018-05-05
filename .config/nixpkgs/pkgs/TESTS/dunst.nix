{ stdenv, fetchFromGitHub, fetchpatch, callPackage
, pkgconfig, which, perl, libXrandr
, cairo, dbus, systemd, glib, libX11, libXScrnSaver
, libXinerama, libnotify, libxdg_basedir, pango, xproto
}:

let
  librsvg = (callPackage ./librsvg.nix {});
  gdk_pixbuf = (callPackage ./pixbuf.nix {});
in stdenv.mkDerivation rec {
  name = "dunst-fixes-new-${version}";
  version = "1.3.1";

  src = fetchFromGitHub {
    owner = "dunst-project";
    repo = "dunst";
    rev = "6c126eef32f7b459c47b4066b3bfc33bcb70e81e";
    sha256 = "10drpgxc3d63xf89xr812qnvp8mgrkysjaa1nyph35fgpdk2y627";
  };

  nativeBuildInputs = [ perl pkgconfig which systemd ];

  buildInputs = [
    cairo dbus glib libX11 libXScrnSaver
    libXinerama libnotify libxdg_basedir pango xproto librsvg libXrandr
    gdk_pixbuf
  ];

  outputs = [ "out" "man" ];

  makeFlags = [
    "debug"
    "PREFIX=$(out)"
    "VERSION=$(version)"
    "SERVICEDIR_DBUS=$(out)/share/dbus-1/services"
    "SERVICEDIR_SYSTEMD=$(out)/lib/systemd/user"
  ];

  meta = with stdenv.lib; {
    description = "Lightweight and customizable notification daemon";
    homepage = https://dunst-project.org/;
    license = licenses.bsd3;
    # NOTE: 'unix' or even 'all' COULD work too, I'm not sure
    platforms = platforms.linux;
    maintainers = [ maintainers.domenkozar ];
  };
}