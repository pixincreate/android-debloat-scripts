#!/bin/bash
# Motorola G57 Power - Bloatware Removal Script

echo "=========================================="
echo "Motorola G57 Power - Bloatware Remover"
echo "=========================================="
echo ""

if ! command -v adb &> /dev/null; then
    echo "Error: ADB not found. Install Android SDK Platform Tools."
    exit 1
fi

echo "Waiting for device..."
adb wait-for-device

DEVICE_STATE=$(adb get-state 2>&1 || true)
if [[ "$DEVICE_STATE" == "unauthorized" ]]; then
    echo "Error: Device not authorized. Check phone for USB debugging permission."
    exit 1
elif [[ "$DEVICE_STATE" == "no device" ]]; then
    echo "Error: No device connected."
    exit 1
fi

echo "Device connected. Starting bloatware removal..."
echo ""

MOTOROLA_APPS=(
    "com.motorola.smartfeed"
    "com.motorola.brapps"
    "com.motorola.installer"
    "com.motorola.mobiledesktop.core"
    "com.motorola.mobiledesktop"
    "com.motorola.demo"
    "com.motorola.demo.env"
    "com.motorola.help.extlog"
    "com.motorola.help"
    "com.motorola.aiservices"
    "com.motorola.moto"
    "com.motorola.lifetimedata"
    "com.motorola.launcherconfig"
    "com.motorola.gamemode"
    "com.motorola.spaces"
    "com.motorola.motocare"
    "com.motorola.motocare.internal"
    "com.motorola.motocit"
    "com.motorola.mykey"
    "com.motorola.slpc_sys"
    "com.motorola.iotservice"
    "com.motorola.livewallpaper3"
    "com.motorola.genie"
    "com.motorola.timeweatherwidget"
    "com.motorola.wifi.motowifimetrics"
    "com.motorola.enterprise.adapter.service"
    "com.motorola.dimo"
    "com.motorola.autoinstallext"
    "com.motorola.motcameradesktop"
    "com.motorola.contacts.preloadcontacts"
    "com.motorola.easyprefix"
    "com.dti.motorola"
    "com.motorola.paks.notification"
    "com.motorola.paks"
    "com.aura.oobe.motorola"
    "com.orange.aura.oobe"
    "com.motorola.bug2go"
    "com.qualcomm.qti.qms.service.telemetry"
    "com.motorola.omadm.vzw"
    "com.motorola.appdirectedsmsproxy"
    "com.motorola.android.overlay.payjoy"
)

THIRD_PARTY_APPS=(
    "com.indus.appstore"
    "com.orange.update"
    "com.ironsource.appcloud.oobe.hutchinson"
    "com.motorola.att.phone.extensions"
    "com.glance.lockscreenM"
    "com.inmobi.weather"
    "com.handmark.expressweather"
    "id.mjs.etalaseapp"
    "com.ertanto.kompas.official"
    "com.facebook.services"
    "com.facebook.appmanager"
    "com.facebook.katana"
    "com.facebook.system"
    "com.instagram.android"
    "com.amazon.appmanager"
    "com.payjoy.access"
    "com.zte.iptvclient.android.idmnc"
    "com.taboola.mip"
    "android.autoinstalls.config.motorola.layout"
    "de.telekom.tsc"
    "com.lenovo.lsf.user"
    "com.verizon.loginengine.unbranded"
    "com.vzw.apnlib"
    "com.vzw.apnservice"

)

GOOGLE_APPS=(
    "com.android.chrome"
    "com.google.android.apps.youtube.music"
    "com.google.mainline.telemetry"
    "com.google.mainline.adservices"
    "com.google.android.apps.carrier.carrierwifi"
    "com.google.android.youtube"
    "com.google.android.contactkeys"
    "com.google.android.safetycore"
    "com.google.ar.core"
    "com.google.ambient.streaming"
    "com.google.android.adservices.api"
    "com.google.android.apps.tachyon"
    "com.google.android.apps.turbo"
    "com.google.android.apps.wellbeing"
    "com.google.android.apps.docs"
    "com.google.android.apps.nbu.files"
    "com.google.android.apps.setupwizard.searchselector"
    "com.google.android.apps.bard"
    "com.google.android.apps.messaging"
    "com.google.android.videos"
    "com.google.android.gm"
    "com.google.android.as.oss"
    "com.google.android.deskclock"
    "com.google.android.projection.gearhead"
    "com.google.android.calendar"
    "com.google.android.calculator"
    "com.google.android.apps.photos"
    "com.google.android.feedback"
    "com.google.android.googlequicksearchbox"
    "com.google.android.partnersetup"
    "com.google.android.onetimeinitializer"
    "com.android.hotwordenrollment.okgoogle"
    "com.android.hotwordenrollment.xgoogle"
    "com.google.android.gms.location.history"
    "com.google.android.keep"
)

uninstall_app() {
    local pkg="$1"
    local result

    result=$(adb shell pm uninstall --user 0 "$pkg" 2>&1)

    if [[ "$result" == *"No such package"* ]]; then
        echo "  [NOT FOUND] $pkg"
    elif [[ "$result" == *"Failure"* ]]; then
        echo "  [FAILED]   $pkg"
    else
        echo "  [UNINSTALLED] $pkg"
    fi
}

echo "Removing Motorola bloatware..."
for app in "${MOTOROLA_APPS[@]}"; do
    uninstall_app "$app"
done

echo ""
echo "Removing third-party bloatware..."
for app in "${THIRD_PARTY_APPS[@]}"; do
    uninstall_app "$app"
done

echo ""
echo "Removing Google bloatware..."
for app in "${GOOGLE_APPS[@]}"; do
    uninstall_app "$app"
done

echo ""
echo "=========================================="
echo "Done! Some apps may require reboot."
echo "To verify, run: adb shell pm list packages -d"
echo "=========================================="
