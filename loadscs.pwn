#include <a_samp>
#include <foreach>
#include <progress2>
#include <YSI\y_timers>

#define BAR_COLOR 0xAAAAAAFF // white

new ldsc;
new Text:loadsc_;
new PlayerBar:loadsct[MAX_PLAYERS] = {PlayerBar:-1,...};
new Float:loadscv[MAX_PLAYERS];

new loadsc[14][18] =
{
	"loadsuk:loadsc1",
	"loadsuk:loadsc2",
	"loadsuk:loadsc3",
	"loadsuk:loadsc4",
	"loadsuk:loadsc5",
	"loadsuk:loadsc6",
	"loadsuk:loadsc7",
	"loadsuk:loadsc8",
	"loadsuk:loadsc9",
	"loadsuk:loadsc10",
	"loadsuk:loadsc11",
	"loadsuk:loadsc12",
	"loadsuk:loadsc13",
	"loadsuk:loadsc14"
};

public OnFilterScriptInit()
{
	loadsc_ = TextDrawCreate(0.000000, 0.000000, "LOADSUK:loadsc1");
	TextDrawTextSize(loadsc_, 640.000000, 451.359771);
	TextDrawAlignment(loadsc_, 1);
	TextDrawColor(loadsc_, -1);
	TextDrawSetShadow(loadsc_, 0);
	TextDrawBackgroundColor(loadsc_, 255);
	TextDrawFont(loadsc_, 4);
	TextDrawSetProportional(loadsc_, 0);
	return 1;
}

public OnFilterScriptExit()
{
	TextDrawDestroy(loadsc_);
	foreach(new i : Player)
	{
	    if(!loadscv[i]) continue;
	    DestroyPlayerProgressBar(i, loadsct[i]);
	    TogglePlayerSpectating(i, 0);
	    ForceClassSelection(i);
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(!IsPlayerNPC(playerid))
	{
	    for(new i = 0; i < 100; i ++)
	    {
	        SendClientMessage(playerid, 0, "");
	    }
	    TextDrawShowForPlayer(playerid, loadsc_);
	    loadsct[playerid] = CreatePlayerProgressBar(playerid, 50.0, 415.0, 170.0, 5.0, BAR_COLOR);
        ShowPlayerProgressBar(playerid, loadsct[playerid]);
		TogglePlayerSpectating(playerid, 1);
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(!IsPlayerNPC(playerid))
	{
	    DestroyPlayerProgressBar(playerid, loadsct[playerid]);
		loadsct[playerid] = PlayerBar:-1;
		loadscv[playerid] = 0.0;
	}
	return 1;
}

task loadsc_update[100]()
{
	new ltime = gettime();
	foreach(new i : Player)
	{
	    if(loadscv[i] >= 100.0) continue;
		if(ldsc != ltime)
		{
			TextDrawSetString(loadsc_, loadsc[random(sizeof(loadsc))]);
			ldsc = ltime;
		}
		loadscv[i] += 1.0;
		loadscv[i] = loadscv[i] >= 100.0 ? 100.0 : loadscv[i];
		SetPlayerProgressBarValue(i, loadsct[i], loadscv[i]);
		if(loadscv[i] == 100.0)
		{
		    TextDrawHideForPlayer(i, loadsc_);
		    HidePlayerProgressBar(i, loadsct[i]);
			TogglePlayerSpectating(i, 0);
			ForceClassSelection(i);
		}
	}
	return 1;
}

