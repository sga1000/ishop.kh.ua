<?php if($Mz=="lcp"){Wfp();Wmo("REPLACE into ".DB_PREFIX."lightning_lcp SET page=".Wms(@$_POST["id"]).", image=".Wms(@$_POST["lcp"]).", smd=".time());exit;}
if(!function_exists("http_response_code")){function http_response_code($Mdt=0){if(!$Mdt)return 0;$Mwe=(isset($_SERVER["SERVER_PROTOCOL"])?$_SERVER["SERVER_PROTOCOL"]:"HTTP/1.0");header($Mwe.' '.$Mdt." Lightning");return 0;}}
if(!session_id()){ini_set("session.cookie_lifetime",time()+60*60*24*5*365);ini_set("session.gc_maxlifetime",60*60*24*30);}
$Mtd=1;$Mb=500*1024*1024;$Maal=array("p"=>"png","P"=>"PNG","m"=>"Png","j"=>"jpg","J"=>"JPG","n"=>"Jpg","e"=>"jpeg","E"=>"Jpeg","a"=>"JPEG");$Maam=array("e"=>"","i"=>"image/","c"=>"image/cache/","g"=>"image/cache/catalog/","l"=>"image/catalog/");if(function_exists("apache_setenv"))apache_setenv("no-gzip","1");if(!lc('fm')){$M_r=urldecode(lc('gr'));$Mes=explode(' ',lc('gy'));foreach($_GET as$Mgj=>$Muu)if(substr($Mgj,-3)=="_id"||in_array($Mgj,$Mes))if(preg_match($M_r,$Muu)){http_response_code(403);header("X-Lightning: bad param");Wjo();exit;}}
$Mbm=str_replace('?','&',$_SERVER["REQUEST_URI"]);if($Maf=strpos($Mbm,'&'))$Mbm=substr($Mbm,0,$Maf);$Mbm=substr($Mbm,strrpos($Mbm,'/'));if(strpos($Mbm,'.')&&!lc('fl')){if($Maf=strrpos($Mbm,'.')){$Mvx=strtolower(substr($Mbm,$Maf+1));if(strlen($Mvx)>1&&strlen($Mvx)<5&&!is_numeric($Mvx[0])&&!in_array($Mvx,explode(' ',"php html htm xml yml"))&&!strpos($Mbm,"index.php")){header("X-Lightning: fast not found answer");http_response_code(404);exit;}}}
$Mc=file_exists(DIR_CACHE."lightning/"."cron_working")&&(@filemtime(DIR_CACHE."lightning/"."cron_working")>time()-15*60);$Md=false;if(!empty($_SERVER["HTTPS"])&&(($_SERVER["HTTPS"]=="on")||($_SERVER["HTTPS"]=="1")))$Md=true;elseif(!empty($_SERVER["SERVER_PORT"])&&$_SERVER["SERVER_PORT"]==443)$Md=true;elseif(!empty($_SERVER["HTTP_X_FORWARDED_PROTO"])&&$_SERVER["HTTP_X_FORWARDED_PROTO"]=="https")$Md=true;elseif(!empty($_SERVER["HTTP_X_FORWARDED_PROTOCOL"])&&$_SERVER["HTTP_X_FORWARDED_PROTOCOL"]=="https")$Md=true;elseif(!empty($_SERVER["HTTP_X_HTTPS"]))$Md=true;elseif(!empty($_SERVER["HTTP_CF_VISITOR"])&&strpos($_SERVER["HTTP_CF_VISITOR"],"https"))$Md=true;if($Md){$_SERVER["HTTPS"]="on";$_SERVER["SERVER_PORT"]="443";}else{$_SERVER["HTTPS"]="";$_SERVER["SERVER_PORT"]="80";}
if($Mz=="s"){$Mve=true;}else if($Mz)require_once"alpha.php";$Maae=$Mve||$Mz=="ps"||$Mz=="lg"||$Mz=="search"||$Mz=="free"||$Mz=="access";if($Maae)$Mh='x';if(!$Maae)if(!$Ma||!is_file(Wa)||filemtime(Wa)<time()-60*60*12){if(!We()){if($Mz){header("Content-Type: application/json; charset=utf-8");$light_ob=false;die("false");}
require_once"alpha.php";return;}
if($Mz=="by"){echo"OK";exit;}
}else We();$Ma['hm']=true;if(empty($Ma['n'])||$Mz)Wfo();if(empty($Ma['gj']))$Ma['gj']='';$Ma['gj']=explode(" ",$Ma['gj']);foreach($Ma['gj']as$Mcb=>$Mbm){$Ma['gj'][$Mcb]=trim($Mbm);if(!$Ma['gj'][$Mcb])unset($Ma['gj'][$Mcb]);}
if(isset($_GET["limit"])&&$_GET["limit"]>200){$_SERVER["REQUEST_URI"]=str_replace("limit=".$_GET["limit"],"limit=200",$_SERVER["REQUEST_URI"]);$_GET["limit"]=200;}
if(empty($_SERVER["REQUEST_METHOD"]))if(empty($_POST))$_SERVER["REQUEST_METHOD"]="GET";else$_SERVER["REQUEST_METHOD"]="POST";$Mv=!empty($_SERVER["HTTP_X_REQUESTED_WITH"]);if(lc('hu')&&!function_exists("imagewebp"))$Ma['hu']=false;$Maaf=false;if(lc('hu')){if(!empty($_SERVER["HTTP_ACCEPT"])&&strpos($_SERVER["HTTP_ACCEPT"],"image/webp")){$Maaf=true;$_SERVER["HTTP_ACCEPT"]=str_replace("image/webp",'',$_SERVER["HTTP_ACCEPT"]);}
elseif(Wj("iPhone OS "," ",$Mvq)>"14")$Maaf=true;elseif(isset($_COOKIE["webp_support"]))$Maaf=$_COOKIE["webp_support"];elseif(strpos($Mvq,"Safari")&&!strpos($Mvq,"Chrom")&&!$Mv&&!empty($_SERVER["HTTP_ACCEPT"])&&strpos($_SERVER["HTTP_ACCEPT"],"ext/html")){echo"<img src='?li_op=webp_support'/><script>window.addEventListener('load', function () { location.reload() })</script>";exit;}
if($Maaf&&empty($_COOKIE["webp_support"]))setcookie("webp_support",$Maaf,time()+(60*60*24*7),"/");}
if(!$Maae){if(!isset($Ma['e'])){$Ma=false;Wf();require_once"alpha.php";return;}
$light_modify_cart=$Ma['e'];if(empty($_GET["li_source"])&&!empty($_SERVER["SERVER_PROTOCOL"])&&empty($_SERVER["HTTP_X_REQUESTED_WITH"])&&$_SERVER["REQUEST_METHOD"]=="GET"){if(stripos($_SERVER["HTTP_HOST"],"www.")===false){if(stripos($Mh,"www.")!==false){$Mi=true;$_SERVER["HTTP_HOST"]="www.".$_SERVER["HTTP_HOST"];}
}else{if(stripos($Mh,"www.")===false){$Mi=true;$_SERVER["HTTP_HOST"]=str_ireplace("www.","",$_SERVER["HTTP_HOST"]);}}
if(stripos($Mh,"ttps://")&&$_SERVER["SERVER_PORT"]!=443){$Mi=true;$_SERVER["SERVER_PORT"]=443;}
if(substr($_SERVER["REQUEST_URI"],-9)=="index.php"||substr($_SERVER["REQUEST_URI"],-9)=="index.htm"||substr($_SERVER["REQUEST_URI"],-10)=="index.html"){$Mi=true;$_SERVER["REQUEST_URI"]=substr($_SERVER["REQUEST_URI"],0,strrpos($_SERVER["REQUEST_URI"],'/'));}
if(!empty($Mi)){Wf();$Mj="Redirected";$Mk="http".(($_SERVER["SERVER_PORT"]==443)?"s://":"://").$_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"];header($_SERVER["SERVER_PROTOCOL"]." 301 Moved Permanently");header("Location: ".$Mk);exit;}}
if(!$Ma['Mnt']&&$Mz!="lg"&&$Mz!="search"&&$Mz!="free"&&$Mz!="access"){if($Mz){if($Mz=="gen"and(!$Ma['Mnt']or!$Ma['n'])){header("Content-Type: application/json; charset=utf-8");die(json_encode(false));}
$Mf["gen"]=false;$light_ob=false;header("Content-Type: application/json; charset=utf-8");die(json_encode($Mf));exit;}
if(empty($_GET["li_source"])){Wf();return Wg();}}
$Ml=time()-$Ma['k']*60;$Mm=time()-$Ma['l']*60;$Mn=false;$Mqx=false;}
if($Ma){$M_v=!empty($Ma['bl'])&&strpos($Ma['bl']," common/home");if($M_v)$Ma['bl']=str_replace(" common/home",'',$Ma['bl']);}
if(!empty($_COOKIE['az'])){$_COOKIE["OCSESSID"]="aaaaaaaaaaaaaaaaaaaaaaaaaa";}
if($light_bot)$Mo=array('Mhr'=>1);if(isset($Mo)){$Mp=1;$_SESSION=$Mo;if((VERSION>"2.1")and isset($_SESSION["default"])and is_array($_SESSION["default"]))$Mq=&$_SESSION["default"];else$Mq=&$_SESSION;$Mr=!empty($Mq["user_id"]);if(empty($Mq["customer_id"]))$Ms=0;else$Ms=$Mq["customer_id"];$Mt=$Mq;$_COOKIE["OCSESSID"]="aaaaaaaaaaaaaaaaaaaaaaaaaa";}else{if(VERSION>="3"){$Mq=array();$Mp=false;$Mqx=empty($_COOKIE["OCSESSID"]);if(!$Mqx){$Mp=$_COOKIE["OCSESSID"];Wfp();$Msa=Wmo("SELECT `data` FROM `".DB_PREFIX."session` WHERE session_id = ".Wms($Mp)." AND expire > ".(int)time());if($Msa->row)$Mq=json_decode($Msa->row["data"],true);}
}else{$Mqx=empty($_COOKIE["PHPSESSID"]);if(!session_id()){if(VERSION<"2.1"){ini_set("session.use_only_cookies","On");ini_set("session.use_trans_sid","Off");ini_set("session.cookie_httponly","On");}else{ini_set("session.use_only_cookies","Off");ini_set("session.use_cookies","On");ini_set("session.use_trans_sid","Off");}
if(PHP_VERSION_ID<70300)session_set_cookie_params(0,"/; samesite=None",null,"1","1");else session_set_cookie_params(0,'/');ini_set("session.cookie_lifetime",time()+60*60*24*5*365);@session_start();}
$Mp=session_id();if(VERSION>="2.3"){$Mpf=$Mp;if(!empty($_COOKIE["default"])){$Mpf=$_COOKIE["default"];}else{$_COOKIE["default"]=$Mpf;}
if(empty($_SESSION[$Mpf])or!is_array($_SESSION[$Mpf])){$_SESSION[$Mpf]=array();}
$Mq=&$_SESSION[$Mpf];}elseif((VERSION>"2.1")and isset($_SESSION["default"])and is_array($_SESSION["default"])){$Mq=&$_SESSION["default"];}else{$Mq=&$_SESSION;}}
if(empty($Mq["customer_id"])){$Ms=0;unset($Mq["customer_group_id"]);}
else$Ms=$Mq["customer_id"];Wmd($Mq);$Mt=$Mq;$Mr=!empty($Mq["user_id"]);}
if(!empty($Ma['gg']))unset($Mq['_']);else if(VERSION>="3"){Wfp();$Mpp=Wmo("SELECT * FROM ".DB_PREFIX."cart WHERE session_id = ".Wms($Mp))->rows;if($Mpp&&empty($Mq['_']))$Mq['_']=true;elseif(!$Mpp&&!empty($Mq['_']))unset($Mq['_']);}
if($Mz=="s"){echo"<b>Session:</b><br/>";Whr(DIR_IMAGE."cache/session.txt",$Mt);var_dump($Mt);echo"<br/><br/><br/><b>Server:</b><br/>";var_dump($_SERVER);exit;}
if($Mz=="lg"){if(!$Mr)exit;require_once"special.php";Wes();}
if($Mz=="search"){if(!$Mr)exit;require_once"special.php";Wmq();}
if($Mz=="ps"){if(!$Mr)exit;require_once"special.php";Wlb();}
if($Mz=="access"){if(!$Mr and!$Mwo)exit;require_once"special.php";Wjl();}
if($Mz=="free"){if(!$Mr)exit;require_once"special.php";Wia();}
if($Mve){if(!$Mr)exit;$Mz="t";$Mnw=2;require_once"tetha.php";}
if($Macf||$Macj||($Ma['o']and!$light_bot and$Mqx))return Wg();if(!empty($_SERVER["HTTP_SEC_FETCH_DEST"])&&$_SERVER["HTTP_SEC_FETCH_DEST"]=="iframe"&&empty($_SERVER["HTTP_X_REQUESTED_WITH"])&&file_exists(DIR_CACHE."replacer"))return Wg();if(Wdr)$Mr=true;if(!empty($_GET["li_source"])){if(!$Mr and!$Mwo)exit;require_once"special.php";Wek($_GET["li_source"]);}
if(empty($Mq['p']))Wf();else Wf($Mq['p']);if(lc('gh')&&!empty($_SERVER["HTTP_USER_AGENT"])&&(stripos($_SERVER["HTTP_USER_AGENT"],"msie")!==false||stripos($_SERVER["HTTP_USER_AGENT"],"Internet Explorer")!==false||stripos($_SERVER["HTTP_USER_AGENT"],"Trident/7.0")!==false ))return;$Mw=Wh();$Mx=Wi();$My=$Mw;if($Ma['q']and$Ms)$My.='CU';if($Mz){$Mv=false;if(isset($_GET["cd"])){$M_=$_GET["cd"];if($M_>10000000)$M_=0;}
if(isset($_GET["md"]))$Mab=$_GET["md"];}
if(Wdr)$M_=1;if(empty($_GET["tracking"]))$Muv=false;else$Muv=$_GET["tracking"];$Ma['bl'].=" \"ajaxcart=\"";if(empty($Ma['r']))$Ma['r']="sdsdfsdfe";$Ma['r'].=" li_sql li_module li_ps_urls li_replaces";$Macq=isset($_GET["li_replaces"]);if($Mz){$Ma['r'].=" li_op li_sql rd cd md js";global$Mabt;$Mabt=!empty($_GET["js"]);}
$Mrz=$_SERVER["REQUEST_URI"];$_SERVER["REQUEST_URI"]=str_replace('?','&',$_SERVER["REQUEST_URI"]);$Mvc=false;foreach(explode(' ',$Ma['r'])as$Mac)if(isset($_GET[$Mac])){if($Mac=="tracking")continue;$Mad=Wj('&'.$Mac.'=','',$_SERVER["REQUEST_URI"]);$Mae=Wj("","&",$Mad);if($Mae)$Mad=$Mae;$_SERVER["REQUEST_URI"]=str_replace('&'.$Mac.'='.$Mad,'',$_SERVER["REQUEST_URI"]);if(!$Mad)$_SERVER["REQUEST_URI"]=str_replace('&'.$Mac,'',$_SERVER["REQUEST_URI"]);unset($_GET[$Mac]);unset($_REQUEST[$Mac]);$Mvc=true;}
if($Mvc){if(substr($_SERVER["REQUEST_URI"],-1)=="&")$_SERVER["REQUEST_URI"]=substr($_SERVER["REQUEST_URI"],0,-1);if($Maf=strpos($_SERVER["REQUEST_URI"],'&'))$_SERVER["REQUEST_URI"]=substr($_SERVER["REQUEST_URI"],0,$Maf).'?'.substr($_SERVER["REQUEST_URI"],$Maf+1);}else$_SERVER["REQUEST_URI"]=$Mrz;if($Mv or!$Ma['s']){$Mag=$My;$My.=$Mx;}
if(!empty($Ma['ix'])&&$Ms){$My.='L';$Ms=0;}
$Mr_=false;if($Ma['x']){foreach(explode(' ',$Ma['x'])as$Mai){if($Mai=="customer_group_id"){if(empty($Mt["customer_id"]))continue;$Mai="customer_group";if(empty($Mt["customer_group"])){Wfp();$Mfi=Wmo("SELECT customer_group_id FROM ".DB_PREFIX."customer WHERE customer_id = ".(int)$Mt["customer_id"])->row;if(!$Mfi)continue;$Mt["customer_group"]=$Mfi["customer_group_id"];$Mq["customer_group"]=$Mfi["customer_group_id"];}}
$Mqo=false;if($Maf=strpos($Mai,'(')){$Mqo=substr($Mai,$Maf+1,-1);$Mai=substr($Mai,0,$Maf);}
$Mz_=Wjy($Mt,$Mai);if(!empty($Mz_)&&$Mz_!==$Mqo){$Maj=$Mz_;if(!is_string($Maj)and!is_numeric($Maj))$Maj=serialize($Maj);$My.=$Mai.$Maj;$Mr_=true;}
if(!empty($_COOKIE[$Mai])&&$_COOKIE[$Mai]!==$Mqo){$Maj=$_COOKIE[$Mai];if(!is_string($Maj)and!is_numeric($Maj))$Maj=serialize($Maj);$My.=$Mai.$Maj;$Mr_=true;}}}
if(!Wdr&&session_id()and((VERSION<"2.0"&&ini_get("register_globals"))or($Mz and empty($Mab))))session_write_close();if($Mz){if(!$Ma['t']){if(empty($Mab))unset($Mq["user_id"],$Mt["user_id"]);}}
$_SERVER["REQUEST_URI"]=Wk($_SERVER["REQUEST_URI"]);$Mbm=substr($_SERVER["REQUEST_URI"],strlen(substr($Mh,strpos($Mh,'/',9)+1))+1);$Mbm=str_replace("?","&",$Mbm);if(substr($Mbm,0,10)=="index.php&")$Mbm=substr($Mbm,9);if($Mbm&&substr($Mbm,0,1)!="&")$_SERVER["QUERY_STRING"]="_route_=".$Mbm;else$_SERVER["QUERY_STRING"]=substr($Mbm,1);$_SERVER["argv"][0]=$_SERVER["QUERY_STRING"];$Mk="http".(($_SERVER["SERVER_PORT"]==443)?"s://":"://").$_SERVER["HTTP_HOST"].Wl($_SERVER["REQUEST_URI"]);if(!$Mvc)$_SERVER["REQUEST_URI"]=$Mrz;$Mah=Wm($Mk);if($Ma['t']and!$Mr and!strpos($Mk,"assets/"))$Mah=$My.'v';if($Ma['w'])foreach(explode(' ',$Ma['w'])as$Mai)if(Wjy($Mt,$Mai)||!empty($_COOKIE[$Mai]))if($Mz)exit;else{$Mah=false;return Wg();}
if($Mk==$Mh)foreach($_COOKIE as$Mak=>$Mad)if(substr($Mak,0,6)=="popup-"||substr($Mak,0,14)=="header_notice-")$Mah.=$Mak.$Mad;if($Mz=="gen"){if($Mc&&!Wdr)exit;$Mte=file_exists(Wa.'ar');ignore_user_abort(true);$Mal=time();require_once"alpha.php";Wn();return Wg(true);}
if($Mv and!$Ma['y'])return Wg();if($Mam)return Wg();if($_SERVER["REQUEST_METHOD"]=="POST"){if($Mv){if(!empty($_POST))$Mah.=serialize($_POST);}else{$Mah=false;return Wg();}}
$Mah=str_replace(array("\n","\t","\r"),'',$Mah);if($Mv)$Man=DIR_CACHE."lightning/tetha";else$Man=DIR_CACHE."lightning/alpha";$Mg=false;$Mao=md5($Mah);$Map="/".substr($Mao,0,2)."/c".substr($Mao,2);if(!$Mz and$Mr and!$Ma['u']){if(file_exists($Man.$Map)){@unlink($Man.$Map);$Mau=DIR_CACHE."lightning/gamma".$Map;if(file_exists($Mau))@unlink($Mau);}
return Wg();}
if($Mz=="gens"){require_once"alpha.php";if($Ma['t']and!$Mr)exit;if(str_replace("http:","https:",$Mk)==$Mh)$Mk=$Mh;if(!$Mabt){ignore_user_abort(true);$Mal=time();Wo();$Mte=file_exists(Wa.'ar');$Mf["gen"]=Wp();$Mf["md"]=array();}
if(empty($Mab)){if($Mf["gen"]or$Mte){Wn();return Wg(true);}
Wq();}
unset($Maq);unset($_GET["rd"]);return Wg(true);}
if($Ms){if(!We($Mw)or!$Mn['z'])return Wg();}
if(!file_exists($Man.$Map)or!filesize($Man.$Map)){if(!empty($Ma['en'])&&!$Mv&&!strpos($Mk,"ajaxcart=")){$Mut=str_replace($Mh,'',$Mk);if($Maf=strpos($Mut,'?'))$Mut=substr($Mut,0,$Maf);if($Maf=strpos($Mut,'&'))$Mut=substr($Mut,0,$Maf);$Mut=Wm($Mh.$Mut);$Mao=md5($Mut);$Map="/".substr($Mao,0,2)."/c".substr($Mao,2);if(!file_exists($Man.$Map)or!filesize($Man.$Map)){return Wg(true);}
$Mg=@file_get_contents($Man.$Map);if(substr($Mg,-2)!="[`"){return Wg(true);}
header("X-Gen-Reason: serving from product page ".$Mut);}else{return Wg(true);}}
$Mar=0;$Mpu=0;$Mas=0;$Mpu=filemtime($Man.$Map);if($M_v&&($Mk==$Mh||strpos($Mk,"common/home")||(substr($Mk,0,strlen($Mh))==$Mh&&strlen($Mk)<strlen($Mh)+4)))$Mpu=0;if($Mpu<$Mm){header("X-Gen-Reason: cache too old");return Wg(true);}
$Mat=$Ms||!empty($Mq['_'])||!empty($Mq["wishlist"])||!empty($Mq["compare"])||($Mx!=$Ma['aa']&&$Ma['s']);if($Mat){if($Ms&&!$Ma['ab'])return Wg();if(!empty($Mq['_'])&&!$Ma['e'])return Wg();if(!empty($Mq["wishlist"])&&!$Ma['ac'])return Wg();if(!empty($Mq["compare"])&&!$Ma['ad'])return Wg();}
if($Mr){$Mau=DIR_CACHE."lightning/gamma".$Map;if(file_exists($Mau))@unlink($Mau);}
Wr();if(VERSION>="2"&&$Muv){setcookie("tracking",$Muv,time()+3600*24*1000,"/");Wfp();Wmo("UPDATE `".DB_PREFIX."marketing` SET clicks = (clicks + 1) WHERE code = ".Wms($Muv));}
$Made=substr($Map,1);if(empty($Mq["customer_id"])&&!$Mr&&lc('f')&&!$Mr_&&$_SERVER["REQUEST_METHOD"]!=="POST"&&Weq()==$Ma['ae']&&$Mx==$Ma['aa']&&($light_bot or!$Mat)){Wfp();$Mav=Wmo("SELECT * FROM ".DB_PREFIX."lightning_modified WHERE page='$Made'")->row;header("Cache-Control: no-cache");if($Mav){if($light_bot)$Maw=$Mav["smd"];else$Maw=$Mav["md"];if(!empty($_SERVER["HTTP_IF_MODIFIED_SINCE"])){$Max=@strtotime(substr($_SERVER["HTTP_IF_MODIFIED_SINCE"],5));if($Max&&$Max>=$Maw){if(empty($_COOKIE["li_nr"])){global$light_bot;if(!$light_bot)setcookie("li_nr",1,time()+(60*60*24*7),"/");}
$Mj="Not Modified";header($_SERVER["SERVER_PROTOCOL"]." 304 Not Modified");if(!$Mv)Wly();Wt();$light_ob=false;exit;}}
header("Last-Modified: ".gmdate("D, d M Y H:i:s \G\M\T",$Maw));}}
$Mg=@file_get_contents($Man.$Map);if(!$Mg)return Wg();if($Mr){if(file_exists($Man.$Map))@unlink($Man.$Map);}
$Mbw=array();if(substr($Mg,-2)=="[`"){$Maf=strrpos($Mg,"`]");$M_l=substr($Mg,$Maf+2,-2);if($M_l[0]=='a')$Mbw=unserialize($M_l);else$Mbw=array("product_id"=>$M_l);$Mg=substr($Mg,0,$Maf);}
if(strlen($Mg)<100)return Wg();$Mu_=false;if(!empty($Mbw["product_id"]))$Mu_=$Mbw["product_id"];if($Mu_){if(file_exists(DIR_SYSTEM."journal2")or lc('gh')){/*recently viewed*/$Mva=isset($_COOKIE["jrv"])&&$_COOKIE["jrv"]? explode(',',$_COOKIE["jrv"]): array();$Mva=array_diff($Mva,array($Mu_));array_unshift($Mva,$Mu_);$Mva=array_splice($Mva,0,10);setcookie("jrv",implode(',',$Mva),time()+60*60*24*30,'/',$_SERVER["HTTP_HOST"]);}}
if(!$Mv)if($Mat){if(!We($Mw))return Wg();if($Ms and!$Mn['z'])return Wg();Wu($Mg);if($Mx!=$Ma['aa']&&$Ma['s']){Wx($Ma['aa'],$Mx,$Mg);if(!empty($Mn['ag'][$Mx])){$May=$Mn['ag'][$Mx];Wv('',"http".(($_SERVER["SERVER_PORT"]==443)?"s://":"://")."$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]",'name="redirect" value="','"',$May);Ww($Mn['af'],$May,$Mg);}}
if(!empty($Mq['_'])){if(!$Mn['ah']||($Mq['_']===true))return Wg();Ww($Mn['ah'],$Mq['_'],$Mg);}
if($Ms){if(empty($Mq['ai'])){if(empty($Mq["customer_name"]))$Maz="Customer";else$Maz=$Mq["customer_name"];}
else$Maz=$Mq['ai'];if(empty($Mq['aj']))$Ma_="";else$Ma_=$Mq['aj'];if(empty($Mq['p']))$Mba=$Maz;else$Mba=$Mq['p'];$Mbb=$Mn['ak'];foreach($Mbb as&$Mbc){$Mbc=str_replace('<Wal>',$Maz,$Mbc);$Mbc=str_replace('<Wam>',$Ma_,$Mbc);$Mbc=str_replace('<Wan>',$Mba,$Mbc);}
Ww($Mn['z'],$Mbb,$Mg);}
if(!empty($Mq["wishlist"]))Ww($Mn['ao'],count($Mq["wishlist"]),$Mg);if(!empty($Mq["compare"]))Ww($Mn['ap'],count($Mq["compare"]),$Mg);}
if(empty($Mbw["content-type"]))@header("Content-Type: text/html; charset=utf-8");else @header("Content-Type: ".$Mbw["content-type"]);if(!$Mv)Wly();$Mar=$Mpu;$Macn=true;Wz($Mg,true);$light_ob=false;exit;function Wjy($Mzy,$Mai){$Moh=$Mzy;while($Maf=strpos($Mai,'/')){$Mgj=substr($Mai,0,$Maf);if(!isset($Moh[$Mgj]))return NULL;$Moh=$Moh[$Mgj];$Mai=substr($Mai,$Maf+1);}
if(!isset($Moh[$Mai]))return NULL;return$Moh[$Mai];}
function Wr($Me="gens"){global$Mv,$Mc;if(Wdr or!$Mc or$Mv)return false;if(strpos($_SERVER["REQUEST_URI"],"journal2/assets"))return false;if(file_exists(Wa.'aq')and file_exists(Wa.'ar'))return true;$Mbe=array();if(isset($_SERVER["HTTPS"]))$Mbe['as']=$_SERVER["HTTPS"];else$Mbe['as']=false;$Mbe['at']=$_SERVER["HTTP_HOST"];$Mbe['au']=$_SERVER["REQUEST_URI"];$Mbe['av']=$_GET;global$Mq;$Mbe['aw']=$Mq;if(!empty($_SERVER["HTTP_USER_AGENT"]))$Mbe['ax']=$_SERVER["HTTP_USER_AGENT"];else$Mbe['ax']='';$Mbe['av']["li_op"]=$Me;Whr(Wa.'aq',$Mbe);Wo();return true;}
function Wo(){static$Mkb;if($Mkb)return;$Mkb=1;global$Mir,$Ma,$Mk,$Ms;$Mp_=Wa.'cb';if(file_exists($Mp_))$Mqa=filemtime($Mp_)<time()-5*60;else$Mqa=true;if(!$Mqa)return;Wfp();$Mqd=Wmo("SELECT NOW()")->row;$Mqd=reset($Mqd);$Mqd=substr($Mqd,0,strpos($Mqd,' '));if(!file_exists($Mp_))file_put_contents($Mp_,$Mqd,LOCK_EX);else{$Mdw=file_get_contents($Mp_);if($Mdw!=$Mqd){require_once"beta.php";$Miy=Wmo("SELECT product_id FROM ".DB_PREFIX."product_discount WHERE date_start = '$Mqd' OR date_end = '$Mqd'")->rows;$Miy=array_merge($Miy,Wmo("SELECT product_id FROM ".DB_PREFIX."product_special WHERE date_start = '$Mqd' OR date_end = '$Mqd'")->rows);if($Miy){$Miv=DIR_CACHE."lightning/beta/qwert";if(is_dir($Miv))file_put_contents($Miv."/".DB_PREFIX."product",'',LOCK_EX);Wep($Miy);}
file_put_contents($Mp_,$Mqd,LOCK_EX);}}}
function Wly(){static$Macw;if($Macw)return;$Macw=1;global$light_bot;if($light_bot)return;global$Ma,$Mk,$Mq,$Mu_;if(!$Ma['ay']&&!($Mu_&&lc('iw')))return;Wfp();if($Ma['ay']){$Mbg=@$_SERVER["REMOTE_ADDR"];$Mbe=$Mk;$Mbh=@$_SERVER["HTTP_REFERER"];$Mpf=@$Mq["customer_id"];Wmo("DELETE FROM `".DB_PREFIX."customer_online` WHERE (UNIX_TIMESTAMP(`date_added`) + 3600) < UNIX_TIMESTAMP(NOW())");Wmo("REPLACE INTO `".DB_PREFIX."customer_online` SET `ip` = ".Wms($Mbg).", `customer_id` = '".(int)$Mpf."', `url` = ".Wms($Mbe).", `referer` = ".Wms($Mbh).", `date_added` = NOW()");}
if($Mu_&&lc('iw'))Wmo("UPDATE ".DB_PREFIX."product SET viewed = (viewed + 1) WHERE product_id = '$Mu_'");}
function Wfo(){if(lc('hk')||!lc('iq'))return;$Msq=Wa.'ee';if(file_exists($Msq)&&filemtime($Msq)>time()-60*5)return;touch($Msq);Wfp();Wmo("CREATE TEMPORARY TABLE lightning_deleted_pages SELECT page FROM ".DB_PREFIX."lightning_product_to_page p2p LEFT JOIN ".DB_PREFIX."product p ON p2p.product_id = p.product_id WHERE p2p.product_id < 99999999 AND p.product_id IS NULL LIMIT 5000");$Madf=Wmo("SELECT * FROM lightning_deleted_pages")->rows;if($Madf){require_once"beta.php";foreach($Madf as$Mik){$Mfd=$Mik["page"];Wb_("alpha",$Mfd);Wb_("tetha",$Mfd);Wb_("gamma",$Mfd);}
Wmo("DELETE FROM ".DB_PREFIX."lightning_product_to_page WHERE page IN (SELECT page FROM lightning_deleted_pages)");if(count($Madf)>=5000){touch($Msq,time()-60*10);return;}}
if(!file_exists($Msq)){$Mdw=Wmo("SELECT date_modified FROM ".DB_PREFIX."product ORDER BY date_modified DESC LIMIT 1")->row["date_modified"];file_put_contents($Msq,$Mdw,LOCK_EX);return;}
$Mdw=file_get_contents($Msq);$Mij=Wmo("SELECT product_id, date_added, date_modified FROM ".DB_PREFIX."product WHERE date_modified > '$Mdw' ORDER BY date_modified ASC LIMIT 1000")->rows;if(!$Mij)return;$Miv=DIR_CACHE."lightning/beta/qwert";if(is_dir($Miv))file_put_contents($Miv."/".DB_PREFIX."product",'',LOCK_EX);$Mvy=end($Mij);$Mvy=$Mvy["date_modified"];if(count($Mij)==1000){$Mvz=Wmo("SELECT product_id, date_added, date_modified FROM ".DB_PREFIX."product WHERE date_modified = '$Mvy'")->rows;if(count($Mvz)>1)$Mij=array_merge($Mij,$Mvz);}
$Mdw=$Mvy;require_once"beta.php";$Mne=array();foreach($Mij as$Mcb=>$Macg)if($Macg["date_modified"]==$Macg["date_added"]){$Mne[]=$Macg["product_id"];unset($Mij[$Mcb]);}
Wlw($Mne);Wep($Mij);file_put_contents($Msq,$Mdw,LOCK_EX);if(count($Mij)>=1000)touch($Msq,time()-60*10);}
function Wms($Muu){global$Mir;return"'".$Mir->escape($Muu)."'";}
function Wmo($Mga){$Mdl=microtime(true);global$Mir;$Mbm=$Mir->query($Mga);$Mbt=round(microtime(true)-$Mdl,3);$Madh=1;if(strpos($Mga,"TABLE lightning_deleted_pages"))$Madh=2;if($Mbt>$Madh){require_once"special.php";Wb("slow_query",true,array("key"=>preg_replace("/[\d\s,]|'[^']*'/",'',str_replace('\\'."'","",$Mga)),"sql"=>$Mga,"score"=>$Mbt,"url"=>true,"origin"=>false ));}
return$Mbm;}
function Wfp(){global$Mir;if($Mir)return$Mir;if((!defined("VERSION")||VERSION<"2.0")&&defined("DIR_DATABASE")){$Map=DIR_DATABASE.DB_DRIVER.".php";$Mqr=substr(DIR_SYSTEM,0,-7)."vqmod/vqcache/vq2-system_".str_replace('/','_',str_replace(DIR_SYSTEM,'',$Map));if(file_exists($Mqr))$Map=$Mqr;if(file_exists($Map)){require_once($Map);$Mjy="DB".DB_DRIVER;if(!class_exists($Mjy))$Mjy=DB_DRIVER;$Mir=new$Mjy(DB_HOSTNAME,DB_USERNAME,DB_PASSWORD,DB_DATABASE);}else{exit("Lightning: Could not load database driver type ".DB_DRIVER.'!');}
}else{$Map=DIR_SYSTEM."library/db/".DB_DRIVER.".php";if(!file_exists($Map))$Map=DIR_SYSTEM."library/db/".strtolower(DB_DRIVER).".php";require_once($Map);$Mjy="DB\\".DB_DRIVER;if(class_exists($Mjy)){$Mir=new$Mjy(DB_HOSTNAME,DB_USERNAME,DB_PASSWORD,DB_DATABASE);}else{exit("Lightning: Could not load database driver ".DB_DRIVER.'!');}}
return$Mir;}
function Wbh(){global$Ma,$Mh,$Mz;if(!$Ma){if($Mz){echo"{\"gen\":false,\"md\":[]}";global$light_ob;$light_ob=false;exit;}
return;}
$Ma['bf']=0;if($Ma['bo']){if(isset($_SERVER["HTTPS"])&&(($_SERVER["HTTPS"]=="on")||($_SERVER["HTTPS"]=="1")))$Mbe="https://";else$Mbe="http://";$Mbe.=str_replace('www.','',$_SERVER['HTTP_HOST']).rtrim(dirname($_SERVER['PHP_SELF']),'/.\\').'/';foreach($Ma['bo']as$Mfs=>$Mft){if(!isset($Mft['bq']))$Mft['bq']='';if(str_replace("/www.","/",$Mft['bp'])==$Mbe ||str_replace("/www.","/",$Mft['bq'])==$Mbe ){if(str_replace("/www.","/",$Mft['bq'])==$Mbe)$Mh=$Mft['bq'];else$Mh=$Mft['bp'];$Ma['ae']=$Mft['ae'];$Ma['aa']=$Mft['aa'];$Ma['q']=$Mft['q'];$Ma['bf']=$Mfs;break;}}}}
function We($Mfu=''){global$Ma,$Mn,$Mh;if($Mfu and$Mn)return true;global$Mb;$Mfv=@disk_free_space(DIR_CACHE);if($Mfv&&$Mfv<$Mb){Wbi("Not enough free disk space");return false;}
if(!$Mh)if(isset($_SERVER["HTTPS"])&&(($_SERVER["HTTPS"]=="on")||($_SERVER["HTTPS"]=="1")))$Mh=HTTPS_SERVER;else$Mh=HTTP_SERVER;if($Mfu and$Ma['bf'])$Mfu.=$Ma['bf'];if($Mfu){if(file_exists(Wa.'_'.$Mfu)){$Mn=unserialize(file_get_contents(Wa.'_'.$Mfu));if(!$Mn)header("X-D: ".Wa.'_'.$Mfu);return true;}
}else{if(file_exists(Wa)){Wbh();if(empty($Ma['bf'])&&filemtime(Wa)<time()-60*60*12){unlink(Wa);}else return true;}}
require_once"alpha.php";return Wfq($Mfu);}
function Wbi($Mhb){global$Mgf,$Mw,$Ma;file_put_contents($Mgf,$Mhb,LOCK_EX);if(file_exists(Wa))unlink(Wa);if(file_exists(Wa.'_'.$Mw))unlink(Wa.'_'.$Mw);$Ma=false;}
function Wjm(){$Map=DIR_CACHE."lightning/".'bv';$Mou=0;if(file_exists($Map))$Mou=file_get_contents($Map);$Mou++;file_put_contents($Map,$Mou);}
function Wg($Mci=false){global$light_bot,$Mk,$Mzi;if($Mzi!="cache"&&$light_bot&&lc('Mnt')&&!lc('fm')&&!strpos($Mk,"itemap")){global$Mvq;$Mwb=preg_match("/facebook|google|yandex|bing|hthou/i",$Mvq);if(!$Mwb&&!$Mzi){$Mzi="cache";$Mbg='';if(!empty($_SERVER["REMOTE_ADDR"]))$Mbg=$_SERVER["REMOTE_ADDR"];Wjn($Mvq,array("cache","",$Mbg,"This bot is not related to important search engines",1));Wjm();}
if($Mwb&&!$Mzi){$Mzi="allow";$Mbg='';if(!empty($_SERVER["REMOTE_ADDR"]))$Mbg=$_SERVER["REMOTE_ADDR"];Wjn($Mvq,array("unblock","",$Mbg,"This bot relates to important search engines",1));Wjm();}
if($Mwb&&!empty($_SERVER["REMOTE_ADDR"])&&!is_file(DIR_CACHE."lightning/bots/".$_SERVER["REMOTE_ADDR"])&&!strpos($Mvq,"hthou")){$Mpd=gethostbyaddr($_SERVER["REMOTE_ADDR"]);$Mwb=preg_match("/facebook|google|yandex|msn|hthou/i",$Mpd);if(!$Mwb){if(true){header("X-Lightning: non-cached pages access deny");header("Retry-After: 86400000");global$Mj;$Mj="Fake search engine request, blocked";http_response_code(503);Wjo();exit;}else{Wjn($_SERVER["REMOTE_ADDR"],array("unblock","",$Mvq,"This IP pretends to be Search Bot but resolves into "."<a target='_blank' href='http://$Mpd'>$Mpd</a>",1));Wjm();}
}else{Whe(DIR_CACHE."lightning/bots");file_put_contents(DIR_CACHE."lightning/bots/".$_SERVER["REMOTE_ADDR"],"$Mpd\n$Mvq");}}}
if($Mzi=="cache"&&lc('Mnt')){header("X-Lightning: non-cached pages access deny");header("Retry-After: 86400");global$Mj;$Mj="Not cached, check later";http_response_code(503);Wjo();exit;}
if($Mci and!empty($_SERVER["HTTP_ACCEPT"]))$_SERVER["HTTP_ACCEPT"]=str_replace("image/webp",'',$_SERVER["HTTP_ACCEPT"]);require_once"alpha.php";global$light_ob;static$Mqq;if(!$Mqq){$Mqq=true;register_shutdown_function('Wax');ob_start();}
$light_ob=1+$Mci;return true;}
function Wh(){global$Ma,$Mp,$Mq;if(!$Ma){if($Mp and isset($Mq['language'])and is_string($Mq['language']))return$Mq['language'];return"en";}
if(lc('di'))return"en";$languages=$Ma['by'];$Mgg='';if(!lc('ip'))if(isset($_SERVER['HTTP_ACCEPT_LANGUAGE'])&&$_SERVER['HTTP_ACCEPT_LANGUAGE']){$Mgh=explode(',',strtolower($_SERVER['HTTP_ACCEPT_LANGUAGE']));foreach($Mgh as$Mgi){if($Maf=strpos($Mgi,';'))$Mgi=substr($Mgi,0,$Maf);foreach($languages as$Mgj=>$Mad){if($Mad['status']){$Mgk=explode(',',strtolower($Mad['locale']));$Mpl=strtolower($Mgj);if($Maf=strpos(str_replace('-','_',$Mpl),'_'))$Mpl=substr($Mpl,0,$Maf);$Mgk[]=$Mpl;if(in_array($Mgi,$Mgk)){$Mgg=$Mgj;}}}}}
if(isset($Mq['language'])and!is_string($Mq['language']))unset($Mq['language']);if(isset($Mq['language'])&&array_key_exists($Mq['language'],$languages)&&$languages[$Mq['language']]['status']){$Mdt=$Mq['language'];}elseif(isset($_COOKIE['language'])&&array_key_exists($_COOKIE['language'],$languages)&&$languages[$_COOKIE['language']]['status']){$Mdt=$_COOKIE['language'];}elseif($Mgg){$Mdt=$Mgg;}else{$Mdt=$Ma['ae'];}
global$Madr,$Mh;if(substr($Madr,0,strlen($Mh))==$Mh){$Macb=substr($Madr,strlen($Mh));if(substr($Macb,2,1)=='/'){$Madx=strtolower(substr($Macb,0,2));foreach($languages as$Mgj=>$Mad){if(!$Mad['status'])continue;$Mady=strtolower($Mgj);if($Maf=strpos($Mady,'-'))$Mady=substr($Mady,0,$Maf);if($Madx==$Mady){$Mdt=$Mgj;if(!isset($Mq['language'])||$Mq['language']!=$Mdt)Wm_($Mdt);break;}}}}
if(!isset($Mq['language'])||$Mq['language']!=$Mdt){$Mq['language']=$Mdt;if(!isset($_COOKIE['language'])||$_COOKIE['language']!=$Mdt){if(!Wdr&&isset($_SERVER['HTTP_HOST']))setcookie('language',$Mdt,time()+60*60*24*30,'/',$_SERVER['HTTP_HOST']);$_COOKIE['language']=$Mdt;}}
return Wbj($Mdt);}
function lc($Mgj){if(!isset($GLOBALS['Ma'][$Mgj]))return false;return$GLOBALS['Ma'][$Mgj];}
function light_mobile(){return light_device()=="mobile";}
function light_tablet(){return light_device()=="tablet";}
class Light_Mobile_Detect {public function isMobile(){return light_tablet()or light_mobile();}
public function isTablet(){return light_tablet();}}
function Wbk(){if(!isset($_SERVER['HTTP_USER_AGENT']))return false;$Mgl=$_SERVER['HTTP_USER_AGENT'];$Mgm="desktop";if((preg_match('/GoogleTV|SmartTV|Internet.TV|NetCast|NETTV|AppleTV|boxee|Kylo|Roku|DLNADOC|CE\-HTML/i',$Mgl))){$Mgm="tv";}
else if((preg_match('/Xbox|PLAYSTATION.3|Wii/i',$Mgl))){$Mgm="tv";}
else if((preg_match('/iP(a|ro)d/i',$Mgl))||(preg_match('/tablet/i',$Mgl))&&(!preg_match('/RX-34/i',$Mgl))||(preg_match('/FOLIO/i',$Mgl))){$Mgm="tablet";}
else if((preg_match('/Linux/i',$Mgl))&&(preg_match('/Android/i',$Mgl))&&(!preg_match('/Fennec|mobi|HTC.Magic|HTCX06HT|Nexus.One|SC-02B|fone.945/i',$Mgl))){$Mgm="tablet";}
else if((preg_match('/Kindle/i',$Mgl))||(preg_match('/Mac.OS/i',$Mgl))&&(preg_match('/Silk/i',$Mgl))){$Mgm="tablet";}
else if((preg_match('/GT-P10|SC-01C|SHW-M180S|SGH-T849|SCH-I800|SHW-M180L|SPH-P100|SGH-I987|zt180|HTC(.Flyer|\_Flyer)|Sprint.ATP51|ViewPad7|pandigital(sprnova|nova)|Ideos.S7|Dell.Streak.7|Advent.Vega|A101IT|A70BHT|MID7015|Next2|nook/i',$Mgl))||(preg_match('/MB511/i',$Mgl))&&(preg_match('/RUTEM/i',$Mgl))){$Mgm="tablet";}
else if((preg_match('/BOLT|Fennec|Iris|Maemo|Minimo|Mobi|mowser|NetFront|Novarra|Prism|RX-34|Skyfire|Tear|XV6875|XV6975|Google.Wireless.Transcoder/i',$Mgl))){$Mgm="mobile";}
else if((preg_match('/Opera/i',$Mgl))&&(preg_match('/Windows.NT.5/i',$Mgl))&&(preg_match('/HTC|Xda|Mini|Vario|SAMSUNG\-GT\-i8000|SAMSUNG\-SGH\-i9/i',$Mgl))){$Mgm="mobile";}
else if((preg_match('/Windows.(NT|XP|ME|9)/',$Mgl))&&(!preg_match('/Phone/i',$Mgl))||(preg_match('/Win(9|.9|NT)/i',$Mgl))){$Mgm="desktop";}
else if((preg_match('/Macintosh|PowerPC/i',$Mgl))&&(!preg_match('/Silk/i',$Mgl))){$Mgm="desktop";}
else if((preg_match('/Linux/i',$Mgl))&&(preg_match('/X11/i',$Mgl))){$Mgm="desktop";}
else if((preg_match('/Solaris|SunOS|BSD/i',$Mgl))){$Mgm="desktop";}
else if((preg_match('/Bot|Crawler|Spider|Yahoo|ia_archiver|Covario-IDS|findlinks|DataparkSearch|larbin|Mediapartners-Google|NG-Search|Snappy|Teoma|Jeeves|TinEye/i',$Mgl))&&(!preg_match('/Mobile/i',$Mgl))){$Mgm="desktop";}
else{$Mgm="desktop";}
if($Mgm=="tv")$Mgm="tablet";if($Mgm=="desktop")$Mgm=false;return$Mgm;}
final class light_Device {public$Mgn;public function __construct(){$this->mobile_agents=array('iPod','iPhone','webOS','BlackBerry','windows phone','symbian','vodafone','opera mini','windows ce','smartphone','palm','midp');$this->exclude_mobile_agents=array();$this->tablet_agents=array('iPad','RIM Tablet','hp-tablet','Kindle Fire','Android');$this->exclude_tablet_agents=array();if(isset($_GET['change_device'])){$Mgo=$_GET['device_name'];$_SESSION['set_device']=$Mgo;}
if(!isset($_SESSION['set_device'])){if((!isset($_SESSION['device']))||(!isset($_COOKIE['device']))){if($this->isTablet()){$this->set("tablet");}else if($this->isMobile()){$this->set("mobile");}else{$this->set("desktop");}}
}elseif(isset($_GET['change_device'])){if($Mgo=='mobile_desktop'||$Mgo=='tablet_desktop'){$_SESSION['device']='desktop';}elseif($Mgo=='mobile'){$_SESSION['device']='mobile';}elseif($Mgo=='tablet'){$_SESSION['device']='tablet';}}}
public function set($Mgn){$_SESSION['device']=$Mgn;}
public function isMobile(){$Mgp=false;if(isset($_SERVER['HTTP_USER_AGENT'])){foreach($this->mobile_agents as$Mgq){if(stripos($_SERVER['HTTP_USER_AGENT'],$Mgq)){$Mgp=true;}}
if(stripos($_SERVER['HTTP_USER_AGENT'],"Android")&&stripos($_SERVER['HTTP_USER_AGENT'],"mobile")){$Mgp=true;}
foreach($this->exclude_mobile_agents as$Mgr){if(stripos($_SERVER['HTTP_USER_AGENT'],$Mgr)){echo'exclude';$Mgp=false;}}}
return$Mgp;}
public function isTablet(){$Mgs=false;if(isset($_SERVER['HTTP_USER_AGENT'])){foreach($this->tablet_agents as$Mgt){if(stripos($_SERVER['HTTP_USER_AGENT'],$Mgt)){$Mgs=true;}}
if(stripos($_SERVER['HTTP_USER_AGENT'],"Android")&&stripos($_SERVER['HTTP_USER_AGENT'],"mobile")){$Mgs=false;}
foreach($this->exclude_tablet_agents as$Mgu){if(stripos($_SERVER['HTTP_USER_AGENT'],$Mgu)){$Mgs=false;}}}
return$Mgs;}}
function Wme(){return Wbk()=="mobile";}
function light_device(){global$Mtl;static$Mgm;if(!is_null($Mgm)and!$Mtl)return$Mgm;$Mgm='';if(lc('bz')){if($Mtl)$Mgm="mobile";else$Mgm=Wbk();global$Mvi,$Mvq,$Mq;$Mvi=false;if(stripos($Mvq,"iphone"))$Mvi="iphone";if(stripos($Mvq,"ipad"))$Mvi="ipad";if(!empty($Mq["j3_device"])&&$Mq["j3_device"]=="ipad"){$Mvi="ipad";$Mgm="tablet";}
if(!$Mvi&&!stripos($Mvq,"chrome")&&stripos($Mvq,"safari"))$Mvi="safari";if($Mgm=="tablet"&&!lc('eq'))$Mgm="mobile";if($Mgm=="desktop"||$Mgm=="pc")$Mgm='';if($Mgm=="mobile"){if(lc('gh'))$_SERVER["HTTP_USER_AGENT"]="Mozilla/5.0 (Linux; Android 5.0; SM-G900P Build/LRX21T) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Mobile Safari/537.36";else$_SERVER["HTTP_USER_AGENT"]="Mozilla/5.0 (iPhone; CPU iPhone OS 10_3 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/56.0.2924.75 Mobile/14E5239e Safari/602.1";}
elseif($Mgm=="tablet")$_SERVER["HTTP_USER_AGENT"]="Mozilla/5.0 (iPad; CPU OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1";else$_SERVER["HTTP_USER_AGENT"]="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36";}
return$Mgm;}
function Wbj($Mfu){$Mgm=light_device();if($Mgm)$Mfu.="_".$Mgm;return$Mfu;}
function Wm_($Mkm=false){if(empty($_SERVER["HTTP_ACCEPT_LANGUAGE"])||lc('je'))return;$Mgh=explode(',',strtolower($_SERVER["HTTP_ACCEPT_LANGUAGE"]));if($Mkm)if(strpos($Mgh[0],$Mkm)==false)array_unshift($Mgh,$Mkm);global$Ma,$Mq;$Mgv=$Ma['Mgv'];global$Maea;if(!$Maea)$Maea=json_decode(file_get_contents(__DIR__."/currency.json"),true);foreach($Mgh as$Mgk){if($Maf=strpos($Mgk,';'))$Mgk=substr($Mgk,0,$Maf);if($Maf=strpos(str_replace('-','_',$Mgk),'_'))$Mgk=substr($Mgk,$Maf+1);if(empty($Maea[$Mgk]))continue;foreach(explode(' ',strtoupper($Maea[$Mgk]))as$Mad_)if(!empty($Mgv[$Mad_])){if(!empty($Mq)&&$Mq["currency"]==$Mad_)return;$Mq["currency"]=$Mad_;if(!Wdr&&isset($_SERVER["HTTP_HOST"]))setcookie("currency",$Mad_,time()+60*60*24*30,'/',$_SERVER["HTTP_HOST"]);return;}}}
function Wi(){global$Ma,$Mp,$Mq;$Mgv=$Ma['Mgv'];if(isset($_GET["currency"])&&(array_key_exists($_GET["currency"],$Mgv))){$Mfe=$_GET["currency"];$Mq["currency"]=$Mfe;if(!Wdr&&isset($_SERVER["HTTP_HOST"]))setcookie("currency",$Mfe,time()+60*60*24*30,'/',$_SERVER["HTTP_HOST"]);}elseif($Mp&&(isset($Mq["currency"]))&&(array_key_exists($Mq["currency"],$Mgv))){$Mfe=$Mq["currency"];}elseif((isset($_COOKIE["currency"]))&&(array_key_exists($_COOKIE["currency"],$Mgv))){$Mfe=$_COOKIE["currency"];$Mq["currency"]=$Mfe;}else{$Mfe=$Ma['aa'];$Mq["currency"]=$Mfe;Wm_();return$Mq["currency"];}
return$Mfe;}
function Wk($Mbe){if(substr($Mbe,-27)=="index.php?route=common/home")$Mbe=substr($Mbe,0,-27);elseif(substr($Mbe,-9)=="index.php")$Mbe=substr($Mbe,0,-9);$Mbe=urldecode($Mbe);$Mbe=str_replace("&amp;","&",$Mbe);$Mbn=substr($Mbe,-1);if($Mbn=="?"||$Mbn=="&")$Mbe=substr($Mbe,0,-1);return$Mbe;}
function Wl($Mbe){if(!lc('r'))return$Mbe;$Mbe=str_replace('?','&',$Mbe);foreach(explode(' ',lc('r'))as$Mac)if(isset($_GET[$Mac])){$Mbe=str_replace('&'.$Mac.'='.$_GET[$Mac],'',$Mbe);}
$Mbn=substr($Mbe,-1);if($Mbn=="&")$Mbe=substr($Mbe,0,-1);$Maf=strpos($Mbe,'&');if($Maf)$Mbe=substr($Mbe,0,$Maf).'?'.substr($Mbe,$Maf+1);if(substr($Mbe,-27)=="index.php?route=common/home")$Mbe=substr($Mbe,0,-27);elseif(substr($Mbe,-9)=="index.php")$Mbe=substr($Mbe,0,-9);return$Mbe;}
function Wm($Mbe){global$My;return$My.str_replace('?','&',$Mbe);}
function Weq(){global$Mw;$Mlm=$Mw;if($Maf=strpos($Mlm,"_"))$Mlm=substr($Mlm,0,$Maf);return$Mlm;}
function Wz($Mg,$Mwf=false){if(substr($Mg,-2)=="[`")$Mg=substr($Mg,0,strrpos($Mg,"`]"));if(empty($_COOKIE["li_nr"])){global$light_bot;if(!$light_bot)setcookie("li_nr",1,time()+60*60*24*30);}
if(lc('bz')&&lc('gh')){global$Mvi;if($Mvi){Wu($Mg);if($Mvi=="safari"){$Maf=strpos($Mg," chrome ");if($Maf){$Mg=substr($Mg,0,$Maf)." ".$Mvi." ".substr($Mg,$Maf+strlen(" chrome "));}
}else{$Maf=strpos($Mg," touchevents ");if($Maf){$Maf+=strlen(" touchevents ");$Mg=substr($Mg,0,$Maf).$Mvi." ios apple safari ".substr($Mg,$Maf);}}}}
if(lc('hu')){global$Maaf,$Mvq;if(!$Maaf&&$Mwf&&!strpos($Mvq,"Chrome-Lighthouse")){Wkq($Mg);$Mg=str_replace("_wp.",".",$Mg);}
if($Maaf&&!$Mwf)Whk($Mg);}
Wlp($Mg);global$Mv,$Mah;if(Wme()&&!$Mv&&@$_SERVER["REQUEST_METHOD"]!=="POST"&&!headers_sent()){Wfp();global$Mh;global$My,$Mw;$My=$Mw;$Made=md5("http".(($_SERVER["SERVER_PORT"]==443)?"s://":"://").$_SERVER["HTTP_HOST"].Wl($_SERVER["REQUEST_URI"]));$Mdg=Wmo("SELECT image FROM ".DB_PREFIX."lightning_lcp WHERE page='$Made'")->row;if($Mdg){$Mdg=$Mdg["image"];setcookie("li_lcp",$Mdg);if(substr($Mdg,0,strlen($Mh))==$Mh)$Mdg=substr($Mdg,strpos($Mdg,'/',10));header("Link: <$Mdg>; rel=preload; as=image");Wmo("UPDATE ".DB_PREFIX."lightning_lcp SET smd=".time()." WHERE page='$Made'");}}
Waz();if(ob_get_level())ob_flush();if($Mg)Wam($Mg);echo$Mg;Wt();}
function Wlp(&$output){if(!function_exists("replacer_preview_request"))return;global$Macn;if($Macn)return;$Macn=true;if(replacer_preview_request())replacer_save_page($output);@include(DIR_CONFIG."replaces.php");}
function Wlt(&$output){if(function_exists("replacer_preview_request")and!replacer_preview_request())@include(DIR_CONFIG."replaces.php");}
function Wu(&$Mg){if(!$Mg||(ord($Mg[0])!=31))return;if(function_exists("gzdecode"))$Mg=gzdecode($Mg);else$Mg=gzinflate(substr($Mg,10,-8));}
function Whi(&$Mg,$Mgw=2){if(!extension_loaded("zlib")or!function_exists("gzencode"))return;$Mg=gzencode($Mg,$Mgw);}
function Wam(&$Mg,$Mgw=2){if(headers_sent()or lc('ct')){Wu($Mg);return;}
if(!empty($_SERVER["HTTP_ACCEPT"])){if(substr($_SERVER["HTTP_ACCEPT"],0,5)=="image"&&!strpos($_SERVER["HTTP_ACCEPT"],"xml")){Wu($Mg);return;}}
if(isset($_SERVER["HTTP_ACCEPT_ENCODING"])&&(strpos($_SERVER["HTTP_ACCEPT_ENCODING"],"gzip")!==false)){$Mgx="gzip";}
if(isset($_SERVER["HTTP_ACCEPT_ENCODING"])&&(strpos($_SERVER["HTTP_ACCEPT_ENCODING"],"x-gzip")!==false)){$Mgx="x-gzip";}
if(!empty($_SERVER["HTTP_USER_AGENT"]))if(strpos($_SERVER["HTTP_USER_AGENT"],"MSIE 7")||strpos($_SERVER["HTTP_USER_AGENT"],"MSIE 8"))$Mgx=false;if(empty($Mgx)){Wu($Mg);return;}
if(!extension_loaded("zlib")){Wu($Mg);return;}
if(ini_get("zlib.output_compression")){Wu($Mg);return;}
if(headers_sent()){Wu($Mg);return;}
if(connection_status()){Wu($Mg);return;}
header("Content-Encoding: ".$Mgx);if(ord($Mg[0])!=31){$Mg=gzencode($Mg,$Mgw);}
return true;}
function Waz(){global$Mgy,$Mar,$Mgz,$Mg_;$Mha=0;if($Mar){$Mhb="Served in ".Wbl(microtime(true)-$Mgy)." sec from page cache written ".Wbm(microtime(true)-$Mar)." ago. ";}else{$Mha=microtime(true)-$Mgy;$Mhb="Generated in ".Wbl($Mha)." sec. ";}
$Mhc=false;if($Mg_){$Mhb.=$Mg_." cached queries, ";$Mhc="real ";}
if($Mgz==1)$Mhb.="1 ".$Mhc."DB query used.";else if($Mgz)$Mhb.=$Mgz." ".$Mhc."DB queries used.";global$Mhd,$Mhe;if($Mha){$Mhf=$Mha-$Mhd;$Mhg=$Mhd-$Mhe;$Mhh=round($Mhf/$Mha*100);$Mhi=round($Mhg/$Mha*100);$Mhj=round($Mhe/$Mha*100);$Mbp=array();if($Mhh)$Mbp[]=$Mhh."% PHP";if($Mhi)$Mbp[]=$Mhi."% Lightning";if($Mhj)$Mbp[]=$Mhj."% SQL";$Mhb.=" [".implode(", ",$Mbp)."]";}
if(!headers_sent())header("X-OpenCart-Lightning: ".$Mhb);}
function Wbl($Mhk){if($Mhk<1)$Mhk=round($Mhk,3);elseif($Mhk<2)$Mhk=round($Mhk,2);elseif($Mhk<6)$Mhk=round($Mhk,1);else$Mhk=round($Mhk);return($Mhk);}
function Wbm($Mbt){if($Mbt<60)return Wbl($Mbt)." sec";$Mbt=round($Mbt/60);if($Mbt<60)return$Mbt." min";$Mbt=round($Mbt/60);if($Mbt==1)return"1 hour";if($Mbt<60)return$Mbt." hours";$Mbt=round($Mbt/24);if($Mbt==1)return"1 day";return$Mbt." days";}
function Wbp($Mcu){global$Mhy,$Mhz;static$Mh_,$Mia,$Mib,$Mic,$Mid,$Mie;if($Mh_!=$Mhz){global$Ma,$Mn;$Mh_=$Mhz;$Mia=$Ma['Mgv'][$Mhz]['Mia'];if(!$Mia&&$Mia!=="0")$Mia=2;$Mia=(int)$Mia;$Mib=$Ma['Mgv'][$Mhz]['Mib'];$Mic=$Ma['Mgv'][$Mhz]['Mic'];$Mid=$Mn['Mid'];$Mie=$Mn['Mie'];}
$Mad=Wbq($Mcu[1])*$Mhy;$Mif=$Mib.number_format(round($Mad,$Mia),$Mia,$Mid,$Mie).$Mic;return$Mif;}
function Wx($Mig,$Mh_,&$Mg){global$Ma,$Mn,$Mhy,$Mhz;if(isset($Ma['Mgv'][$Mig])){$Mih=$Ma['Mgv'][$Mig]['Mad'];}else{return;}
if(isset($Ma['Mgv'][$Mh_])){$Mii=$Ma['Mgv'][$Mh_]['Mad'];}else{return;}
$Mhy=$Mii/$Mih;$Mhz=$Mh_;$Mg=preg_replace_callback("/".preg_quote($Ma['Mgv'][$Mig]['Mib'])."([0-9][0-9".preg_quote($Mn['Mie']).preg_quote($Mn['Mid'])."]*)".preg_quote($Ma['Mgv'][$Mig]['Mic'])."/u",'Wbp',$Mg);$Mg=str_replace(">".$Ma['Mgv'][$Mig]['Mib'].$Ma['Mgv'][$Mig]['Mic']."<",">".$Ma['Mgv'][$Mh_]['Mib'].$Ma['Mgv'][$Mh_]['Mic']."<",$Mg);}
function Ww($Mee,$Meu,&$Mdk){if(!$Mee)return;if(is_array($Meu)){foreach($Meu as$Mcb=>$Mbc){Ww($Mee[$Mcb],$Mbc,$Mdk);}
return;}
foreach($Mee as$Mei)Wgs($Mei,$Meu,$Mdk);}
function Wgs($Mee,$Meu,&$Mdk,$Mdl=0){if(!$Mee)return;if(lc('gh')&&strpos($Mee['Mev'],"count-badge")&&!strpos($Mdk,$Mee['Mev']))$Mee['Mev']=str_replace("-badge\"", "-badge count-zero\"",$Mee['Mev']);global$Macq;$Macr="<pre><code style='color:black'>".htmlentities($Mee['Mev'])."<font color='blue'>".htmlentities($Meu)."</font>".htmlentities($Mee['Mex'])."</code></pre><br><br>";$Mev=explode("%*%",$Mee['Mev']);$Mei=$Mdl;foreach($Mev as$Mew){$Mqf=$Mei;if(!trim($Mew))continue;$Mei=strpos($Mdk,$Mew,$Mei);if($Mei===false){$Mew=trim($Mew);$Mei=strpos($Mdk,$Mew,$Mqf);}
if($Mei===false){if($Macq)echo str_replace(htmlentities($Mew),"<font color='red'>".htmlentities($Mew)."</font>",$Macr);return;}
$Mei+=strlen($Mew);}
$Maf=$Mei;$Mex=explode("%*%",$Mee['Mex']);foreach($Mex as$Mew){if(!trim($Mew))continue;$Mew=trim($Mew);$Mey=strpos($Mdk,$Mew,$Maf);if($Mey===false){$Mew=trim($Mew);$Mey=strpos($Mdk,$Mew,$Maf);}
if($Mey===false){if($Macq)echo str_replace(htmlentities($Mew),"<font color='red'>".htmlentities($Mew)."</font>",$Macr);return;}
$Maf=$Mey+strlen($Mew);}
$Mdk=substr($Mdk,0,$Mei).$Meu.substr($Mdk,$Mey);if(lc('gh')&&strpos($Mee['Mev'],"count-badge"))if(!$Meu)$Mdk=str_replace($Mee['Mev'],str_replace("-badge\"", "-badge count-zero\"",$Mee['Mev']),$Mdk);else$Mdk=str_replace($Mee['Mev'],str_replace(" count-zero","",$Mee['Mev']),$Mdk);if($Macq)echo$Macr;return$Mey;}
function Wv($Mez,$Meu,$Mdl,$Mbn,&$Mdk){$Mei=0;while(($Mei=stripos($Mdk,$Mdl,$Mei))!==false){$Mei+=strlen($Mdl);if($Mbn)$Mey=stripos($Mdk,$Mbn,$Mei);else$Mey=strlen($Mdk);if($Mey){$Me_=substr($Mdk,0,$Mei);$Mfa=substr($Mdk,$Mey);$Mfb=substr($Mdk,$Mei,$Mey-$Mei);$Mfc=strlen($Mfb);if($Mez!=='')$Mfb=str_ireplace($Mez,$Meu,$Mfb);else$Mfb=$Meu;$Mdk=$Me_.$Mfb.$Mfa;$Mey=$Mey+strlen($Mfb)-$Mfc;$Mei=$Mey+strlen($Mbn);if($Mei>strlen($Mdk))break;}}}
function Wbq($Mil){$Mhk=preg_replace("/[^0-9.,]/i",'',$Mil);if(substr($Mhk,-3,1)==","){$Mhk=substr($Mhk,0,-3).".".substr($Mhk,-2);$Mhk=str_replace(",","",$Mhk);}
$Mhk=str_replace(",","",$Mhk);$Mim=round(abs($Mhk),2);return$Mim;}
function Wj($Mdl,$Mbn,$Mdk){$Mbm='';if($Mdl)$Mei=stripos($Mdk,$Mdl);else$Mei=0;if($Mei!==false){$Mei+=strlen($Mdl);if($Mbn)$Mey=stripos($Mdk,$Mbn,$Mei);else$Mey=strlen($Mdk);if($Mey!==false)$Mbm=trim(substr($Mdk,$Mei,$Mey-$Mei));}
return$Mbm;}
function Why($Mkq,$Meu,$Mdk){if(($Maf=strpos($Mkq,'*'))!==false){$Mev=substr($Mkq,0,$Maf);$Mex=substr($Mkq,$Maf+1);Wv("","",$Mev,$Mex,$Mdk);$Mbm=str_ireplace($Mev.$Mex,$Meu,$Mdk);}else $Mbm=str_ireplace($Mkq,$Meu,$Mdk);return$Mbm;}
function Wfy($Map){if(!is_file($Map))return;unlink($Map);}
function Wkq(&$Mg){if(!lc('hu'))return;Wu($Mg);$Mg=preg_replace_callback("/image\/cache\/wp\/.+?\.webp/",'Wks',$Mg);$Mg=preg_replace_callback("/image\\\\\/cache\\\\\/wp\\\\\/.+?\.webp/",'Wkr',$Mg);}
function Wkr($Mvm){$Mvm=str_replace('\/','/',$Mvm[0]);$Mvm=Wks(array($Mvm));return str_replace('/','\/',$Mvm);}
function Wks($Mvm){$Mvm=$Mvm[0];$Mvm=substr($Mvm,15);global$Maal,$Maam;$Maan=$Maam[$Mvm[0]];$Mvx=$Maal[$Mvm[1]];$Mlm=$Maan.substr($Mvm,3,-4).$Mvx;return$Mlm;}
function Wmd(&$session){global$Ma,$Mz;if(empty($Ma['bf'])||$Mz&&!$Ma['t'])return;static$Madc;if(is_null($Madc)){$Madc=false;$Madd=DIR_CACHE."lightning/".'in';if($Ma['bf']&&file_exists($Madd)){$M_l=@file_get_contents($Madd);$M_l=explode('=',$M_l);if($_SERVER["REMOTE_ADDR"]==$M_l[0])$Madc=$M_l[1];}}
if($Madc){if(empty($session["user_id"]))$session["user_id"]=$Madc;}}
function Wnc($Mvp,$Mvm){if(!lc('hu'))return;$Mvn=substr(DIR_SYSTEM,0,-7);if(substr($Mvm,0,strlen($Mvn))!=$Mvn)return;if(strpos($Mvm,".."))return;if(strpos($Mvm,"favicon"))return;$Mdg=substr($Mvm,strlen($Mvn));$Mvx=substr($Mdg,strrpos($Mdg,'.')+1);global$Maal;$Maap=array_search($Mvx,$Maal);if($Maap===false)return;$Mvo=substr($Mdg,0,strrpos($Mdg,'.')).".webp";$Maaq="e";if(substr($Mvo,0,6)=="image/"){$Mvo=substr($Mvo,6);$Maaq="i";if(substr($Mvo,0,6)=="cache/"){$Mvo=substr($Mvo,6);$Maaq="c";if(substr($Mvo,0,8)=="catalog/"){$Mvo=substr($Mvo,8);$Maaq="g";}
}elseif(substr($Mvo,0,8)=="catalog/"){$Mvo=substr($Mvo,8);$Maaq="l";}}
$Mvo="image/cache/wp/".$Maaq.$Maap."/".$Mvo;Whm($Mvp,$Mvn.$Mvo);}
function Whm($Mvp,$Map,$Maar=0){$Mks=substr($Map,0,strrpos($Map,'/'));Whe($Mks);$Mwi=is_file($Map);if(is_string($Mvp))file_put_contents($Map,file_get_contents($Mvp));else{imagewebp($Mvp,$Map);if(filesize($Map)% 2==1){file_put_contents($Map,"\0",FILE_APPEND);}}
if($Mwi)return;$Mwk=DIR_IMAGE."cache/wp/lightning_webp_data";if(is_file($Mwk)){$Mwj=explode('|',@file_get_contents($Mwk));if(empty($Mwj[1])){sleep(1);Wcv($Mwk);$Mwj=explode('|',@file_get_contents($Mwk));}}
if(empty($Mwj[1]))$Mwj=array(0,0,0);$Mwj[0]++;$Maeb=filesize($Map);$Mwj[1]+=$Maeb;if(!$Maar)$Maar=$Maeb*2;$Mwj[2]+=$Maar;file_put_contents($Mwk,implode('|',$Mwj),LOCK_EX);}