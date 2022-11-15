#include <a_samp>

new Text:wasted;
new Text:wasted2;

public OnFilterScriptInit()
{
	wasted = TextDrawCreate(0.0000, 0.0000, "Box"); 
	TextDrawLetterSize(wasted, 0.0000, 50.7333);
	TextDrawTextSize(wasted, 666.0000, 0.0000);
	TextDrawAlignment(wasted, 1);
	TextDrawColor(wasted, -1);
	TextDrawUseBox(wasted, 1);
	TextDrawBoxColor(wasted, 1077952544);
	TextDrawBackgroundColor(wasted, 255);
	TextDrawFont(wasted, 1);
	TextDrawSetProportional(wasted, 1);
	TextDrawSetShadow(wasted, 0);
	wasted2 = TextDrawCreate(320.0000, 159.1996, "~r~wasted"); 
	TextDrawLetterSize(wasted2, 0.4880, 5.8891);
	TextDrawTextSize(wasted2, 0.0000, 639.0000);
	TextDrawAlignment(wasted2, 2);
	TextDrawColor(wasted2, -1);
	TextDrawUseBox(wasted2, 1);
	TextDrawBoxColor(wasted2, 85);
	TextDrawBackgroundColor(wasted2, 255);
	TextDrawFont(wasted2, 1);
	TextDrawSetProportional(wasted2, 1);
	TextDrawSetShadow(wasted2, 0);
	return 1;
}

public OnFilterScriptExit()
{
	TextDrawDestroy(wasted);
	TextDrawDestroy(wasted2);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	TextDrawShowForPlayer(playerid, wasted);
	TextDrawShowForPlayer(playerid, wasted2);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate != 7 && oldstate == 7)
	{
		TextDrawHideForPlayer(playerid, wasted);
		TextDrawHideForPlayer(playerid, wasted2);	
	}
	return 1;
}
