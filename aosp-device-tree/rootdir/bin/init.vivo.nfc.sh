export PATH=/vendor/bin

if [ -f /sys/nfc/nfc_enable ]; then
    fp_module=`cat /sys/nfc/nfc_enable` 2> /dev/null

    if [ "$fp_module" == "0" ];then
    	setprop vendor.vivo.nfc.boot "0"
    else
    	setprop vendor.vivo.nfc.boot "1"
    fi

    if [ "$fp_module" == "1" ];then
        setprop persist.vendor.vivo.nfc.chip.type "SN110"
    fi

    if [ "$fp_module" == "3" ];then
        setprop persist.vendor.vivo.nfc.chip.type "S3NSN4V"
    fi
    if [ "$fp_module" == "4" ];then
        setprop persist.vendor.vivo.nfc.chip.type "SN220"
    fi

    if [ "$fp_module" == "6" ];then
        setprop persist.vendor.vivo.nfc.chip.type "ST54J"
    fi

    if [ "$fp_module" == "8" ];then
        setprop vendor.vivo.nfc.boot "2"
        setprop persist.vendor.vivo.nfc.chip.type "PN560"
    fi

else
	echo "there is no nfc_enable node!!"
	setprop vendor.vivo.nfc.boot 0
fi
