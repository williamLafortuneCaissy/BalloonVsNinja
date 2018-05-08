//////////////////////////////////////////////////////////////////////////
// CLASSE STATIQUE: Nav
// Auteur: William Lafortune-Caissy
// Automne 2016
/////////////////////////////////////////////////////////////////////////

package {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;

	public class Nav {
		// VARIABLES -------------------------------------------------------
		public static const INTRO: String = "Intro";
		public static const INSTRUCTION: String = "Instruction";
		public static const JEU: String = "Jeu";
		public static const FIN: String = "Fin";

		private static var _main: Main = null;
		private static var _ecrans: Dictionary = new Dictionary();

		// CONSTRUCTEUR ----------------------------------------------------
		public static function setMain(unMain: Main) {
			_main = unMain;
		}

		public static function go(destination: String, ecranOrigine: MovieClip = null): void {

			if (ecranOrigine != null && _main != null) _main.removeChild(ecranOrigine);

			if (_main == null) _main = Main(ecranOrigine);

			if (_ecrans[destination] == null) {
				var classe: Class = Class(getDefinitionByName(destination));
				_ecrans[destination] = new classe();
				//_ecrans[destination].init();
			}
			_main.addChild(_ecrans[destination]);
		}

	} //classe
} //package