//////////////////////////////////////////////////////////////////////////
// CLASSE STATIQUE: Enemie
// Auteur: William Lafortune-Caissy
// Automne 2016
/////////////////////////////////////////////////////////////////////////

package {

	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	import fl.transitions.TweenEvent;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.media.Sound;

	public class Enemie extends MovieClip {


		// VARIABLES -------------------------------------------------------
		private var etat: uint;
		private const TIRE: uint = 1;
		private const DEPLACEMENT: uint = 2;
		private const ARRET: uint = 3;

		private var _posX: uint;
		private var _posY: uint;

		private var _tweenX: Tween;
		private var _tweenY: Tween;
		private var _vitesse: Number;
		private var _difficulte: Number = 2000;
		private const _VDEPART: uint = 2
		
		private var _sonShuriken: Sound = new Shuriken();

		// CONSTRUCTEUR ----------------------------------------------------
		public function Enemie(posX, posY): void {
			x = posX;
			y = posY;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		// FONCTIONS PUBLIC -----------------------------------------------
		public function arrete(): void {
			etat = ARRET;
		}
		
		public function tuer(): void {
			kill();
		}

		public function joue(): void {
			etat = TIRE;
		}

		// FONCTIONS PRIVÉE -----------------------------------------------
		private function init(e: Event): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			etat = TIRE;
			addEventListener(Event.ENTER_FRAME, loop);
		}

		private function loop(e: Event): void {
			if (etat == TIRE) {
				MovieClip(parent).addChild(new Projectile(x, y, 0, 10));
				MovieClip(parent).addChild(new Projectile(x, y, 7, 7));
				MovieClip(parent).addChild(new Projectile(x, y, 10, 0));
				MovieClip(parent).addChild(new Projectile(x, y, 7, -7));
				MovieClip(parent).addChild(new Projectile(x, y, 0, -10));
				MovieClip(parent).addChild(new Projectile(x, y, -7, -7));
				MovieClip(parent).addChild(new Projectile(x, y, -10, 0));
				MovieClip(parent).addChild(new Projectile(x, y, -7, 7));
				Jeu(parent).projectiles(8);	
				_sonShuriken.play();

				_posX = Math.floor(Math.random() * ((stage.stageWidth - this.width / 2) - (this.width / 2) + 1) + this.width / 2);
				_posY = Math.floor(Math.random() * ((stage.stageHeight - this.height / 2) - (this.height / 2) + 1) + this.height / 2);

				if (_posX < x) {
					gotoAndPlay(1);
				} else {
					gotoAndPlay(6);
				}
				
				_vitesse = _VDEPART - Jeu(parent).getPointage() / _difficulte; // 0pt = 2s, 2000pt = 1s, 4000pt = 0,5s
				
				_tweenX = new Tween(this, "x", Strong.easeOut, this.x, _posX, _vitesse, true);
				_tweenY = new Tween(this, "y", Strong.easeOut, this.y, _posY, _vitesse, true);

				etat = DEPLACEMENT;

				_tweenX.addEventListener(TweenEvent.MOTION_FINISH, tire);
			}

		}

		private function tire(e: TweenEvent): void {
			_tweenX = null;
			_tweenY = null;
			if (etat !=ARRET) {
				etat = TIRE;
			}
		}
		
		private function kill(): void {
			removeEventListener(Event.ENTER_FRAME, loop);
			Jeu(parent).removeChild(this);
		}

	}
}