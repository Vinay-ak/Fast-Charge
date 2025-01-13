#!/system/bin/sh

# Monitor charger connection state continuously
while true; do
    # Check if charger is connected (2: connected, 0: disconnected)
    CHARGER_STATUS=$(cat /sys/class/power_supply/primary_chg/online)

    # Path to the charge current control file
    CHARGE_CURRENT_FILE="/sys/devices/platform/soc/soc:odm/soc:odm:mmi_chrg_manager/power_supply/mmi_chrg_manager/constant_charge_current_max"

    if [ "$CHARGER_STATUS" -eq 2 ]; then
        # Charger is connected, adjust charge current if needed
        CURRENT_VALUE=$(cat "$CHARGE_CURRENT_FILE")
        if [ "$CURRENT_VALUE" -ne 6000000 ]; then
            echo "6000000" > "$CHARGE_CURRENT_FILE" #You can edit this value to upto 6000000
        fi
    fi

    # Sleep for a short interval before checking again
    sleep 60  # Adjust this interval as needed
done

#By Vinayak Shree 
