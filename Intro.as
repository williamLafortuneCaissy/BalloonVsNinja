//////////////////////////////////////////////////////////////////////////
// CLASSE STATIQUE: Intro
// Auteur: William Lafortune-Caissy
// Automne 2016
/////////////////////////////////////////////////////////////////////////

package {
	import flash.display.*;
	import flash.events.*;
	import flash.media.Sound;
	import flash.media.SoundMixer;

	public class Intro extends MovieClip {
		private var _className: String = Nav.INTRO;
		private var _sonIntro: Sound = new ChansonIntro();


		// CONSTRUCTEUR ----------------------------------------------------
		public function Intro() {
			trace(">>>>>> " + _className + " créé");

			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			trace(">> " + _className + " init");

			bt_jouer.addEventListener(MouseEvent.CLICK, goJeu);
			bt_instruction.addEventListener(MouseEvent.CLICK, goInstruction);
		}

		private function addedToStage(e: Event): void {
			trace(">> " + _className + " addedToStage");
			SoundMixer.stopAll();//_sonIntro.play();
		}

		private function removedFromStage(e: Event): void {
			trace(">> " + _className + " removedFromStage");
			// retirer ici tous les écouteurs problématiques
			// (en particulier ENTER_FRAME)
		}

		private function goInstruction(e: MouseEvent): void {
			Nav.go(Nav.INSTRUCTION, this);
		}

		private function goJeu(e: MouseEvent): void {
			Nav.go(Nav.JEU, this);
		}

	} //classe
} //package