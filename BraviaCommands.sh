#!/bin/bash

set -e

cd $(dirname $0)

if [ "$1" = "" ]; then
  echo "Usage: $0 <TV_IP>"
  exit 1
fi

# IP of TV
tv_ip=$1

# TV KDL-40EX720 with remote RM-EDO44 protocol IRCC-IP InfraRed Compatible Control over Internet Protocol from https://pro-bravia.sony.net/develop/integrate/ircc-ip/overview/index.html and additional data through https://openremote.github.io/archive-dotorg/forums/Sony%20TV%20HTTP%20control.html

declare -A ircc_commandmap_RM_EDO44
ircc_commandmap_RM_EDO44[POWER]="AAAAAQAAAAEAAAAVAw=="
ircc_commandmap_RM_EDO44[POWER_ON]="AAAAAQAAAAEAAAAuAw=="
ircc_commandmap_RM_EDO44[POWER_OFF]="AAAAAQAAAAEAAAAvAw=="
ircc_commandmap_RM_EDO44[INPUT]="AAAAAQAAAAEAAAAlAw=="
ircc_commandmap_RM_EDO44[TrackID]="AAAAAgAAABoAAAB+Aw=="
ircc_commandmap_RM_EDO44[Prev]="AAAAAgAAAJcAAAA8Aw=="
ircc_commandmap_RM_EDO44[Pause]="AAAAAgAAAJcAAAAZAw=="
ircc_commandmap_RM_EDO44[Next]="AAAAAgAAAJcAAAA9Aw=="
ircc_commandmap_RM_EDO44[iManual]="AAAAAgAAABoAAAB7Aw=="
ircc_commandmap_RM_EDO44[Rewind]="AAAAAgAAAJcAAAAbAw=="
ircc_commandmap_RM_EDO44[Play]="AAAAAgAAAJcAAAAaAw=="
ircc_commandmap_RM_EDO44[Forward]="AAAAAgAAAJcAAAAcAw=="
ircc_commandmap_RM_EDO44[Mode3D]="AAAAAgAAAHcAAABNAw=="
ircc_commandmap_RM_EDO44[Wide]="AAAAAgAAAKQAAAA9Aw=="
ircc_commandmap_RM_EDO44[Stop]="AAAAAgAAAJcAAAAYAw=="
ircc_commandmap_RM_EDO44[Rec]="AAAAAgAAAJcAAAAgAw=="
ircc_commandmap_RM_EDO44[Analog]="AAAAAgAAAHcAAAANAw=="
ircc_commandmap_RM_EDO44[Digital]="AAAAAgAAAJcAAAAyAw=="
ircc_commandmap_RM_EDO44[Exit]="AAAAAQAAAAEAAABjAw=="
ircc_commandmap_RM_EDO44[Scene]="AAAAAgAAABoAAAB4Aw=="
ircc_commandmap_RM_EDO44[Internet_Video]="AAAAAgAAABoAAAB5Aw=="
ircc_commandmap_RM_EDO44[SyncMenu]="AAAAAgAAABoAAABYAw=="
ircc_commandmap_RM_EDO44[EPG]="AAAAAgAAAKQAAABbAw=="
ircc_commandmap_RM_EDO44[Display_I_Plus]="AAAAAQAAAAEAAAA6Aw==" 
ircc_commandmap_RM_EDO44[Options]="AAAAAgAAAJcAAAA2Aw=="
ircc_commandmap_RM_EDO44[Home]="AAAAAQAAAAEAAABgAw=="
ircc_commandmap_RM_EDO44[Return]="AAAAAgAAAJcAAAAjAw=="
ircc_commandmap_RM_EDO44[Confirm]="AAAAAQAAAAEAAABlAw=="
ircc_commandmap_RM_EDO44[Up]="AAAAAQAAAAEAAAB0Aw=="
ircc_commandmap_RM_EDO44[Down]="AAAAAQAAAAEAAAB1Aw=="
ircc_commandmap_RM_EDO44[Right]="AAAAAQAAAAEAAAAzAw=="
ircc_commandmap_RM_EDO44[Left]="AAAAAQAAAAEAAAA0Aw=="
ircc_commandmap_RM_EDO44[Red]="AAAAAgAAAJcAAAAlAw=="
ircc_commandmap_RM_EDO44[Green]="AAAAAgAAAJcAAAAmAw=="
ircc_commandmap_RM_EDO44[Yellow]="AAAAAgAAAJcAAAAnAw=="
ircc_commandmap_RM_EDO44[Blue]="AAAAAgAAAJcAAAAkAw=="
ircc_commandmap_RM_EDO44[Num1]="AAAAAQAAAAEAAAAAAw=="
ircc_commandmap_RM_EDO44[Num2]="AAAAAQAAAAEAAAABAw=="
ircc_commandmap_RM_EDO44[Num3]="AAAAAQAAAAEAAAACAw=="
ircc_commandmap_RM_EDO44[Num4]="AAAAAQAAAAEAAAADAw=="
ircc_commandmap_RM_EDO44[Num5]="AAAAAQAAAAEAAAAEAw=="
ircc_commandmap_RM_EDO44[Num6]="AAAAAQAAAAEAAAAFAw=="
ircc_commandmap_RM_EDO44[Num7]="AAAAAQAAAAEAAAAGAw=="
ircc_commandmap_RM_EDO44[Num8]="AAAAAQAAAAEAAAAHAw=="
ircc_commandmap_RM_EDO44[Num9]="AAAAAQAAAAEAAAAIAw=="
ircc_commandmap_RM_EDO44[Teletext]="AAAAAQAAAAEAAAA/Aw=="
ircc_commandmap_RM_EDO44[Num0]="AAAAAQAAAAEAAAAJAw=="
ircc_commandmap_RM_EDO44[SubTitle]="AAAAAgAAAJcAAAAoAw=="
ircc_commandmap_RM_EDO44[Mute]="AAAAAQAAAAEAAAAUAw=="
ircc_commandmap_RM_EDO44[VolumeUp]="AAAAAQAAAAEAAAASAw=="
ircc_commandmap_RM_EDO44[VolumeDown]="AAAAAQAAAAEAAAATAw=="
ircc_commandmap_RM_EDO44[ChannelUp]="AAAAAQAAAAEAAAAQAw=="
ircc_commandmap_RM_EDO44[ChannelDown]="AAAAAQAAAAEAAAARAw=="
ircc_commandmap_RM_EDO44[Audio]="AAAAAQAAAAEAAAAXAw=="

#not existing as a button on remote but working with KDL-40EX720
ircc_commandmap_RM_EDO44[HDMI1]="AAAAAgAAABoAAABaAw=="
ircc_commandmap_RM_EDO44[HDMI2]="AAAAAgAAABoAAABbAw=="
ircc_commandmap_RM_EDO44[HDMI3]="AAAAAgAAABoAAABcAw=="
ircc_commandmap_RM_EDO44[HDMI4]="AAAAAgAAABoAAABdAw=="
ircc_commandmap_RM_EDO44[Video_AV1]="AAAAAQAAAAEAAABAAw=="
ircc_commandmap_RM_EDO44[Video_AV2]="AAAAAQAAAAEAAABBAw=="
ircc_commandmap_RM_EDO44[ComponentAV2]="AAAAAgAAAKQAAAA2Aw=="
ircc_commandmap_RM_EDO44[Analog_RGB_PC_VGA]="AAAAAQAAAAEAAABDAw=="
ircc_commandmap_RM_EDO44[PAP]=:"AAAAAgAAAKQAAAB3Aw==" #Picture in picture
ircc_commandmap_RM_EDO44[ClosedCaption]="AAAAAgAAAKQAAAAQAw==" #the same as Subtitles
ircc_commandmap_RM_EDO44[Jump]="AAAAAQAAAAEAAAA7Aw=="
ircc_commandmap_RM_EDO44[PictureOff]="AAAAAQAAAAEAAAA+Aw=="
ircc_commandmap_RM_EDO44[Guide]="AAAAAQAAAAEAAAAOAw==" #the same as EPG
ircc_commandmap_RM_EDO44[TVanalog]="AAAAAQAAAAEAAAA4Aw=="
ircc_commandmap_RM_EDO44[SleepTimer]="AAAAAQAAAAEAAAA2Aw=="
ircc_commandmap_RM_EDO44[TV]="AAAAAQAAAAEAAAAkAw=="
ircc_commandmap_RM_EDO44[AudioQualityMode]="AAAAAgAAAJcAAAB7Aw=="
ircc_commandmap_RM_EDO44[DemoMode]="AAAAAgAAAJcAAAB8Aw=="
ircc_commandmap_RM_EDO44[DigitalToggle]="AAAAAgAAAHcAAABSAw=="
ircc_commandmap_RM_EDO44[DemoSurround]="AAAAAgAAAHcAAAB7Aw=="
ircc_commandmap_RM_EDO44[Audio_Description]="AAAAAgAAABoAAAA7Aw=="
ircc_commandmap_RM_EDO44[AudioMixUp]="AAAAAgAAABoAAAA8Aw=="
ircc_commandmap_RM_EDO44[AudioMixDown]="AAAAAgAAABoAAAA9Aw=="
ircc_commandmap_RM_EDO44[Netflix]="AAAAAgAAABoAAAB8Aw=="
ircc_commandmap_RM_EDO44[ShopRemoteControlForcedDynamic]="AAAAAgAAAJcAAABqAw=="
ircc_commandmap_RM_EDO44[AppliCast]="AAAAAgAAABoAAABvAw=="

# TV KDL-40EX720 REST API uses JSON-RPC over HTTP from https://pro-bravia.sony.net/develop/integrate/rest-api/spec/index.html

declare -A ip_commandmap_KDL40EX720
ip_commandmap_KDL40EX720[MuteOn]="http://$tv_ip:80/cers/command/MuteOn"
ip_commandmap_KDL40EX720[MuteOff]="http://$tv_ip:80/cers/command/MuteOff"




ircc_commandmap_RM_EDO44() {
  echo -n "Pressed IRCC Virtual remote button "
  echo -n "$1:"
  ./send_command_IRCC_over_IP.sh $tv_ip ${ircc_commandmap_RM_EDO44[$1]}
}

ip_commandmap_KDL40EX720() {
  echo -n "Sending IP command "
  echo -n "$1:"
  ./send_command_direct_IP.sh $tv_ip ${ip_commandmap_KDL40EX720[$1]}
}


#Mute on off IP
#ip_commandmap_KDL40EX720 'MuteOn'
#sleep 4
#ip_commandmap_KDL40EX720 'MuteOff

#ircc_commandmap_RM_EDO44 'ChannelDown'
#sleep 4
#ircc_commandmap_RM_EDO44 'ChannelUp'

#ircc_commandmap_RM_EDO44 'VolumeUp'
#ircc_commandmap_RM_EDO44 'VolumeDown'

#ircc_commandmap_RM_EDO44 'Mute'
#sleep 4
#ircc_commandmap_RM_EDO44 'Mute'

#ircc_commandmap_RM_EDO44 'Num2'
#ircc_commandmap_RM_EDO44 'Num4'
#ircc_commandmap_RM_EDO44 'Num4'

# teletext on
#ircc_commandmap_RM_EDO44 'Teletext'
#ircc_commandmap_RM_EDO44 'Teletext'
#sleep 4
#ircc_commandmap_RM_EDO44 'Teletext'
#ircc_commandmap_RM_EDO44 'Red'
#sleep 4
#ircc_commandmap_RM_EDO44 'Teletext'

# swith on and off EPG
#ircc_commandmap_RM_EDO44 'DemoMode'

#ircc_commandmap_RM_EDO44 'AppliCast'
#sleep 2
#ircc_commandmap_RM_EDO44 'Up'
#sleep 2
#ircc_commandmap_RM_EDO44 'Up'
#sleep 2
#ircc_commandmap_RM_EDO44 'Confirm'
# select 'media player in lower left corner'
#remote 'DOWN'
#remote 'DOWN'
#remote 'LEFT'
#remote 'CONFIRM'
