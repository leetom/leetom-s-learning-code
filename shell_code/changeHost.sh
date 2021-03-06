#!/bin/bash

hostFile="/etc/hosts"

addGoogle(){
	echo "203.208.46.29 plus.Google.com
203.208.46.29 talkgadget.google.com" >> $hostFile
}

addVideoBanAD(){
	echo "127.0.0.1 a.cctv.com
	127.0.0.1 a.cntv.cn
	127.0.0.1 ad.cctv.com
	127.0.0.1 d.cntv.cn
	127.0.0.1 adguanggao.eee114.com
	127.0.0.1 cctv.adsunion.com
	127.0.0.1 luck.v1.cn
	127.0.0.1 acs.56.com
	127.0.0.1 acs.agent.56.com
	127.0.0.1 acs.agent.v-56.com
	127.0.0.1 bill.agent.56.com
	127.0.0.1 bill.agent.v-56.com
	127.0.0.1 stat.56.com
	127.0.0.1 stat2.corp.56.com
	127.0.0.1 union.56.com
	127.0.0.1 uvimage.56.com
	127.0.0.1 v16.56.com
	127.0.0.1 pole.6rooms.com
	127.0.0.1 shrek.6.cn
	127.0.0.1 simba.6.cn
	127.0.0.1 union.6.cn
	127.0.0.1 atm.youku.com
	127.0.0.1 Fvid.atm.youku.com
	127.0.0.1 html.atm.youku.com
	127.0.0.1 lstat.youku.com
	127.0.0.1 speed.lstat.youku.com
	127.0.0.1 stat.youku.com
	127.0.0.1 static.lstat.youku.com
	127.0.0.1 urchin.lstat.youku.com
	127.0.0.1 valb.atm.youku.com
	127.0.0.1 valc.atm.youku.com
	127.0.0.1 valf.atm.youku.com
	127.0.0.1 valo.atm.youku.com
	127.0.0.1 valp.atm.youku.com
	127.0.0.1 vid.atm.youku.com
	127.0.0.1 walp.atm.youku.com
	127.0.0.1 adextensioncontrol.tudou.com
	127.0.0.1 adplay.tudou.com
	127.0.0.1 iwstat.tudou.com
	127.0.0.1 nstat.tudou.com
	127.0.0.1 stat.tudou.com
	127.0.0.1 stats.tudou.com
	127.0.0.1 tdap.tudou.com
	127.0.0.1 tdcm.tudou.com
	127.0.0.1 cpro.baidu.com
	127.0.0.1 86mms.megajoy.com
	127.0.0.1 86file.megajoy.com
	127.0.0.1 86get.joy.cn
	127.0.0.1 86log.joy.cn
	127.0.0.1 casting.openv.com
	127.0.0.1 m.openv.tv
	127.0.0.1 uniclick.openv.com
	127.0.0.1 wo318.k621.com
	127.0.0.1 union.pomoho.com
	127.0.0.1 pro.letv.com
	127.0.0.1 t.top100.cn
	127.0.0.1 images.sohu.com
	127.0.0.1 adcount.sandai.net
	127.0.0.1 advstat.xunlei.com
	127.0.0.1 analytics-union.sandai.net
	127.0.0.1 biz4.sandai.net
	127.0.0.1 biz5.sandai.net
	127.0.0.1 biz5c.sandai.net
	127.0.0.1 cknum.sandai.net
	127.0.0.1 click.cm.sandai.net
	127.0.0.1 float.sandai.net
	127.0.0.1 gvod.union.sandai.net
	127.0.0.1 hubstat.sandai.net
	127.0.0.1 logic.cpm.cm.sandai.net
	127.0.0.1 mcfg.sandai.net
	127.0.0.1 mpv.sandai.net
	127.0.0.1 pubstat.sandai.net
	127.0.0.1 server1.adpolestar.net
	127.0.0.1 ub.dphub.sandai.net
	127.0.0.1 vodsts.sandai.net
	127.0.0.1 afp.qiyi.com 
	127.0.0.1 focusbaiduafp.allyes.com 
	127.0.0.1 cs.37see.com
	127.0.0.1 js.5566ad.com
	127.0.0.1 comment.ifeng.com
	127.0.0.1 flvad.ifeng.com
	127.0.0.1 favorites.ifeng.com
	127.0.0.1 itv.ifeng.com
	127.0.0.1 my.ifeng.com
	127.0.0.1 partner.itv.ifeng.com
	127.0.0.1 sc.ifeng.com
	127.0.0.1 sta.ifeng.com
	127.0.0.1 stadig.ifeng.com
	127.0.0.1 survey.news.ifeng.com
	127.0.0.1 t.ifeng.com
	127.0.0.1 v.t.sina.com.cn
	127.0.0.1 adsfile.qq.com
	127.0.0.1 adsgroup.qq.com
	#127.0.0.1 adshmct.qq.com
	127.0.0.1 adshmmsg.qq.com
	127.0.0.1 dl.ddong.com
	127.0.0.1 game.kugou.com
	127.0.0.1 games.kugou.com
	127.0.0.1 install.kugou.com
	127.0.0.1 links.kugoo.com
	127.0.0.1 mkg.kugou.com
	127.0.0.1 myonline.kugou.com
	127.0.0.1 sdn.kugoo.com
	127.0.0.1 sdn.kugou.com
	127.0.0.1 softstat.kugou.com
	127.0.0.1 yx.kugou.com
	127.0.0.1 g.koowo.com
	127.0.0.1 g.kuwo.cn
	127.0.0.1 wa.kuwo.cn
	127.0.0.1 wa.koowo.com
	127.0.0.1 notice.ppstream.com
	127.0.0.1 stat.ppstream.com
	127.0.0.1 update.111222.cn
	127.0.0.1 game.pps.tv
	127.0.0.1 afp.pplive.com
	127.0.0.1 afv.pplive.com
	127.0.0.1 caipiao.pplive.com
	127.0.0.1 dh.pplive.com
	127.0.0.1 g.pplive.com
	127.0.0.1 ins-stat.pplive.com
	127.0.0.1 ins-version.pplive.com
	127.0.0.1 ins.pplive.com
	127.0.0.1 iptable.pplive.com
	127.0.0.1 live.v2.pplive.com
	127.0.0.1 download.pplive.com
	127.0.0.1 pp1.pplive.com
	127.0.0.1 up.pplive.com
	127.0.0.1 g.pptv.com
	127.0.0.1 pp2.pptv.com
	127.0.0.1 ppsj.pptv.com
	127.0.0.1 wafp.pptv.com
	127.0.0.1 wstat.pptv.com
	127.0.0.1 h.g1d.net
	127.0.0.1 p.g1d.net
	127.0.0.1 ppva.g1d.net
	127.0.0.1 video-va.g1d.net
	127.0.0.1 pplive-ppva.datamaster.com.cn
	127.0.0.1 pplive-probe.datamaster.com.cn
	127.0.0.1 res-pplive.datamaster.com.cn
	127.0.0.1 110.qvod.com
	127.0.0.1 buffer-ad.qvod.com
	127.0.0.1 insert-ad.qvod.com
	127.0.0.1 pause-ad.qvod.com
	127.0.0.1 text-ad.qvod.com
	127.0.0.1 tj.qvod.com
	127.0.0.1 update.qvod.com
	127.0.0.1 hao.kuaibo.com
	127.0.0.1 searchstat.kuaibo.com
	127.0.0.1 qvodlink.hco.cc
	127.0.0.1 g.uusee.com
	127.0.0.1 sa.uusee.com
	127.0.0.1 traffic.uusee.com
	127.0.0.1 uhms.uusee.com
	127.0.0.1 uuseeafp.allyes.com
	127.0.0.1 ads.qianqian.com
	127.0.0.1 ttmsg.qianqian.com
	127.0.0.1 ttads.ttplayer.com
	127.0.0.1 dcads.sina.com.cn 
	127.0.0.1 links.kugoo.com 
	127.0.0.1 links.kugoo.com


	127.0.0.1 atm.youku.com
	127.0.0.1 Fvid.atm.youku.com
	127.0.0.1 html.atm.youku.com
	127.0.0.1 valb.atm.youku.com
	127.0.0.1 valf.atm.youku.com
	127.0.0.1 valo.atm.youku.com
	127.0.0.1 valp.atm.youku.com
	127.0.0.1 lstat.youku.com
	127.0.0.1 speed.lstat.youku.com
	127.0.0.1 urchin.lstat.youku.com
	127.0.0.1 stat.youku.com
	127.0.0.1 static.lstat.youku.com
	127.0.0.1 valc.atm.youku.com
	203.208.46.29 picadaweb.google.com
	203.208.46.29 lh1.ggpht.com
	203.208.46.29 lh2.ggpht.com
	203.208.46.29 lh3.ggpht.com
	203.208.46.29 lh4.ggpht.com
	203.208.46.29 lh5.ggpht.com
	203.208.46.29 lh6.ggpht.com
	203.208.46.29 lh6.googleusercontent.com
	203.208.46.29 lh5.googleusercontent.com
	203.208.46.29 lh4.googleusercontent.com
	203.208.46.29 lh3.googleusercontent.com
	203.208.46.29 lh2.googleusercontent.com
	203.208.46.29 lh1.googleusercontent.com
	203.208.46.29 plus.google.com
	203.208.46.29 talkgadget.google.com" >> $hostFile
}

copyHost(){
	cp -f /etc/hosts ~/.hosts || echo "操作失败" 
}

backUp(){
	cp -f ~/.hosts /etc/hosts || echo "操作失败" 
}

echo "************************************************************
**                                                        **
**                  Hosts文件修改助手                     **
**                     版本号V1.0                         **
**                                                        **
**                    2011年7月27日                       **
**                                by leetom               **
************************************************************"
while true ; do
	echo "输入相应编号，完成对应功能(1/2/4需root权限)：
	 * (1)-增加Google+解析
	 * (2)-增加Google+解析各大视频网站广告过滤功能
	 * (3)-备份hosts文件（到~/.hosts）
	 * (4)-恢复hosts文件（从~/.hosts）
	 * (q)-不玩儿了 退出"
	read -p "选择：" choice
	case $choice in
		1)	addGoogle || echo "操作失败"  && read -p "按任意建继续" -n 1;;
		2)	addVideoBanAD || echo "操作失败"  && read -p "按任意建继续" -n 1;;
		3)	copyHost && read -p "按任意建继续" -n 1;;
		4)	backUp && read -p "按任意建继续" -n 1;;
		q)	break;;
		*)	echo "输入错误！"; read -p "按任意建继续" -n 1;;
	esac
	clear
done

