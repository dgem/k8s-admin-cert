

## Headless setup for RPi
https://www.raspberrypi.org/documentation/configuration/wireless/headless.md

https://raspberrypi.stackexchange.com/questions/10251/prepare-sd-card-for-wifi-on-headless-pi

/boot/wpa_supplicant.conf
```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=«your_ISO-3166-1_two-letter_country_code»

network={
		ssid="Home Network"
		psk="Home Password"
    key_mgmt=WPA-PSK
}
```

http://www.raspberry-projects.com/pi/software_utilities/wifi-access-point

https://www.raspberrypi.org/documentation/remote-access/ssh/
create /boot/ssh file

# David
```
g-74nKAt
```

## RPi Operating systems
https://wiki.archlinux.org/index.php/USB_flash_installation_media#In_macOS

https://docs.resin.io/learn/welcome/primer/
https://resinos.io/docs/raspberry-pi/gettingstarted/
https://www.yoctoproject.org/software-overview/
https://jumpnowtek.com/rpi/Raspberry-Pi-Systems-with-Yocto.html


## RPI and Docker GPIO
https://stackoverflow.com/questions/30059784/docker-access-to-raspberry-pi-gpio-pins


## NAT
```
iptables -t nat -A  POSTROUTING -o wlan0 -j MASQUERADE
iptables -A FORWARD -i wlan1 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o wlan1  -j ACCEPT


iptables -t nat -A  POSTROUTING -o wlan0 -j LOG --log-prefix "NAT POSTROUTING"
iptables -A FORWARD -i wlan1 -o wlan0 -m state --state RELATED,ESTABLISHED -j LOG --log-prefix "NAT FORWARD wlan1->wlan0"
iptables -A FORWARD -i wlan0 -o wlan1 -j LOG --log-prefix "NAT FORWARD wlan1->wlan0"
```


mount /boot
init-local
clout-init (pre-networking)
metadataservice crawler

## Building for RPi Zero W
https://povilasv.me/raspberrypi-kubelet/
https://github.com/kubernetes/kubeadm/issues/253#issuecomment-390442023

mkswap /dev/sda
swapon /dev/sda

```
export GOOS=${platform%/*}
  export GOARCH=${platform##*/}
	export GOARM=6

  # Do not set CC when building natively on a platform, only if cross-compiling from linux/amd64
  if [[ $(kube::golang::host_platform) == "linux/amd64" ]]; then
    # Dynamic CGO linking for other server architectures than linux/amd64 goes here
    # If you want to include support for more server platforms than these, add arch-specific gcc names here
    case "${platform}" in
      "linux/arm")
        export CGO_ENABLED=1
        #export CC=arm-linux-gnueabihf-gcc
				export CC=arm-linux-gnueabi-gcc
        ;;
```

ARMv6 with hfp in RPi W
https://raspberrypi.stackexchange.com/questions/545/does-the-raspberry-pi-have-hardware-floating-point-support
https://github.com/raspberrypi/linux/issues/1958

https://archlinuxarm.org/platforms/armv6/raspberry-pi
https://www.raspberrypi.org/documentation/faqs/#hardware


https://github.com/dockcross/dockcross
https://github.com/kubernetes/kubernetes/releases
1.12 is latest stable

## Cross compiling k8s for piw

https://golang.org/doc/install
https://dl.google.com/go/go1.11.1.linux-armv6l.tar.gz

tar -C /usr/local -xzf go1.11.1.linux-armv6l.tar.gz
export PATH=$PATH:/usr/local/go/bin

mkdir -p ~/go/src
export GOPATH=~/go/src

```
sudo swapon --all --verbose
```

https://povilasv.me/raspberrypi-kubelet/


## Debian supported cross builder
```
https://wiki.debian.org/CrossToolchains#In_jessie_.28Debian_8.29
http://emdebian.org/tools/debian/

arm64
armel
armhf
mips
mipsel
powerpc
ppc64el

cat <<EOF >/etc/apt/sources.list.d/crosstools.list
deb http://emdebian.org/tools/debian/ jessie main
EOF
curl http://emdebian.org/tools/debian/emdebian-toolchain-archive.key | sudo apt-key add -

sudo dpkg --add-architecture armhf
sudo apt-get update
sudo apt-get install crossbuild-essential-armhf

```


##
```
git clone git@github.com:kubernetes/kubernetes.git
git checkout release-1.12
make all WHAT=cmd/kubelet KUBE_BUILD_PLATFORMS=linux/arm
make all WHAT=cmd/kubeadm KUBE_BUILD_PLATFORMS=linux/arm
make all WHAT=cmd/kubectl KUBE_BUILD_PLATFORMS=linux/arm
```

## Kubernetes

### Installing software
```
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add
```
```
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
```

```
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
```

```
apt-get update && apt-get upgrade -y && apt-get install -y kubelet kubeadm kubernetes-cni kubectl
```

### Initialising the first master
```
/kubeadm init --pod-network-cidr 10.244.0.0/16 --apiserver-advertise-address 10.0.0.1
```

```
kubeadm init --pod-network-cidr 10.244.0.0/16 --apiserver-advertise-address 10.0.0.1 --ignore-preflight-errors=all
```

```
kubeadm join 10.0.0.115:6443 --token 5c8hud.m9c8utffktjjdjcu --discovery-token-ca-cert-hash sha256:63fd9ed289f0d11fb573bedc33d5c88233479f4bc008dfc5b8c478004a272b63
```

https://kubernetes.io/docs/setup/independent/install-kubeadm/

https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/#kubenet

### Installing flannel
Networking overlay
```
https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```


## JUST US FISH
### building kubelet
```
ls -al _output/local/bin/linux/arm/kubelet
-rwxr-xr-x 1 pi pi 93560884 Oct 22 20:02 _output/local/bin/linux/arm/kubelet

ldd _output/local/bin/linux/arm/kubelet
	linux-vdso.so.1 (0x7ef83000)
	/usr/lib/arm-linux-gnueabihf/libarmmem.so (0x76f35000)
	libpthread.so.0 => /lib/arm-linux-gnueabihf/libpthread.so.0 (0x76f0c000)
	libdl.so.2 => /lib/arm-linux-gnueabihf/libdl.so.2 (0x76ef9000)
	libc.so.6 => /lib/arm-linux-gnueabihf/libc.so.6 (0x76dba000)
	/lib/ld-linux-armhf.so.3 (0x76f4b000)
```



```
2018-10-23 14:47:29,433 - util.py[DEBUG]: Reading from /proc/586/cmdline (quiet=False)
2018-10-23 14:47:29,444 - util.py[DEBUG]: Read 58 bytes from /proc/586/cmdline
2018-10-23 14:47:29,447 - cc_power_state_change.py[DEBUG]: After pid 586 ends, will execute: shutdown -r +30s ****  CLOUD-INIT COMPLETED  ****
**** REBOOTING, PLEASE HOLD ****

2018-10-23 14:47:29,464 - util.py[DEBUG]: Forked child 14724 who will run callback run_after_pid_gone
2018-10-23 14:47:29,506 - handlers.py[DEBUG]: finish: modules-final/config-power-state-change: SUCCESS: config-power-state-change ran successfully
2018-10-23 14:47:29,521 - main.py[DEBUG]: Ran 17 modules with 0 failures
2018-10-23 14:47:29,534 - util.py[DEBUG]: Reading from /proc/586/cmdline (quiet=Fals


	ps -ef | grep 586
	root     14884 14846  0 14:53 pts/0    00:00:00 grep 586

```
