//////////////////////////////////////////////////////////////////////////
// CLASSE STATIQUE: Projectile
// Auteur: William Lafortune-Caissy
// Automne 2016
/////////////////////////////////////////////////////////////////////////

package {

	// IMPORTATIONS -------------------------------------------------------
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Projectile extends MovieClip {

		// VARIABLES -------------------------------------------------------
		private var _vX: int;
		private var _vY: int;

		// CONSTRUCTEUR ----------------------------------------------------
		public function Projectile(posX: Number, posY: Number, vitesseX: int, vitesseY: int): void {
			x = posX;
			y = posY;
			_vX = vitesseX;
			_vY = vitesseY;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		// FONCTIONS PUBLIC -----------------------------------------------
		public function kill(): void {
			Jeu(parent).projectiles(-1);
			die();
		}

		public function die(e: Event = null): void {
			if (parent != null) parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME, loop);
		}

		// FONCTIONS PRIVÉE -----------------------------------------------
		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, loop);
			addEventListener(Event.REMOVED_FROM_STAGE, remove);
			Jeu(parent).addEventListener("ByeBye", die);
		}

		private function remove(e: Event): void {
			removeEventListener(Event.ENTER_FRAME, loop);
		}

		private function loop(e: Event): void {
			x += _vX;
			y += _vY;

			if (hitTestObject(MovieClip(parent).getAvatar())) {
				MovieClip(parent).getAvatar().toucher();
			} else if (
				x > stage.stageWidth + width ||
				y > stage.stageWidth + height ||
				x < 0 - width ||
				y < 0 - width) {
				kill();
			}
		}

	}

}