
--Salidar

-- Load and initialize the include file.
include('Mirdain-Include')

-- Use "gs c food" to use the specified food item 
Food = "Miso Ramen"

-- 'TP','ACC','DT' are standard Default modes.  You may add more and assigne equipsets for them ( Idle.X and OffenseMode.X )
state.OffenseMode:options('TP','ACC','DT','PDT','MEVA','AoE') -- ACC effects WS and TP modes

--Enable JobMode for UI.
UI_Name = 'Auto Tank'
--Modes for specific to RUN
state.JobMode = M{['description']='Auto Tank'}
state.JobMode:options('OFF','ON') -- Modes used to use Rune Enhancement
state.JobMode:set('OFF')

-- Function used to change pallets based off sub job and modes
function Macro_Sub_Job()
	local macro = 1
	if player.sub_job == "BLU" then
		state.OffenseMode:set('AoE')
		macro = 3
		send_command('wait 2;aset set tanking')
	else
		state.OffenseMode:set('DT')
		macro = 1
	end
	return macro
end

-- Blue spells used for tanking (Azureset)

--[[
    <tanking>
        <slot01>healing breeze</slot01>
        <slot02>sheep song</slot02>
        <slot03>wild carrot</slot03>
        <slot04>pollen</slot04>
        <slot05>terror touch</slot05>
        <slot06>grand slam</slot06>
        <slot07>cocoon</slot07>
        <slot08>jettatura</slot08>
        <slot09>blank gaze</slot09>
        <slot10>screwdriver</slot10>
        <slot11>geist wall</slot11>
        <slot12>sandspin</slot12>
    </tanking>
]]--

BlueNuke = S{'Spectral Floe','Entomb', 'Magic Hammer', 'Tenebral Crush'}
BlueHealing = S{'Magic Fruit', 'Healing Breeze','Pollen', 'Wild Carrot'}
BlueSkill = S{'Occultation','Erratic Flutter','Nature\'s Meditation','Cocoon','Barrier Tusk','Matellic Body','Mighty Guard'}
BlueTank = S{'Jettatura','Blank Gaze','Sheep Song','Geist Wall'}

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "13"
MacroBook = "5"
MacroSet = Macro_Sub_Job()

--Command to Lock Style and Set the correct macros
jobsetup (LockStylePallet,MacroBook,MacroSet)

--
-- HP balancing: 2900 HP
-- MP balancing: 800 MP
--

function get_sets()

	-- Standard Idle set
	sets.Idle = {
		main="Burtgang", -- 18/0
		sub="Ochain",
		ammo="Staunch Tathlum +1", -- 3/3
		head="Volte Salade", -- 3/7
		body="Sacro Breastplate",
		hands="Volte Moufles", -- 6/4
		legs="Volte Brayettes", -- 7/3
		feet="Volte Sollerets", -- 4/6
		neck={ name="Unmoving Collar +1", augments={'Path: A',}, priority=1},
		waist="Flume Belt +1", -- 4/0
		left_ear={ name="Tuisto Earring", priority=4},
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=2}, -- 3/5
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}, priority=3}, -- 7/-1
		right_ring={ name="Moonlight Ring", bag="wardrobe1", priority=4}, -- 5/5
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}}, -- 10/0
	} -- 68 PDT 32 MDT

	sets.Idle.DT = set_combine( sets.Idle, {
	
	})

	sets.Idle.PDT = set_combine( sets.Idle, {
	
	})

	sets.Idle.MEVA = set_combine( sets.Idle, {
		sub="Aegis", 
		neck="Moonlight Necklace",
		left_ear="Eabani Earring",
		waist="Asklepian Belt",
	})

	sets.Idle.AoE = set_combine( sets.Idle, {

	})

	sets.Movement = {
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=1},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}, priority=2},
    }

	-- Set to be used if you get cursna casted on you
	sets.Cursna_Recieved = {
	    neck="Nicander's Necklace",
	    left_ring={ name="Saida Ring", bag="wardrobe1", priority=2},
		right_ring={ name="Saida Ring", bag="wardrobe3", priority=1},
		waist="Gishdubar Sash",
	}

	sets.OffenseMode = {}

	--Base TP set to build off
	sets.OffenseMode.TP = {
		ammo="Ginsen", --  UPGRADE TO SEETHING BOMBLET
		head={ name="Hjarrandi Helm", priority=3},
		body={ name="Hjarrandi Breast.", priority=4},
		hands="Volte Moufles",
		legs="Volte Brayettes",
		feet="Volte Sollerets",
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Sarissapho. Belt",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=3},
		right_ear="Digni. Earring",
		left_ring={ name="Moonlight Ring", bag="wardrobe3", priority=1},
		right_ring={ name="Moonlight Ring", bag="wardrobe1", priority=2},
		back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	sets.OffenseMode.ACC = {

	}

	--This set is used when OffenseMode is DT and Enaged (Augments the TP base set)
	sets.OffenseMode.DT = {

	}

	--This set is used when OffenseMode is PDT and Enaged (Augments the TP base set)
	sets.OffenseMode.PDT = {

	}

	--This set is used when OffenseMode is MEVA and Enaged (Augments the TP base set)
	sets.OffenseMode.MEVA = {

	}

	--This set is used when OffenseMode is AoE and Enaged (Augments the TP base set)
	sets.OffenseMode.AoE = {

	}

	sets.Enmity = { -- Goal is 200 total -Crusaade is 30
	    ammo="Sapience Orb", --2
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=1}, --9
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=2}, --20
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=3}, --9
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=4}, --9
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=5}, --9
		neck="Moonlight Necklace", --15
		waist="Creed Baudrier", --5
		left_ear="Trux Earring", --5
		right_ear="Cryptic Earring", --4
		left_ring="Apeile Ring +1", -- ~5-9
		right_ring="Apeile Ring", -- ~5-9
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}}, --10
	} -- 136 in gear with Burtang (166 with Crusade)

	sets.Precast = {}

	-- Used for Magic Spells
	sets.Precast.FastCast = { -- 61 FC with 3029/890
		ammo="Sapience Orb", --2
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --14
		body="Rev. Surcoat +3", --10
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=1},
		legs={ name="Odyssean Cuisses", augments={'"Fast Cast"+6','Accuracy+13','Attack+2',}}, -- 6
		feet={ name="Odyssean Greaves", augments={'Mag. Acc.+5','"Fast Cast"+6','CHR+8',}}, -- 13
		neck={ name="Unmoving Collar +1", augments={'Path: A',}, priority=2},
		waist= {name="Creed Baudrier", priority=3},
		left_ear={ name="Tuisto Earring", priority=4},
		right_ear={ name="Etiolation Earring", priority=6}, --1
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}, priority=5},
		right_ring="Weather. Ring", --5
		back={ name="Rudianos's Mantle", augments={'HP+60','HP+20','"Fast Cast"+10',}}, --10
	}

	sets.Midcast = {}

	--This set is used in conjuction with set_combine
	sets.Midcast.SIRD = {
		ammo="Staunch Tathlum +1", -- 11
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, -- 20
		legs={ name="Founder's Hose", augments={'MND+8','Mag. Acc.+14','Attack+13','Breath dmg. taken -3%',}}, -- 30
		neck="Moonlight Necklace", -- 15
		waist="Audumbla Sash", -- 10
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Cure" potency +10%','Spell interruption rate down-10%',}}, -- 10
	}

	-- Cure Set (special SIRD set)
	sets.Midcast.Cure = {
		ammo="Staunch Tathlum +1", -- 11
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=6}, -- 20
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=5},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=4},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}, priority=7}, -- 20
		feet={ name="Odyssean Greaves", augments={'"Cure" potency +6%','MND+9','"Mag.Atk.Bns."+11',}}, -- 20
		neck="Sacro Gorget",
		waist="Audumbla Sash", -- 10
		left_ear={ name="Nourish. Earring +1", augments={'Path: A',}}, -- 1
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=2},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}, priority=1},
		right_ring={ name="Moonlight Ring", bag="wardrobe1", priority=3},
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Cure" potency +10%','Spell interruption rate down-10%',}}, --10
	} -- 92 + 10 Merits = 102 SIRD

	-- Enhancing Skill
	sets.Midcast.Enhancing = {
	    ammo="Staunch Tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=1},
		body="Shab. Cuirass +1",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=2},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}, priority=4},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=3},
		neck="Incanter's Torque",
		waist="Flume Belt +1",
		left_ear={ name="Tuisto Earring", priority=5},
		right_ear="Mimir Earring",
		left_ring={ name="Stikini Ring +1", bag="wardrobe1"},
		right_ring={ name="Stikini Ring +1", bag="wardrobe3"},
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}

	sets.Midcast.Divine = {
		ammo="Staunch Tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Rev. Surcoat +3", -- 17
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Founder's Hose", augments={'MND+8','Mag. Acc.+14','Attack+13','Breath dmg. taken -3%',}},
		feet={ name="Odyssean Greaves", augments={'Mag. Acc.+5','"Fast Cast"+6','CHR+8',}},
		neck="Incanter's Torque", -- 10
		waist="Asklepian Belt", --10
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Stikini Ring +1", bag="wardrobe1"}, -- 8
		right_ring={ name="Stikini Ring +1", bag="wardrobe3"}, -- 8
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Cure" potency +10%','Spell interruption rate down-10%',}},
	} -- +53 with 100% SIRD

	-- High MACC for landing spells
	sets.Midcast.Enfeebling = {}

	-- Specific gear for spells
	sets.Midcast["Stoneskin"] = {
		waist="Siegel Sash",
	}
	sets.Midcast["Phalanx"] = { -- For +  Phalanx Gear
		ammo="Staunch Tathlum +1",
		head={ name="Odyssean Helm", augments={'Pet: "Dbl. Atk."+1','CHR+4','Phalanx +3','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		body="Shab. Cuirass +1",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet={ name="Odyssean Greaves", augments={'"Cure" potency +6%','MND+9','"Mag.Atk.Bns."+11',}},
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear={ name="Etiolation Earring", priority=4},
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}, priority=2},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}, priority=1},
		right_ring={ name="Moonlight Ring", bag="wardrobe1", priority=3},
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
	}
	sets.Midcast["Reprisal"] = { -- Block rate is based off HP
		ammo="Staunch Tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body="Shab. Cuirass +1",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet={ name="Odyssean Greaves", augments={'Mag. Acc.+5','"Fast Cast"+6','CHR+8',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Audumbla Sash",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Cure" potency +10%','Spell interruption rate down-10%',}},
	}
	sets.Midcast["Flash"] = sets.Enmity

	sets.JA = {}
	sets.JA["Invincible"] = set_combine( sets.Enmity, { })
	sets.JA["Shield Bash"] = set_combine( sets.Enmity, { })
	sets.JA["Holy Circle"] = set_combine( sets.Enmity, { })
	sets.JA["Sentinel"] = set_combine( sets.Enmity, { })
	sets.JA["Cover"] = set_combine( sets.Enmity, { })
	sets.JA["Provoke"] = set_combine( sets.Enmity, { })
	sets.JA["Rampart"] = set_combine( sets.Enmity, { })
	sets.JA["Divine Emblem"] = set_combine( sets.Enmity, { })
	sets.JA["Sepulcher"] = set_combine( sets.Enmity, { })
	sets.JA["Palisade"] = set_combine( sets.Enmity, { })
	sets.JA["Intervene"] = set_combine( sets.Enmity, { })
	sets.JA["Majesty"] = set_combine( sets.Enmity, { })
	sets.JA["Berserk"] = set_combine( sets.Enmity, { })
	sets.JA["Defender"] = set_combine( sets.Enmity, { })
	sets.JA["Aggressor"] = set_combine( sets.Enmity, { })

	--Default WS set base
	sets.WS = {

	}
	--This set is used when OffenseMode is ACC and a WS is used (Augments the WS base set)
	sets.WS.ACC = {}
	sets.WS.WSD = {}
	sets.WS.CRIT = {}

	--Sword WS
	sets.WS["Fast Blade"] = {}
	sets.WS["Burning Blade"] = {}
	sets.WS["Red Lotus Blade"] = {}
	sets.WS["Flat Blade"] = {}
	sets.WS["Shining Blade"] = {}
	sets.WS["Seraph Blade"] = {}
	sets.WS["Circle Blade"] = {}
	sets.WS["Spirits Within"] = {}
	sets.WS["Swift Blade"] = {}
	sets.WS["Vorpal Blade"] = {}
	sets.WS["Savage Blade"] = sets.WS.WSD
	sets.WS["Atonement"] = sets.Enmity
	sets.WS["Chant du Cygne"] = {}
	sets.WS["Requiescat"] = {}

	--Custom sets for each jobsetup
	sets.Custom = {}

	sets.TreasureHunter = {
		waist="Chaac Belt",
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

	return equipSet
end
-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}

	return equipSet
end
--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	equipSet = {}

	return equipSet
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}

	return equipSet
end
--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}

	return equipSet
end
--Function is called when a self command is issued
function self_command_custom(command)

end

--Function used to automate Job Ability use
function check_buff_JA()
	buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()

	if player.sub_job == 'SAM' then
		if not buffactive['Hasso'] and not buffactive['Seigan'] and ja_recasts[138] == 0 then
			buff = "Hasso"
		end
	end

	if player.sub_job == 'WAR' then
		if not buffactive['Berserk'] and ja_recasts[1] == 0 then
			buff = "Berserk"
		end
		if not buffactive['Aggressor'] and ja_recasts[4] == 0 then
			buff = "Aggressor"
		end
		if not buffactive['Warcry'] and ja_recasts[2] == 0 then
			buff = "Warcry"
		end
	end

	if not buffactive['Majesty'] and ja_recasts[150] == 0 then
		buff = "Majesty"
	end

	return buff
end

--Function used to automate Spell use
function check_buff_SP()
	buff = 'None'
	local sp_recasts = windower.ffxi.get_spell_recasts()

	if not buffactive['Enmity Boost'] and sp_recasts[476] == 0 and player.mp > 18 then
		buff = "Crusade"
	elseif not buffactive['Phalanx'] and sp_recasts[106] == 0 and player.mp > 21 then
		buff = "Phalanx"
	elseif not buffactive['Reprisal'] and sp_recasts[97] == 0 and player.mp > 25 then
		buff = "Reprisal"
	end

	if player.sub_job == "BLU" then
		if not buffactive['Defense Boost'] and sp_recasts[547] == 0 and player.mp > 10 then
			buff = "Cocoon"
		end
	end

	return buff
end




-- Function is called when the job lua is unloaded
function user_file_unload()

end