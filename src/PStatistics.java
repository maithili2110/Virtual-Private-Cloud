package cmpe283Project;

/**
 * Created by Varun on 4/11/2015.
 */
import com.vmware.vim25.mo.*;

import java.net.URL;

public class PStatistics {
    public static String getCPUUsage(String vmName) {
        try {
            URL url = new URL("https://130.65.132.108/sdk");
            ServiceInstance si = new ServiceInstance(url, "administrator",
                    "12!@qwQW", true);
            ManagedEntity[] hosts = new InventoryNavigator(si.getRootFolder()).searchManagedEntities("HostSystem");
            for(int i=0; i<hosts.length; i++) {
                HostSystem h = (HostSystem) hosts[i];
                if (h != null) {
                    if (h.getName() != null) {
                        VirtualMachine vms[] = h.getVms();

                        for (int p = 0; p < vms.length; p++) {
                            VirtualMachine vm = vms[p];
                            if (vm != null && vm.getName().equalsIgnoreCase(vmName)) {
                                if( vm.getRuntime().getMaxCpuUsage() == null)
                                    return "0";
                                else
                                    return vm.getRuntime().getMaxCpuUsage().toString();
                            }
                        }
                    }
                }
            }
        }
        catch(Exception e) {
            System.out.println("Error in gettingCPUUsage: "+ e.getMessage());
        }
        return "0";
    }

    public static String getMemoryUsage(String vmName) {
        try {
            URL url = new URL("https://130.65.132.108/sdk");
            ServiceInstance si = new ServiceInstance(url, "administrator",
                    "12!@qwQW", true);
            ManagedEntity[] hosts = new InventoryNavigator(si.getRootFolder()).searchManagedEntities("HostSystem");
            for(int i=0; i<hosts.length; i++) {
                HostSystem h = (HostSystem) hosts[i];
                if (h != null) {
                    if (h.getName() != null) {
                        VirtualMachine vms[] = h.getVms();

                        for (int p = 0; p < vms.length; p++) {
                            VirtualMachine vm = vms[p];
                            if (vm != null && vm.getName().equalsIgnoreCase(vmName)) {
                                return vm.getSummary().quickStats.getHostMemoryUsage().toString();
                            }
                        }
                    }
                }
            }
        }
        catch(Exception e)  {
            System.out.println("Error in gettingMemoryUsage: "+ e.getMessage());
        }
        return "0";
    }
}
