#include <a_samp>
#include <YSI_Coding\y_timers>
#include <YSI_Data\y_iterate>
#include <zcmd>

new Iterator:rainbow_pool<MAX_PLAYERS>;
new rainbow[MAX_PLAYERS];

public OnPlayerDisconnect(playerid, reason)
{
	if(rainbow[playerid])
	{
		if (GetPlayerState(playerid) == 2) Iter_Remove(rainbow_pool, playerid);
		rainbow[playerid] = 0;
	}
	return 1;
}

CMD:rainbow(playerid, params[])
{
	if (!rainbow[playerid])
	{
		rainbow[playerid] = 1;
		if (GetPlayerState(playerid) == 2) Iter_Add(rainbow_pool, playerid);
		SendClientMessage(playerid, -1, "Rainbow: {00FF00}ON");
		return 1;
	}
	if (GetPlayerState(playerid) == 2) Iter_Remove(rainbow_pool, playerid);
	rainbow[playerid] = 0;
	SendClientMessage(playerid, -1, "Rainbow: {FF0000}OFF");
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if (newstate == 2 && oldstate != 2 && rainbow[playerid])
	{
		Iter_Add(rainbow_pool, playerid);
	}
	if (newstate != 2 && oldstate == rainbow[playerid])
	{
		Iter_Remove(rainbow_pool, playerid);
	}
	return 1;
}

task rainbowupdate[100]()
{
	foreach(new i: rainbow_pool)
	{
		ChangeVehicleColor(GetPlayerVehicleID(i), random(255), random(255));
	}
	return 1;
}
