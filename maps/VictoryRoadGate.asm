	object_const_def
	const VICTORYROADGATE_OFFICER
	const VICTORYROADGATE_BLACK_BELT1
	const VICTORYROADGATE_BLACK_BELT2
	const VICTORYROADGATE_BLUE

VictoryRoadGate_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_DEFAULT
	scene_script .DummyScene1 ; SCENE_FINISHED

	def_callbacks

.DummyScene0:
	end

.DummyScene1:
	end

.DummyScene2:
	end

VictoryRoadGateBadgeCheckScene:
	disappear VICTORYROADGATE_BLUE
	checkevent EVENT_PASSED_GATE_GUARD_VICTORY_ROAD
	iftrue .done
	turnobject PLAYER, LEFT
	sjump VictoryRoadGateBadgeCheckScript

.done
	end

VictoryRoadGateOfficerScript:
	faceplayer
VictoryRoadGateBadgeCheckScript:
	opentext
	writetext VictoryRoadGateOfficerText
	promptbutton
	readvar VAR_BADGES
	ifgreater NUM_JOHTO_BADGES - 1, .AllEightBadges
	writetext VictoryRoadGateNotEnoughBadgesText
	waitbutton
	closetext
	applymovement PLAYER, VictoryRoadGateStepDownMovement
	end

.AllEightBadges:
	writetext VictoryRoadGateEightBadgesText
	waitbutton
	closetext
	setevent EVENT_PASSED_GATE_GUARD_VICTORY_ROAD
	end

VictoryRoadGateLeftBlackBeltScript:
	jumptextfaceplayer VictoryRoadGateLeftBlackBeltText

VictoryRoadGateRightBlackBeltScript:
	jumptextfaceplayer VictoryRoadGateRightBlackBeltText

VictoryRoadGateBlueRematch:
	appear VICTORYROADGATE_BLUE
	opentext
	writetext BlueHoldItText
	waitbutton
	closetext
	special FadeOutMusic
	turnobject PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	playmusic MUSIC_BLUE_ENCOUNTER
	applymovement VICTORYROADGATE_BLUE, BlueWalksToPlayerMovement
	opentext
	writetext BlueFinalChallengeBeforeRedText
	waitbutton
	closetext
	winlosstext PlayerBeatBlueFinalText, 0
	setlasttalked VICTORYROADGATE_BLUE
	loadtrainer BLUE_FINAL, BLUE2
	startbattle
	dontrestartmapmusic
	reloadmap
	playmusic MUSIC_BLUE_ENCOUNTER
	opentext
	writetext BlueCheersYouOnText
	waitbutton
	closetext
	applymovement VICTORYROADGATE_BLUE, BlueWalksFromPlayerMovement
	disappear VICTORYROADGATE_BLUE
	setevent EVENT_BEAT_BLUE2
	setscene SCENE_FINISHED
	playmapmusic
	end

VictoryRoadGateStepDownMovement:
	step DOWN
	step_end

BlueWalksToPlayerMovement:
	slow_step LEFT
	slow_step LEFT
	slow_step LEFT
	slow_step LEFT
	slow_step LEFT
	step_end

BlueWalksFromPlayerMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

VictoryRoadGateOfficerText:
	text "Only trainers who"
	line "have proven them-"
	cont "selves may pass."
	done

VictoryRoadGateNotEnoughBadgesText:
	text "You don't have all"
	line "the GYM BADGES of"
	cont "JOHTO."

	para "I'm sorry, but I"
	line "can't let you go"
	cont "through."
	done

VictoryRoadGateEightBadgesText:
	text "Oh! The eight"
	line "BADGES of JOHTO!"

	para "Please, go right"
	line "on through!"
	done

VictoryRoadGateLeftBlackBeltText:
	text "This way leads to"
	line "MT.SILVER."

	para "You'll see scary-"
	line "strong #MON out"
	cont "there."
	done

VictoryRoadGateRightBlackBeltText:
	text "Off to the #MON"
	line "LEAGUE, are you?"

	para "The ELITE FOUR are"
	line "so strong it's"

	para "scary, and they're"
	line "ready for you!"
	done

BlueHoldItText:
	text "Hold it!"
	done

BlueFinalChallengeBeforeRedText:
	text "Hey, newbie! I"
	line "heard you beat the"

	para "KANTO LEAGUE, huh?"
	line " "

	para "I never would have"
	line "expected a guy"

	para "from JOHTO to get"
	line "this far,"
	
	para "and I have to"
	line "admit, I'm"
	cont "impressed!"

	para "It reminds me"
	line "of my ol' rival."

	para "I'll be darned"
	line "if I let you"

	para "through without"
	line "seeing what you're"

	para "really made of"
	line "first!"
	
	para "You have yet to"
	line "see me at my"
	cont "greatest."

	para "I've got some old"
	line "friends who are"

	para "itching to battle"
	line "you."
	
	para "They carried me to"
	line "championhood"
	cont "three years ago,"

	para "and we'll take"
	line "you down just the"
	cont "same!"
	done

PlayerBeatBlueFinalText:
	text "What?! I don't"
	line "believe it!"
	done

BlueCheersYouOnText:
	text "..."

	para "Heh."

	para "That was the most"
	line "fun I'd had since"
	cont "becoming CHAMPION."

	para "You keep"
	line "surprising"
	cont "me, kid."

	para "You're more than"
	line "ready for what"
	cont "lies ahead."

	para "You better not"
	line "lose to him."

	para "Good luck on MT."
	line "SILVER, CHAMP."

	para "Smell ya later!"
	done

VictoryRoadGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 17,  7, ROUTE_22, 1
	warp_event 18,  7, ROUTE_22, 1
	warp_event  9, 17, ROUTE_26, 1
	warp_event 10, 17, ROUTE_26, 1
	warp_event  9,  0, VICTORY_ROAD, 1
	warp_event 10,  0, VICTORY_ROAD, 1
	warp_event  1,  7, ROUTE_28, 2
	warp_event  2,  7, ROUTE_28, 2

	def_coord_events
	coord_event 10, 11, SCENE_DEFAULT, VictoryRoadGateBadgeCheckScene
	coord_event 3, 5, SCENE_DEFAULT, VictoryRoadGateBlueRematch

	def_bg_events

	def_object_events
	object_event  8, 11, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VictoryRoadGateOfficerScript, -1
	object_event  7,  5, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VictoryRoadGateLeftBlackBeltScript, EVENT_OPENED_MT_SILVER
	object_event 12,  5, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VictoryRoadGateRightBlackBeltScript, EVENT_FOUGHT_SNORLAX
	object_event  9,  5, SPRITE_BLUE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_BEAT_BLUE2
