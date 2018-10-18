#/bin/bash
#by benjaminwan V0.2
printf "**************************************\n"
printf "please put this shell to system folder\n"
printf "**************************************\n"
 
function getNeed()
{
    echo '<<<<<<getting NEED for '$1'>>>>>>'
    case $1 in
      lib/hw)
        name=lib_hw
        ;;
      lib64/hw)
        name=lib64_hw
        ;;
      vendor/bin)
        name=vendor_bin
        ;;
      vendor/lib)
        name=vendor_lib
        ;;
      vendor/lib64)
        name=vendor_lib64
        ;;
      vendor/lib/hw)
        name=vendor_lib_hw
        ;;
      vendor/lib64/hw)
        name=vendor_lib64_hw
        ;;
      *)
        name=$1
        ;;
    esac
 
    if [ ! -d $1 ];then
        printf "can't find $1 folder!\n"
    else
        ls $1 -p | grep [^/]$ > info_$name.txt
        cat info_$name.txt |while read line
        do
            echo "getting NEED for" $line
            echo $line >> Need_$name.txt
            objdump -x $1/$line | grep "NEEDED" >> Need_$name.txt
            echo "*************************************" >> Need_$name.txt
        done
        rm info_$name.txt
    fi
}
 
getNeed bin;
getNeed lib;
getNeed lib64;
getNeed lib/hw;
getNeed lib64/hw;
getNeed vendor/bin;
getNeed vendor/lib;
getNeed vendor/lib64;
getNeed vendor/lib/hw;
printf "**********Completed!**********\n"
