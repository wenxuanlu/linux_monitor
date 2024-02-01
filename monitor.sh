#!/bin/bash
#Color values
colors=([0]=37 [1]=34 [2]=33 [3]=32 [4]=31) 
#Thresholds for various resources
cpu_mem_thres=([0]=0 [1]=10 [2]=30 [3]=50 [4]=90)
disk_io_thres=([0]=0 [1]=10 [2]=50 [3]=200 [4]=1024)
disk_io_rate_thres=([0]=0 [1]=100 [2]=1000 [3]=10000 [4]=100000)
network_thres=([0]=0 [1]=100 [2]=1000 [3]=10000 [4]=100000) 

while true; do

    pid_list=$(top -b -n 1 | awk 'NR>=8 && $9>0 {print $1}')

    echo `date`

    echo "---------------------------------------------------------------------------------------------------------"
    printf "%-12s %-18s %-18s %-18s %-18s %-18s\n" "PID" "CPU(%)" "Memory(%)" "Disk I/O" "Disk I/O Rate" "Network Usage"
    echo "---------------------------------------------------------------------------------------------------------"

    for pid in ${pid_list[*]}; do
        #每轮确定变量
        cpu=`top -b -p $pid -n 1 | awk 'NR>=8{print $9}'`
        mem=`top -b -p $pid -n 1 | awk 'NR>=8{print $10}'`
        disk_io=`pidstat -d -p $pid | awk 'NR>=4{print $4+$5}'`
        disk_io_rate=`pidstat -d -p $pid | awk 'NR>=4{print $4}'`
        network_band_wid=`sudo nethogs -t -c 3 | grep $pid | awk 'END{print $2+$3}'`
        
        if [[ $cpu == "" || $mem == "" || ${disk_io} == "" || ${disk_io_rate} == "" || ${network_band_wid} == "" ]]; then
            continue
        fi
        
        if [[ (`echo "$cpu >= ${cpu_mem_thres[1]}" | bc` -eq 1) || (`echo "$mem >= ${cpu_mem_thres[1]}" | bc` -eq 1) || (`echo "$disk_io >= ${disk_io_thres[1]}" | bc` -eq 1) || (`echo "$disk_io_rate >= ${disk_io_rate_thres[1]}" | bc` -eq 1) || (`echo "$network_band_wid >= ${network_thres[1]}" | bc` -eq 1) ]]; then
            
            printf "%-12d" $pid

            colors_to_print=([0]=37 [1]=37 [2]=37 [3]=37 [4]=37) 

            for idx in 0 1 2 3 4 ; do
                if [[ `echo "$cpu >= ${cpu_mem_thres[$idx]}" | bc` -eq 1 ]]; then
                    colors_to_print[0]=${colors[$idx]}
                fi
                if [[ `echo "$mem >= ${cpu_mem_thres[$idx]}" | bc` -eq 1 ]]; then
                    colors_to_print[1]=${colors[$idx]}
                fi
                if [[ `echo "$disk_io >= ${disk_io_thres[$idx]}" | bc` -eq 1 ]]; then
                    colors_to_print[2]=${colors[$idx]}
                fi
                if [[ `echo "$disk_io_rate >= ${disk_io_rate_thres[$idx]}" | bc` -eq 1 ]]; then
                    colors_to_print[3]=${colors[$idx]}
                fi
                if [[ `echo "$network_band_wid >= ${network_thres[$idx]}" | bc` -eq 1 ]]; then
                    colors_to_print[4]=${colors[$idx]}
                fi
            done

            printf "\e[%dm%-18f \e[%dm%-18f \e[%dm%-18f \e[%dm%-18f \e[%dm%-18f\n" ${colors_to_print[0]} $2 ${colors_to_print[1]} $3 ${colors_to_print[2]} $4 ${colors_to_print[3]} $5 ${colors_to_print[4]} $6
    
        fi
        
    done

    sleep 3
    
    clear 

done
