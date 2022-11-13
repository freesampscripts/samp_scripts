stock pmc_GivePlayerMoney(playerid, amount)
{
	if(!IsPlayerConnected(playerid) || IsPlayerNPC(playerid)) return 0;
	GivePlayerMoney(playerid, amount);
    SetPVarInt(playerid, "pmc_time", gettime() + 2);
    CallRemoteFunction("pmcc", "dd", playerid, amount);
    return 1;
}

#if defined _ALS_GivePlayerMoney
    #undef GivePlayerMoney
#else
    #define _ALS_GivePlayerMoney
#endif
#define GivePlayerMoney pmc_GivePlayerMoney

#if defined PMC_HERE

#include <YSI_Data\y_iterate>
#include <YSI_Coding\y_timers>
#include <YSI_Coding\y_hooks>

static PlayerText:__player_money[MAX_PLAYERS] = {PlayerText:0xFFFF,...};

forward pmcc(playerid, amount);

public pmcc(playerid, amount)
{
	new string[21];
	if(amount > -1)
	{
		format(string, 12, "+$%d", amount);
		PlayerTextDrawSetString(playerid, __player_money[playerid], string);
		return 1;
	}
	format(string, 21, "~r~~h~~h~-$%d", amount * -1);
	PlayerTextDrawSetString(playerid, __player_money[playerid], string);
	return 1;
}

hook OnPlayerConnect(playerid)
{
	if(!IsPlayerConnected(playerid) || IsPlayerNPC(playerid)) return 1;
	__player_money[playerid] = CreatePlayerTextDraw(playerid, 607.6342, 99.2883, ""); 
	PlayerTextDrawLetterSize(playerid, __player_money[playerid], 0.5495, 2.2177);
	PlayerTextDrawAlignment(playerid, __player_money[playerid], 3);
	PlayerTextDrawColor(playerid, __player_money[playerid], -1728606209);
	PlayerTextDrawSetOutline(playerid, __player_money[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, __player_money[playerid], 255);
	PlayerTextDrawFont(playerid, __player_money[playerid], 3);
	PlayerTextDrawSetProportional(playerid, __player_money[playerid], 1);
	PlayerTextDrawSetShadow(playerid, __player_money[playerid], 0);
	PlayerTextDrawShow(playerid, __player_money[playerid]);
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	if(!IsPlayerConnected(playerid) || IsPlayerNPC(playerid)) return 1;
	PlayerTextDrawDestroy(playerid, __player_money[playerid]);
	__player_money[playerid] = PlayerText:0xFFFF;
	return 1;
}

task ___pmc[500]()
{
	new pmccc, pmctime = gettime();
	foreach(new i: Player)
	{
		pmccc = GetPVarInt(i, "pmc_time");
		if(!pmccc) continue;
		if(pmctime <= pmccc) continue;
		PlayerTextDrawSetString(i, __player_money[i], "");
		SetPVarInt(i, "pmc_time", 0);
	}
}

#endif
