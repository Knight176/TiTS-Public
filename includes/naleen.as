﻿import classes.Creature;

//UNLESS OTHERWISE NOTED, ALL SCENES BY SAVINOXO
//Female Naleen Encounter
//(Note: If we could have some kinda Deepwoods area, that'd be great. Failing that, uh, just make these guys encounterable a good ways off from Esbeth. They're people-shy, unlike Zil.)

//Name: Vaelyaniss (Veil - YAN - iss)
//Cup Size: F+
//Fur Pattern: Tiger stripes along the back/sides, with a white patch on her belly/breasts. Ends in a "mane" or collar around her shoulders -- much thinner than a male naleen's would be.
//Hair: Brilliant orange, waist-length. Possibly black highlights/strips?

function naleenSexed(won:Boolean = true):void {
	if (won)
	{
		if(flags["TIMES_WINSEXED_NALEEN"] == undefined) flags["TIMES_WINSEXED_NALEEN"] = 0;
		flags["TIMES_WINSEXED_NALEEN"]++;
	}
	else
	{
		if(flags["TIMES_LOSS_DOMMED_BY_NALEEN"] == undefined) flags["TIMES_LOSS_DOMMED_BY_NALEEN"] = 0;
		flags["TIMES_LOSS_DOMMED_BY_NALEEN"]++;
	}
}

function encounterNaleen():void {
	userInterface.showBust("NALEEN");
	//[First Time]
	if (flags["TIMES_MET_NALEEN"] == undefined)
	{
		flags["TIMES_MET_NALEEN"] = 1;
		//output("\n\nThe forest seems to be growing thicker and thicker with every step, taking you deep into the heart of the jungle far, far away from Esbeth. The trees are overgrown, thick with vines moss, their branches so intertwined you can hardly see the sun. Looking cautiously around, you make your way through the dense underbrush, slowly hacking through the ever-present foliage on your way across the endless sea of trees.");
		output("\n\nYou notice something just through a small wall off growth: a crystal blue circle some few dozen feet across, placid and quiet. Happy to see the sun again, you make your way forward, though soon you realize that you are not alone here: a quiet alien tune carries across the still wind, the language languid and lilting, almost hypnotic in its solemn beauty. You step forward, searching for the source, and your [pc.ears] soon lead you to a lone figure just beyond the shore of the small lake, a beautiful feminine figure wading in the waist-high water. With eyes closed, the woman faces you, hands running through long orange hair, giving you a perfect view of the large, perfect round breasts on her bare chest. Her torso seems wholly covered in a thin, smooth fur that glistens in the water, bearing a bright tiger stripe pattern of black and orange, not unlike her flowing locks. Her voice carries perfectly over the quiet lake, her alien melody captivating and alluring.");
		
		output("\n\nYou watch a moment more, almost entranced by the song and the beautiful form before you. Before you can hide or avert your eyes, however, the bathing figure looks up, finally noticing you.");
		output("\n\nTo your surprise, the woman grins at you, hands resting on her hips just below the water's surface, doing nothing to hide her bosom. <i>\"Well, well, what have we here?\"</i>  she says, voice soft and smooth, alien despite the nearly human face it comes from. Her pointed, feline ears perk up as she glides toward you, moving with a stepless grace. You stumble back, hand grasping a weapon as the woman approaches, her form sliding out of the water to reveal a long, reptilian tail in place of legs, easily longer than the feline body atop it. Your Codex gives an alarmed chirp, identifying the creature as a Naleen, the apex predator on Mhen'ga.");
		
		output("\n\n<i>\"Hmm? Already know about us, hmm?\"</i>  the kitty-snake-thing coos playfully, slithering toward you. You draw down on her, but the serpentine predator just gives you a wink and moves around you, grabbing a huge leaf from the tree line, wrapping it around her slender shoulders like a towel. She turns back to you, arms crossed under her chest, a dangerous grin on her thin lips. <i>\"So, little pet, you and I know how this goes, don't we? Why don't you put that silly little weapon away, and I promise I won't go too hard on you...\"</i>");
		output("\n\nSharp claws appear on her fingertips as the Naleen slithers toward you, clearly intent on assault!");
	}
	//[Repeat Meeting]
	else {
		flags["TIMES_MET_NALEEN"]++;
		//	The forest seems to be growing thicker and thicker with every step, taking you deep into the heart of the jungle far, far away from Esbeth. The trees are overgrown, thick with vines and moss, their branches so intertwined you can hardly see the sun. Looking cautiously around, you make your way through the dense underbrush, slowly hacking through the ever-present foliage on your way across the endless sea of trees.
		output("\n\nSlowly, though, you begin to feel as if you're being watched. You draw a weapon and scan your surroundings, looking for the source of your unease. The jungle seems quiet, too silent and still. Your keen eyes search as you slowly turn, eyeing every angle until finally you catch a glimpse of movement! You ready your weapon and shout for who or whatever it is to show itself - and soon it does. You hear a rustle <i>behind</i> you, and you tuck and roll out of the way as a towering tiger-striped naleen rushes past you, sliding through the space you were a moment ago with claws bared.");
		output("\n\nThe half-snake half-cat tsks its long, forked tongue at you, rising to its full height of well over six feet to ");
		if(pc.tallness >= 78) output("leer up at you");
		else if(pc.tallness >= 67) output("leer at you");
		else output("loom over you");
		output(". <i>\"Feisty little pet, hmm?\"</i>  she grins, claws glistening. <i>\"Why don't you just come get a hug, hmm? No need to fight; I know you want it...\"</i>");
		if(silly) output("\n\nYour Codex beeps an alert that general consensus is that while Naleen give the best hugs, they may or may not prove deadly.");
	}
	userInterface.clearMenu();
	userInterface.addButton(0,"Next",startCombat,"naleen");
}

//Naleen: Combat
//Combat Description
//

//Combat Techniques:
//Savin's note: Naleen should have very high dodge chances, but low Lust resistance. I figure the Zil's lusty aura might be their primary defense versus them, and PCs can take advantage of their sexual nature -- but trying to stand and fight is considerably harder. Teasespam GO!
	//AI: Uses Double Attack most turns; the lower PC HP is, though, the more likely she is to use her Bite attack (say, half inverse chance -- at 50% HP, she has a 25% chance of biting). 

//Double Attack
// two light physical attacks.
function naleenDoubleAttack():void {
	output("The naleen surges forward, lunging at you and swinging her razor-sharp claws right at your throat!\n");
	attack(foes[0],pc,true,1);
	attack(foes[0],pc,false,1);
	//{standard dodge/miss messages}
	//Hit: You get your arms up just in time, yelping in pain as the kitty-snake's claws rake your [skin], making you stumble back.
}

//Constrict
//Grapple, must struggle to escape. Damage over time if fail.
function naleenConstrict():void {
	if(!pc.hasStatusEffect("Naleen Coiled"))
	{
		output("The naleen lunges at you, but you nimbly dodge the attack. However, before you can blink, you feel leather and fur coursing across your body as the serpentine feline coils around you, squeezing tight!");
		
		pc.createStatusEffect("Naleen Coiled",0,0,0,0,true,"","",false,0);
	}
	else
	{
		output("The naleen's constricting embrace tightens slightly, coil after coil slithering around your compressing flesh.");
	}
	var attacker:Creature = foes[0];
	var target:Creature = pc;
	//Damage bonuses:
	var damage:int = 5 + rand(5);
	//Randomize +/- 15%
	var randomizer = (rand(31)+ 85)/100;
	damage *= randomizer;
	var sDamage:Array = new Array();
	
	//Apply damage reductions
	if(target.shieldsRaw > 0) {
		sDamage = shieldDamage(target,damage,attacker.meleeWeapon.damageType);
		//Set damage to leftoverDamage from shieldDamage
		damage = sDamage[1];
		if(target.shieldsRaw > 0) output(" Your shield crackles but holds. (<b>" + sDamage[0] + "</b>)");
		else output(" There is a concussive boom and tingling aftershock of energy as your shield is breached. (<b>" + sDamage[0] + "</b>)");
	}
	if(damage >= 1) {
		damage = HPDamage(target,damage,attacker.meleeWeapon.damageType);
		if(sDamage[0] > 0) output(" Your breath is taken away by a brutal squeezes, and in a moment you're seeing stars! (<b>" + damage + "</b>)");
		else output(" (<b>" + damage + "</b>)");	
	}
	processCombat();
}

function naleenStruggle():void {
	clearOutput();
	if(pc.physique() + rand(20) + 1 + pc.statusEffectv1("Naleen Coiled") * 5 > 24) {
		output("With a mighty heave, you tear your way out of the coils and onto your [pc.feet].");
		pc.removeStatusEffect("Naleen Coiled");
	}
	else if(pc.reflexes() + rand(20) + 1 + pc.statusEffectv1("Naleen Coiled") * 5 > 24) {
		output("You display a remarkable amount of flexibility as you twist and writhe through the coils to freedom.");
		pc.removeStatusEffect("Naleen Coiled");
	}
	//Fail to escape: 
	else
	{
		output("You groan in pain, struggling madly to escape the brutal confines of the naleen's coils. She grins down at you with a feral look in her eyes...");
		pc.addStatusValue("Naleen Coiled",1,1);
	}
	output("\n");
	processCombat();
}
	

//Bite Attack (Paralytic Venom)
//Low chance of use; increases with foe HP drop or if foe is constricted. 
//REQ'S NO SHIELDS!
function biteAttack():void {
	var attacker:Creature = foes[0];
	output("The naleen girl lunges at you with a predatory grin, jaw opening wide as she closes. You can almost seen the glint of venom on her fangs!");
	
	//{standard dodge/miss messages}
	if(combatMiss(foes[0],pc)) {
		output(" You manage to avoid " + attacker.a + possessive(attacker.short) + " bite!");
	}
	else {
		output("The nalenn sinks her teeth into you, twin fangs piercing your tender [pc.skin]. You grint in pain, but that's replaced a moment later by an overwhelming feeling of calm, of peace, of slow dreariness. You just want to curl up in a ball and take a nap. Maybe with a beautiful kitty-snake to ");
		if(pc.hasCock()) output("stroke you off");
		else if(pc.hasVagina()) output("eat you out");
		else output("fuck your ass with her big tail");
		output(" until you're fast asleep.");
		//Effect: Moderate Speed/Dex/Whatever drain. If reduced to 0, auto lose (as if by lust).
		if(!pc.hasStatusEffect("Naleen Venom")) pc.createStatusEffect("Naleen Venom",0,0,0,0,false,"","This venom reduces strength, aim, reflexes, and willpower!",false,10);
		pc.physiqueMod -= 1;
		pc.aimMod -= 1;
		pc.willpowerMod -= 1;
		pc.reflexesMod -= 1;
		pc.addStatusValue("Naleen Venom",1,1);
		pc.lust(10+rand(10));
	}
	processCombat();
}

function naleenAI():void {
	//Low chance of constrict and bite. Bite only when unshielded. 
	//High bite chance once constricted and unshielded.
	if(pc.statusEffectv1("Round") % 5 == 0) naleenConstrict();
	else if(pc.statusEffectv1("Round") % 6 == 0 && pc.shieldsRaw <= 0) biteAttack();
	else if(pc.hasStatusEffect("Naleen Coiled")) {
		if(rand(5) == 0 || pc.shieldsRaw > 0) naleenConstrict();
		else biteAttack();
	}
	else naleenDoubleAttack();
}

//PC loses like a bitch
function pcLosesToNaleenLiekABitch():void {
	output("Succumbing to the ");
	if(pc.HP() <= 0) output("pain wracking your body");
	else if(pc.lust() >= 100) output("lust boiling in your loins");
	else output("venom coursing through your veins");
	output(", you topple backwards - only to land on the thick, leathery tail of your attacker. Grinning down at you with a predatory, hungry glint in her eye, the naleen woman coils around you, tail constricting around your weak [pc.legs] and waist.");
	
	output("\n\n<i>\"You see, little pet?\"</i>  the naleen purrs, upper body moving sinfully close to yours, her huge breasts pressing against you as her deft hands quickly deprive you of your gear, ");
	if(pc.isNude()) output("though that is a simple task thanks to your nudity.");
	else output("soon stripping you bare.");
	output(" <i>\"I knew you wanted me... all you had to do was give in to your lusts like a good little " + pc.mf("boy","girl") + ". But now that we're more comfortable, I'm all yours, sweet little toy.\"</i>");
	
	output("\n\nYou try to say something, to protest, but the naleen instead cups your cheeks and kisses you. You squirm a moment in her grasp, but she's quick to end that: she trails tender kisses down your neck to the great throbbing vein on its side, and looking up at your with great slitted eyes, bites down. There's a flash of pain, but it immediately gives way to an overpowering sense of peace, of heaviness and weariness. You try to lift an arm, but find yourself incapable of even the simplest movement. Your hand merely twitches, flopping onto the serpent-cat's waist. <i>\"Aww, how cute!\"</i>  she coos, putting her hand on yours and leaning in, pushing you back against her tail as she drags her heavy bosom over your [pc.chest] to kiss you again. You're vaguely aware of her tail coiling again, wrapping itself around your numb arms and the naleen's lithe body, pinning you against each other in a great scaly circle.");
	
	output("\n\nThe naleen breaks the kiss, leaning back and running her long, forked tongue over her fangs. <i>\"Now that's much better, isn't it? Nice and warm and safe in my coils, pet... oh, we're going to have so much fun!\"</i>");
	
	userInterface.clearMenu();
	//CHOOSE A VARIANT!
	//Dick Version -- Naleen's personal fuckstick
	if(pc.hasCock()) userInterface.addButton(0,"Next",naleenFucksBoysScene);
	//No Dick Version: Revenge of the Tail-pegging
	else userInterface.addButton(0,"Next",ohNoNoCawkNaleenLoss);
}

//Dick Version -- Naleen's personal fuckstick
function naleenFucksBoysScene():void {
	clearOutput();
	var x:int = pc.cockThatFits(foes[0].vaginalCapacity());
	if(x < 0) x = pc.smallestCockIndex();
	output("You wonder about her idea of fun, but as if on cue, you feel a twitching between your [pc.legs] as your [pc.cock " + x + "] springs to life, steadily stiffening. The naleen grins, wrapping her arms around your waist and pulling you tight against her; face mashed between her huge, heavy tits, surrounded by warm flesh and soft fur. Quietly she whispers, <i>\"That's good, little breeder. Nice and stiff for me, hmm?\"</i>");
	output("\n\nWith your eyes surrounded by an endless mass of breast, you can only feel and hear as the coils of her tail tighten, and your ");
	if(pc.cockTotal() == 1) output("cock grows");
	else output("cocks grow");
	output(" ever harder. Soft, furred fingers brush through your [pc.hair] soothingly as another set slip around your stiff member, gently stroking it to full erection. Her movements are slow and skilled, thumb swirling around your [pc.head] to coax out the first tender hint of pre");
	if(pc.balls > 0) {
		output(" before slipping down to cup your [pc.balls], fondling the heavy gonad");
		if(pc.balls > 1) output("s");
		output(" until you can practically feel your cum churning in the sensitive sphere");
		if(pc.balls > 1) output("s");
		output(".");
	}
	//{If PC has a small dick (less than 6)
	if(pc.cocks[x].cLength < 6) output("\n\n<i>\"Hmm?\"</i>  the naleen purrs, cocking her head askance, <i>\"is this all you've got for me, </i>little<i> pet? Tsk, oh well. I hear tell that it's not how much you have, but how you use it... in your condition, my pet, I do hope you can live up to it. I promise I'll reward you if you do...");

	//(If PC's got a BIGGUS DICKUS (more than 15):
	else if(pc.cocks[x].cLength > 15) output("\n\n<i>\"Oh myyyy,\"</i>  the naleen purrs as your cock grows and grows in her hand, engorging to its inhuman length. <i>\"My, my, you did pack quite a surprise for me, my pet. Such a nice change of pace from these awful, tiny zil boys everywhere.\"</i>  you groan as the naleen hugs you crushingly tight, burying you in titflesh.\n\n<i>\"Oh, I do so hope you last, pet. I want to get the most out of this!\"</i>");
	
	//If PC got a medium/normal dick:
	else output("\n\n<i>\"Ahhh, here we are,\"</i>  the serpent girl purrs, giving your [pc.cock " + x + "] a little squeeze. <i>\"Such a nice, perfect cock, and it's all mine. You don't mind if I borrow it, do you? I promise I'll pay you back.\"</i>");
	
	//{combine:}
	output("\n\nYou gulp and try to squirm away, but the paralytic in your veins keeps you perfectly placid and unresisting as the naleen's hand gently glides from your [pc.hair] down your [pc.chest], stopping to giving one of your [pc.nipples] a pinch and a tug before sliding it down to where the groin would be on a humanoid. Where the feline torso meets serpent body, the naleen's fingers slip into a nearly hidden vertical slit, vanishing up to the knuckle. She breathes deep as her fingers work, the swells of her breasts carrying your head as you lie paralyzed against her, helpless but to listen as a wet schlicking echoes up from her slit and the hand on your [pc.cock " + x + "] gives it a little tug, lining it up with the naleen's reptilian cunt.");
	
	output("\n\nOver you, the naleen gives a surprisingly feminine whimper of pleasure as your [pc.cock " + x + "] brushes her folds, just barely parting the lips of her slit. She pushes you in further a moment later, and before you can blink your prick's engulfed in a warm, silken cocoon: the naleen's tender muscles gently contract and squeeze the invading [pc.cock " + x + "], massaging and caressing inch after glorious inch as the serpentine cunt takes your dick. Helpless as you are, you can do little but moan as your rod slides into the slick snake-pussy, engulfed in her magnificent muff.");
	cockChange();
	
	output("\n\n<i>\"What's that, love?\"</i>  the naleen purrs, a hand running through your hair before pulling your face from the depths of her cleavage, letting you gaze up at her feline face once more. You moan again as her muscles squeeze down all at once, vice-like on your [pc.cock " + x + "]. The naleen giggles, cupping your cheek in both her hands. <i>\"You see, I tried to tell you how nice it would be... but that's no matter now, hmm? No, no. You're all mine now, my dear little walking cock. I do so love the feel of you inside me... so perfect, is it not? Mmm, I'm just not alive without a </i>");
	
	if(pc.cocks[x].cLength < 6) output("<i>tender little</i>");
	else if(pc.cocks[x].cLength > 15) output("<i>nice, perfect</i>");
	else output("<i>big, beautiful</i>");
	
	output(" <i>cock inside me. And the way you're whimpering, I think you feel the same. There's so little to life without sex... how boring your off-world life must be, so constrained, so hollow. But you're in my realm now, my pet,\"</i> she laughs, kissing you. You moan into her open mouth as her long, forked tongue slides past your lips.");
	
	output("\n\n<i>\"You belong to me, little pet. You and your cock and all the beautiful cum inside you... all mine.\"</i>");
	
	output("\n\nInevitably, you cum. Your [pc.cock " + x + "] spasms inside the writhing wet velvet of the naleen's cunt, utterly unable to hold back against her alien ministrations. You grunt and moan, and your captor coos with glee as you pump a thick load in her, filling her with your seed. Pleasure blooms in your mind, stars of ecstacy blossoming in the corner of your eyes as you cum and cum, shooting deep in her womb. The naleen draws a sharp breath and sighs, holding you close as the orgasm rocks your body. Some small part of your brain echoes her, relieved and exalted as you discharge your seed into the alien, reveling in the strong hands and warm embrace surrounding you, easing you through the bliss of climax.");
	
	output("\n\nBut it doesn't seem she's done with you yet.");
	
	output("\n\n<i>\"All mine,\"</i>  she breathes again, hands clasping your cheeks and guiding you down. The orgasm seems to have strengthened you, weakened the paralysis, but by now.. you don't care. You want more. The serpent-cat guides you to one of her huge, soft, perfect breasts. By instinct, your lips open, accepting her teat with eager lust. <i>\"Ahhhh, met pet, you know exactly what I want... what I like. Perhaps I shouldn't let you go, hmm? Be my perfect cock forever and ever... I'd take good care of you, and you... you could relax in comfort and contentment, eager to please your doting lover. Nice, no?\"</i>");
	
	output("\n\nShe sighs and strokes you");
	if(pc.hasHair()) output("r hair");
	output(", muscles twitching and caressing your cock as it hardens again. <i>\"A girl can dream, I suppose... I'm not cruel, pet, as you can see. I'll let you go eventually. But for now, you're mine. At least until my sweet venom wears off. Until then, your cock serves me without question, isn't that so?\"</i>");
	
	output("\n\nYour [pc.cock " + x + "] jumps to attention, hard again and ready for more. You stifle a moan, too intent on sucking the big, stiff nipple in your mouth to resist as the naleen gently rocks her hips, grinding on the cock buried inside her. It feels amazing: her vaginal muscles moving in inhuman ways, milking your seed-stiff shaft as her hips carry her up and down your helpless body. You quickly cum again, mouth popping from her teat as you cry out, howling pleasure into the warm jungle air.");
	
	output("\n\nA moment later and the other nipple is firmly in your mouth and the snake-girl's moving again, your cock rock hard inside her. She's relentless, and for hours she fucks you, draining you of orgasm after orgasm until hours later she, too, is finally on the edge.");
	
	output("\n\n<i>\"Ah, my pet, you're so good. Your cock is so perfect inside me, so irresistibly hard that I... I...\"</i>");
	
	output("\n\nShe cums, squealing in delight as her muscles clamp around you, suddenly all too tight; her coils wring your bodies, mashing you together until your lips meet, and soon you're kissing her, arms free to cup her cheeks and pull her hard against you. She tries to mumble something, but the power of her orgams silences her with a groan of pleasure that sends her hips bucking wildly against yours. You cum again, one last time to fill her sticky, seed-smeared womb with your [pc.cumColor] jizz once again.");
	
	output("\n\nFinally, miraculously, the endless fuck ends. The naleen loses her grip on you, and you tumble back, but she catches you yet again. She's under you in the blink of an eye, breaking your fall with a face full of soft, furry tits. You feel fingers running through your hair, and look up to see the naleen smiling at you, a drowsy, contented look in her eye.");
	
	output("\n\n<i>\"Not so bad after all, my pet? Don't pretend you didn't enjoy it... I know all too well,\"</i>  she says with a wink, and you can almost feel your many loads of cum rolling in her womb. <i>\"Perhaps we'll meet again, and next time you'll know the pleasures a beautiful naleen has to offer, hmm? Or maybe next time I'll let you win, and get to feel your hips pounding into mine as you fuck me in return? So many possibilities.\"</i>");
	
	output("\n\nThe naleen lets you off her when you try to stand, and shakily you collect your gear, all the while acutely aware of the serpentine feline staring at you, watching your every move with quiet lust before you can stagger away.\n\n");
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	processTime(30+rand(10));
	naleenSexed(false);
	genericLoss();
}

//No Dick Version: Revenge of the Tail-pegging
function ohNoNoCawkNaleenLoss():void {
	clearOutput();
	var x:int = 0;
	if(pc.hasVagina()) x = pc.smallestVaginaIndex();
	output("As the word <i>\"fun\"</i>  escapes her lips, you feel the naleen's reptilian tail loosen around your limp body. She leans back onto the warm, soft ground, letting you collapse atop her, cheek resting on her belly. Your [pc.legs] limply fall around her, leaving you in a pose not unlike a mockery of straddling with your ass hiked in the air, completely vulnerable to the lusty alien. You can just see the outline of her face, the sharp outline of her jaw as it twitches into a grin, feline ears alert as her serpentine body shifts beneath you. Hot leather coils around your [pc.legs],s a small, slender point teasingly inching up your thigh until your can feel it brushing against your [pc.butt]. Your inert body gives an involuntary shudder as the naleen's leathery tail caresses your bare flesh, the very head slipping between your cheeks to spread you apart.");
		
	output("\n\n<i>\"This is so much better, is it not?\"</i>  the feline beauty teases as her coils wrap around your upturned posterior. <i>\"Ass up like the little whore you are, ripe and eager for a fucking. You're lucky you didn't run into a male of my race, or you'd already have a pair of big, thick rods violating your every hole. I'm so much gentler than that... though from where you're sitting, perhaps you don't believe me?\"</i>");
	
	output("\n\nYou try to answer, but all your limp tongue can gugle out is an animalistic grunt, which soon earns you a coo of delight from the predatory woman. <i>\"You like my tail, no? Don't worry, my pet, you'll soon be moaning in pleasure for me,\"</i> she laughs, and suddenly your head is wrapped between her slender fingers, face shifted to be mere inches from her own. With surprising gentleness she pulls you down onto her, kissing your numb lips as her soft digits play down your body, tearing away what remains of your equipment until the tips brush along the very edge of your [pc.vagOrAss " + x + "]. Your breath catches as she circles your vulnerable hole once, twice, then presses in, a single finger vanishing up to the knuckle. The muscles of your helpless orifice are completely unable to resist, to even squeeze or contract around the probing finger, letting it slide effortlessly into you.");
	
	output("\n\n<i>\"Perrrrrffeeeeecct, little pet,\"</i>  the naleen grins, <i>\"Nice and loose and soooo.... unresisting for me.\"</i>");
	
	output("\n\nSlowly, she withdraws her finger, leaving your [pc.vagOrAss " + x + "] feeling agape and empty, almost cold in how unfilled it is. But the sudden sensation of leathery scales sliding across your bare [pc.butt] promises a quick remedy to your emptiness; you whine pathetically as the naleen's huge tail wraps once around your [pc.leg], the slender tip caressing your bare cheek before you feel a swelling pressure building at the ");
	if(pc.hasVagina()) output("lips of your [pc.vagina " + x + "]");
	else output("the ring of your [pc.asshole]");
	output(". With a groan, you feel your limp defenses giving way, letting the slim tip pierce into your helpless hole.");
	buttChange(20,true,true,false);
	
	output("\n\nThe first inch feels like her finger: long and slender, delving between the parted walls of your [pc.vagOrAss " + x + "], caressing every paralyzed muscle until your body is screaming in pleasure and pain, trying desperately to accommodate the growing pressure forcing its way into your body. While the tip was small, easy to accommodate with your relaxed, envenomed body, its size doubles again and again, stretching your hole until you're screaming incoherently, overwhelmed by the massive tail insertion. The naleen's penetration is unrelenting, inch after inch of ever-widening scales pumped into your [pc.vagOrAss " + x + "]. As you cry and moan, the huntress gently strokes your cheeks, fingers ");
	if(pc.hasHair()) output("running through your [pc.hair]");
	else output("rubbing across your head");
	output(" as she violates your deepest depths, stretching you until you feel as if you'll be torn apart.");
	buttChange(100,true,true,false);
	
	output("\n\n<i>\"I can almost see your stomach bulging, pet. You love having so much of me inside you, yes? I can feel your heart hammering, your body reacting to so much, so soon. But you love it, don't you? Being my little slut to be violated again and again, stretched until you cry my name to the heavens.\"</i>  As she speaks, though, you can feel the massive insertion slithering back up your [pc.vagOrAss " + x + "], leaving you with a cavernous, unquenchable emptiness as the great tail slides out, leaving little more than the tip in your well-stretched hole. Breathing hard, heart pounding from the pleasure of such a tremendous stretching, your gaze locks with the naleen's brilliant orange eyes for the briefest moment... before the great serpentine tail slams back home, ramming into your ");
	if(pc.hasVagina()) output("cunt");
	else output("ass");
	output(" until you're screaming with staggering pleasure. You're left a crying, desperately writhing pile of fuck on the naleen's belly, numb muscles violently twitching against their paralysis, trying madly to find some way to rebel against the assault - or to find some way of humping back, thrusting against the naleen's tail as it pounds your ");
	if(pc.hasVagina()) output("pussy");
	else output("anus");
	output(".");
	
	output("\n\nAss raised and helpless, your hole is fucked brutally by the naleen's seemingly endless coils of tails, slamming deep into your [pc.vagOrAss " + x + "] before pulling out again until you feel hollow, only to fill you so utterly that your mind is left blank, body lurching and spasming around it. You are brutally tail-fucked again and again, subjected to an unending assault on your battered hole, helpless but to cry and whine and moan, cursing your body for starting to enjoy such a horrible fate. It feels... good. Better and better with each gut-distending thrust that have your cries of horror soon ascending into screams of pleasure; whatever paralysis that naleen's bite inflicted seems to fade as her sexual attack stretches you over and over again, and all your sex-addled mind can think to do about it is to wiggle your hips, thrusting back on her great tail to get even just a little more of that wonderful, hot leather deep inside you.");
	
	output("\n\nSeeing you fucking her tail right back, the naleen smiles and coos, cupping your cheek to plant a proud kiss on your lips. <i>\"All mine, little pet. Body and mind, soon utterly broken, fit only for a great tail such as mine. How will you ever satisfy another cock, when you're sooooo perfectly stretched as this, hmm? You'll be crawling back to me before long, begging to feel me inside you yet again. With a face as lewd as this,\"</i> she laughs, kissing you again, <i>\"perhaps I might agree. Mmm, it's a day like this that makes being a huntress so worthwhile.\"</i>");
	
	output("\n\nYou merely groan in response, burying your face into the great furry valley of her cleavage as your hips thrust and thrust, bucking back on her hammering tail. In some primal, half-conscious part of your mind, you realize her words are meant to confuse you, the make you submit; but the rest of you doesn't care. You can feel the swelling pressure of impending orgasm approaching, building toward explosive crescendo with every buck and thrust, driving you wild with need and exquisite pleasure. You move faster and harder, trying to bring what must be a massive orgasm on sooner; the naleen just giggles, matching your quickened pace. <i>\"I told you that we would have fun, no?\"</i>");
	
	output("\n\nAnd then it hits.");
	
	output("\n\nYou throw you head back and scream, voice echoing to the heavens as your orgasm smalsm into you like a freighter, powering through your [pc.vagOrAss " + x + "] with a mind-shattering pleasure as the naleen's tail buries into you, so much deeper than ever before until your gut feels like bursting. You scream and scream, writhing on her tail until finally, with a heavy sigh, you collapse, barely conscious atop her, head cradled in her great big bosom. You feel fingers running through your hair, and groggily gaze up to see the naleen smiling at you, a drowsy, contented look in her eye.");

	output("\n\n<i>\"Not so bad after all, my pet? Don't pretend you didn't enjoy it... I know all too well,\"</i>  she says with a wink, and you squirm and groans as her hige tail slithers out of you, leaving you feeling wholly hollow and cold. She only laughs, planting a little kiss on your brow. <i>\"Perhaps we'll meet again, and next time you'll know the pleasures a beautiful naleen has to offer, hmm? Or maybe next time I'll let you win, and get to taste of your so very stretchy hole as you ride my slender tongue? You'd be amazed what I can do with it, if I so choose. So many possibilities.\"</i>");
	
	output("\n\nThe naleen lets you off her when you try to stand, and shakily you collect your gear, all the while acutely aware of the serpentine feline staring at you, watching your every move with quiet lust before you can stagger away, [pc.vagOrAss " + x + "] agape and sore.\n\n");
	pc.orgasm();
	naleenSexed(false);
	genericLoss();
}

//PC Defeats Kitty-Naga
function beatDatCatNaga():void {
	//{if by Physical damage:}
	if(pc.HP() <= 0) output("Battered and beaten, the strange alien feline-naga collapses into the dirt. She shakily tries to pick herself up, but only serves to flop down on her side, staring up at you with wide, slitted eyes. <i>\"So... you were strong enough after all. So very rare on this planet. Very well, off-worlder. What will you do with me, hmm? Perhaps I can offer you something; an apology for my attack, hmm? I have soooo many ways to make it up to you,\"</i> she says with a light coo, a hand resting on her big hip, with her huge bosom bared to you, so soft and inviting.");
	//{if by Lust:}
	else output("A master of carnal desire such as you is more than a match for such a lusty huntress. Panting heavily, the alien kitty-naga collapses to the ground, her desire clearly visible through the slick, parted folds of her sex. True to form, though, she shakily rights herself, resting on an elbow with her great big tits on enticing display as on hand dives toward her sex, starting to finger the wanton hole. <i>\"You're so.... so sensual, so beautiful. I am at your mercy, off-worlder. My body is yours to command, and I do so hope you can forgive my attack... I have soooo many ways to make it up to you.\"</i>\n\n");
	
	//99999
	userInterface.clearMenu();
	if(pc.hasCock()) {
		userInterface.addButton(0,"Titfuck",naleenTitFuck)
		if(pc.cockThatFits(chars["NALEEN"].vaginalCapacity()) >= 0) userInterface.addButton(1,"FuckHer",bendNaleenOver);
		else userInterface.addDisabledButton(1,"Fuck Her");
	}
	else {
		userInterface.addDisabledButton(0,"Titfuck");
		userInterface.addDisabledButton(1,"Fuck Her");
	}
	if(pc.hasVagina() || pc.hasCock()) userInterface.addButton(2,"GetTailPeg",obligatorySavinTailPegging);
	else userInterface.addDisabledButton(2,"GetTailPeg");
	if(pc.isLactating() && chars["PC"].milkType == GLOBAL.MILK) userInterface.addButton(3,"Breastfeed",feedDatNaleenSumMilk);
	else userInterface.addDisabledButton(3,"Breastfeed");
	userInterface.addButton(14,"Leave",genericVictory);
}
/*
Sex Options:
Dickmeisters:
	Titfuck (She's so sensitive!)
	Bend Her Over (+DP)
Cuntlets:
	Trib & Fondle (Surprise tail-pegging)
All:
	Ride Her Face (Rimming ftw)
Breastfeed (if Milky TiTS)
*/

//Titfuck
function naleenTitFuck():void {
	clearOutput();
	output("Gazing down at the sprawling serpentine beauty, your eyes are drawn inexorably toward her feline half; to the pair of huge, perfectly formed breasts, covered in a soft, downy white fur and tipped with a pair of big, pink teats. Seeing when your gaze has wandered, the naleen cracks a smile and cups one of the massive orbs, taking the stiff nipple into her mouth and giving a long lick with her slender tongue.");
	
	output("\n\n<i>\"Like what you see, off-worlder?\"</i> she grins, rolling onto her back as you approach, tossing your gear aside, <i>\"Then why don't you show me that [pc.cockBiggest] of yours and let me show you my very favorite way to pleasure a lover.\"</i>");
	
	output("\n\nNow that's an idea you can get behind. You loom over the defeated kitty-naga and drop down to your [pc.knees], straddling her, cock flopping down onto her buxom chest. She wiggles back, her great leathery tail coiling behind her head like a pillow, giving her something to lean back on as her fingers brush along the top of your [pc.cockBiggest], gently teasing the sensitive [pc.cockHeadBiggest]. They're sooooo soft.... You shake the thought from your head and turn your attentions back to the naleen huntress as she gently strokes your [pc.cockBiggest], letting it slip down into the great valley of her cleavage, nestling the throbbing meat between her big, white-furred tits with a lusty smile playing across her face.");
	
	output("\n\n<i>\"It's so nice to be able to do this once and a while,\"</i>  she says, gently squeezing the two mounds together. You stifle a shudder as the downy fur envelopes your [pc.cockBiggest], sheathing your prick in her warm, soft embrace. <i>\"Naleen males and Zil boys are always so fuck-crazy, always wanting to shove it in this hole or that. Breed, breed, breed. Never any time for the simpler pleasures.\"</i>");
	
	output("\n\nSimpler pleasures, indeed. As she speaks, the naleen's slender fingers wrap around her tits, gently moving them up along the length of your dick; the feeling of her soft fur stroking your [pc.cockBiggest] is heavenly: completely enveloped in a cocoon of soft, warm, squishy cat-tits that oh so gently caresses your tender cockflesh with short strokes that soon have you as hard as diamonds. She grins up at you as she moves her breasts, her slitted eyes gleaming with lust. Looks like she's enjoying herself too...");
	
	output("\n\nYou lean back, letting the kitty's big breasts caress your tender cockflesh. She squeezes them together as tightly as she can, steadily starting to stroking you faster, though never too fast. With her velveteen fur, it's all about the gentle, constant envelopment of your [pc.cockBiggest], brushing from your base to the [pc.cockHeadBiggest], never letting your tip escape her grasp for a moment. The pleasure is almost mind-numbing her eager breast-strokes encouraging you to lay back and forget your troubles, to just let the alien cat-naga tit-fuck you to orgasm again and again. Idly, your hands drift onto hers, fingers clasping around her slender digits. The naleen looks at you with surprise, but in the blink of an eye has her lusty countenance back again, and slips her hands out, letting you squeeze her tits for yourself, giving you control.");
	
	output("\n\n<i>\"How's that, pet?\"</i>  she asks, reclining against her coiled tail, hands resting your [pc.hips]. <i>\"Just be gentle... they may be big, but they're soooo sensitive.\"</i>");
	
	output("\n\nWell, that's practically an invitation. You shift your grasp to the tops of her huge mounds, letting her perky little teats rest in your palms as her boobflesh flows out around you, much too much to hold at once. You squeeze and knead them, and the kitty purrs in response, eyes closing in quiet pleasure. Another rough squeeze has her back arching, practically dragging your hard rod through her heaving bosom. Her breath turns ragged as you increase your attentions, and when you pinch one of her nipples, rolling the stiff point between your thumb and forefigner, she answers with a tiny yelp of pleasure, turning her gaze away from your as her cheeks flush red.");
	
	output("\n\nShe really <i>is</i> sensitive, isn't she?");
	
	output("\n\nYou grab her teats and squeeze, making the sultry naleen whimper in pleasure, squirming under you - which only exacerbates her predicament as her tits jiggle and quake as she moves, pulling on her nipples. A few minutes of that and her teats are as stiff as they can be, burning a bright red as you savage them, tugging and twisting until the poor huntress's sweet, high voice is crying with pleasure. Your hips start to buck, moving almost unconsciously into the soft underside of the naleen's boobs.");
	
	output("\n\nYou start to to hump her buxom chest, [pc.hips] slapping into the furry underside of the naleen's boobs as you pinch and tug her teats. Her hands lock onto your hips, holding on for dear life as you pleasure yourself between her breasts, thrusting and thrusting and thrusting with increasing tempo as her little cries get higher and higher. A moment later and her back arches, her voice breaking as her mouth locks into a wide 'O' of ecstasy. She writhes under you, bucking her chest into your hands, letting you grab the full swell of her breasts and squeeze, roughly teasing and kneading her huge jugs as the huntress's body convulses in a mighty boobgasm.");
	
	output("\n\nAll the while, your [pc.cockBiggest] ceaselessly assaults her cleavage, pounding her tits until the first sticky smears of pre wet her fur. Panting hard, practically quivering in her afterglow, the naleen is putty in your hands, listlessly allowing your to mash her tits around your rod and fuck her harder. You settle into a steady, intense rhythm at the limp naleen's expense, basking in the sensation of feeling cum welling up your throbbing fur-sheathed vein.");
	
	output("\n\nA weak voice below you murmurs, <i>\"Your hands.... mmm, so strong.\"</i>  You look into the naleen's slitted, feline eyes, seeing the renewed lust in them, watching her slender forked tongue flick across her lips as she rights herself, leaning up on her elbows. Your cock twitches mightily, discharging a thick stream of pre that dribbles back down the valley of her tits.");
	
	output("\n\n<i>\"You really like my tits, hmm pet?\"</i>  she asks, wrapping her hands around the pair of huge orbs, so large and yeilding that they spill out around her fingers. <i>\"Then why not give me a big, creamy load right between them? Something to remember you by until we meet again...\"</i>");
	
	output("\n\nEven as she speaks, the naleen's lengthy tongue slithers from her full lips, teasing across the [pc.cockHeadBiggest] of your [pc.cockBiggest]. You shudder in response, breath catching as the narrow strip of her tongue flecks across the tip, practically lapping at the pools of pre dribbling down your length. it doesn't take but a moment to be convinced that she's an expert at her craft, excelling with her alien endowments. Her tongue slides down, rolling out of her mouth in seemingly endless rings to wrap around your length, binding the tip of your [pc.cockBiggest] in wet warmth even as she starts to pump her breasts, running the smooth, fleshy teats across every inch her tongue doesn't encompass. It doesn't take much of of this exceptional treatment to make your head swim, enveloped in a lusty haze as the naleen's tongue and tits work your rod, bringing you closer to orgasm with every second.");
	
	output("\n\nIn the blink of an eye, the naleen's face goes from that of a sultry vixen to a cum-drenched whore. You cry out as her tongue wrings you to orgasm, stopping only when her face is suddenly plastered with a huge gush of [pc.cumColor], smearing across her cheeks and shooting into her open mouth. She just giggles and opens wide, leaning up as you fire another blast of [pc.cumColor] cream right in, pasting her lips and tongue in your seed. She swallows it up with glee, flicking her tongue across your [pc.cockHeadBiggest] between each musky spurt to lap up every straggling drop.");
	
	output("\n\nShe purrs and moans, drinking every drop you have to give her; but the fruit of your loins can't <i>all</i> go into her mouth, now can it? She wanted a thick load in the tits, and damned if you aren't going to give it to her. You plant your palm on her brow and push her head back just before she can lock her lips around your [pc.cockHeadBiggest], and sure enough a final thick wad of your [pc.cum] spurts out, shooting right between her tits. She gives a yelp of surprise, but grins as you smear her tits with your spooge, the thrusting of your [pc.cockBiggest] rubbing it into her soft fur until it sheens with your [pc.cumColor] jizz.");
	
	output("\n\nFinally spent, you roll off the spunk-coated naleen, flopping onto your back with chest heaving. The huntress slithers over you, cooing with delight and cupping her big breasts for you to view. <i>\"Hmmm... satisfied with your work, offworlder?\"</i>  she giggles, her long tongue flicking out to lick a bead of seed from her left breast. She swallows it with obvious relish, her eyes never averting from yours as she sucks down your cum. You nod, slowly gathering your discarded gear as the serpentine sex-kitten enjoys the warm, sticky mess you've left her. You stagger off, feeling mightily satisfied; behind you, the naleen waves goodbye before coiling around herself, tits up, to dry in the sun.\n\n");
	processTime(20+rand(10));
	naleenSexed();
	pc.orgasm();
	genericVictory();
}

//Breastfeed
// Needs Breastmilky-PC
//Actual milk too. Lactating latex won't cut it.
function feedDatNaleenSumMilk():void {
	clearOutput();
	output("Contemplating what to do with your hard-won prize, you take a step toward the naleen -- only to feel the heavy slosh of your motherly milk in your hefty teats. God, so full... You cup your [pc.chest], momentarily ignoring the beaten huntress to jiggle and squeeze your tits, feeling your full tits churn with an over-fullness of milk. You feel a powerful need for a good old fashioned milking, but there's nothing but a poor lusty kitty to use. Oh, whatever will you do? You turn your gaze back to the naleen, still cupping your breasts, and with a sashay to your step, approach her.");
	//If Nice/Snarky PC:
	if(!pc.isAss()) output("\n\n<i>\"Kitty want some milk?\"</i>  you ask, ");
	else output("<i>\"Open up, slut,\"</i> you command, ");
	output("tossing your kit aside to bare your needy teats, a tiny, pearly bead already forming atop your swollen nipples. The huntress' long tongue flicks out, tasting the air, and her eyes widen. <i>\"Ahhhh, what a treat you've brought me,\"</i>  she purrs, leaning back on her elbows, caressing her own huge bosom as you move overtop her, straddling her serpentine waist.");
	output("\n\nYou sit down astride her wide hips, resting back on her hefty naga body as her kitty-half slithers up into your open arms, forked tongue licking her lips with gleeful anticipation as her downy-soft fingers play across your bare flesh, holding herself tight against you, breasts pressing into one another. She plants a kiss on your lips, breathing huskily, <i>\"Thank you for the treat, offworlder. I'll make this so very pleasurable for you...\"</i>  Considering you're the one with the milk, she damned well better.");
	
	output("\n\nA pair of lithe arms, surprisingly strong, wrap around your neck. The huntress cradles herself as your own arms slip around her slender frame, guiding her down your milk-laden chest. She goes slowly, her long tongue flicking out to taste your bare [pc.skin], sending shivers down your spine. One of her hands slips down with her and slips beneath your breast, cupping the hefty orb with just enough squeeze to draw forth a bead of milk. Seeing how freely you give of your motherly bounty, her tongue reaches slowly  out, almost tentatively, just barely close enough as the lone little drop falls from your [pc.nipple]. She catches it, tongue darting back with its prize; a smile forms on her lips as she tastes of you, and she purrs so sweetly you can't help but slip a hand through her long orange hair, gently guiding her to your breast.");
	output("\n\nHer lips open wide, locking perfectly around your teat, with just the barest hint of suckling that you barely feel it. She squeezes your breast again, even gentler this time, letting her mouth urge out the first steady stream from you. Your back arches as she suckles, fingers digging through her soft hair as your teat beads and finally pours, flowing freely into the hungry kitten's maw. Her eyes lock with yours, half-sparkling with glee as she swallows, and she purrs softly, a low thrumming running through your leaky teat that makes you gasp in pleasure.");
	output("\n\nIn return, your own hands snake downwards to where kitty meets serpent. You grab her wide waist, fingers squeezing the big, round cheeks of her fleshy ass, pulling her so close against you that you wince as fangs graze your tender flesh. The naleen looks up apologetically, but you answer with a sharp swat on that ass that makes her gasp and gag, milk pouring out onto her own huge bust, staining the white strike of fur on her belly. She gives a little whine, and after that you content yourself with playing with her big booty, squeezing and kneading the yielding ass-flesh. But you can't content yourself with that for long.");
	output("\n\nFor a few minutes, you revel in the soft, slaking pleasure of breastfeeding, feeling the milk drain from your tit, gasping and moaning as the naleen's snake-like tongue plays across your sensitive teat, teasing you with every breath until you can barely take it. When the pleasure's almost too much, you pull her head back, letting the last drops fall onto her own chest. She mewls hungrily, and soon you have her moved over to the other tit; but when she's almost settled in again, purring happily as she sucks you dry, you have a surprise for her.");
	
	output("\n\nYour hands again move to her hips, holding them for a minute longer before spreading her cheeks wide. The naleen gasps, but you move quickly, fingers darting through the tiny gap in her thighs to the slick slit of her sex. She stifles a gasp, moaning into her mouthful of titty as your fingers slip easily into her warm embrace, thumb teasing across her tight-clenched little ass as two others pierce her womanhood, delving so deep the naleen can't help but cry out, spilling her mouthful of cream all over your chest and hers. <i>\"Naughty kitty. Clean that up,\"</i>  you chide, mock-scolding her as your thumb pushes in, making her whine and howl until you shut her up with a face-full of milky tit, still half-full. Spreading both her holes and with your milk being suckled again, you both moan as pleasure, primal and undeniable, overtakes you.");
	//If PC has a cock:
	if(pc.hasCock())
	{
		output("\n\nBut she won't let you off that easily. Shifting ever so slightly, her hand plays across your thighs, teasing your tender skin. You look down, just in time to see her white-clad fingers locking around [pc.oneCock]. You hadn't even realized how hard you were... She gives you a little wink, emerald eyes full of mischief as she starts to tenderly caress your cock, gently stroking it with fur so soft you could swear it was heaven. You move your hand in response, buried deep inside her. For every stroke, you thrust your fingers in, spearing her cunt and ass harder and faster as she picks up her pace, quickly building to a furious handjob. You grunt in sexual need, straining not to cum too quickly at the naleen's hand. She doesn't make it easy for you, though: she keeps up the unyielding pressure for what seems like eternity before finally, with a sly grin offset by her stuffed gob, she slips her waist forward, grinding her finger-filled cunt up against your drooling pecker. Your breath comes sharply as the radiant heat of her eager sex rubs off on you, her cunny's slick lube letting her hand work ever faster. You try to distract her by pushing her down on your breast, but the sudden shift of her body has just the wrong effect: with a gasp, you feel your [pc.cockSmallest] bend a moment before it suddenly finds itself rushing into a tight, warm, wet enclosure, hugging it tightly as your fingers clench inside her.");
	}
	
	output("\n\nMoaning and purring, the naleen moves on your fingers, hips rocking, nearly baring you to the ground as she drinks and drinks, a seemingly endless hunger for your milk and sex overtaking her. You hook an arm around her, holding the passionate kitty as she grinds and humps on your hand {and cock}, pushing you deeper into her slavering holes as her tongue goes wild on your [pc.nipple], lapping at the constant flow of your sweet milk, urging you on into a torrent that bulges her cheeks, too fast for her to swallow it all. Soon, she's wholly overflowing with your bounty, humping away with utter abandon. Her eyes roll closed, utterly absorbed in the furious fuck.");
	
	//If cock:
	output("\n\n");
	if(pc.hasCock())
	{
		output("You groan, muscles spasming as the naleen rides your cock, bouncing on your [pc.cockSmallest] with muscles writhing and squeezing, trapping your rod in a slick sheath of sex. Your fingers work her from behind, moving just out of sync with your prick to keep the pressure on her, pounding into her holes twice as hard with her every bucking motion. ");
	}
	output("The Naleen's tail coils around you, squeezing you tight as she moves, hips bucking as her face presses hard into your breast, sucking out every drop she can get - and nearly driving you mad with pleasure. Her tongue moves wildly, soft lips kissing, teeth scoring across your [pc.nipple]; you can't take much more of this. You throw your head back, pulling the huntress close as you feel your orgasm coming");
	if(pc.hasCock()) output(", cock throbbing inside her, spilling the first trails of [pc.cumColor] into her sodden box");
	output(". The naleen herself isn't much better off, her high voice whining as her quim drenches your fingers in orgasmic fluids, clamping and squeezing and milking ");
	if(!pc.hasCock()) output("them ");
	else output("your [pc.cockSmallest]");
	output(". The way she purrs and moans around your tit, though... the vibrations are what push you over, your titflesh quaking into a massive boogasm that wracks your body from the [pc.chest] out");
	if(pc.hasCock()) 
	{
		output(", quickly shooting down through your veins like a wildfire of pleasure until your [pc.cocks] ");
		if(pc.cockTotal() > 1) output("blow their pent-up loads, one spasming out a huge, thick swath of seed into her waiting hole.");
		else output("blows its pent-up load, spasming out a huge thick swath of seed into her waiting hole.");
	}
	output("\n\nWith a gasp, the naleen falls onto her back, milk dripping from the corners of her mouth as she flops down, sodden tits jiggling obscenely. ");
	if(pc.hasCock()) output("Your [pc.cockSmallest] pops free of her vice-like cunt as she does so, leaving a nice creamy smear on her thigh as you withdraw. ");
	output("With a contented sigh, the huntress wipes her lips and idly rubs her cum-stained quim, regarding you with wide eyes. <i>\"That was a magnificent treat, pet,\"</i> she purrs, smiling. <i>\"Among my people, it's a great honor to suckle from a mother's teats. A sign of unparalleled trust and love. Thank you, little pet.\"</i>");
	
	output("\n\nYou don't know what to say to that, if only for a moment. A moment she takes to plant a quick kiss on your cheek and slithers off, leaving you to your own devices.\n\n");
	processTime(40+rand(10));
	pc.orgasm();
	naleenSexed();
	genericVictory();
}

//Bend Her Over (+DP)
//{For PCs with 1+ dicks}
function bendNaleenOver():void {
	clearOutput();
	var x:int = pc.cockThatFits(foes[0].vaginalCapacity());
	if(x < 0) x = pc.smallestCockIndex();
	var y:int = pc.cockThatFits2(foes[0].vaginalCapacity());
	output("You move to straddle the prone kitty-naga, tearing your gear off and brandishing your [pc.cocks], letting your half-hard member");
	if(pc.cockTotal() > 1) output("s");
	output(" dangle over her wide-eyed face. She stares up at your ");
	if(pc.cockTotal() > 3) output("many ");
	output("length");
	if(pc.cockTotal() > 1) output("s");
	output(", lips curling into a lusty smile as her tongue flicks out, its slender tip barely caressing the crown of your [pc.cock " + x + "] - just enough to send a shudder of pleasure up your spine, her slightest touch electric on your most sensitive skin. <i>\"Brought me a present, did you, pet? Oh, I'll take good care of </i>");
	if(pc.cockTotal() == 1) output("<i>this</i>");
	else output("<i>these</i>");
	output("<i>; just lie back and relax.\"</i>");
	
	output("\n\nOh, no she doesn't. You grab the naleen by her flared waist, rolling her serpentine body over; she instinctively hikes her ass up, rounded cheeks swaying temptingly above her writhing coils. Cheek in the dirt, the naleen looks up at you expectantly, reaching back to cup your ");
	if(pc.balls > 0) output("swaying sack ");
	else output("...[pc.butt] ");
	output("and urge you on, utterly shameless in her defeat and lust. You give her a swat on the backside, inadvertently pushing her deeper into the mire of the forest. She cries out, left resting on her tremendous bust as you shift to straddle her elongated form, lining your [pc.cocks] up with her lush backside.");
	
	//If PC has 2+ cocks (Holy shit Savin has variation!)
	if(pc.cockTotal() > 1 && y >= 0) {
		output("\n\n<i>\"A pair of pretty pricks for me, pet?\"</i>  the naleen giggles, shifting back to rub her ass against the undersides of your two pulsing, eager members. <i>\"You do know how to spoil me, don't you? So rare to see a </i>real<i> male out here....\"</i>");
		
		output("\n\nYou grunt approvingly as your [pc.cock " + x + "] slips between her pliant cheeks, squeezed between hot, taut assflesh as the other flops over the mound of her backside, drooling eager pre onto her arched, furry back. She purrs sexily, a soft moan escaping her lips as your cock rubs across the gash of her sex and the tight ring of her ass. <i>\"One for breeding and one for feeling,\"</i> she giggles, reaching back to grab your second prick, stroking your shaft in time to the movement of her hips, making sure both your manhoods get their fair share of pleasure.");
		output("\n\n<i>\"To tell you the truth, I've always wondered how it is supposed to be with our males: is it two in the pussy, to make sure it's nice and packed full of babies, or one in each hole to make sure we feel every bit of pleasure. Or maybe it's supposed to be one for two different girls? You'd like that, wouldn't you pet - if I went and found one of my sisters to join us? Naleen are always best in groups, you know... maybe if you're a good " + pc.mf("boy","girl") + " I'll take you along some time. With these beauties,\"</i>  she giggles, tugging your pricks, <i>\"you'd fit right in.\"</i>");
		
		//If PC is snarky: 
		if(pc.isMischievous()) output("\n\n<i>\"Speaking of fitting,\"</i>  ");
		else if(pc.isNice()) output("\n\n<i>\"Maybe I'll take you up on that some time. But for now...\"</i>  ");
		else output("\n\n<i>\"Enough with the talking,\"</i>  ");
		output(" you say, giving her ass a rough squeeze - hard enough to spatter a little bit of fem-slime out onto your cock, getting you nice and lubed for what's to come.");
	}
	//If PC is monocock:
	else {
		output("\n\nBefore you can slip your cock into her, the naleen shifts her own backside up, grabbing your [pc.cock " + x + "] between the tight clefts of her ass. You draw a hissing breath - damn she's tight! - but a moment later and she's purring happily, rocking her booty along the shaft of your schlong, rubbing her slick pussy juices all along your length. She gasps and moans as your [pc.cock " + x + "] slides through her cheeks, rubbing along the puckered star of her ass and the lowest folds of her wet, drooling cunt.");
		
		output("\n\n<i>\"Do you do this to all the pretty girls you meet out here, pet: beat them down and push them into the dirt to tease them relentlessly? Or are you going to actually </i>fuck<i> me?\"</i>");
		
		output("\n\n<i>\"You started it,\"</i>  you snap, giving her ass a rough squeeze - hard enough to spatter a little bit of fem-slime out onto your cock, getting you nice and lubed for what's to come.");
	}
	
	//{Combine:}
	output("\n\nThe way your naleen slut's purring and whining, she's practically begging for it. You line the crown");
	if(y >= 0) output("s");
	output(" of your cock");
	if(y >= 0) output("s");
	output(" up with the kitty-naga's slavering cunt");
	if(y >= 0) output(" and winking asshole, so relaxed and ready you're sure you could slip in as easily as a well-fucked pussy");
	output(". Her back arches in a rush of pleasure as the tip of your [pc.cock " + x + "] brushes her slick folds, making her gasp as your [pc.cockHead " + x + "] every so slightly parts her womanly veil, letting her juices run free to practically slather your schlong. Grabbing her big hips for support, you slide forward, parting her slick folds");
	if(y >= 0) output(" as your [pc.cock " + y + "] presses up against her tight rump, straining for a brief moment before the naleen screams as you're in, pushing through her tight rectal channel");
	output(". Her walls squirm and squeeze around your cock");
	if(y >= 0) output("s");
	output(", pushing back hard against you to make your work for every inch. But she's so wet, it barely slows your onslaught. ");
	if(y >= 0) output("Her ass gives a bit more of a fight, but the steady push of your hips keeps it going - and your lover's not shy about thrusting her hips back, too, moaning louder with every pump you give into her tight behind. ");
	output("She's loving every second of it, clutching at her tits and purring so throatily you can feel it all the way back in her quivering quim, a thrumming vibration that spreads to your very core.");
	cockChange();
	
	output("\n\nYou wrap your hand through her fiery hair, pulling the slut's head back to stop her before you cum too soon. She gives a sharp cry, but returns your harsh rebuke by grinding her hips back against you, nearly swallowing your cock");
	if(y >= 0) output("s");
	output(" up until ");
	if(y >= 0) output("they're");
	else output("it's");
	output(" so deep inside her that ");
	var totalStuff:int = pc.cockVolume(x);
	if(y >= 0) totalStuff += pc.cockVolume(y);
	if(totalStuff > foes[0].vaginalCapacity()) output("her stomach bulges obscenely");
	else output("your groin presses deep into her cushiony tush");
	output(". As speared on your cock");
	if(y >= 0) output("s");
	output(" as she's going to get, the naleen purrs happily, content to let you take back the initiative. You give her a rough slap on the backside to chastise her, but only end up making her squeeze and clamp around your buried member");
	if(y >= 0) output("s");
	output(", her slick pussy");
	if(y >= 0) output(" and tight little ass");
	output(" wringing your manhood so tightly you're tempted to just let go and cum on the spot.");
	
	output("\n\nHolding it in takes every bit of your willpower, but the approving grin from the kitty-slut beneath you makes it all worthwhile. <i>\"Mmm, now </i>there<i>'s a good ");
	if(y >= 0) output("pair of cocks");
	else output("cock");
	output(". Such control, pet... I can't remember the last male that didn't just give it all up to my... ministrations,\"</i>  she giggles, slowly relaxing her muscles enough that you can move again, letting you slide your prick");
	if(y >= 0) output("s");
	output(" out to the crown");
	if(y >= 0) output("s");
	output(" - only to plunge back in again, right to the hilt! She cries, back arching as you slam into her backside. The naleen's long, powerful tail thrashes between your [pc.legs], coiling and spasming as her body takes your cock");
	if(y >= 0) output("s");
	output(" again and again, stretching her hole");
	if(y >= 0) output("s");
	output(" until her pussy's drooling slime into the dirt between hammering thrusts. Her fingers dig into the sodden ground, biting her lip to keep from screaming - too often, anyway - as you fuck her faster and harder for every one of her cute moans and pleasured cries. The white-furred crests of her ass jiggle lewdly as your crotch slaps into it, each thrust sending big full bubble butt bouncing.");
	
	output("\n\n<i>\"Yes! Yeeeessss!\"</i>  the naleen cries, finally losing all control as you slam your cock");
	if(y >= 0) output("s");
	output(" deep into her, ");
	
	if(totalStuff <= foes[0].vaginalCapacity()) output("crotch slamming into her jiggling ass");
	else {
		output("massive erection");
		if(y >= 0) output("s");
		output(" distending her until her stomach bulges larger than even her tremendous bust");
	}
	output(". Her ecstatic voice warps into a scream of feral pleasure as you fuck her, higher and higher as she loses herself to orgasm. Her cunt's soaked channel squeezes and slides along your rock-hard length, spasming wildly as her fem-cum splatters across her coiled tail, a steady stream of alien spunk leaking from her well-fucked womanhood as you slow your furious pace, letting her ride her orgasm out. ");
	if(y >= 0) output("Her ass is no slouch, either: as her cunt milks your [pc.cock " + y + "], your other meaty prick is subjected to an endless wringing courtesy of her tight-clenched muscles, squeezing and pushing at the veiny intruder piercing her tender ass. ");
	output("No reason to hold back anymore: you grab her hips and slam in one last time, making her scream as her muscles do the rest: squeezing down so tight around your ");
	if(y >= 0) output("dual cocks");
	else output("cock");
	output(" that you can't help but cum with her.");
	
	output("\n\nYour [pc.cock " + x + "] erupts inside her, a thick stream of [pc.cum] flooding into her spasming cunt to greet the lips of her winking womb");
	if(y >= 0) output(", followed a moment later by your [pc.cock " + y + "] which blows a thick, creamy load deep in her abused asshole, smearing her rectal walls [pc.cumColor]");
	output(". You continue to thrust into the squealing kitty-naga as you cum, pushing your spunk as far into her as you can - and she's happy to take every drop. Settling down after cumming, the naleen begins to wiggle her ass for you, pushing back against you to take every last inch of your throbbing, cum-filled cock");
	if(y >= 0) output("s");
	output(".");
	
	output("\n\nWith one final, spunk-leaking twitch, you feel your orgasm subsiding. With a heavy, contented sigh, you pull out of the kitty-naga, leaving her ");
	if(y >= 0) output("ass and ");
	output("pussy gaping after your rough fucking, cum drooling obscenely from her battered sex. <i>\"Mmm, that was marvelous. Perhaps I ought to let you win more often, hmm?\"</i>  she teases, winking over her shoulder at you and giving her booty a little wiggle. You give her a sharp swat on the behind as you stagger to your [pc.feet], collecting your gear. By the time you're ready to go, the naleen is snoozing peacefully, coiled up in a rare sunny spot, still dripping [pc.cumColor].\n\n");
	processTime(30+rand(5));
	pc.orgasm();
	naleenSexed();
	genericVictory();
}
//Tail-pegging
//Requires at least a cunt or dick.
function obligatorySavinTailPegging():void {
	clearOutput();
	var x:int = pc
	output("Oh, she'll make it up to you alright. You loom over the fallen kitty-naga, licking your lips as you visually feast on her buxom, serpentine body: eyes following the soft, wide curves of her wide hips, along her flat, taut belly and its thin diamond of white fur in a sea of orange, up to the great swells of her oh-so-soft breasts, each heaving with her quickened breath, clearly aroused by your lustful stares. One of her slender hands slips down her supple form to the conjoinment of her humanoid and naga halves, fingertips teasing the shimmering slit of her sex, two slipping in with such smooth, silky ease that you feel yourself drawn in, sitting down to the naleen's level and straddling her broad flanks, your ");
	if(pc.hasVagina()) output("[pc.vaginas]");
	if(pc.hasCock() && pc.hasVagina()) output(" and ");
	if(pc.hasCock()) output("[pc.cocks]");
	output(" sinfully close to her sodden slit, so close that you can feel the wet heat welling up from the depths of her silken pussy.");
	
	output("\n\nIt's oh so hard to draw your attention from the naleen's inviting little cunt, letting your hands come to rest on her gropable hips, fingers ever so slightly caressing the swell of her big bubble butt. Your touch sends shivers through the horny huntress, nearly toppling you off her as her tremendous tail swishes beneath you, its man-sized girth powerful enough to send some of your discarded gear flying. Niiiice. You reach back, grabbing the very tip of her writhing tail; she freezes like a deer in the headlights, breath catching as your fingers brush the slender end of her lengthy body. <i>\"W-what are you going to do with that, hmm?\"</i>  she finally manages to stammer out as you gently caress the smooth, warm scales of her hind end. With a sly grin, you guide the tip of her tail back, coiling it around itself, bringing it ever closer home. With every tug and slip of your hand, the naleen gasps and coos, biting her lip and blushing a bright crimson by the tip her wriggling point slips along the sheer curve of your ...[pc.butt].");
	
	output("\n\n<i>\"Gentle, pet,\"</i>  the naleen hisses as you squeeze her tail, grinding your ...[pc.butt] against its leathery underside. You give her a playful pinch on one of her wide pink teats, jiggling the massive tit until she whines with pleasure, tail thrashing powerfully in your grasp. Oh, this is going to be good. You release her reddened nipple, and with a few finally shakes, the tip of her tail calms down, though still shivering in anticipation in your hand.");
	
	output("\n\n<i>\"You're a brute,\"</i>  she whines, cupping her breasts protectively, shielding them from your machination. So sensitive! You bypass her defenses entirely, leaning down over the prostrated kitty-naga and kissing her full on the lips, taking her wholly off-guard. She freezes again, but only for an instant this time; she recovers with a vengeance, letting her slender tongue probe past your [pc.lips], playing across your own, letting you gently brush her hands off her bust to let you cup them, squeezing the big soft orbs more gently this time, teasing her puffy teats and sensitive undersides. Her own hands slip back, grabbing your ...[pc.butt] and sinking her fingers in, playfully spreading and squeezing your cheeks. You let loose a little moan, breaking the kiss to nuzzle into her neck, cheek brushing her soft-furred shoulders as your own hand returns to working her tip, stroking it like a cock as you inch it further and further up her supple frame.");
	
	output("\n\nAs long and flexible as she is, it's only a matter of time before the tender tip of her tail is coiled up to her chest. You give her a gentle nibble on the inside of her neck, making the huntress gasp and arch her back, distracted and defenseless as you slip her tail up between your bodies, trapping between the valley of her breasts and your own [pc.chest] pressing down on her bust. ");
	if(pc.biggestTitSize() > 2) output("The naleen coos as her tail is caught up in a double tit-fuck,wriggling rhytmically between your tits, even flicking up to brush your [pc.nipples] as you start to move, dragging your own full breasts up along the length of her scaly end. <i>\"Oooh, you really know how to treat a girl, don't you? Mmmm don't stop,\"</i>  she murmurs, cupping her own breasts to work alongside you, jerking her sensitive tail off like the great big kitty-cock you're soon going to use it as.");
	else output("Pressing down on the naleen's bust, you grab the two tremendous orbs of kitty-flesh, so sinfully soft that your fingers practically disappear into the yielding flesh of her buxom chest. She purrs happily, leaning back as you at once massage her needy chest and tit-fuck her leathery tail, jerking it off like the big kitty-cock you're soon going to use it as.");
	output(" She shows no sign of resistance to you anymore, happily allowing you to worship her tail, eager to surrender her own breasts for the purpose. But if she thinks she's just getting a tit-job, she's got another thing coming...");
	
	output("\n\nYou gently shift your [pc.chest] up, pulling with it a few more inches of naleen-tail until the very writhing tip is practically flopping onto the huntress's nose. She gives a little gasp as it brushes her button nose, but when you lean in and give it a long, languid lick from tip to teat, she's eager to join you. You suck the tip into your mouth, letting your tongue play across her most sensitive little nub as the naleens long, forked tongue caresses her underside, lapping at the leather like candy. Her breath quickens visibly as the two of you worship her leathery appendage, chest heaving as her breasts ceaselessly massage her length, pushed further and further apart as her tail rapidly expands, growing from but an inch thick in your eager mouth to almost a foot across between her tits. And every inch seems as whorishly sensitive as the first, responding to your every touch and caress with a wiggle and a little gasp of pleasure from your lover. You let a hand slide down again, gently stroking the writhing mass of her lower half as you search out the conjoinment of kitty and snake; you feel the heat and wetness long before the slit itself, and your fingers as soon slathered in the naleen's excitement, her dripping pussy winking and spasming as your hand draws nearer, so eager and needy, desperate for a cock or a fist to fill it.");
	
	
	output("\n\nYou circle a single finger around the lips of her quivering quim, making the sultry vixen gasp with delight, crying, <i>\"Yeeees, right there! Give it to me, make me yours!\"</i>  You let her tail-cock pop out of your mouth, trading the spit-slick tip for her kissable lips as your whole body shifts, your ");
	if(pc.hasVagina() && !pc.hasCock()) 
	{
		output("own puss");
		if(pc.totalVaginas() == 1) output("y");
		else output("ies");
		output(" gliding across the naleen's, [pc.clits] brushing her own engorged bud.");
	}
	else if(pc.hasCock()) {
		output("[pc.cocks] slide");
		if(pc.cockTotal() == 1) output("s");
		output(" across her taut body, gliding through the slick field of her spilt excitement until the crown brushes her netherlips. Penetrating her is effortless, her slutty slit easily parting to accept your cock, taking inch after inch as you slide yourself home inside her.");
		cockChange();
	}
	else output("featureless groin rubbing her pussy, gliding across her with almost unnatural ease thanks to the lake of fem-slime coating her groin.");
	output(" Her back arches under you as she cries her pleasure, filled with such primal lust that you fear she'll cum on the spot! Your sexes meet, crotches grinding with a steady passion, keeping the kitten on the edge of her orgasm as you take hold of her wet tail-tip, guiding it back around your entwined bodies toward your own pleasure.");
	
	output("\n\nShe catches on, grinning up at you as her hands slip around your [pc.hips] again, planting themselves on your ...[pc.butt] and spreading your wide. <i>\"Allow me,\"</i>  she whispers, voice husky. You answer her with another kiss, lasting but a second before she slides down your cheek and neck, nibbling the sensitive flesh there to take your mind off your behind as her tail slithers up - but a rough smack on the ass brings you right back, gasping with pain and pleasure as the dirty little naleen gives you another spank, giggling as your ass clenches.");
	
	output("\n\nYou wiggle your heiny, and gaps again as she gives you a playful swat, setting the flesh on your ...[pc.butt] to jiggling obscenely. Another slap and you've had all you can take - she's stronger than she looks, and that's saying something! But she seems to know it, and much more gently lets her moistened tip caress your sore cheek, coiling around it before slipping into your crack. Your breath catches as her warm, wet tail-prick glides over your ass");
	if(pc.hasCock()) output(", [pc.oneCock] trembling in her warm embrace; she squeezes down around your engorged length, purring sweetly as she takes more of your shaft, muscles caressing every inch of your fuckpole with a practiced skill that soon has you wanting to spurt your load - but you can't, not yet");
	else if(pc.hasVagina()) output(", and even your pussy quivers overtop hers. She grins, letting one of her hands twist down to your nethers, and you sigh with blessed relief as a pair of her fingers slip in, finally answering your cunt's call for something to fill it, to squeeze and milk. You buck your hips on her inserted digits, riding them like a little cock, letting your pussy grind over her wrist, pushing it back against her own needy box");
	output(". The moment of penetration looms, but before she pushes in, the naleen gently cups your cheek, kissing you again before guiding your head down to the now-vacant valley of her cleavage, letting you rest your head between her breasts as her tail lines up with your eager behind.");
	
	output("\n\n<i>\"Just relax, my loving little pet,\"</i>  the huntress coos, stroking your hair as her tip pushes forward, finally pressing against the ring of your [pc.asshole]. You gasp and cry, biting your lip hard as she steadily applies pressure to your helpless sphincter. All there is to do is relax yourself as best you can and take the thick slab of scaled tail that you so desperately wanted. And the moment it's inside you, everything pays off in spades. Back arched and ass gaping, you scream and cum as her thick tail rams mercilessly past your limp defenses, spreading you wide. Your ass quivers and spasms with wild abandon around her probing member");
	if(pc.hasCock()) output(", and your cock joins a moment later, busting a load right into the sex-kitten's eager pussy as she milks your prostate. She gives a little cry as your seed flows into her, spattering her slick walls with sticky [pc.cumColor] spunk");
	else if(pc.hasVagina()) output(", just as your pussy does around her hilted fingers, squeezing and clamping with lustful release, riding her hand as you cum and cum");
	output(". She gives a sharp squeal of delight as your ass milks her tail-tip and your ");
	if(!pc.hasCock() && pc.hasVagina()) output("pussy");
	else if(!pc.hasCock()) output("groin grinds along her own needy box");
	else output("cock fills her again and again");
	output(". You hump desperately along her lithe form, pounding your ");
	if(!pc.hasCock()) output("ass along her length");
	else output("[pc.cock " + x + "] deeper and deeper");
	output(" until she's cumming with you, head thrown back and screaming her orgasm. Desperately, you grab the kitty's cheek and kiss her, fingers brushing through her fiery tresses as you silence her. She tries to reciprocate, but it's as if she's lost to the pleasure, spasming in your arms.");
	
	buttChange(100,true,true,false);
	
	output("\n\nYou know time passes, but for you, it has little meaning as the naleen mercilessly writhes and thrashes in your ass, ramming more and more tail deep inside you even as your orgasm passes, replaced by mind-numbing anal pleasure. She groans and moans, holding you tight as your stomach distends, organs pushed and cramped to take the massive insertion cramming up your bum. When it's finally over, all you can do is sigh with utter, complete contentment, hand holding your bulging belly as the half-senseless naleen slowly pulls herself from you.");
	output("\n\nYou don't know how many times you've cum");
	if(pc.hasVagina()) output(", but the sea of fem-cum");
	if(pc.hasCock() && pc.hasVagina()) output(" and leaking spunk pouring from the naleen's cunt to pool");
	else if(pc.hasCock()) output(", but the sea of leaking spunk pouring from the naleen's cunt to pool");
	output(" around you would seem to say quite a few times indeed");
	output(". With a wet, body-shaking POP, the huntress's tail slithers out of you completely, and senseless, you roll off her into the soft dirt. You barely notice as the kitty-naga coils herself up around you, picking your head back up to rest on her breast, surrounded by warm, comforting snake-scale and soft fur. You feel long, slender fingers stroking your ");
	if(pc.hasHair()) output("[pc.hair]");
	else output("head");
	output(", another hand gently ");
	if(pc.hasCock()) output("warpping around your half-hard cock, using your own cum as lube to continue stroking you off");
	else if(pc.hasVagina()) output("masturbating your still-hot cunt, fingers gingerly probing the depths of your womanhood");
	else output("caressing the bare [pc.skin] of your groin");
	output(", letting you drift off to sleep in her arms.");
	pc.orgasm();
	pc.orgasm();
	pc.orgasm();
	processTime(30+rand(40));
	if(rand(3) == 0) pc.orgasm();
	if(rand(4) == 0) pc.orgasm();
	if(rand(5) == 0) pc.orgasm();
	if(rand(6) == 0) pc.orgasm();
	if(rand(7) == 0) pc.orgasm();
	naleenSexed();
	userInterface.clearMenu();
	userInterface.addButton(0,"Next",tailpeggingNaleenPartII);
}

function tailpeggingNaleenPartII():void {
	clearOutput();
	output("Your eyes flitter open, squinting in the darkness of the forest floor. You're acutely aware of the bed of snake surrounding you, gently shifting with the rise and fall of her steady, strong breath. You roll half-over on your pillow of boob-flesh, but find your huntress lover quite thoroughly asleep, eyes closed and mouth agape, snoring peacefully. You smile wanly, leaning over to kiss her before struggling to your [pc.feet], searching for your discarded gear. As you get ready to leave, you turn back just in time to see one of her brilliant green eyes quickly closing as she pretends to stay asleep, letting you go in peace.\n\n");
	processTime(60+rand(40));
	genericVictory();
}

//Naleen Night-time Cuddles
//Requires the PC to have fought the naleen at least five times. Chance to encounter when the PC is in the forest in the late afternoon -> night time. Chance = Fatigue / 2?
//Proc at 11 PM in the jungle!
function naleenNightCuddles():void {
	clearOutput();
	output("The forest seems to be growing thicker and thicker with every step, taking you deep into the heart of the jungle far, far away from Esbeth. The trees are overgrown, thick with vines and moss, their branches so intertwined you can hardly see the sun. Looking cautiously around, you make your way through the dense underbrush, slowly hacking through the ever-present foliage on your way across the endless sea of trees.");
	output("\n\nSlowly, though, you begin to feel as if you're being watched. You draw your [pc.meleeWeapon.longName] and scan your surroundings, looking for the source of your unease. The jungle seems quiet, too silent and still. Your keen eyes search as you slowly turn, eyeing every angle until finally you catch a glimpse of movement! You ready your weapon and shout for who or whatever it is to show itself - and soon it does. You hear a rustle AHEAD of you for once, and ready your [pc.meleeWeapon.longName] as the brush parts to reveal the familiar form of the naleen huntress who's stalked you since first meeting. This time, though, she raises her hands in a sign of peace as she slithers toward you, a slight smile on her lips.");
	
	output("\n\n<i>\"Easy, my pet, I mean no harm. It is very late out, now... why have you not returned to your village, hmm?\"</i>  she queries, gently pushing your [pc.meleeWeapon.longName] down as she teases, <i>\"Were you out looking for me, pet? Tsk, you only had to call!\"</i>");
	
	output("\n\nYou lower your [pc.meleeWeapon.longName] as the naleen circles you, hips swaying seductively with her every serpentine motion. She slips behind you, big bare jugs pressing into your back as she whispers, <i>\"It's dangerous to go alone at night in these woods, my pet. You should know better... but at least it's me who found you first, and not some fuck-mad zil, no?\"</i>  The huntress chuckles to herself, breath hot on your cheek as her slender, powerful arms wrap around your waist and under your [pc.chest]. Considering how frequently the two of you have battled, you feel oddly at ease in the lusty kitten's embrace, and let yourself relax in her arms, head resting back into the soft, inviting pillow of her chest. She doesn't seem to mind at all.");
	output("\n\n<i>\"Pretty, silly pet,\"</i> the naleen coos, stroking your hair. <i>\"Whatever would I do if you were to be captured by some filthy zil-slut, or dragged away to be filled with a trapper-plant's pollen forever after, hmm? I suppose I'll have to watch over you tonight, won't I, pet? At least to keep the cold away - it gets so awfully chilly here at night.\"</i>");
	processTime(3);
	userInterface.clearMenu();
	userInterface.addButton(0,"Yes",yesSnuggleWifZatNaleen);
	userInterface.addButton(1,"No",noDontSnuggleDatCatShellClawYerEyesOutManIswearISawItOnAHolo);
}
//No, thanks
function noDontSnuggleDatCatShellClawYerEyesOutManIswearISawItOnAHolo():void {
	clearOutput();
	output("You gently push the naleen girl off. <i>\"I'll have to pass this time, beautiful,\"</i>  you say, putting a bit of distance between the two of you.");
	
	output("\n\nShe makes as if to respond, but merely slumps her shoulders and gives a little pout. <i>\"Have it your way, pet. Perhaps you'll think different when you've wandered alone in the cold, wet wilderness for a while more.\"</i>");
	processTime(1);
	userInterface.clearMenu();
	userInterface.addButton(0,"Next",mainGameMenu);
}
	
//Awesome!
function yesSnuggleWifZatNaleen():void {
	clearOutput();
	output("<i>\"I guess you'll have to,\"</i>  you grin, reaching back around to cup a handful of the naleen's bountiful bottom. She gives a happy little gasp, wiggling her behind and slowly lowering herself to the forest floor, pulling you down with her. You let yourself be cradled down to the ground, head resting on the best pair of pillows around, nestled in the valley of soft white fur and warm, yielding flesh that seems to conform to your very shape. She giggles, shifting her tits playfully as you get comfortable atop her, helping you to pull off your [pc.armor.longArmor] and gear, tossing it aside, submerging you in the pleasant warmth of the naleen's sexy body. You hadn't even realized how cold you were, but your rock-hard nipples and shivering body soon draw the attention of the pretty kitty: <i>\"I told you, pet, it gets so very cold here. But we'll keep each other warm tonight, won't we?\"</i>");
	
	output("\n\nYou nod enthusiastically, stopping only to gasp as you feel a slender spear of warmth wrapping around one of your [pc.legs]. You manage to slip your arms around the naleen's waist, holding her tight against you before her coils utterly enwrap you, binding you in a blanket of soothingly warm, soft scales. <i>\"Better?\"</i>  the huntress teases, pinching one of your rigid teats between her coils.");
	
	output("\n\n<i>\"Much,\"</i>  you say, leaning up to kiss her. She returns it with a playful smile, pushing your head down into her bosom, stroking your ");
	if(pc.hasHair()) output("[pc.hair]");
	else output("head");
	output(" with surprising affection as you nestle into your lover's embrace.");
	
	//if PC has a cock: 
	if(pc.hasCock()) {
		output("\n\n<i>\"Oh! But we cannot have this getting cold, can we?\"</i>  the huntress grins, slipping an arm down into the bed of coils around the pair of you. You wince as her fingers graze your [pc.cocks], wrapping around your soft length");
		if(pc.cockTotal() > 1) output("s");
		output(". She rocks her wrist, jacking you off a few short times until you're half-erect, blood rushing to your suddenly stimulated schlong{s} as she guides ");
		if(pc.cockTotal() == 1) output("it");
		else output("them");
		output(" toward her waiting womanhood. Your mind fizzles blank with sudden and overwhelming pleasure as your [pc.balls] sinks into the hot, sultry depths of the naleen's welcoming pussy.");
		
		output("\n\n<i>\"Better?\"</i> she teases, clenching her muscles around your prick");
		if(pc.cockTotal() > 1) output("s");
		output(", massaging ");
		if(pc.cockTotal() == 1) output("it");
		else output("them");
		output(" oh so sweetly inside herself.");
		
		output("\n\n<i>\"Much,\"</i> you groan, laying your head to rest as the huntress holds you tight, letting you drift off to sleep buried inside her, cumming again and again throughout the night thanks to her ceaseless ministrations. You've never felt warmer.");
		cockChange();
		pc.orgasm();
		pc.orgasm();
		if(rand(3) == 0) pc.orgasm();
		if(rand(3) == 0) pc.orgasm();
	}
	processTime(420+rand(60));
	userInterface.clearMenu();
	userInterface.addButton(0,"Next",finishNaleenSnuggles);
}

//[NEXT]
function finishNaleenSnuggles():void {
	clearOutput();
	output("You awaken to the familiar smell of fresh-cooked fish, wafting pleasantly through the air. You slowly open your eyes, stretching and yawning as you sit up.");
	
	output("\n\n<i>\"Up so soon, pet?\"</i>  the naleen giggles, drawing your eyes to the small cookfire in the center of your clearing, surrounded by small stones and overshadowed by a great, well-cooked fish about the size of your forearm. <i>\"I thought you might cat-nap a while longer. Good morning,\"</i>  she says with a smile, slithering over to embrace you.");
	
	output("\n\n<i>\"Morning,\"</i>  you say, rubbing the sleep from your eyes. <i>\"What's cooking?\"</i>");
	
	output("\n\n<i>\"Ginder fish! My favorite,\"</i>  she answers, pulling the skewer from the crackling cookfire and handing it to you. You hesitate to try actually eating the alien food, but the wide-eyed, expectant look on the naleen's face practically implores you to at least taste it. After a moment, you give in and take an experimental bite: the flavorful fish practically melts in your mouth, turning into a thick, rich cream in your mouth with a single chew.");
	//Mean/Snarky/Nice: 
	if(pc.isAss()) output("\n\n<i>\"Could be worse, I guess,\"</i>");
	else if(pc.isMischievous()) output("\n\n<i>\"I've had worse,\"</i>");
	else output("\n\n<i>\"Delicious\"</i>");
	output(" you say approvingly, ripping off another bite.");
	
	output("\n\nThe naleen gives a gleeful, girlish squeal of delight, obviously happy that you're enjoying her cooking. She joins you, claws handily slicing up the ginder fish into strips for her to slurp down. She's certainly got an appetite, too: the naleen girl chews through the lion's share of the oversized fish before long, though you hardly end up starving, either. With a contented belch, you toss a tiny bone aside and pat your belly, snickering as the naleen licks some fish-grease from her furry fingertips. She grins bashfully, slithering around the embers of her fire to coil up beside you, head resting on your shoulder.");
	
	output("\n\n<i>\"Will you be leaving soon, pet?\"</i>  she asks after a long moment.");
	output("\n\nYou nod.\n\n<i>\"Mmm. If you must, love. But I won't be so gentle during the day, you know... unless I can convince you to stay? Any huntress would kill for a strong, " + pc.mf("handsome","beautiful") + " mate like you.\"</i>");
	
	output("\n\nSadly, no. You have a fortune to chase. The naleen sighs, picking herself up and slithering away before you can answer. She stops at the edge of the little clearing, though, just long enough to blow you a kiss before vanishing into the brush.");
	processTime(30+rand(5));
	userInterface.clearMenu();
	userInterface.addButton(0,"Next",mainGameMenu);
}