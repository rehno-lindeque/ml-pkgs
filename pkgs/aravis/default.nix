{ stdenv, fetchurl, autoreconfHook, pkgconfig, gtk_doc, intltool
, audit, glib, libusb, libxml2
, wrapGAppsHook
, gst_all ? null
, libnotify ? null
, gnome3 ? null
, enableUsb ? true
, enablePacketSocket ? true
, enableViewer ? true
, enableGstPlugin ? true
, enableCppTest ? false
, enableFastHeartbeat ? false
, enableAsan ? false
}:

assert enableGstPlugin -> gst_all != null;
assert enableViewer -> enableGstPlugin;
assert enableViewer -> stdenv.lib.versionAtLeast (stdenv.lib.getVersion gst_all.gstreamer) "1.0";
assert enableViewer -> libnotify != null;
assert enableViewer -> gnome3 != null;

stdenv.mkDerivation rec {
  pname = "aravis";
  version = "0.5.13";
  name = "${pname}-${version}";

  src = fetchurl {
    url = https://github.com/AravisProject/aravis/archive/ARAVIS_0_5_13.tar.gz;
    sha256 = "1dh9a4xxy78sxbcg7dyh7p4k9j31l4g510138z0cv0rh2xamilkd";
  };

  nativeBuildInputs = [
    autoreconfHook
    pkgconfig
    intltool
    gtk_doc
  ] ++ stdenv.lib.optional enableViewer wrapGAppsHook;

  buildInputs =
    with gst_all;
    [ glib libxml2 ]
    ++ stdenv.lib.optional enableUsb libusb
    ++ stdenv.lib.optional enablePacketSocket audit
    ++ stdenv.lib.optionals (enableViewer || enableGstPlugin) [ gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad ]
    ++ stdenv.lib.optionals (enableViewer) [ libnotify gnome3.gtk3 gnome3.defaultIconTheme ];

  preAutoreconf = ''./autogen.sh'';

  configureFlags =
    stdenv.lib.optional enableUsb "--enable-usb"
      ++ stdenv.lib.optional enablePacketSocket "--enable-packet-socket"
      ++ stdenv.lib.optional enableViewer "--enable-viewer"
      ++ stdenv.lib.optional enableGstPlugin
      (if gst_all != null && stdenv.lib.versionAtLeast (stdenv.lib.getVersion gst_all.gstreamer) "1.0"
          then "--enable-gst-plugin"
          else "--enable-gst-0.10-plugin")
      ++ stdenv.lib.optional enableCppTest "--enable-cpp-test"
      ++ stdenv.lib.optional enableFastHeartbeat "--enable-fast-heartbeat"
      ++ stdenv.lib.optional enableAsan "--enable-asan";

  postPatch = ''
      ln -s ${gtk_doc}/share/gtk-doc/data/gtk-doc.make .
    '';

  doCheck = true;

  meta = {
    description = "Library for video acquisition using Genicam cameras.";
    longDescription = ''
      Implements the gigabit ethernet and USB3 protocols used by industrial cameras.
    '';
    homepage = https://aravisproject.github.io/docs/aravis-0.5;
    license = stdenv.lib.licenses.lgpl2;
    maintainers = [];
    platforms = stdenv.lib.platforms.unix;
  };
}

