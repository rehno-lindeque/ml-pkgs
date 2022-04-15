{
  stdenv,
  lib,
  fetchurl,
  autoreconfHook,
  pkgconfig,
  gtk_doc,
  intltool,
  audit,
  glib,
  libusb,
  libxml2,
  wrapGAppsHook,
  gst_all ? null,
  libnotify ? null,
  gnome3 ? null,
  enableUsb ? true,
  enablePacketSocket ? true,
  enableViewer ? true,
  enableGstPlugin ? true,
  enableCppTest ? false,
  enableFastHeartbeat ? false,
  enableAsan ? false,
}:
assert enableGstPlugin -> gst_all != null;
assert enableViewer -> enableGstPlugin;
assert enableViewer -> lib.versionAtLeast (lib.getVersion gst_all.gstreamer) "1.0";
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

    nativeBuildInputs =
      [
        autoreconfHook
        pkgconfig
        intltool
        gtk_doc
      ]
      ++ lib.optional enableViewer wrapGAppsHook;

    buildInputs = with gst_all;
      [glib libxml2]
      ++ lib.optional enableUsb libusb
      ++ lib.optional enablePacketSocket audit
      ++ lib.optionals (enableViewer || enableGstPlugin) [gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad]
      ++ lib.optionals enableViewer [libnotify gnome3.gtk3 gnome3.defaultIconTheme];

    preAutoreconf = ''./autogen.sh'';

    configureFlags =
      lib.optional enableUsb "--enable-usb"
      ++ lib.optional enablePacketSocket "--enable-packet-socket"
      ++ lib.optional enableViewer "--enable-viewer"
      ++ lib.optional enableGstPlugin
      (
        if gst_all != null && lib.versionAtLeast (lib.getVersion gst_all.gstreamer) "1.0"
        then "--enable-gst-plugin"
        else "--enable-gst-0.10-plugin"
      )
      ++ lib.optional enableCppTest "--enable-cpp-test"
      ++ lib.optional enableFastHeartbeat "--enable-fast-heartbeat"
      ++ lib.optional enableAsan "--enable-asan";

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
      license = lib.licenses.lgpl2;
      maintainers = [];
      platforms = lib.platforms.unix;
    };
  }
