//////////////////////////////////////////////////////////////////////////
// CLASSE STATIQUE: Fin
// Auteur: William Lafortune-Caissy
// Automne 2016
/////////////////////////////////////////////////////////////////////////

package {
	import flash.display.*;
	import flash.events.*;

	public class Fin extends MovieClip {
		private var _className: String = Nav.FIN;

		// CONSTRUCTEUR ----------------------------------------------------
		public function Fin() {
			trace(">>>>>> " + _className + " créé");
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			trace(">> " + _className + " init");
			carreFin_mc.alpha = 0, 5;

		}

		private function addedToStage(e: Event): void {
			trace(">> " + _className + " addedToStage");
			stage.focus = stage;
			bt_recommencer.addEventListener(MouseEvent.CLICK, recommencer);
			pointsFin_ta.text = String("Pointage final: " + Jeu(parent).getPointage());
		}

		private function removedFromStage(e: Event): void {
			trace(">> " + _className + " removedFromStage");
			// retirer ici tous les écouteurs problématiques
			// (en particulier ENTER_FRAME)
		}

		private function recommencer(e: MouseEvent): void {
			Jeu(parent).fermeFin();
		}

	} //classe
} //package