/*******************************************************************************
 * AltTechTreeMutate generated by Eliot.UELib using UE Explorer.
 * Eliot.UELib © 2009-2015 Eliot van Uytfanghe. All rights reserved.
 * http://eliotvu.com
 *
 * All rights belong to their respective owners.
 *******************************************************************************/
class AltTechTreeMutate extends XComMutator
    config(AltTree)
    hidecategories(Navigation,Movement,Collision,Navigation);

enum EWeaponSort
{
    eWeaponSort_None,
    eWeaponSort_Ballistic,
    eWeaponSort_Beam,
    eWeaponSort_Gauss,
    eWeaponSort_Pulse,
    eWeaponSort_Fusion,
    eWeaponSort_EMP,
    eWeaponSort_Plasma,
    eWeaponSort_MAX
};

enum EArmorSort
{
    eArmorSort_None,
    eArmorSort_Light,
    eArmorSort_Medium,
    eArmorSort_Heavy,
    eArmorSort_MECArmor,
    eArmorSort_SHIVArmor,
    eArmorSort_MAX
};

struct TWeaponMods
{
    var AltTechTreeMutate.EWeaponSort EWeaponSort;
    var bool bApplied;
    var int eTech;
    var int eFTech;
    var int iDamage;
    var int iAim;
    var int iCritical;
    var int iRange;
    var int iAmmo;

    structdefaultproperties
    {
        EWeaponSort=EWeaponSort.eWeaponSort_None
        bApplied=false
        eTech=0
        eFTech=0
        iDamage=0
        iAim=0
        iCritical=0
        iRange=0
        iAmmo=0
    }
};

struct TArmorMods
{
    var AltTechTreeMutate.EArmorSort EArmorSort;
    var bool bApplied;
    var int eTech;
    var int eFTech;
    var int iHPBonus;
    var int iDefenseBonus;
    var int iMobilityBonus;

    structdefaultproperties
    {
        EArmorSort=EArmorSort.eArmorSort_None
        bApplied=false
        eTech=0
        eFTech=0
        iHPBonus=0
        iDefenseBonus=0
        iMobilityBonus=0
    }
};

var config array<config XComGame.XGGameData.EItemType> ballisticWeapons;
var config array<config XComGame.XGGameData.EItemType> beamWeapons;
var config array<config XComGame.XGGameData.EItemType> gaussWeapons;
var config array<config XComGame.XGGameData.EItemType> pulseWeapons;
var config array<config XComGame.XGGameData.EItemType> fusionWeapons;
var config array<config XComGame.XGGameData.EItemType> empWeapons;
var config array<config XComGame.XGGameData.EItemType> plasmaWeapons;
var config array<config XComGame.XGGameData.EItemType> lightArmor;
var config array<config XComGame.XGGameData.EItemType> mediumArmor;
var config array<config XComGame.XGGameData.EItemType> heavyArmor;
var config array<config XComGame.XGGameData.EItemType> MECArmor;
var config array<config XComGame.XGGameData.EItemType> SHIVArmor;
var config array<config TWeaponMods> weaponMods;
var config array<config TArmorMods> armorMods;
var AltTechTree m_kAltTree;
var AltItemTree m_kAltItems;

function AltTechTree AltTree()
{
    return m_kAltTree;
    //return ReturnValue;    
}

function XGTechTree TECHTREE()
{
    LogInternal("This Is Alright");
    return XComHeadquartersGame(class'Engine'.static.GetCurrentWorldInfo().Game).GetGameCore().GetHQ().GetLabs().m_kTree;
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

function Mutate(string MutateString, PlayerController Sender)
{
    local XGFacility_Labs iLab;
    local XGFacility_Engineering iItem;
    local XComGame.XGGameData.ETechType eTech;
    local bool bIsAvailable;

    LogInternal("This is 1");
    // End:0xA8
    if(MutateString == "XGFacility_Labs.Init")
    {
        m_kAltTree = Spawn(class'AltTechTree');
        // End:0xA7
        foreach AllActors(class'XGFacility_Labs', iLab)
        {
            LogInternal("This is Fun");
            iLab.m_kTree = m_kAltTree;            
        }        
    }
    // End:0x14D
    if(MutateString == "XGFacility_Engineering.Init")
    {
        m_kAltItems = Spawn(class'AltItemTree');
        // End:0x14C
        foreach AllActors(class'XGFacility_Engineering', iItem)
        {
            LogInternal("This is Success");
            iItem.m_kItems = m_kAltItems;            
        }        
    }
    // End:0x19D
    if(MutateString == "XGHeadQuarters.InitLoadGame")
    {
        LogInternal("This is Load");
        BuildWeaponMods();
        BuildArmorMods();
    }
    // End:0x1F5
    if(MutateString == "XGFacility_Labs.OnResearchCompleted")
    {
        LogInternal("This is Labs");
        BuildWeaponMods();
        BuildArmorMods();
    }
    // End:0x261
    if(MutateString == "XGFacility_Engineering.OnFoundryProjectCompleted")
    {
        LogInternal("This is Engineering");
        BuildWeaponMods();
        BuildArmorMods();
    }
    super.Mutate(MutateString, Sender);
    //return;    
}

function HeadQuartersInitNewGame(PlayerController Sender)
{
    LogInternal("This is 2");
    // End:0x44
    if(IsOptionEnabled(30))
    {
        LogInternal("This is New");
        BuildWeaponMods();
        BuildArmorMods();
    }
    // End:0x46
    else
    {
        return;
    }
    //return;    
}

function BuildWeaponMods()
{
    local int iWeaponMods, iItem;
    local TWeapon kWeapon;
    local TConfigWeapon kConfig;

    LogInternal("This is Tough");
    iWeaponMods = 0;
    J0x1D:
    // End:0x2576 [Loop If]
    if(iWeaponMods < weaponMods.Length)
    {
        LogInternal("iWeaponMods=" $ string(iWeaponMods));
        LogInternal("WeaponMods.Length=" $ string(weaponMods.Length));
        LogInternal("This is 4");
        // End:0x2568
        if(!weaponMods[iWeaponMods].bApplied && ((weaponMods[iWeaponMods].eTech == 0) || LABS().IsResearched(weaponMods[iWeaponMods].eTech)) && (weaponMods[iWeaponMods].eFTech == 0) || ENGINEERING().IsFoundryTechResearched(weaponMods[iWeaponMods].eFTech))
        {
            LogInternal("This is something");
            LogInternal("ballisticWeapons.Length=" $ string(ballisticWeapons.Length));
            switch(weaponMods[iWeaponMods].EWeaponSort)
            {
                // End:0x736
                case 1:
                    LogInternal("This is progress");
                    iItem = 0;
                    J0x23A:
                    // End:0x70A [Loop If]
                    if(iItem < ballisticWeapons.Length)
                    {
                        LogInternal("This is Ballistic");
                        kWeapon = theGameCore().m_arrWeapons[ballisticWeapons[iItem]];
                        kConfig = theGameCore().Weapons[ballisticWeapons[iItem]];
                        kWeapon.iDamage += weaponMods[iWeaponMods].iDamage;
                        kWeapon.iOffenseBonus += weaponMods[iWeaponMods].iAim;
                        kWeapon.iCritical += weaponMods[iWeaponMods].iCritical;
                        kWeapon.iRange += weaponMods[iWeaponMods].iRange;
                        kWeapon.iSuppression += weaponMods[iWeaponMods].iAmmo;
                        kConfig.iDamage += weaponMods[iWeaponMods].iDamage;
                        kConfig.iOffenseBonus += weaponMods[iWeaponMods].iAim;
                        kConfig.iCritical += weaponMods[iWeaponMods].iCritical;
                        kConfig.iRange += weaponMods[iWeaponMods].iRange;
                        kConfig.iSuppression += weaponMods[iWeaponMods].iAmmo;
                        LogInternal("iItem=" $ string(iItem));
                        LogInternal("Damage=" $ string(kWeapon.iDamage));
                        LogInternal("Aim=" $ string(kWeapon.iOffenseBonus));
                        LogInternal("Critical=" $ string(kWeapon.iCritical));
                        LogInternal("Range=" $ string(kWeapon.iRange));
                        LogInternal("Ammo=" $ string(kWeapon.iSuppression));
                        theGameCore().Weapons[ballisticWeapons[iItem]] = kConfig;
                        theGameCore().m_arrWeapons[ballisticWeapons[iItem]] = kWeapon;
                        ++ iItem;
                        // [Loop Continue]
                        goto J0x23A;
                    }
                    weaponMods[iWeaponMods].bApplied = true;
                    // End:0x2568
                    break;
                // End:0xC3D
                case 2:
                    iItem = 0;
                    J0x746:
                    // End:0xC11 [Loop If]
                    if(iItem < beamWeapons.Length)
                    {
                        LogInternal("This is Beam");
                        kWeapon = theGameCore().m_arrWeapons[beamWeapons[iItem]];
                        kConfig = theGameCore().Weapons[beamWeapons[iItem]];
                        kWeapon.iDamage += weaponMods[iWeaponMods].iDamage;
                        kWeapon.iOffenseBonus += weaponMods[iWeaponMods].iAim;
                        kWeapon.iCritical += weaponMods[iWeaponMods].iCritical;
                        kWeapon.iRange += weaponMods[iWeaponMods].iRange;
                        kWeapon.iSuppression += weaponMods[iWeaponMods].iAmmo;
                        kConfig.iDamage += weaponMods[iWeaponMods].iDamage;
                        kConfig.iOffenseBonus += weaponMods[iWeaponMods].iAim;
                        kConfig.iCritical += weaponMods[iWeaponMods].iCritical;
                        kConfig.iRange += weaponMods[iWeaponMods].iRange;
                        kConfig.iSuppression += weaponMods[iWeaponMods].iAmmo;
                        LogInternal("iItem=" $ string(iItem));
                        LogInternal("Damage=" $ string(kWeapon.iDamage));
                        LogInternal("Aim=" $ string(kWeapon.iOffenseBonus));
                        LogInternal("Critical=" $ string(kWeapon.iCritical));
                        LogInternal("Range=" $ string(kWeapon.iRange));
                        LogInternal("Ammo=" $ string(kWeapon.iSuppression));
                        theGameCore().Weapons[beamWeapons[iItem]] = kConfig;
                        theGameCore().m_arrWeapons[beamWeapons[iItem]] = kWeapon;
                        ++ iItem;
                        // [Loop Continue]
                        goto J0x746;
                    }
                    weaponMods[iWeaponMods].bApplied = true;
                    // End:0x2568
                    break;
                // End:0x1145
                case 3:
                    iItem = 0;
                    J0xC4D:
                    // End:0x1119 [Loop If]
                    if(iItem < gaussWeapons.Length)
                    {
                        LogInternal("This is Gauss");
                        kWeapon = theGameCore().m_arrWeapons[gaussWeapons[iItem]];
                        kConfig = theGameCore().Weapons[gaussWeapons[iItem]];
                        kWeapon.iDamage += weaponMods[iWeaponMods].iDamage;
                        kWeapon.iOffenseBonus += weaponMods[iWeaponMods].iAim;
                        kWeapon.iCritical += weaponMods[iWeaponMods].iCritical;
                        kWeapon.iRange += weaponMods[iWeaponMods].iRange;
                        kWeapon.iSuppression += weaponMods[iWeaponMods].iAmmo;
                        kConfig.iDamage += weaponMods[iWeaponMods].iDamage;
                        kConfig.iOffenseBonus += weaponMods[iWeaponMods].iAim;
                        kConfig.iCritical += weaponMods[iWeaponMods].iCritical;
                        kConfig.iRange += weaponMods[iWeaponMods].iRange;
                        kConfig.iSuppression += weaponMods[iWeaponMods].iAmmo;
                        LogInternal("iItem=" $ string(iItem));
                        LogInternal("Damage=" $ string(kWeapon.iDamage));
                        LogInternal("Aim=" $ string(kWeapon.iOffenseBonus));
                        LogInternal("Critical=" $ string(kWeapon.iCritical));
                        LogInternal("Range=" $ string(kWeapon.iRange));
                        LogInternal("Ammo=" $ string(kWeapon.iSuppression));
                        theGameCore().Weapons[gaussWeapons[iItem]] = kConfig;
                        theGameCore().m_arrWeapons[gaussWeapons[iItem]] = kWeapon;
                        ++ iItem;
                        // [Loop Continue]
                        goto J0xC4D;
                    }
                    weaponMods[iWeaponMods].bApplied = true;
                    // End:0x2568
                    break;
                // End:0x164D
                case 4:
                    iItem = 0;
                    J0x1155:
                    // End:0x1621 [Loop If]
                    if(iItem < pulseWeapons.Length)
                    {
                        LogInternal("This is Pulse");
                        kWeapon = theGameCore().m_arrWeapons[pulseWeapons[iItem]];
                        kConfig = theGameCore().Weapons[pulseWeapons[iItem]];
                        kWeapon.iDamage += weaponMods[iWeaponMods].iDamage;
                        kWeapon.iOffenseBonus += weaponMods[iWeaponMods].iAim;
                        kWeapon.iCritical += weaponMods[iWeaponMods].iCritical;
                        kWeapon.iRange += weaponMods[iWeaponMods].iRange;
                        kWeapon.iSuppression += weaponMods[iWeaponMods].iAmmo;
                        kConfig.iDamage += weaponMods[iWeaponMods].iDamage;
                        kConfig.iOffenseBonus += weaponMods[iWeaponMods].iAim;
                        kConfig.iCritical += weaponMods[iWeaponMods].iCritical;
                        kConfig.iRange += weaponMods[iWeaponMods].iRange;
                        kConfig.iSuppression += weaponMods[iWeaponMods].iAmmo;
                        LogInternal("iItem=" $ string(iItem));
                        LogInternal("Damage=" $ string(kWeapon.iDamage));
                        LogInternal("Aim=" $ string(kWeapon.iOffenseBonus));
                        LogInternal("Critical=" $ string(kWeapon.iCritical));
                        LogInternal("Range=" $ string(kWeapon.iRange));
                        LogInternal("Ammo=" $ string(kWeapon.iSuppression));
                        theGameCore().Weapons[pulseWeapons[iItem]] = kConfig;
                        theGameCore().m_arrWeapons[pulseWeapons[iItem]] = kWeapon;
                        ++ iItem;
                        // [Loop Continue]
                        goto J0x1155;
                    }
                    weaponMods[iWeaponMods].bApplied = true;
                    // End:0x2568
                    break;
                // End:0x1B56
                case 5:
                    iItem = 0;
                    J0x165D:
                    // End:0x1B2A [Loop If]
                    if(iItem < fusionWeapons.Length)
                    {
                        LogInternal("This is Fusion");
                        kWeapon = theGameCore().m_arrWeapons[fusionWeapons[iItem]];
                        kConfig = theGameCore().Weapons[fusionWeapons[iItem]];
                        kWeapon.iDamage += weaponMods[iWeaponMods].iDamage;
                        kWeapon.iOffenseBonus += weaponMods[iWeaponMods].iAim;
                        kWeapon.iCritical += weaponMods[iWeaponMods].iCritical;
                        kWeapon.iRange += weaponMods[iWeaponMods].iRange;
                        kWeapon.iSuppression += weaponMods[iWeaponMods].iAmmo;
                        kConfig.iDamage += weaponMods[iWeaponMods].iDamage;
                        kConfig.iOffenseBonus += weaponMods[iWeaponMods].iAim;
                        kConfig.iCritical += weaponMods[iWeaponMods].iCritical;
                        kConfig.iRange += weaponMods[iWeaponMods].iRange;
                        kConfig.iSuppression += weaponMods[iWeaponMods].iAmmo;
                        LogInternal("iItem=" $ string(iItem));
                        LogInternal("Damage=" $ string(kWeapon.iDamage));
                        LogInternal("Aim=" $ string(kWeapon.iOffenseBonus));
                        LogInternal("Critical=" $ string(kWeapon.iCritical));
                        LogInternal("Range=" $ string(kWeapon.iRange));
                        LogInternal("Ammo=" $ string(kWeapon.iSuppression));
                        theGameCore().Weapons[fusionWeapons[iItem]] = kConfig;
                        theGameCore().m_arrWeapons[fusionWeapons[iItem]] = kWeapon;
                        ++ iItem;
                        // [Loop Continue]
                        goto J0x165D;
                    }
                    weaponMods[iWeaponMods].bApplied = true;
                    // End:0x2568
                    break;
                // End:0x205C
                case 6:
                    iItem = 0;
                    J0x1B66:
                    // End:0x2030 [Loop If]
                    if(iItem < empWeapons.Length)
                    {
                        LogInternal("This is EMP");
                        kWeapon = theGameCore().m_arrWeapons[empWeapons[iItem]];
                        kConfig = theGameCore().Weapons[empWeapons[iItem]];
                        kWeapon.iDamage += weaponMods[iWeaponMods].iDamage;
                        kWeapon.iOffenseBonus += weaponMods[iWeaponMods].iAim;
                        kWeapon.iCritical += weaponMods[iWeaponMods].iCritical;
                        kWeapon.iRange += weaponMods[iWeaponMods].iRange;
                        kWeapon.iSuppression += weaponMods[iWeaponMods].iAmmo;
                        kConfig.iDamage += weaponMods[iWeaponMods].iDamage;
                        kConfig.iOffenseBonus += weaponMods[iWeaponMods].iAim;
                        kConfig.iCritical += weaponMods[iWeaponMods].iCritical;
                        kConfig.iRange += weaponMods[iWeaponMods].iRange;
                        kConfig.iSuppression += weaponMods[iWeaponMods].iAmmo;
                        LogInternal("iItem=" $ string(iItem));
                        LogInternal("Damage=" $ string(kWeapon.iDamage));
                        LogInternal("Aim=" $ string(kWeapon.iOffenseBonus));
                        LogInternal("Critical=" $ string(kWeapon.iCritical));
                        LogInternal("Range=" $ string(kWeapon.iRange));
                        LogInternal("Ammo=" $ string(kWeapon.iSuppression));
                        theGameCore().Weapons[empWeapons[iItem]] = kConfig;
                        theGameCore().m_arrWeapons[empWeapons[iItem]] = kWeapon;
                        ++ iItem;
                        // [Loop Continue]
                        goto J0x1B66;
                    }
                    weaponMods[iWeaponMods].bApplied = true;
                    // End:0x2568
                    break;
                // End:0x2565
                case 7:
                    iItem = 0;
                    J0x206C:
                    // End:0x2539 [Loop If]
                    if(iItem < plasmaWeapons.Length)
                    {
                        LogInternal("This is Plasma");
                        kWeapon = theGameCore().m_arrWeapons[plasmaWeapons[iItem]];
                        kConfig = theGameCore().Weapons[plasmaWeapons[iItem]];
                        kWeapon.iDamage += weaponMods[iWeaponMods].iDamage;
                        kWeapon.iOffenseBonus += weaponMods[iWeaponMods].iAim;
                        kWeapon.iCritical += weaponMods[iWeaponMods].iCritical;
                        kWeapon.iRange += weaponMods[iWeaponMods].iRange;
                        kWeapon.iSuppression += weaponMods[iWeaponMods].iAmmo;
                        kConfig.iDamage += weaponMods[iWeaponMods].iDamage;
                        kConfig.iOffenseBonus += weaponMods[iWeaponMods].iAim;
                        kConfig.iCritical += weaponMods[iWeaponMods].iCritical;
                        kConfig.iRange += weaponMods[iWeaponMods].iRange;
                        kConfig.iSuppression += weaponMods[iWeaponMods].iAmmo;
                        LogInternal("iItem=" $ string(iItem));
                        LogInternal("Damage=" $ string(kWeapon.iDamage));
                        LogInternal("Aim=" $ string(kWeapon.iOffenseBonus));
                        LogInternal("Critical=" $ string(kWeapon.iCritical));
                        LogInternal("Range=" $ string(kWeapon.iRange));
                        LogInternal("Ammo=" $ string(kWeapon.iSuppression));
                        theGameCore().Weapons[plasmaWeapons[iItem]] = kConfig;
                        theGameCore().m_arrWeapons[plasmaWeapons[iItem]] = kWeapon;
                        ++ iItem;
                        // [Loop Continue]
                        goto J0x206C;
                    }
                    weaponMods[iWeaponMods].bApplied = true;
                    // End:0x2568
                    break;
                // End:0xFFFF
                default:
                }
                ++ iWeaponMods;
                // [Loop Continue]
                goto J0x1D;
            }
            //return;            
}

function BuildArmorMods()
{
    local int iArmorMods, iItem;
    local TArmor kArmor;
    local TConfigArmor kConfig;

    iArmorMods = 0;
    J0x0B:
    // End:0x13D2 [Loop If]
    if(iArmorMods < armorMods.Length)
    {
        // End:0x13C4
        if(!armorMods[iArmorMods].bApplied && ((armorMods[iArmorMods].eTech == 0) || LABS().IsResearched(armorMods[iArmorMods].eTech)) && (armorMods[iArmorMods].eFTech == 0) || ENGINEERING().IsFoundryTechResearched(armorMods[iArmorMods].eFTech))
        {
            switch(armorMods[iArmorMods].EArmorSort)
            {
                // End:0x51B
                case 1:
                    iItem = 0;
                    J0x181:
                    // End:0x4EF [Loop If]
                    if(iItem < lightArmor.Length)
                    {
                        LogInternal("This is Light");
                        kArmor = theGameCore().m_arrArmors[lightArmor[iItem]];
                        kConfig = theGameCore().Armors[lightArmor[iItem]];
                        kArmor.iHPBonus += armorMods[iArmorMods].iHPBonus;
                        kArmor.iDefenseBonus += armorMods[iArmorMods].iDefenseBonus;
                        kArmor.iMobilityBonus += armorMods[iArmorMods].iMobilityBonus;
                        kConfig.iHPBonus += armorMods[iArmorMods].iHPBonus;
                        kConfig.iDefenseBonus += armorMods[iArmorMods].iDefenseBonus;
                        kConfig.iMobilityBonus += armorMods[iArmorMods].iMobilityBonus;
                        LogInternal("iItem=" $ string(iItem));
                        LogInternal("HPBonus=" $ string(kArmor.iHPBonus));
                        LogInternal("DefenseB=" $ string(kArmor.iDefenseBonus));
                        LogInternal("MobilityB=" $ string(kArmor.iMobilityBonus));
                        theGameCore().Armors[lightArmor[iItem]] = kConfig;
                        theGameCore().m_arrArmors[lightArmor[iItem]] = kArmor;
                        ++ iItem;
                        // [Loop Continue]
                        goto J0x181;
                    }
                    armorMods[iArmorMods].bApplied = true;
                    // End:0x13C4
                    break;
                // End:0x8C6
                case 2:
                    iItem = 0;
                    J0x52B:
                    // End:0x89A [Loop If]
                    if(iItem < mediumArmor.Length)
                    {
                        LogInternal("This is Medium");
                        kArmor = theGameCore().m_arrArmors[mediumArmor[iItem]];
                        kConfig = theGameCore().Armors[mediumArmor[iItem]];
                        kArmor.iHPBonus += armorMods[iArmorMods].iHPBonus;
                        kArmor.iDefenseBonus += armorMods[iArmorMods].iDefenseBonus;
                        kArmor.iMobilityBonus += armorMods[iArmorMods].iMobilityBonus;
                        kConfig.iHPBonus += armorMods[iArmorMods].iHPBonus;
                        kConfig.iDefenseBonus += armorMods[iArmorMods].iDefenseBonus;
                        kConfig.iMobilityBonus += armorMods[iArmorMods].iMobilityBonus;
                        LogInternal("iItem=" $ string(iItem));
                        LogInternal("HPBonus=" $ string(kArmor.iHPBonus));
                        LogInternal("DefenseB=" $ string(kArmor.iDefenseBonus));
                        LogInternal("MobilityB=" $ string(kArmor.iMobilityBonus));
                        theGameCore().Armors[mediumArmor[iItem]] = kConfig;
                        theGameCore().m_arrArmors[mediumArmor[iItem]] = kArmor;
                        ++ iItem;
                        // [Loop Continue]
                        goto J0x52B;
                    }
                    armorMods[iArmorMods].bApplied = true;
                    // End:0x13C4
                    break;
                // End:0xC70
                case 3:
                    iItem = 0;
                    J0x8D6:
                    // End:0xC44 [Loop If]
                    if(iItem < heavyArmor.Length)
                    {
                        LogInternal("This is Heavy");
                        kArmor = theGameCore().m_arrArmors[heavyArmor[iItem]];
                        kConfig = theGameCore().Armors[heavyArmor[iItem]];
                        kArmor.iHPBonus += armorMods[iArmorMods].iHPBonus;
                        kArmor.iDefenseBonus += armorMods[iArmorMods].iDefenseBonus;
                        kArmor.iMobilityBonus += armorMods[iArmorMods].iMobilityBonus;
                        kConfig.iHPBonus += armorMods[iArmorMods].iHPBonus;
                        kConfig.iDefenseBonus += armorMods[iArmorMods].iDefenseBonus;
                        kConfig.iMobilityBonus += armorMods[iArmorMods].iMobilityBonus;
                        LogInternal("iItem=" $ string(iItem));
                        LogInternal("HPBonus=" $ string(kArmor.iHPBonus));
                        LogInternal("DefenseB=" $ string(kArmor.iDefenseBonus));
                        LogInternal("MobilityB=" $ string(kArmor.iMobilityBonus));
                        theGameCore().Armors[heavyArmor[iItem]] = kConfig;
                        theGameCore().m_arrArmors[heavyArmor[iItem]] = kArmor;
                        ++ iItem;
                        // [Loop Continue]
                        goto J0x8D6;
                    }
                    armorMods[iArmorMods].bApplied = true;
                    // End:0x13C4
                    break;
                // End:0x1018
                case 4:
                    iItem = 0;
                    J0xC80:
                    // End:0xFEC [Loop If]
                    if(iItem < MECArmor.Length)
                    {
                        LogInternal("This is MEC");
                        kArmor = theGameCore().m_arrArmors[MECArmor[iItem]];
                        kConfig = theGameCore().Armors[MECArmor[iItem]];
                        kArmor.iHPBonus += armorMods[iArmorMods].iHPBonus;
                        kArmor.iDefenseBonus += armorMods[iArmorMods].iDefenseBonus;
                        kArmor.iMobilityBonus += armorMods[iArmorMods].iMobilityBonus;
                        kConfig.iHPBonus += armorMods[iArmorMods].iHPBonus;
                        kConfig.iDefenseBonus += armorMods[iArmorMods].iDefenseBonus;
                        kConfig.iMobilityBonus += armorMods[iArmorMods].iMobilityBonus;
                        LogInternal("iItem=" $ string(iItem));
                        LogInternal("HPBonus=" $ string(kArmor.iHPBonus));
                        LogInternal("DefenseB=" $ string(kArmor.iDefenseBonus));
                        LogInternal("MobilityB=" $ string(kArmor.iMobilityBonus));
                        theGameCore().Armors[MECArmor[iItem]] = kConfig;
                        theGameCore().m_arrArmors[MECArmor[iItem]] = kArmor;
                        ++ iItem;
                        // [Loop Continue]
                        goto J0xC80;
                    }
                    armorMods[iArmorMods].bApplied = true;
                    // End:0x13C4
                    break;
                // End:0x13C1
                case 5:
                    iItem = 0;
                    J0x1028:
                    // End:0x1395 [Loop If]
                    if(iItem < SHIVArmor.Length)
                    {
                        LogInternal("This is SHIV");
                        kArmor = theGameCore().m_arrArmors[SHIVArmor[iItem]];
                        kConfig = theGameCore().Armors[SHIVArmor[iItem]];
                        kArmor.iHPBonus += armorMods[iArmorMods].iHPBonus;
                        kArmor.iDefenseBonus += armorMods[iArmorMods].iDefenseBonus;
                        kArmor.iMobilityBonus += armorMods[iArmorMods].iMobilityBonus;
                        kConfig.iHPBonus += armorMods[iArmorMods].iHPBonus;
                        kConfig.iDefenseBonus += armorMods[iArmorMods].iDefenseBonus;
                        kConfig.iMobilityBonus += armorMods[iArmorMods].iMobilityBonus;
                        LogInternal("iItem=" $ string(iItem));
                        LogInternal("HPBonus=" $ string(kArmor.iHPBonus));
                        LogInternal("DefenseB=" $ string(kArmor.iDefenseBonus));
                        LogInternal("MobilityB=" $ string(kArmor.iMobilityBonus));
                        theGameCore().Armors[SHIVArmor[iItem]] = kConfig;
                        theGameCore().m_arrArmors[SHIVArmor[iItem]] = kArmor;
                        ++ iItem;
                        // [Loop Continue]
                        goto J0x1028;
                    }
                    armorMods[iArmorMods].bApplied = true;
                    // End:0x13C4
                    break;
                // End:0xFFFF
                default:
                }
                ++ iArmorMods;
                // [Loop Continue]
                goto J0x0B;
            }
            //return;            
}

defaultproperties
{
    begin object name=Sprite class=SpriteComponent
        ReplacementPrimitive=none
    object end
    // Reference: SpriteComponent'Default__AltTechTreeMutate.Sprite'
    Components(0)=Sprite
}