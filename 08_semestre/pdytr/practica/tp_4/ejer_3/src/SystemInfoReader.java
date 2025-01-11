import com.sun.management.OperatingSystemMXBean;
import java.io.Serializable;
import java.lang.management.ManagementFactory;
import java.net.InetAddress;
import java.net.UnknownHostException;

public final class SystemInfoReader {
    private static final OperatingSystemMXBean osBean = (com.sun.management.OperatingSystemMXBean) ManagementFactory.getOperatingSystemMXBean();

    public static SystemInfo getSystemInfo(String id) {
        // Get CPU usage
        // double cpuUsage = osBean.getSystemCpuLoad() * 100; // deprecated
        double cpuUsage = osBean.getCpuLoad() * 100;
        
        // Get memory usage
        // long totalMemory = osBean.getTotalPhysicalMemorySize(); // deprecated
        long totalMemory = osBean.getTotalMemorySize();
        // long freeMemory = osBean.getFreePhysicalMemorySize(); // deprecated
        long freeMemory = osBean.getFreeMemorySize();
        double memoryUsage = (1.0 - (double)freeMemory / totalMemory) * 100;
        
        // Get computer name/ID (or network ID)
        String computerName = System.getenv("COMPUTERNAME");
        if (computerName == null) {
            computerName = System.getenv("HOSTNAME");
        }
        if (computerName == null) {
            try {
                InetAddress inetAddress = InetAddress.getLocalHost();
                computerName = inetAddress.getHostName();
            } catch (UnknownHostException e) {
                computerName = "Unknown";
            }
        }

        return new SystemInfo(id, cpuUsage, memoryUsage, computerName);
    }

    public static final class SystemInfo implements Serializable {
        public String id;
        public final double cpuUsage;
        public final double memoryUsage;
        public final String computerName;

        public SystemInfo(String id, double cpuUsage, double memoryUsage, String computerName) {
            this.id = id;
            this.cpuUsage = cpuUsage;
            this.memoryUsage = memoryUsage;
            this.computerName = computerName;
        }

        @Override
        public String toString() {
            String format = (id == null || id.isEmpty() ? "" : id + "\n") + "CPU: %6.2f%%    Mem: %6.2f%%    PC: %s";
            return String.format(format, cpuUsage, memoryUsage, computerName);
        }
    }
}
