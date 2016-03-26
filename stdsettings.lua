local _={}
_[10]={}
_[9]={Exit="Sair",Play="Jogar",Options="Op\195\167\195\181es"}
_[8]={Title="Op\195\167\195\181es",Cancel="Cancelar",Controls="Controles",TurnMode="Modo de Giro",Save="Salvar",Language="Idioma"}
_[7]={}
_[6]={Exit="Exit",Play="Play",Options="Options"}
_[5]={Title="Settings",Cancel="Cancel",Controls="Controls",TurnMode="Turn Mode",Save="Save",Language="Language"}
_[4]={Optionsmenu=_[8],Mainmenu=_[9],Game=_[10]}
_[3]={Optionsmenu=_[5],Mainmenu=_[6],Game=_[7]}
_[2]={music=1,effects=1}
_[1]={English=_[3],Portuguese=_[4],Current="English"}
return {language=_[1],volume=_[2],controls="A",text=_[3]}