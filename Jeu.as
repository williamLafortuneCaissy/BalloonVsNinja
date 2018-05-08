//////////////////////////////////////////////////////////////////////////
// CLASSE STATIQUE: Jeu
// Auteur: William Lafortune-Caissy
// Automne 2016
/////////////////////////////////////////////////////////////////////////


//_sonJeu.play(0,9999);-------------------------------------------------------------


package {
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Keyboard;
	import fl.motion.easing.Back;
	import flash.media.Sound;
	import flash.media.SoundMixer;

	public class Jeu extends MovieClip {

		// VARIABLES -------------------------------------------------------
		private var _className: String = Nav.JEU;

		private var etat: uint;
		private const ACTIF: uint = 1;
		private const ARRET: uint = 2;

		private var _avatar: Avatar;
		private var _enemie: Enemie;
		private var _pageFin: Fin;

		private var _pointage: uint;
		private var _nbProj: uint;

		private var _toucheDroite: Boolean;
		private var _toucheGauche: Boolean;
		private var _toucheHaut: Boolean;
		private var _toucheBas: Boolean;
		private var w: uint = 87;
		private var s: uint = 83;
		private var a: uint = 65;
		private var d: uint = 68;
		
		private var _sonJeu: Sound = new ChansonJeu();

		// CONSTRUCTEUR ----------------------------------------------------
		public function Jeu() {
			trace(">>>>>> " + _className + " créé");
			addEventListener(Event.ADDED_TO_STAGE, init);
			trace(">> " + _className + " init");
		}

		// FONCTIONS PUBLIC ------------------------------------------------

		public function getPointage(): Number {
			return _pointage;
		}

		public function getAvatar(): Avatar {
			return _avatar;
		}

		public function arrete(): void {
			_enemie.arrete();
			if (etat == ACTIF) {
				etat = ARRET;
			}
		}

		public function joue(): void {
			_enemie.joue();
		}

		public function fini(): void {
			_pageFin = new Fin;
			addChild(_pageFin);
			pointage_ta.alpha = 0;
			removeEventListener(Event.ENTER_FRAME, loop);
		}

		public function projectiles(nombre): void {
			_nbProj += nombre;
		}


		// FONCTIONS PRIVÉE -----------------------------------------------
		private function init(e: Event): void {
			trace(">> " + _className + " addedToStage");
			SoundMixer.stopAll();
			//_sonJeu.play();
			etat = ACTIF;
			_nbProj = 0;
			_pointage = 1;
			pointage_ta.alpha = 1;

			_avatar = new Avatar(200, 350);
			addChild(_avatar);
			_enemie = new Enemie(700, 350);
			addChild(_enemie);

			stage.focus = stage;

			addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyIsUp);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}

		private function loop(e: Event): void {
			if (etat == ACTIF) {
				_pointage += 1;
				pointage_ta.text = String("Pointage: " + _pointage);
			} else if (etat == ARRET) {
				if (_nbProj == 0) {
					etat = ACTIF
					_enemie.joue();
					_avatar.joue();
				}

			}
		}

		private function keyIsDown(e: KeyboardEvent): void {
			if (e.keyCode == a) {
				if (_toucheGauche == false) _avatar.gauche();
				_toucheGauche = true;
			} else if (e.keyCode == d) {
				if (_toucheDroite == false) _avatar.droite();
				_toucheDroite = true;
			} else if (e.keyCode == w) {
				if (_toucheHaut == false) _avatar.haut();
				_toucheHaut = true;
			} else if (e.keyCode == s) {
				if (_toucheBas == false) _avatar.bas();
				_toucheBas = true;
			}
			if (_toucheDroite == false && _toucheGauche == false) {
				_avatar.arreterHorizontal();
			}
			/*else if (_toucheDroite == true && _toucheGauche == true) {
				_avatar.arreterHorizontal();
			}*/

			if (_toucheHaut == false && _toucheBas == false) {
				_avatar.arreterVertical();
			}
			/*else	if (_toucheHaut == true && _toucheBas == true) {
				_avatar.arreterVertical();
			}*/
		}

		private function keyIsUp(e: KeyboardEvent): void {
			if (e.keyCode == d) {
				_toucheDroite = false;
			} else if (e.keyCode == a) {
				_toucheGauche = false;
			} else if (e.keyCode == w) {
				_toucheHaut = false;
			} else if (e.keyCode == s) {
				_toucheBas = false;
			}
			if (_toucheDroite == false && _toucheGauche == false) {
				_avatar.arreterHorizontal();
			}
			if (_toucheHaut == false && _toucheBas == false) {
				_avatar.arreterVertical();
			}
		}

		private function removedFromStage(e: Event): void {
			trace(">> " + _className + " removedFromStage");
			_avatar.tuer();
			_enemie.tuer();
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyIsUp);
		}

		public function fermeFin(): void {
			dispatchEvent(new Event("ByeBye"));
			removeChild(_pageFin);
			Nav.go(Nav.INTRO, this);
		}

	} //classe
} //package