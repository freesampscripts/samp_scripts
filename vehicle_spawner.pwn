#include <a_samp>
#include <zcmd>

new pveh[MAX_PLAYERS];

new vehmodel_names[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel",
    "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
    "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
    "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
    "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
    "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
    "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder",
    "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
    "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
    "Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
    "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
    "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper",
    "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
    "Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin",
    "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
    "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
    "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
    "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune",
    "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
    "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
    "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
    "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
    "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
    "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
    "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
    "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car",
    "Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
    "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
    "Tiller", "Utility Trailer"
};

public OnPlayerDisconnect(playerid, reason)
{
    if(pveh[playerid])
	{
	    DestroyVehicle(pveh[playerid]);
	    pveh[playerid] = 0;
	}
	return 1;
}

CMD:v(playerid, params[])
{
	new string[25], Float:x, Float:y, Float:z, Float:vx, Float:vy, Float:vz, Float:angle, modelid;
	if(params[0] == '\1') return SendClientMessage(playerid, -1, "/v [modelid / name]");
	if(params[0] >= '0' && params[0] <= '9')
	{
	    modelid = strval(params);
	    if(modelid < 400 || modelid > 611) return SendClientMessage(playerid, 0xFA0000FF, "Valid vehicle modelids 400-611");
	}
	else
	{
	    for(new i = 0; i < sizeof(vehmodel_names); i ++)
	    {
	        if(strcmp(params, vehmodel_names[i], true)) continue;
	        modelid = i + 400;
	        break;
	    }
	}
	if(!modelid) return SendClientMessage(playerid, 0xFA0000FF, "Invalid vehicle name");
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);
	GetVehicleModelInfo(modelid, 1, vx, vy, vz);
	x += (vx / 2.0) + 5.0 * floatsin(-angle, degrees);
	y += (vy / 2.0) * floatcos(-angle, degrees);
	if(pveh[playerid])
	{
	    DestroyVehicle(pveh[playerid]);
	}
	format(string, 25, "%s spawned", vehmodel_names[modelid - 400]);
	pveh[playerid] = CreateVehicle(modelid, x, y, z, angle + 90.0, -1, -1, -1);
	SendClientMessage(playerid, 0xFFFF00FF, string);
	return 1;
}

