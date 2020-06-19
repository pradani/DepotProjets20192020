//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package inet.examples.inet.Mon_TP;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.EtherSwitch;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;


network Broadcast
{
    parameters:
        int numTargets;
        @display("bgb=2300.826,1723.4099");
    types:
        channel C extends DatarateChannel
        {
            datarate = 10Mbps;
            delay = 0.1us;
        }
    submodules:
        target[numTargets]: StandardHost {
            parameters:
                @display("i=device/pc3;p=1157.09,110.528,col,50");
        }
        Serveur: StandardHost {
            parameters:
                @display("p=138.46199,111.948;i=device/pc2");
        }

        R2: Router {

            @display("p=536.172,170.868");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                config = xmldoc("config.xml");
                @display("p=12,7;is=s");
        }
        switch: EtherSwitch {
            @display("p=228,804;is=vl");
        }

    connections:
        Serveur.pppg++ <--> C <--> R2.pppg++;
        R2.ethg++ <--> C <--> switch.ethg++;
        for i=0..numTargets-1 {
            switch.ethg++ <--> C <--> target[i].ethg++;
        }
}
