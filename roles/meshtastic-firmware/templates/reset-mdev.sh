#!/bin/bash
tlora='1a86:55d4'
for X in /sys/bus/usb/devices/*; do 
        usbVen=`cat $X/idVendor 2>/dev/null`
        usbProd=`cat $X/idProduct 2>/dev/null`
        if [ "${usbVen}:${usbProd}" = "$tlora" ]; then
                usbID=`awk -F/ '{print $NF}' <<< ${X}`
                echo "Reconnecting ${usbID}..."
		echo ${usbID} | tee /sys/bus/usb/drivers/usb/unbind
		echo ${usbID} | tee /sys/bus/usb/drivers/usb/bind
        fi
done
