/*******************************************************************************
 * AltTechTree generated by Eliot.UELib using UE Explorer.
 * Eliot.UELib © 2009-2015 Eliot van Uytfanghe. All rights reserved.
 * http://eliotvu.com
 *
 * All rights belong to their respective owners.
 *******************************************************************************/
class AltTechTree extends XGTechTree
    config(AltTree)
    hidecategories(Navigation,Navigation,Navigation,Navigation,Navigation);

struct native TAltTechBalance
{
    var XComGame.XGGameData.ETechType eTech;
    var int iTime;
    var int iAlloys;
    var int iElerium;
    var int iNumFragments;
    var int iNumItems;

    structdefaultproperties
    {
        eTech=ETechType.eTech_None
        iTime=0
        iAlloys=0
        iElerium=0
        iNumFragments=0
        iNumItems=0
    }
};

struct TAltFoundryBalance
{
    var XComGame.XGGameData.EFoundryTech eFTech;
    var int iTime;
    var int iEngineers;
    var int iCash;
    var int iAlloys;
    var int iElerium;
    var int iFragments;
    var int iNumItems;
    var XComGame.XGGameData.EItemType eReqItem;
    var XComGame.XGGameData.ETechType eReqTech;

    structdefaultproperties
    {
        eFTech=EFoundryTech.eFoundry_None
        iTime=0
        iEngineers=0
        iCash=0
        iAlloys=0
        iElerium=0
        iFragments=0
        iNumItems=0
        eReqItem=EItemType.eItem_NONE
        eReqTech=ETechType.eTech_None
    }
};

struct TGeneMods
{
    var int iFatigue;
    var int iInjury;

    structdefaultproperties
    {
        iFatigue=0
        iInjury=0
    }
};

struct THiringWidget
{
    var TText txtTitle;
    var TLabeledText txtFacilityCap;
    var TLabeledText txtCost;
    var TText txtNumToHire;
    var TButtonText txtButtonHelp;
    var TImage imgStaff;
    var TLabeledText txtMoney;

    structdefaultproperties
    {
        txtTitle=(StrValue="",iState=0)
        txtFacilityCap=(StrValue="",strLabel="",iState=0,bNumber=false)
        txtCost=(StrValue="",strLabel="",iState=0,bNumber=false)
        txtNumToHire=(StrValue="",iState=0)
        txtButtonHelp=(StrValue="",iState=0,iButton=0)
        imgStaff=(iImage=0,strLabel="",iState=0,strPath="")
        txtMoney=(StrValue="",strLabel="",iState=0,bNumber=false)
    }
};

var bool bTechAdjust;
var THiringWidget m_kHiring;
var const localized string altTechTypeNames[76];
var const localized string altTechTypeSummary[76];
var const localized string altTechTypeReport[76];
var const localized string altTechTypeCodeName[76];
var const localized string altTechTypeResults[76];
var const localized string FoundryTechNames[60];
var const localized string FoundryTechSummary[60];
var config array<config TAltTechBalance> altTechBalance;
var config array<config TAltFoundryBalance> altFoundryBalance;
var config array<config TGeneMods> geneMods;
var int notfun;

function Init()
{
    LogInternal("This is 2");
    BuildAltTechs();
    BuildAltFoundryTechs();
    BuildAltOTSTechs();
    BuildObjectives();
    BuildResearchCredits();
    BuildGeneTechs();
    //return;    
}

function XGTechTree TECHTREE()
{
    LogInternal("This Is Alright");
    return XComHeadquartersGame(class'Engine'.static.GetCurrentWorldInfo().Game).GetGameCore().GetHQ().GetLabs().m_kTree;
    //return ReturnValue;    
}

function XGFacility_Barracks BARRACKS()
{
    return XComHeadquartersGame(class'Engine'.static.GetCurrentWorldInfo().Game).GetGameCore().GetHQ().m_kBarracks;
    //return ReturnValue;    
}

function TItem STAFF(int iStaffType)
{
    return ENGINEERING().m_kItems.GetStaff(iStaffType);
    //return ReturnValue;    
}

function XGFacility_Labs LABS()
{
    return XComHeadquartersGame(class'Engine'.static.GetCurrentWorldInfo().Game).GetGameCore().GetHQ().m_kLabs;
    //return ReturnValue;    
}

function XGFacility_Engineering ENGINEERING()
{
    return XComHeadquartersGame(class'Engine'.static.GetCurrentWorldInfo().Game).GetGameCore().GetHQ().m_kEngineering;
    //return ReturnValue;    
}

function XGStorage STORAGE()
{
    return XComHeadquartersGame(class'Engine'.static.GetCurrentWorldInfo().Game).GetGameCore().GetHQ().m_kEngineering.GetStorage();
    //return ReturnValue;    
}

function XGTacticalGameCore theGameCore()
{
    return XComGameReplicationInfo(class'Engine'.static.GetCurrentWorldInfo().GRI).m_kGameCore;
    //return ReturnValue;    
}

function bool IsOptionEnabled(XComGame.XGGameData.EGameplayOption eOption)
{
    return XComHeadquartersGame(class'Engine'.static.GetCurrentWorldInfo().Game).GetGameCore().m_arrSecondWave[eOption] > 0;
    //return ReturnValue;    
}

function TTech TECH(int iTechType)
{
    return XComHeadquartersGame(class'Engine'.static.GetCurrentWorldInfo().Game).GetGameCore().GetHQ().GetLabs().m_kTree.GetTech(iTechType);
    //return ReturnValue;    
}

function XGGeoscape GEOSCAPE()
{
    return XComHeadquartersGame(class'Engine'.static.GetCurrentWorldInfo().Game).GetGameCore().GetGeoscape();
    //return ReturnValue;    
}

function BuildAltTechs()
{
    LogInternal("This Is Tech");
    m_arrTechs.Add(76);
    BuildTech(1, 1, true, 134,, 42);
    BuildTech(2, 1, false, 134, 1, 3);
    BuildTech(3, 1, true, 183, 4, 10);
    BuildTech(4, 1, true, 164, 1, 26);
    BuildTech(5, 1, true, 170, 12, 17);
    BuildTech(6, 1, true, 135, 13, 65);
    BuildTech(7, 1, false, 171, 2, 21);
    BuildTech(8, 1, false, 180, 43, 35);
    BuildTech(9, 1, false,,, 0);
    BuildTech(10, 1, false, 164,, 1);
    BuildTech(11, 1, true,, 10, 16);
    BuildTech(12, 1, false,, 10, 14);
    BuildTech(13, 1, false, 164, 1, 68);
    BuildTech(14, 1, true, 164, 3, 9);
    BuildTech(15, 1, true,, 72, 5);
    BuildTech(16, 1, true,, 12, 7);
    BuildTech(17, 1, true, 170, 11, 8);
    BuildTech(18, 1, true,, 7, 6);
    BuildTech(19, 1, true,, 5, 4);
    BuildTech(20, 1, true,, 9, 23);
    BuildTech(21, 1, true,, 20, 24);
    BuildTech(22, 1, true, 242, 20, 22);
    BuildTech(23, 1, true, 147, 9, 31);
    BuildTech(24, 1, true, 42, 9, 30);
    BuildTech(25, 1, false, 45, 24, 32);
    BuildTech(26, 1, true, 188, 10, 29);
    BuildTech(27, 1, true,, 9, 34);
    BuildTech(28, 1, true,, 10, 33);
    BuildTech(29, 1, true, 16, 30, 28);
    BuildTech(30, 1, true, 179, 26, 18);
    BuildTech(31, 1, true,, 23, 33);
    BuildTech(32, 1, false, 168,, 39);
    BuildTech(33, 1, true, 170, 12, 40);
    BuildTech(34, 1, false,, 22, 15);
    BuildTech(35, 1, false, 150, 44, 43, 6);
    BuildTech(36, 1, false, 152, 45, 44, 4);
    BuildTech(37, 1, false, 155, 47, 45, 7);
    BuildTech(38, 1, false, 151, 6, 51, 8);
    BuildTech(39, 1, false, 157, 51, 48, 5);
    BuildTech(40, 1, false, 154, 46, 46, 1);
    BuildTech(41, 1, false, 153, 52, 50, 2);
    BuildTech(42, 1, false, 156, 53, 49, 3);
    BuildTech(43, 1, false, 158, 56, 47, 9);
    BuildTech(44, 1, false, 134, 1, 52);
    BuildTech(45, 1, false, 136, 11, 53);
    BuildTech(46, 1, false, 138, 1, 55);
    BuildTech(47, 1, false, 139, 1, 54);
    BuildTech(48, 1, false, 144, 13, 56);
    BuildTech(49, 1, true,, 22, 37);
    BuildTech(50, 1, false, 142, 11, 59);
    BuildTech(51, 1, true, 141, 2, 62);
    BuildTech(52, 1, true, 137, 45, 64);
    BuildTech(53, 1, false, 140, 47, 63);
    BuildTech(54, 1, false, 147, 10, 60);
    BuildTech(55, 1, false, 146, 32, 61);
    BuildTech(56, 1, false, 143, 4, 58);
    BuildTech(57, 1, true, 187, 44, 66);
    BuildTech(58, 1, false, 188, 32, 67);
    BuildTech(59, 1, true,, 3, 36);
    BuildTech(60, 1, true, 164, 11, 66);
    BuildTech(61, 1, true,, 10, 41);
    BuildTech(62, 1, true,, 10, 41);
    BuildTech(63, 1, true,, 10, 41);
    BuildTech(64, 1, true,, 10, 41);
    BuildTech(65, 1, true,, 10, 41);
    BuildTech(66, 1, true,, 10, 41);
    BuildTech(67, 1, true,, 10, 41);
    BuildTech(68, 1, true,, 10, 41);
    BuildTech(69, 1, true,, 10, 41);
    BuildTech(70, 1, true,, 10, 41);
    BuildTech(71, 1, true,, 10, 41);
    BuildTech(72, 1, false,, 10, 5);
    BuildTech(73, 1, true, 164, 48, 66);
    BuildTech(74, 1, true, 164, 17, 66);
    BuildTech(75, 1, true, 164, 17, 66);
    BalanceTechs();
    //return;    
}

function BuildAltFoundryTechs()
{
    LogInternal("This is Foundry");
    m_arrFoundryTechs.Add(60);
    BuildFoundryTech(1, 0, 0,,,,,, 12);
    BuildFoundryTech(2, 0, 0,,,,,, 9);
    BuildFoundryTech(3, 0, 0,,,,,, 3);
    BuildFoundryTech(4, 0, 0,,,,,, 4);
    BuildFoundryTech(5, 0, 0,,,,,, 11);
    BuildFoundryTech(6, 0, 0,,,,,, 6);
    BuildFoundryTech(7, 0, 0,,,,,, 7);
    BuildFoundryTech(8, 0, 0,,,,,, 1);
    BuildFoundryTech(9, 0, 0,,,,,, 2);
    BuildFoundryTech(10, 0, 0,,,,,, 5);
    BuildFoundryTech(11, 0, 0,,,,,, 8);
    BuildFoundryTech(12, 0, 0,,,,,, 11);
    BuildFoundryTech(13, 0, 0,,,,,, 12);
    BuildFoundryTech(14, 0, 0,,,,,, 13);
    BuildFoundryTech(15, 0, 0,,,,,, 14);
    BuildFoundryTech(16, 0, 0,,,,,, 15);
    BuildFoundryTech(17, 0, 0,,,,,, 16);
    BuildFoundryTech(18, 0, 0,,,,,, 17);
    BuildFoundryTech(19, 0, 0,,,,,, 20);
    BuildFoundryTech(20, 0, 0,,,,,, 23);
    BuildFoundryTech(21, 0, 0,,,,,, 18);
    BuildFoundryTech(22, 0, 0,,,,,, 19);
    BuildFoundryTech(23, 0, 0,,,,,, 21);
    BuildFoundryTech(24, 0, 0,,,,,, 22);
    BuildFoundryTech(25, 0, 0,,,,,, 4);
    BuildFoundryTech(26, 0, 0,,,,,, 11);
    BuildFoundryTech(27, 0, 0,,,,,, 11);
    BuildFoundryTech(28, 0, 0,,,,,, 11);
    BuildFoundryTech(29, 0, 0,,,,,, 21);
    BuildFoundryTech(30, 0, 0,,,,,, 3);
    BuildFoundryTech(31, 0, 0,,,,,, 11);
    BuildFoundryTech(32, 0, 0,,,,,, 11);
    BuildFoundryTech(33, 0, 0,,,,,, 20);
    BuildFoundryTech(34, 0, 0,,,,,, 6);
    BuildFoundryTech(35, 0, 0,,,,,, 16);
    BuildFoundryTech(36, 0, 0,,,,,, 18);
    BuildFoundryTech(37, 0, 0,,,,,, 11);
    BuildFoundryTech(38, 0, 0,,,,,, 20);
    BuildFoundryTech(39, 0, 0,,,,,, 4);
    BuildFoundryTech(40, 0, 0,,,,,, 17);
    BuildFoundryTech(41, 0, 0,,,,,, 19);
    BuildFoundryTech(42, 0, 0,,,,,, 17);
    BuildFoundryTech(43, 0, 0,,,,,, 19);
    BuildFoundryTech(44, 0, 0,,,,,, 19);
    BuildFoundryTech(45, 0, 0,,,,,, 19);
    BuildFoundryTech(46, 0, 0,,,,,, 19);
    BuildFoundryTech(47, 0, 0,,,,,, 19);
    BuildFoundryTech(48, 0, 0,,,,,, 19);
    BuildFoundryTech(49, 0, 0,,,,,, 19);
    BuildFoundryTech(50, 0, 0,,,,,, 19);
    BuildFoundryTech(51, 0, 0,,,,,, 19);
    BuildFoundryTech(52, 0, 0,,,,,, 19);
    BuildFoundryTech(53, 0, 0,,,,,, 19);
    BuildFoundryTech(54, 0, 0,,,,,, 19);
    BuildFoundryTech(55, 0, 0,,,,,, 19);
    BuildFoundryTech(56, 0, 0,,,,,, 19);
    BuildFoundryTech(57, 0, 0,,,,,, 19);
    BuildFoundryTech(58, 0, 0,,,,,, 19);
    BalanceFoundry();
    //return;    
}

function BuildAltOTSTechs()
{
    LogInternal("This is OTS");
    BuildOTSTech(7, 6, 275,,, 0);
    BuildOTSTech(1, OTSRank(), 50,,, 1);
    BuildOTSTech(6, OTSRank(), 125,,, 2);
    BuildOTSTech(4, (OTSRank()) + 1, 150,,, 3);
    BuildOTSTech(2, (OTSRank()) + 2, 75,,, 4);
    BuildOTSTech(3, (OTSRank()) + 3, 250,,, 5);
    BuildOTSTech(5, 7, 275,,, 6);
    BuildOTSTech(8, 3, 325,,, 1);
    BuildOTSTech(9, 4, 425,,, 1);
    BuildOTSTech(10, 5, 550,,, 1);
    BuildOTSTech(11, 6, 700,,, 1);
    BalanceOTS();
    //return;    
}
