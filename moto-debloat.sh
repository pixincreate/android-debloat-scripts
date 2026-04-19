#!/bin/bash
# Motorola G57 Power - Bloatware Removal Script

echo "=========================================="
echo "Motorola G57 Power - Bloatware Remover"
echo "=========================================="
echo ""

usage() {
    echo "Usage: $0 [uninstall|install|remove-permissions]"
    echo ""
    echo "Commands:"
    echo "  uninstall          Remove bloatware apps (default)"
    echo "  install            Reinstall previously removed apps"
    echo "  remove-permissions Remove privacy-invading permissions from system apps"
    echo ""
    exit 1
}

if [ $# -eq 0 ]; then
    MODE="uninstall"
else
    MODE="$1"
fi

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

echo "Device connected."
echo ""

PERMISSION_TARGET_APPS=(
    "com.google.android.as"
    "com.google.android.youtube"
    "com.google.android.gms"
    "com.android.vending"
    "com.google.android.inputmethod.latin"
    "com.google.android.tts"
    "com.google.android.apps.maps"
    "com.motorols.securityhub"
    "com.motorola.launcher3"
)

PERMISSIONS_TO_REMOVE=(
    "android.permission.ACCESS_COARSE_LOCATION"
    "android.permission.ACCESS_FINE_LOCATION"
    "android.permission.ACCESS_WIFI_STATE"
    "android.permission.ACCESS_BACKGROUND_LOCATION"
    "android.permission.ACCESS_FINE_LOCATION"
    "android.permission.ACCESS_BACKGROUND_LOCATION"
    "android.permission.FINE_LOCATION_SOURCE"
    "android.permission.ACTIVITY_RECOGNITION_SOURCE"
    "android.permission.READ_WRITE_HEALTH_DATA"
    "android.permission.USE_FULL_SCREEN_INTENT"
    "android.permission.READ_HEART_RATE"
    "android.permission.CAMERA"
    "android.permission.RECORD_AUDIO"
    "android.permission.READ_SMS"
    "android.permission.RECEIVE_SMS"
    "android.permission.RECEIVE_MMS"
    "android.permission.READ_ICCC_SMS"
    "android.permission.SEND_SMS"
    "android.permission.READ_PHONE_STATE"
    "android.permission.READ_PHONE_NUMBERS"
    "android.permission.READ_CALL_LOG"
    "android.permission.CALL_PHONE"
    "android.permission.PROCESS_OUTGOING_CALLS"
    "android.permission.WRITE_CALL_LOG"
    "android.permission.READ_CONTACTS"
    "android.permission.WRITE_CONTACTS"
    "android.permission.GET_ACCOUNTS"
    "android.permission.ACTIVITY_RECOGNITION"
    "android.permission.READ_CLIPBOARD"
    "android.permission.GET_USAGE_STATS"
    "android.permission.CHANGE_WIFI_STATE"
    "android.permission.WRITE_SETTINGS"
    "android.permission.ACCESS_RESTRICTED_SETTINGS"
)

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

install_app() {
    local pkg="$1"
    local result

    result=$(adb shell pm install-existing --user 0 "$pkg" 2>&1)

    if [[ "$result" == *"Package $pkg does not exist"* ]]; then
        echo "  [NOT INSTALLED] $pkg (was never removed or not available)"
    elif [[ "$result" == *"already installed"* ]]; then
        echo "  [SKIPPED]  $pkg (already installed)"
    elif [[ "$result" == *"Failure"* ]]; then
        echo "  [FAILED]   $pkg"
    else
        echo "  [INSTALLED] $pkg"
    fi
}

remove_app_permissions() {
    local pkg="$1"
    local perm="$2"
    local result=""

    case "$perm" in
        android.permission.GET_USAGE_STATS)
            result=$(adb shell cmd appops set "$pkg" GET_USAGE_STATS ignore 2>&1)
            ;;
        android.permission.ACCESS_BACKGROUND_LOCATION)
            result=$(adb shell cmd appops set "$pkg" ACCESS_BACKGROUND_LOCATION ignore 2>&1)
            ;;
        android.permission.CHANGE_WIFI_STATE)
            result=$(adb shell cmd appops set "$pkg" CHANGE_WIFI_STATE ignore 2>&1)
            ;;
        android.permission.WRITE_SETTINGS)
            result=$(adb shell cmd appops set "$pkg" WRITE_SETTINGS ignore 2>&1)
            ;;
        android.permission.ACCESS_RESTRICTED_SETTINGS)
            result=$(adb shell cmd appops set "$pkg" ACCESS_RESTRICTED_SETTINGS ignore 2>&1)
;;
        *)
            result=$(adb shell pm revoke "$pkg" "$perm" 2>&1)
            ;;
    esac

    if [[ "$result" == *"No such permission"* ]]; then
        echo "  [NOT FOUND] $perm for $pkg"
    elif [[ "$result" == *"Exception"* ]] || [[ "$result" == *"error"* ]]; then
        echo "  [FAILED]   $perm for $pkg"
    else
        echo "  [REVOKED]  $perm from $pkg"
    fi
}

case "$MODE" in
    uninstall)
        echo "Starting bloatware removal..."
        echo ""
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
        ;;

    install)
        echo "Starting bloatware reinstallation..."
        echo ""
        echo "Reinstalling Motorola apps..."
        for app in "${MOTOROLA_APPS[@]}"; do
            install_app "$app"
        done

        echo ""
        echo "Reinstalling third-party apps..."
        for app in "${THIRD_PARTY_APPS[@]}"; do
            install_app "$app"
        done

        echo ""
        echo "Reinstalling Google apps..."
        for app in "${GOOGLE_APPS[@]}"; do
            install_app "$app"
        done

        echo ""
        echo "=========================================="
        echo "Done! Reboot may be required."
        echo "=========================================="
        ;;

    remove-permissions)
        echo "Starting permission removal from privacy-invasive apps..."
        echo ""
        echo "Note: Some permissions may auto-regrant on system updates or setup."
        echo ""

        for app in "${PERMISSION_TARGET_APPS[@]}"; do
            echo "Processing: $app"
            for perm in "${PERMISSIONS_TO_REMOVE[@]}"; do
                remove_app_permissions "$app" "$perm"
            done
            echo ""
        done

        echo "=========================================="
        echo "Done! Reboot recommended."
        echo "=========================================="
        ;;

    *)
        usage
        ;;
esac

echo ""
echo "=========================================="
echo "Privacy Apps Recommendations"
echo "=========================================="
echo "Consider installing these privacy-focused alternatives:"
echo ""
echo "  Signal          - Encrypted messaging"
echo "                    https://github.com/signalapp/signal-android"
echo ""
echo "  Shizuku         - ADB power user helper"
echo "                    https://github.com/thedjchi/shizuku"
echo ""
echo "  RethinkDNS      - DNS-based ad/trackering blocker"
echo "                    https://github.com/celzero/rethink-app"
echo ""
echo "  Obtanium        - Ungoogled Chromium for Android"
echo "                    https://github.com/imranr98/obtanium"
echo ""
echo "  Lawnchair       - Customizable Pixel launcher"
echo "                    https://github.com/lawnchairlauncher/lawnchair"
echo ""
echo "  Heliboard       - Privacy-focused keyboard"
echo "                    https://github.com/helium314/heliboard"
echo ""
echo "  Edge Gallery    - AI model testing/hosting"
echo "                    https://github.com/google-ai-edge/gallery"
echo ""
echo "  Droidify        - F-Droid client with modern UI"
echo "                    https://github.com/droid-ify/client"
echo ""
echo ""
echo "  Vanadium        - Best Browser for Android"
echo "                    Alternatives: Brave / Cromite / Ironfox"
echo "                    https://github.com/GrapheneOS/Vanadium"
echo ""
echo "=========================================="
