import os
import platform
import psutil
import socket

def get_cpu_info():
    print("\nCPU Information:")
    print(f"  Physical cores: {psutil.cpu_count(logical=False)}")
    print(f"  Total cores: {psutil.cpu_count(logical=True)}")
    cpu_freq = psutil.cpu_freq()
    print(f"  Max Frequency: {cpu_freq.max:.2f} Mhz")
    if hasattr(cpu_freq, 'min'):
        print(f"  Min Frequency: {cpu_freq.min:.2f} Mhz")
    else:
        print("  Min Frequency: N/A")
    print(f"  Current Frequency: {cpu_freq.current:.2f} Mhz")
    print(f"  CPU Usage: {psutil.cpu_percent(interval=1)}%")

def get_memory_info():
    print("\nMemory Information:")
    svmem = psutil.virtual_memory()
    print(f"  Total: {svmem.total / (1024 ** 3):.2f} GB")
    print(f"  Available: {svmem.available / (1024 ** 3):.2f} GB")
    print(f"  Used: {svmem.used / (1024 ** 3):.2f} GB")
    print(f"  Percentage Used: {svmem.percent}%")

def get_disk_info():
    print("\nDisk Information:")
    partitions = psutil.disk_partitions()
    for partition in partitions:
        if partition.mountpoint:  # Filter out partitions without a valid mount point
            print(f"  Device: {partition.device}")
            print(f"    Mountpoint: {partition.mountpoint}")
            print(f"    File system type: {partition.fstype}")
            try:
                partition_usage = psutil.disk_usage(partition.mountpoint)
            except PermissionError:
                print(f"    Skipped {partition.mountpoint} due to permission error.")
                continue
            print(f"    Total Size: {partition_usage.total / (1024 ** 3):.2f} GB")
            print(f"    Used: {partition_usage.used / (1024 ** 3):.2f} GB")
            print(f"    Free: {partition_usage.free / (1024 ** 3):.2f} GB")
            print(f"    Percentage Used: {partition_usage.percent}%")

def get_network_info():
    print("\nNetwork Information:")
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)
    print(f"  Hostname: {hostname}")
    print(f"  IP Address: {ip_address}")
    interfaces = psutil.net_if_addrs()
    for interface_name, interface_addresses in interfaces.items():
        if any(str(addr.family) == 'AddressFamily.AF_INET' for addr in interface_addresses):  # Filter out interfaces without IP
            print(f"  Interface: {interface_name}")
            for address in interface_addresses:
                if str(address.family) == 'AddressFamily.AF_INET':
                    print(f"    IP Address: {address.address}")
                    print(f"    Netmask: {address.netmask}")
                    print(f"    Broadcast IP: {address.broadcast}")
                elif str(address.family) == 'AddressFamily.AF_PACKET':
                    print(f"    MAC Address: {address.address}")
                    print(f"    Netmask: {address.netmask}")
                    print(f"    Broadcast MAC: {address.broadcast}")

def get_os_info():
    print("\nOS Information:")
    print(f"  System: {platform.system()}")
    print(f"  Node Name: {platform.node()}")
    print(f"  Release: {platform.release()}")
    print(f"  Version: {platform.version()}")
    print(f"  Machine: {platform.machine()}")
    print(f"  Processor: {os.environ.get('PROCESSOR_IDENTIFIER', 'N/A')}")

def main():
    get_cpu_info()
    get_memory_info()
    get_disk_info()
    get_network_info()
    get_os_info()
    input("\nPress Enter to exit...")

if __name__ == "__main__":
    main()