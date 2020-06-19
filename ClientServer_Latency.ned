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
import inet.common.misc.NetAnimTrace;
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.inet.StandardHost;
import ned.DatarateChannel;

network ClientServeurLatency
{
    parameters:
        double per = default(0);
        @display("bgb=1109.1324,601.0025");
    types:
        channel C extends DatarateChannel
        {
            datarate = 10Mbps;
            delay = 0.1us;
            per = per;
        }
    submodules:
        client: StandardHost {
            parameters:
                @display("p=48,240;i=device/pc;is=vl");
        }
        Serveur: StandardHost {
            parameters:
                @display("p=1058.96,239.12;i=device/router;is=vl");
        }

        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=48,13;is=s");
        }
//        configurator: NextHopNetworkConfigurator {
//            parameters:
//                @display("p=53,134");
//        }

    connections allowunconnected:
        client.pppg++ <--> C <--> Serveur.pppg++;
}
