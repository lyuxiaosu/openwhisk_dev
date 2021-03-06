#/bin/bash

setVim(){
echo "hi comment ctermfg=3
set hlsearch

if has(\"autocmd\")
	au BufReadPost * if line(\"'\\\"\") > 1 && line(\"'\\\"\") <= line(\"$\") | exe \"normal! g'\\\"\" | endif
endif

" > ~/.vimrc
}

setVim

#remember github username and password
git config --global credential.helper store

do_partition() {
echo "doing partition"
echo "n
p
1

+400G
w
" | sudo fdisk /dev/sdb && sudo mkfs.ext4 /dev/sdb1
}

add_partition() {
	has_sdb=`sudo fdisk -l /dev/sdb|grep "/dev/sdb: 1.1 TiB"`
	no_partition=`sudo fdisk -l /dev/sdb|grep "Device"`
	#echo $has_sdb
	if [[ $has_sdb == *"Disk /dev/sdb: 1.1 TiB"* ]]; then
	    if [ -z "$no_partition" ];
            then 
		    do_partition
	    else
		echo "/dev/sdb already has paritions"
		exit
	    fi	   
	else
	    echo "no /dev/sdb or its capacity is not 1.1 TiB"
	    exit
	fi
}

mount_partition() {
    sudo mkdir /my_mount
    sudo mount /dev/sdb1 /my_mount
    df -h
}
add_partition
mount_partition
