--Relyk

-- Load and initialize the include file.
include('Mirdain-Include')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "18"
MacroBook = "18"  -- Sub Job macro pallets can be defined in the sub_job_change_custom function below
MacroSet = "1"

-- Use "gs c food" to use the specified food item 
Food = "Sublime Sushi"

--Set default mode (TP,ACC,DT)
state.OffenseMode:set('TP')

--Enable JobMode for UI
UI_Name = 'DPS'

--Modes for specific to Corsair
state.JobMode = M{['description']='Corsair Damage Mode'}
state.JobMode:options('Fomalhaut','Death Penalty', 'Savage Blade', 'Aeolian Edge')
state.JobMode:set('Death Penalty')

elemental_ws = S{'Aeolian Edge', 'Leaden Salute', 'Wildfire','Earth Shot','Ice Shot','Water Shot','Fire Shot','Wind Shot','Thunder Shot'}

-- load addons
send_command('lua l autocor')

-- Initialize Player
jobsetup (LockStylePallet,MacroBook,MacroSet)

-- Threshold for Ammunition Warning
Ammo_Warning_Limit = 99

function get_sets()

	--Set the weapon options.  This is set below in job customization section

	-- Weapon setup
	sets.Weapons = {}

	sets.Weapons['Savage Blade'] = {
		main="Naegling",
		sub="Blurred Knife +1",
		range={ name="Anarchy +2", augments={'Delay:+60','TP Bonus +1000',}},
	}

	sets.Weapons['Fomalhaut'] = {
		main={ name="Rostam", augments={'Path: A'}, bag="Wardrobe 4"},
		sub={ name="Rostam", augments={'Path: C'}, bag="Wardrobe 2"},
		range={ name="Fomalhaut", augments={'Path: A',}},
	}

	sets.Weapons['Death Penalty'] = {
		main={ name="Rostam", augments={'Path: A'}, bag="Wardrobe 4"},
		sub="Tauret",
		range={ name="Death Penalty", augments={'Path: A',}},
	}

	sets.Weapons['Aeolian Edge'] = {
		ammo=Ammo.Bullet.MAG_WS,
		main="Tauret",
		sub="Naegling",
		range={ name="Anarchy +2", augments={'Delay:+60','TP Bonus +1000',}},
	}

	sets.Weapons.Shield = {
		sub={ name="Nusku Shield", priority=1},
	}

	-- Ammo Selection
	Ammo.Bullet.RA = "Chrono Bullet"		-- TP Ammo
	Ammo.Bullet.WS = "Chrono Bullet"		-- Physical Weaponskills
	Ammo.Bullet.MAB = "Living Bullet"		-- Magical Weaponskills
	Ammo.Bullet.MACC = "Chrono Bullet"		-- Magic Accuracy
	Ammo.Bullet.QD = "Hauksbok Bullet"		-- Quick Draw
	Ammo.Bullet.MAG_WS = "Hauksbok Bullet"	-- Magic Weapon Skills

	-- Standard Idle set with -DT,Refresh,Regen with NO movement gear
	sets.Idle = {
		ammo = Ammo.Bullet.RA,
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Sanare Earring",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Shadow Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }

	sets.Movement = {
		legs="Carmine Cuisses +1",
	}

	-- Set to be used if you get 
	sets.Cursna_Recieved = {
	    neck="Nicander's Necklace",
	    left_ring={ name="Saida Ring", bag="wardrobe1", priority=2},
		right_ring={ name="Saida Ring", bag="wardrobe3", priority=1},
		waist="Gishdubar Sash",
	}

	sets.OffenseMode = {}

	--Base TP set to build off when melee'n
	sets.OffenseMode.TP = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Grunfeld Rope",
		left_ear="Telos Earring",
		right_ear="Eabani Earring",
		left_ring="Petrov Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	--This set is used when OffenseMode is DT and Enaged
	sets.OffenseMode.DT = set_combine(sets.OffenseMode.TP, {
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
	})

	--The following sets augment the base TP set above for Dual Wielding
	sets.DualWield = {
		waist="Reiki Yotai",
		right_ear="Eabani Earring",
	}

	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	sets.OffenseMode.ACC = {}

	sets.Precast = {}
	-- 70 snapshot is Cap.  Need 60 due to 10 from gifts
	-- Snapshot / Rapidshot
	-- Rapid shot is like quick magic
	-- Snapshot is like Fast Cast
	-- Flurry is 15% Snapshot
	-- Flurry II 30% Snapshot

	--No flurry - 60 Snapshot needed
	sets.Precast.RA = {
		ammo=Ammo.Bullet.RA,
		head={ name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5',}}, -- 10/0
		body="Oshosi Vest +1", -- 14/0
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}, -- 8/11
		legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}, -- 10/13
		feet="Meg. Jam. +2", -- 10/0
		left_ear={ name="Tuisto Earring", priority=2},
		right_ear={ name="Etiolation Earring", priority=1},
		left_ring={ name="Ilabrat Ring", priority=3},
		right_ring={ name="Regal Ring", priority=4},
		neck={ name="Comm. Charm +2", augments={'Path: A',}}, -- 4/0
		waist="Yemaya Belt", -- 0/10
		back={ name="Camulus's Mantle", augments={'HP+60','HP+20','"Snapshot"+10',}}, -- 10/0
    } -- Totals 66/24

	-- Flurry - 45 Snapshot Needed
	sets.Precast.RA.Flurry = set_combine(sets.Precast.RA, {
		body="Laksa. Frac +3",
	}) -- Totals 52/54

	-- Flurry II - 30 Snapshot Needed
	sets.Precast.RA.Flurry_II = set_combine( sets.Precast.RA.Flurry, { 
		head="Chass. Tricorne +1", 
		feet={ name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}}
    }) -- Totals 32/78

	sets.Precast.RA.ACC = {}

	-- Fast Cast for Magic
	sets.Precast.FastCast = {
	    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, -- 14
		body={ name="Taeon Tabard", augments={'"Fast Cast"+5','HP+44',}}, -- 9
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}, -- 7
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+7','"Fast Cast"+6',}}, -- 6
		feet={ name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}}, -- 8
		neck="Voltsurge Torque", -- 4
		waist="Sailfi Belt",
		left_ear="Loquac. Earring", -- 2
		right_ear="Enchntr. Earring +1", -- 2
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Kishar Ring", -- 4
		back={ name="Camulus's Mantle", augments={'HP+60','HP+20','"Fast Cast"+10',}}, -- 10
	} -- 66 FC

	sets.Midcast = {}

	-- Ranged Attack Gear (Normal Midshot)
    sets.Midcast.RA = {
		ammo=Ammo.Bullet.RA,
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Dingir Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    }

	-- Ranged Attack Gear (Triple Shot Midshot)
	sets.Midcast.RA.TripleShot = set_combine(sets.Midcast.RA, {
        head="Oshosi Mask +1", --5
        body="Chasseur's Frac +1", --12
        hands="Lanun Gants +3", -- Tripple shot becomes Quad shot
        legs="Osh. Trousers +1", --6
        feet="Osh. Leggings +1", --3
    }) --27

	-- Quick Draw Gear Sets
	sets.QuickDraw = {}

	sets.QuickDraw.ACC = {
		ammo = Ammo.Bullet.QD,
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Digni. Earring",
		right_ear="Gwati Earring",
		left_ring="Sangoma Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	sets.QuickDraw.DMG = {
		ammo=Ammo.Bullet.MAB,
	    feet="Chass. Bottes +1",
	}
	sets.QuickDraw.STP = {
		ammo=Ammo.Bullet.QD,
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Dingir Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	-- Quick Draw 
	sets.Midcast.QuickDraw = {}
	sets.Midcast.QuickDraw["Fire Shot"] = sets.QuickDraw.STP
	sets.Midcast.QuickDraw["Ice Shot"] = sets.QuickDraw.STP
	sets.Midcast.QuickDraw["Wind Shot"] = sets.QuickDraw.STP
	sets.Midcast.QuickDraw["Earth Shot"] = sets.QuickDraw.STP
	sets.Midcast.QuickDraw["Thunder Shot"] = sets.QuickDraw.STP
	sets.Midcast.QuickDraw["Water Shot"] = sets.QuickDraw.STP
	sets.Midcast.QuickDraw["Light Shot"] = sets.QuickDraw.ACC
	sets.Midcast.QuickDraw["Dark Shot"] = sets.QuickDraw.ACC

	-- Job Abilities
	sets.JA = {}
	sets.JA["Wild Card"] = {
	    feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
	}
	sets.JA["Phantom Roll"] = {}
	sets.JA["Random Deal"] = {
	    body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
	}
	sets.JA["Snake Eye"] = {
	    legs={ name="Lanun Trews +3", augments={'Enhances "Snake Eye" effect',}},
	}
	sets.JA["Fold"] = {}			-- Use gloves for bust
	sets.JA["Triple Shot"] = {}		-- Gear to be worn during Midshot
	sets.JA["Cutting Cards"] = {}
	sets.JA["Crooked Cards"] = {}

	--Base Set used for all rolls
	sets.PhantomRoll = set_combine(sets.Idle, {
		main={ name="Rostam", augments={'Path: C'}, bag="Wardrobe 2", priority=1}, -- +8 Effect and 60 sec Duration
		sub={ name="Nusku Shield", priority=2},
		range="Compensator", -- 20 sec Duration
		head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}}, -- 50% Job ability Bonus
		hands="Chasseur's Gants +1", --50 sec Duration
		neck="Regal Necklace", -- 20 sec Duration
		right_ring="Luzaf's Ring", -- 16 yalm range
		back={ name="Camulus's Mantle", augments={'HP+60','HP+20','"Snapshot"+10',}}, -- 30 sec Duration
	})

	sets.PhantomRoll['Fighter\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Monk\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Healer\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Wizard\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Warlocks\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Rogue\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Gallant\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Chaos Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Beast Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Choral Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Hunters\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Samurai Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Ninja Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Drachen Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Evoker\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Magus\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Corsair\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Puppet Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Dancer\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Scholar\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Bolter\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll["Caster's Roll"] = set_combine(sets.PhantomRoll, {}) -- {legs="Chas. Culottes +1"}
	sets.PhantomRoll["Tactician's Roll"] = set_combine(sets.PhantomRoll, {body="Chasseur's Frac +1"})
	sets.PhantomRoll["Allies' Roll"] = set_combine(sets.PhantomRoll, {hands="Chasseur's Gants +1"})
	sets.PhantomRoll['Miser\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Companion\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Avenger\'s Roll'] = sets.PhantomRoll
	sets.PhantomRoll['Naturalist\'s Roll'] = sets.PhantomRoll
    sets.PhantomRoll["Courser's Roll"] = set_combine(sets.PhantomRoll, {feet="Chass. Bottes +1"})
    sets.PhantomRoll["Blitzer's Roll"] = set_combine(sets.PhantomRoll, {head="Chass. Tricorne +1"})

	sets.WS = {
		ammo=Ammo.Bullet.WS,
		head={ name="Herculean Helm", augments={'Accuracy+25','Weapon skill damage +4%','AGI+10','Attack+14',}},
		body="Laksa. Frac +3",
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'DEX+7','Pet: Mag. Acc.+4','Weapon skill damage +10%','Accuracy+1 Attack+1',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Comm. Charm +2",
		waist="Grunfeld Rope",
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Karieyh Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}

	sets.WS.MAB = {
		ammo=Ammo.Bullet.MAB,
		head={ name="Herculean Helm", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Weapon skill damage +5%','Mag. Acc.+2',}},
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'Attack+12','"Mag.Atk.Bns."+27','Accuracy+3 Attack+3','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck={ name="Comm. Charm +2", augments={'Path: A',}},
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Crematio Earring",
		left_ring="Dingir Ring",
		right_ring="Karieyh Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	}

	sets.WS["Wildfire"] = set_combine(sets.WS.MAB, {

	})

	sets.WS["Leaden Salute"] = set_combine(sets.WS.MAB, {
		head="Pixie Hairpin +1",
		right_ring="Archon Ring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		waist="Svelt. Gouriz +1",   -- Changes based off elemental function
	})

	sets.WS['Aeolian Edge'] = set_combine(sets.WS.MAB, {
		ammo=Ammo.Bullet.MAG_WS,
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	})

	sets.WS.MACC = set_combine(sets.WS.MAB, {
		ammo=Ammo.Bullet.MACC,
	})

	sets.WS.WSD = {
		ammo=Ammo.Bullet.WS,
		head={ name="Herculean Helm", augments={'Accuracy+25','Weapon skill damage +4%','AGI+10','Attack+14',}},
		body="Laksa. Frac +3",
		hands="Meg. Gloves +2",
		legs={ name="Herculean Trousers", augments={'DEX+7','Pet: Mag. Acc.+4','Weapon skill damage +10%','Accuracy+1 Attack+1',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Comm. Charm +2",
		waist="Grunfeld Rope",
		left_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Karieyh Ring",
		right_ring="Regal Ring",
		back={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}

	sets.WS["Savage Blade"] = set_combine(sets.WS.WSD, {

	})

	sets.WS["Last Stand"] = set_combine(sets.WS.WSD, {
		head={ name="Lanun Tricorne +3", augments={'Enhances "Winning Streak" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
	})

	-- Accuracy set used in OffenseMode.ACC
	sets.WS.ACC = {}

	-- Uses Default WS set
	sets.WS["Hot Shot"] = {}
	sets.WS["Split Shot"] = {}
	sets.WS["Sniper Shot"] = {}
	sets.WS["Slug Shot"] = {}
	sets.WS["Numbing Shot"] = {}
	sets.WS["Fast Blade"] = {}
	sets.WS["Burning Blade"] = {}
	sets.WS["Flat Blade"] = {}
	sets.WS["Shining Blade"] = {}
	sets.WS["Circle Blade"] = {}
	sets.WS["Spirits Within"] = {}
	sets.WS["Requiescat"] = {}

	sets.Charm = {
	    main="Lament",
		range="Compensator",
		ammo=Ammo.Bullet.RA,
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Yemaya Belt",
		left_ear="Sanare Earring",
		right_ear="Thureous Earring",
		left_ring="Defending Ring",
		right_ring="Shadow Ring",
		back={ name="Camulus's Mantle", augments={'HP+60','HP+20','"Snapshot"+10',}},
	}

	sets.TreasureHunter = {

	}

	organizer_items  = {		
		item1 = "Echo Drops",
		item2 = "Remedy",
		item3 = "Holy Water",
	}	
end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's subjob changes.
function sub_job_change_custom(new, old)
	-- Typically used for Macro pallet changing
end

--Adjust custom precast actions
function pretarget_custom(spell,action)

end
-- Augment basic equipment sets
function precast_custom(spell)
	equipSet = {}

	if spell.english == 'Fold' then
		equipSet = set_combine(equipSet, {hands={ name="Lanun Gants +3", augments={'Enhances "Fold" effect',}}})
    end

	if spell.id == 123 or spell.type == 'CorsairRoll' then -- Double up and bypass weapon check
		return equipSet
	end

	equipSet = Elemental_check(equipSet, spell)

	return Weapon_Check(equipSet)
end
-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}

	if spell.id == 123 or spell.type == 'CorsairRoll' then -- Double up and bypass weapon check
		return equipSet
	end

	return Weapon_Check(equipSet)
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}

	return Weapon_Check(equipSet)
end
--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}

	return Weapon_Check(equipSet)
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}

	return Weapon_Check(equipSet)
end
--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}

	return Weapon_Check(equipSet)
end

--Function is called when a self command is issued
function self_command_custom(command)

end

function user_file_unload()
	send_command('lua u autocor')
end

function check_buff_JA()
	buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()
	if player.sub_job == 'WAR' then
		if not buffactive['Berserk'] and ja_recasts[1] == 0 then
			buff = "Berserk"
		elseif not buffactive['Aggressor'] and ja_recasts[4] == 0 then
			buff = "Aggressor"
		elseif not buffactive['Warcry'] and ja_recasts[2] == 0 then
			buff = "Warcry"
		end
	end
	return buff
end

function check_buff_SP()
	buff = 'None'
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end

function Weapon_Check(equipSet)
	equipSet = set_combine(equipSet,sets.Weapons[state.JobMode.value])
	if DualWield == false then
		equipSet = set_combine(equipSet,sets.Weapons.Shield)
	end
	return equipSet
end

function Elemental_check(equipSet, spell)
	-- This function swaps in the Orpheus or Hachirin as needed
	if elemental_ws:contains(spell.name) then
		-- Matching double weather (w/o day conflict).
		if spell.element == world.weather_element and world.weather_intensity == 2 then
			equipSet = set_combine(equipSet, {waist="Hachirin-no-Obi",})
			windower.add_to_chat(8,'Weather is Double ['.. world.weather_element .. '] - using Hachirin-no-Obi')
		-- Matching day and weather.
		elseif spell.element == world.day_element and spell.element == world.weather_element then
			equipSet = set_combine(equipSet, {waist="Hachirin-no-Obi",})
			windower.add_to_chat(8,'[' ..world.day_element.. '] day and weather is ['.. world.weather_element .. '] - using Hachirin-no-Obi')
			-- Target distance less than 6 yalms
		elseif spell.target.distance < (6 + spell.target.model_size) then
			equipSet = set_combine(equipSet, {waist="Orpheus's Sash",})
			windower.add_to_chat(8,'Distance is ['.. round(spell.target.distance,2) .. '] using Orpheus Sash')
		-- Match day or weather.
		elseif spell.element == world.day_element or spell.element == world.weather_element then
			windower.add_to_chat(8,'[' ..world.day_element.. '] day and weather is ['.. world.weather_element .. '] - using Hachirin-no-Obi')
			equipSet = set_combine(equipSet, {waist="Hachirin-no-Obi",})
		end
	end
	return equipSet
end