# A Linux Resource Monitoring Shell Script

This shell script monitors five types of resources and prints out the resource usage of dangerous processes. The conditions for monitoring are as follows:

1. CPU usage exceeding 10%, 30%, 50%, 90% of available CPU resources.
2. Memory usage exceeding 10%, 30%, 50%, 90% of available memory.
3. Disk I/O exceeding 10MB, 50MB, 200MB, 1GB.
4. Disk I/O rate exceeding 100 times/s, 1000 times/s, 10000 times/s, 100000 times/s.
5. Network bandwidth usage exceeding 100kB/s, 1000kB/s, 10000kB/s, 100000kB/s.

### Requirements:
- The script uses shell scripting to list dangerous processes' resource usage every 3 seconds.
- For dangerous resources falling into the five intervals (inclusive of the left boundary and exclusive of the right boundary), the resource usage values are printed in white, blue, yellow, green, and red colors respectively.

### Usage:
1. Make the script executable: `chmod +x resource_monitor.sh`
2. Run the script: `./resource_monitor.sh`

### Note:
- Ensure proper permissions to execute the script.
- The script continuously monitors and prints dangerous processes' resource usage until manually interrupted.

## Chinses-version Readme
这是一个Linux shell script的一个应用：
对五种资源（超过其中最小阈值之一定义为危险）进行监控：
1、CPU占用超过当前系统可用CPU资源10%、30%、50%、90%；
2、内存占用超过当前系统内存容量10%、30%、50%、90%；
3、磁盘读写超过10MB、50MB、200MB、1GB
4、磁盘读写频率超过100次/秒、1000次/秒、10000次/秒、100000次/秒
5、网络带宽占用超过100kB/秒、1000kB/秒、10000kB/秒、100000kB/秒
使用shell每个3秒列表打印危险进程的上述资源占用，对于落在5个区间（含左右开区间）的危险资源分别采用白、蓝、黄、绿、红颜色打印资源占用值。
