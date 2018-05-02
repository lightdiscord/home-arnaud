{ stdenv, fetchFromGitHub, fetchpatch
, pkgconfig, which, perl, libXrandr
, cairo, dbus, systemd, gdk_pixbuf, glib, libX11, libXScrnSaver
, libXinerama, libnotify, libxdg_basedir, pango, xproto, librsvg
}:

stdenv.mkDerivation rec {
  name = "dunst-fixes-${version}";
  version = "1.3.1";

  src = fetchFromGitHub {
    owner = "dunst-project";
    repo = "dunst";
    rev = "534b09cfcdf456fa8736ddd315da6ec0c2a45b08";
    sha256 = "0s8zalcpz040rgsqs12q05m078wshhqjwmghiaahg3p4qr95xcxy";
  };

  nativeBuildInputs = [ perl pkgconfig which systemd ];

  buildInputs = [
    cairo dbus gdk_pixbuf glib libX11 libXScrnSaver
    libXinerama libnotify libxdg_basedir pango xproto librsvg libXrandr
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