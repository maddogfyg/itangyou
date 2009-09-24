#
# PHPwind bakfile
# Version:7.5
# Time: 2009-09-24 14:28
# Type: 
# PHPwind: http://www.phpwind.net
# --------------------------------------------------------


DROP TABLE IF EXISTS pw_actions;
CREATE TABLE pw_actions (
  id smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  images varchar(15) NOT NULL DEFAULT '',
  `name` varchar(15) NOT NULL DEFAULT '',
  descrip varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_activity;
CREATE TABLE pw_activity (
  tid mediumint(8) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(80) NOT NULL DEFAULT '',
  admin mediumint(8) NOT NULL DEFAULT '0',
  starttime int(10) NOT NULL DEFAULT '0',
  endtime int(10) NOT NULL DEFAULT '0',
  location varchar(20) NOT NULL DEFAULT '',
  num smallint(6) NOT NULL DEFAULT '0',
  sexneed tinyint(1) NOT NULL DEFAULT '0',
  costs int(10) NOT NULL DEFAULT '0',
  deadline int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (tid),
  KEY admin (admin)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_actmember;
CREATE TABLE pw_actmember (
  id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  actid mediumint(8) NOT NULL DEFAULT '0',
  winduid mediumint(8) NOT NULL DEFAULT '0',
  state tinyint(1) NOT NULL DEFAULT '0',
  applydate int(10) NOT NULL DEFAULT '0',
  contact varchar(20) NOT NULL DEFAULT '',
  message varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  KEY actid (actid),
  KEY winduid (winduid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_administrators;
CREATE TABLE pw_administrators (
  uid mediumint(8) unsigned NOT NULL DEFAULT '0',
  username varchar(15) NOT NULL DEFAULT '',
  groupid tinyint(3) NOT NULL DEFAULT '0',
  groups varchar(255) NOT NULL DEFAULT '',
  slog varchar(255) NOT NULL,
  PRIMARY KEY (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_adminlog;
CREATE TABLE pw_adminlog (
  id int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) NOT NULL DEFAULT '',
  username1 varchar(30) NOT NULL DEFAULT '',
  username2 varchar(30) NOT NULL DEFAULT '',
  field1 varchar(30) NOT NULL DEFAULT '',
  field2 varchar(30) NOT NULL DEFAULT '',
  field3 varchar(255) NOT NULL DEFAULT '',
  descrip text NOT NULL,
  `timestamp` int(10) NOT NULL DEFAULT '0',
  ip varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  KEY `type` (`type`,`timestamp`),
  KEY username1 (username1),
  KEY username2 (username2)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_adminset;
CREATE TABLE pw_adminset (
  gid tinyint(3) unsigned NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  PRIMARY KEY (gid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_advert;
CREATE TABLE pw_advert (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT '0',
  uid int(10) unsigned NOT NULL DEFAULT '0',
  ckey varchar(32) NOT NULL,
  stime int(10) unsigned NOT NULL DEFAULT '0',
  etime int(10) unsigned NOT NULL DEFAULT '0',
  ifshow tinyint(1) NOT NULL DEFAULT '0',
  orderby tinyint(1) NOT NULL DEFAULT '0',
  descrip varchar(255) NOT NULL,
  config text NOT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_announce;
CREATE TABLE pw_announce (
  aid smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  fid smallint(6) NOT NULL DEFAULT '-1',
  ifopen tinyint(1) NOT NULL DEFAULT '0',
  ifconvert tinyint(1) NOT NULL DEFAULT '0',
  vieworder smallint(6) NOT NULL DEFAULT '0',
  author varchar(15) NOT NULL DEFAULT '',
  startdate varchar(15) NOT NULL DEFAULT '',
  url varchar(80) NOT NULL DEFAULT '',
  enddate varchar(15) NOT NULL DEFAULT '',
  `subject` varchar(100) NOT NULL DEFAULT '',
  content mediumtext NOT NULL,
  PRIMARY KEY (aid),
  KEY vieworder (vieworder,startdate),
  KEY fid (fid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_argument;
CREATE TABLE pw_argument (
  tid mediumint(8) unsigned NOT NULL,
  cyid smallint(6) unsigned NOT NULL,
  topped tinyint(1) unsigned NOT NULL,
  postdate int(10) unsigned NOT NULL,
  lastpost int(10) unsigned NOT NULL,
  PRIMARY KEY (tid),
  KEY cyid (cyid,topped,lastpost)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_attachbuy;
CREATE TABLE pw_attachbuy (
  aid mediumint(8) unsigned NOT NULL,
  uid mediumint(8) unsigned NOT NULL,
  ctype varchar(20) NOT NULL,
  cost smallint(5) unsigned NOT NULL,
  PRIMARY KEY (aid,uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_attachs;
CREATE TABLE pw_attachs (
  aid mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  fid smallint(6) unsigned NOT NULL DEFAULT '0',
  uid mediumint(8) unsigned NOT NULL DEFAULT '0',
  tid mediumint(8) unsigned NOT NULL DEFAULT '0',
  pid int(10) unsigned NOT NULL DEFAULT '0',
  did int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(80) NOT NULL DEFAULT '',
  `type` varchar(30) NOT NULL DEFAULT '',
  size int(10) unsigned NOT NULL DEFAULT '0',
  attachurl varchar(80) NOT NULL DEFAULT '0',
  hits mediumint(8) unsigned NOT NULL DEFAULT '0',
  needrvrc smallint(6) unsigned NOT NULL DEFAULT '0',
  special tinyint(3) unsigned NOT NULL DEFAULT '0',
  ctype varchar(20) NOT NULL DEFAULT '',
  uploadtime int(10) NOT NULL DEFAULT '0',
  descrip varchar(100) NOT NULL DEFAULT '',
  ifthumb tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (aid),
  KEY fid (fid),
  KEY uid (uid),
  KEY did (did),
  KEY `type` (`type`),
  KEY post (tid,pid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_banuser;
CREATE TABLE pw_banuser (
  id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  uid mediumint(8) unsigned NOT NULL DEFAULT '0',
  fid smallint(6) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(1) NOT NULL DEFAULT '0',
  startdate int(10) NOT NULL DEFAULT '0',
  days int(4) NOT NULL DEFAULT '0',
  admin varchar(15) NOT NULL DEFAULT '',
  reason varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  UNIQUE KEY uid (uid,fid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_bbsinfo;
CREATE TABLE pw_bbsinfo (
  id smallint(3) unsigned NOT NULL AUTO_INCREMENT,
  newmember varchar(15) NOT NULL DEFAULT '',
  totalmember mediumint(8) unsigned NOT NULL DEFAULT '0',
  higholnum smallint(6) unsigned NOT NULL DEFAULT '0',
  higholtime int(10) unsigned NOT NULL DEFAULT '0',
  tdtcontrol int(10) unsigned NOT NULL DEFAULT '0',
  yposts mediumint(8) unsigned NOT NULL DEFAULT '0',
  hposts mediumint(8) unsigned NOT NULL DEFAULT '0',
  hit_tdtime int(10) unsigned NOT NULL DEFAULT '0',
  hit_control tinyint(2) unsigned NOT NULL DEFAULT '0',
  plantime int(10) NOT NULL DEFAULT '0',
  o_post int(10) unsigned NOT NULL DEFAULT '0',
  o_tpost int(10) unsigned NOT NULL DEFAULT '0',
  KEY id (id)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_block;
CREATE TABLE pw_block (
  bid smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  sid smallint(6) unsigned NOT NULL,
  func varchar(30) NOT NULL,
  `name` varchar(30) NOT NULL,
  rang varchar(30) NOT NULL,
  cachetime int(10) unsigned NOT NULL,
  iflock tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (bid)
) ENGINE=MyISAM AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_buyadvert;
CREATE TABLE pw_buyadvert (
  id int(10) unsigned NOT NULL DEFAULT '0',
  uid mediumint(8) unsigned NOT NULL DEFAULT '0',
  ifcheck tinyint(1) NOT NULL DEFAULT '0',
  lasttime int(10) NOT NULL DEFAULT '0',
  config text NOT NULL,
  PRIMARY KEY (id,uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_cache;
CREATE TABLE pw_cache (
  `name` varchar(20) NOT NULL DEFAULT '',
  `cache` mediumtext NOT NULL,
  `time` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_cachedata;
CREATE TABLE pw_cachedata (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  invokepieceid smallint(6) unsigned NOT NULL,
  fid smallint(6) unsigned NOT NULL DEFAULT '0',
  loopid smallint(6) unsigned NOT NULL DEFAULT '0',
  `data` text NOT NULL,
  cachetime int(10) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY invokepieceid (invokepieceid,fid,loopid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_clientorder;
CREATE TABLE pw_clientorder (
  id int(11) NOT NULL AUTO_INCREMENT,
  order_no varchar(30) NOT NULL DEFAULT '',
  `type` tinyint(3) unsigned NOT NULL,
  uid mediumint(8) NOT NULL DEFAULT '0',
  paycredit varchar(15) NOT NULL DEFAULT '',
  price decimal(8,2) NOT NULL DEFAULT '0.00',
  payemail varchar(60) NOT NULL DEFAULT '',
  number smallint(6) NOT NULL DEFAULT '0',
  `date` int(10) NOT NULL DEFAULT '0',
  state tinyint(1) NOT NULL DEFAULT '0',
  extra_1 mediumint(8) NOT NULL,
  PRIMARY KEY (id),
  KEY uid (uid),
  KEY order_no (order_no)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_cmembers;
CREATE TABLE pw_cmembers (
  id mediumint(9) NOT NULL AUTO_INCREMENT,
  uid mediumint(9) unsigned NOT NULL DEFAULT '0',
  username varchar(20) NOT NULL DEFAULT '',
  realname varchar(20) NOT NULL DEFAULT '',
  ifadmin tinyint(1) NOT NULL DEFAULT '0',
  gender tinyint(1) NOT NULL DEFAULT '0',
  tel varchar(15) NOT NULL DEFAULT '',
  email varchar(50) NOT NULL DEFAULT '',
  colonyid smallint(6) NOT NULL DEFAULT '0',
  address varchar(255) NOT NULL DEFAULT '',
  introduce varchar(255) NOT NULL DEFAULT '',
  addtime int(10) unsigned NOT NULL DEFAULT '0',
  lastvisit int(10) unsigned NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY colonyid (colonyid,uid),
  KEY uid (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_cnalbum;
CREATE TABLE pw_cnalbum (
  aid mediumint(8) NOT NULL AUTO_INCREMENT,
  aname varchar(50) NOT NULL DEFAULT '',
  aintro varchar(200) NOT NULL DEFAULT '',
  atype smallint(4) NOT NULL DEFAULT '0',
  private tinyint(1) unsigned NOT NULL,
  albumpwd varchar(40) NOT NULL,
  ownerid mediumint(8) unsigned NOT NULL,
  `owner` varchar(50) NOT NULL DEFAULT '',
  photonum smallint(6) NOT NULL DEFAULT '0',
  lastphoto varchar(100) NOT NULL DEFAULT '',
  lasttime int(10) unsigned NOT NULL,
  lastpid varchar(100) NOT NULL,
  crtime int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (aid),
  KEY atype (atype,ownerid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_cnclass;
CREATE TABLE pw_cnclass (
  fid smallint(6) unsigned NOT NULL,
  cname varchar(20) NOT NULL,
  ifopen tinyint(1) unsigned NOT NULL,
  cnsum int(10) unsigned NOT NULL,
  PRIMARY KEY (fid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_cnphoto;
CREATE TABLE pw_cnphoto (
  pid smallint(8) NOT NULL AUTO_INCREMENT,
  aid smallint(8) NOT NULL DEFAULT '0',
  pintro varchar(200) NOT NULL DEFAULT '',
  path varchar(200) NOT NULL DEFAULT '',
  uploader varchar(50) NOT NULL DEFAULT '',
  uptime int(10) NOT NULL DEFAULT '0',
  hits smallint(6) NOT NULL DEFAULT '0',
  ifthumb tinyint(1) unsigned NOT NULL DEFAULT '0',
  c_num mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (pid),
  KEY aid (aid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_colonys;
CREATE TABLE pw_colonys (
  id smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  classid smallint(6) NOT NULL DEFAULT '0',
  cname varchar(20) NOT NULL DEFAULT '',
  admin varchar(20) NOT NULL DEFAULT '',
  members int(10) NOT NULL DEFAULT '0',
  ifcheck tinyint(1) NOT NULL DEFAULT '0',
  ifopen tinyint(1) NOT NULL DEFAULT '0',
  albumopen tinyint(1) NOT NULL DEFAULT '0',
  cnimg varchar(100) NOT NULL DEFAULT '',
  banner varchar(100) NOT NULL,
  createtime int(10) NOT NULL DEFAULT '0',
  annouce text NOT NULL,
  albumnum smallint(6) NOT NULL DEFAULT '0',
  annoucesee smallint(6) NOT NULL DEFAULT '0',
  descrip varchar(255) NOT NULL DEFAULT '',
  visitor text NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY cname (cname),
  KEY admin (admin),
  KEY classid (classid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_comment;
CREATE TABLE pw_comment (
  id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  uid mediumint(8) unsigned NOT NULL,
  username varchar(15) NOT NULL,
  title varchar(255) NOT NULL,
  `type` varchar(10) NOT NULL,
  typeid mediumint(8) NOT NULL,
  upid mediumint(8) NOT NULL,
  postdate int(10) NOT NULL,
  ifwordsfb tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (id),
  KEY `type` (`type`,typeid),
  KEY upid (upid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_config;
CREATE TABLE pw_config (
  db_name varchar(30) NOT NULL DEFAULT '',
  vtype enum('string','array') NOT NULL DEFAULT 'string',
  db_value text NOT NULL,
  decrip text NOT NULL,
  PRIMARY KEY (db_name)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_creditlog;
CREATE TABLE pw_creditlog (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  uid mediumint(8) unsigned NOT NULL,
  username varchar(15) NOT NULL,
  ctype varchar(8) NOT NULL,
  affect int(10) NOT NULL,
  adddate int(10) NOT NULL,
  logtype varchar(20) NOT NULL,
  ip varchar(15) NOT NULL,
  descrip varchar(255) NOT NULL,
  PRIMARY KEY (id),
  KEY uid (uid),
  KEY adddate (adddate)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_credits;
CREATE TABLE pw_credits (
  cid tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  unit varchar(30) NOT NULL DEFAULT '',
  description varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (cid)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_customfield;
CREATE TABLE pw_customfield (
  id smallint(6) NOT NULL AUTO_INCREMENT,
  title varchar(50) NOT NULL DEFAULT '',
  maxlen smallint(6) NOT NULL DEFAULT '0',
  vieworder smallint(6) NOT NULL DEFAULT '0',
  `type` tinyint(1) NOT NULL DEFAULT '0',
  state tinyint(1) NOT NULL DEFAULT '0',
  required tinyint(1) NOT NULL DEFAULT '0',
  viewinread tinyint(1) NOT NULL DEFAULT '0',
  editable tinyint(1) NOT NULL DEFAULT '0',
  descrip varchar(255) NOT NULL DEFAULT '',
  viewright varchar(255) NOT NULL DEFAULT '',
  `options` text NOT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_datanalyse;
CREATE TABLE pw_datanalyse (
  tag int(10) NOT NULL,
  `action` varchar(30) NOT NULL,
  timeunit int(10) NOT NULL,
  num mediumint(8) NOT NULL DEFAULT '0',
  UNIQUE KEY idx_action_timeunit_tag (`action`,timeunit,tag)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_datastate;
CREATE TABLE pw_datastate (
  `year` smallint(4) NOT NULL DEFAULT '0',
  `month` tinyint(2) NOT NULL DEFAULT '0',
  `day` tinyint(2) NOT NULL DEFAULT '0',
  topic mediumint(8) NOT NULL DEFAULT '0',
  reply mediumint(8) NOT NULL DEFAULT '0',
  regmen mediumint(8) NOT NULL DEFAULT '0',
  postmen mediumint(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`year`,`month`,`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_datastore;
CREATE TABLE pw_datastore (
  skey varchar(32) NOT NULL,
  expire int(10) unsigned NOT NULL,
  vhash char(32) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (skey),
  KEY expire (expire)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_debatedata;
CREATE TABLE pw_debatedata (
  pid int(10) unsigned NOT NULL,
  tid int(10) unsigned NOT NULL,
  authorid int(10) unsigned NOT NULL,
  standpoint tinyint(1) unsigned NOT NULL DEFAULT '0',
  postdate int(10) unsigned NOT NULL,
  vote int(10) unsigned NOT NULL,
  voteids text NOT NULL,
  PRIMARY KEY (pid,tid,authorid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_debates;
CREATE TABLE pw_debates (
  tid int(10) unsigned NOT NULL,
  authorid int(10) unsigned NOT NULL,
  postdate int(10) unsigned NOT NULL,
  obtitle varchar(255) NOT NULL,
  retitle varchar(255) NOT NULL,
  endtime int(10) unsigned NOT NULL,
  obvote int(10) unsigned NOT NULL DEFAULT '0',
  revote int(10) unsigned NOT NULL DEFAULT '0',
  obposts int(10) unsigned NOT NULL DEFAULT '0',
  reposts int(10) unsigned NOT NULL DEFAULT '0',
  umpire varchar(16) NOT NULL,
  umpirepoint varchar(255) NOT NULL,
  debater varchar(16) NOT NULL,
  judge tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (tid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_diary;
CREATE TABLE pw_diary (
  did int(10) NOT NULL AUTO_INCREMENT,
  uid int(10) NOT NULL,
  dtid mediumint(8) NOT NULL,
  aid text NOT NULL,
  username varchar(15) NOT NULL,
  privacy tinyint(1) NOT NULL DEFAULT '0',
  `subject` varchar(150) NOT NULL,
  content text NOT NULL,
  ifcopy tinyint(1) NOT NULL DEFAULT '0',
  copyurl varchar(100) NOT NULL,
  ifconvert tinyint(1) NOT NULL DEFAULT '0',
  ifwordsfb tinyint(1) NOT NULL DEFAULT '0',
  ifupload tinyint(1) NOT NULL DEFAULT '0',
  r_num int(10) NOT NULL DEFAULT '0',
  c_num int(10) NOT NULL DEFAULT '0',
  postdate int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (did),
  KEY uid (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_diarytype;
CREATE TABLE pw_diarytype (
  dtid mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  uid mediumint(8) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  num mediumint(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (dtid),
  KEY uid (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_draft;
CREATE TABLE pw_draft (
  did mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  uid mediumint(8) NOT NULL DEFAULT '0',
  content text NOT NULL,
  PRIMARY KEY (did),
  KEY uid (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_elements;
CREATE TABLE pw_elements (
  eid mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(30) NOT NULL,
  mark varchar(30) NOT NULL,
  id mediumint(8) unsigned NOT NULL,
  `value` int(10) NOT NULL,
  addition varchar(255) NOT NULL,
  special tinyint(1) NOT NULL DEFAULT '0',
  `time` int(10) unsigned NOT NULL,
  PRIMARY KEY (eid),
  UNIQUE KEY `type` (`type`,mark,id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_extragroups;
CREATE TABLE pw_extragroups (
  uid mediumint(9) NOT NULL DEFAULT '0',
  gid smallint(6) NOT NULL DEFAULT '0',
  togid smallint(6) NOT NULL DEFAULT '0',
  startdate int(10) NOT NULL DEFAULT '0',
  days smallint(6) NOT NULL DEFAULT '0',
  KEY uid (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_favors;
CREATE TABLE pw_favors (
  uid mediumint(8) unsigned NOT NULL DEFAULT '1',
  tids text NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_feed;
CREATE TABLE pw_feed (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  uid mediumint(8) unsigned NOT NULL,
  `type` varchar(20) NOT NULL,
  descrip text,
  `timestamp` int(10) unsigned NOT NULL,
  typeid mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (id),
  KEY uid (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_focus;
CREATE TABLE pw_focus (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  pushto varchar(30) NOT NULL,
  pushtime int(10) NOT NULL,
  fid smallint(6) NOT NULL,
  tid mediumint(8) NOT NULL,
  `subject` varchar(100) NOT NULL,
  content text NOT NULL,
  postdate int(10) NOT NULL,
  url varchar(100) NOT NULL,
  imgurl varchar(100) NOT NULL,
  PRIMARY KEY (id),
  KEY pushto (pushto)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_forumdata;
CREATE TABLE pw_forumdata (
  fid smallint(6) unsigned NOT NULL DEFAULT '0',
  tpost mediumint(8) unsigned NOT NULL DEFAULT '0',
  topic mediumint(8) unsigned NOT NULL DEFAULT '0',
  article mediumint(8) unsigned NOT NULL DEFAULT '0',
  subtopic mediumint(8) unsigned NOT NULL DEFAULT '0',
  top1 smallint(6) unsigned NOT NULL DEFAULT '0',
  top2 smallint(6) unsigned NOT NULL DEFAULT '0',
  aid smallint(6) unsigned NOT NULL DEFAULT '0',
  aidcache int(10) unsigned NOT NULL DEFAULT '0',
  aids varchar(135) NOT NULL DEFAULT '',
  lastpost varchar(135) NOT NULL DEFAULT '',
  PRIMARY KEY (fid),
  KEY aid (aid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_forumlog;
CREATE TABLE pw_forumlog (
  id int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(10) NOT NULL DEFAULT '',
  username1 varchar(30) NOT NULL DEFAULT '',
  username2 varchar(30) NOT NULL DEFAULT '',
  field1 varchar(30) NOT NULL DEFAULT '',
  field2 varchar(30) NOT NULL DEFAULT '',
  field3 varchar(255) NOT NULL DEFAULT '',
  descrip text NOT NULL,
  `timestamp` int(10) NOT NULL DEFAULT '0',
  ip varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  KEY `type` (`type`),
  KEY username1 (username1),
  KEY username2 (username2)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_forummsg;
CREATE TABLE pw_forummsg (
  id smallint(6) NOT NULL AUTO_INCREMENT,
  fid smallint(6) NOT NULL DEFAULT '0',
  uid mediumint(8) NOT NULL DEFAULT '0',
  username varchar(15) NOT NULL,
  toname varchar(200) NOT NULL,
  msgtype tinyint(1) NOT NULL DEFAULT '0',
  posttime int(10) NOT NULL DEFAULT '0',
  savetime int(10) NOT NULL DEFAULT '0',
  message mediumtext NOT NULL,
  PRIMARY KEY (id),
  KEY fid (fid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_forums;
CREATE TABLE pw_forums (
  fid smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  fup smallint(6) unsigned NOT NULL DEFAULT '0',
  ifsub tinyint(1) NOT NULL DEFAULT '0',
  childid tinyint(1) NOT NULL DEFAULT '0',
  `type` enum('category','forum','sub','sub2') NOT NULL DEFAULT 'forum',
  logo varchar(100) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  descrip varchar(255) NOT NULL DEFAULT '',
  dirname varchar(15) NOT NULL DEFAULT '',
  keywords varchar(50) NOT NULL DEFAULT '',
  vieworder tinyint(3) NOT NULL DEFAULT '0',
  forumadmin varchar(255) NOT NULL DEFAULT '',
  fupadmin varchar(255) NOT NULL DEFAULT '',
  style varchar(12) NOT NULL DEFAULT '',
  across tinyint(1) NOT NULL DEFAULT '0',
  allowhtm tinyint(1) NOT NULL DEFAULT '0',
  allowhide tinyint(1) NOT NULL DEFAULT '1',
  allowsell tinyint(1) NOT NULL DEFAULT '1',
  allowtype tinyint(3) NOT NULL DEFAULT '1',
  copyctrl tinyint(1) NOT NULL DEFAULT '0',
  allowencode tinyint(1) NOT NULL DEFAULT '1',
  `password` varchar(32) NOT NULL DEFAULT '',
  viewsub tinyint(1) NOT NULL DEFAULT '0',
  allowvisit varchar(120) NOT NULL DEFAULT '',
  allowread varchar(120) NOT NULL DEFAULT '',
  allowpost varchar(120) NOT NULL DEFAULT '',
  allowrp varchar(120) NOT NULL DEFAULT '',
  allowdownload varchar(120) NOT NULL DEFAULT '',
  allowupload varchar(120) NOT NULL DEFAULT '',
  modelid varchar(50) NOT NULL DEFAULT '',
  forumsell varchar(15) NOT NULL DEFAULT '',
  pcid varchar(50) NOT NULL DEFAULT '',
  f_type enum('forum','former','hidden','vote') NOT NULL DEFAULT 'forum',
  f_check tinyint(1) unsigned NOT NULL DEFAULT '0',
  t_type tinyint(1) NOT NULL DEFAULT '0',
  cms tinyint(1) NOT NULL DEFAULT '0',
  ifhide tinyint(1) NOT NULL DEFAULT '1',
  showsub tinyint(1) NOT NULL DEFAULT '0',
  cateid tinyint(3) unsigned NOT NULL,
  forumcate tinyint(1) NOT NULL DEFAULT '1',
  ifcms tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (fid),
  KEY fup (fup),
  KEY `type` (ifsub,vieworder,fup)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_forumsell;
CREATE TABLE pw_forumsell (
  id mediumint(8) NOT NULL AUTO_INCREMENT,
  fid smallint(6) unsigned NOT NULL DEFAULT '0',
  uid mediumint(8) unsigned NOT NULL DEFAULT '1',
  buydate int(10) unsigned NOT NULL DEFAULT '0',
  overdate int(10) unsigned NOT NULL DEFAULT '0',
  credit varchar(8) NOT NULL DEFAULT '',
  cost decimal(8,2) NOT NULL,
  PRIMARY KEY (id),
  KEY fid (fid),
  KEY uid (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_forumsextra;
CREATE TABLE pw_forumsextra (
  fid smallint(6) NOT NULL DEFAULT '0',
  creditset text NOT NULL,
  forumset text NOT NULL,
  commend text NOT NULL,
  PRIMARY KEY (fid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_friends;
CREATE TABLE pw_friends (
  uid mediumint(8) NOT NULL DEFAULT '0',
  friendid mediumint(8) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  joindate int(10) NOT NULL DEFAULT '0',
  descrip varchar(255) NOT NULL DEFAULT '',
  ftid mediumint(8) unsigned NOT NULL DEFAULT '0',
  iffeed tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (uid,friendid),
  KEY joindate (joindate),
  KEY ftid (ftid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_friendtype;
CREATE TABLE pw_friendtype (
  ftid mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  uid mediumint(8) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (ftid),
  KEY uid (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_hack;
CREATE TABLE pw_hack (
  hk_name varchar(30) NOT NULL DEFAULT '',
  vtype enum('string','array') NOT NULL,
  hk_value text NOT NULL,
  decrip text NOT NULL,
  PRIMARY KEY (hk_name)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_help;
CREATE TABLE pw_help (
  hid smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  hup smallint(6) unsigned NOT NULL DEFAULT '0',
  lv tinyint(2) NOT NULL DEFAULT '0',
  fathers varchar(100) NOT NULL DEFAULT '',
  ifchild tinyint(1) NOT NULL DEFAULT '0',
  title varchar(80) NOT NULL DEFAULT '',
  url varchar(80) NOT NULL DEFAULT '',
  content mediumtext NOT NULL,
  vieworder tinyint(3) NOT NULL DEFAULT '0',
  ispw tinyint(1) DEFAULT '0',
  PRIMARY KEY (hid),
  KEY hup (hup)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_invitecode;
CREATE TABLE pw_invitecode (
  id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  invcode varchar(40) NOT NULL DEFAULT '',
  uid mediumint(8) NOT NULL DEFAULT '0',
  receiver varchar(20) NOT NULL DEFAULT '',
  createtime int(10) NOT NULL DEFAULT '0',
  usetime int(10) NOT NULL DEFAULT '0',
  ifused tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  KEY uid (uid),
  KEY invcode (invcode)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_invoke;
CREATE TABLE pw_invoke (
  id smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  tplid smallint(6) NOT NULL,
  parsecode text NOT NULL,
  ifloop tinyint(1) unsigned NOT NULL DEFAULT '0',
  loops text NOT NULL,
  descrip varchar(255) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=119 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_invokepiece;
CREATE TABLE pw_invokepiece (
  id smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  invokename varchar(50) NOT NULL,
  title varchar(50) NOT NULL,
  `action` varchar(30) NOT NULL,
  func varchar(50) NOT NULL,
  num smallint(6) NOT NULL,
  rang varchar(50) NOT NULL,
  param text NOT NULL,
  cachetime int(10) unsigned NOT NULL,
  PRIMARY KEY (id),
  KEY invokename (invokename)
) ENGINE=MyISAM AUTO_INCREMENT=153 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_ipstates;
CREATE TABLE pw_ipstates (
  `day` varchar(10) NOT NULL DEFAULT '',
  `month` varchar(7) NOT NULL DEFAULT '',
  nums int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`day`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_medalinfo;
CREATE TABLE pw_medalinfo (
  id smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL DEFAULT '',
  intro varchar(255) NOT NULL DEFAULT '',
  picurl varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_medalslogs;
CREATE TABLE pw_medalslogs (
  id int(10) NOT NULL AUTO_INCREMENT,
  awardee varchar(40) NOT NULL DEFAULT '',
  awarder varchar(40) NOT NULL DEFAULT '',
  awardtime int(10) NOT NULL DEFAULT '0',
  timelimit tinyint(2) NOT NULL DEFAULT '0',
  state tinyint(1) NOT NULL DEFAULT '0',
  `level` smallint(6) NOT NULL DEFAULT '0',
  `action` tinyint(1) NOT NULL DEFAULT '0',
  why varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  KEY awardee (awardee)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_medaluser;
CREATE TABLE pw_medaluser (
  id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  uid mediumint(8) unsigned NOT NULL,
  mid smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  KEY uid (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_membercredit;
CREATE TABLE pw_membercredit (
  uid mediumint(8) unsigned NOT NULL DEFAULT '0',
  cid tinyint(3) NOT NULL DEFAULT '0',
  `value` mediumint(8) NOT NULL DEFAULT '0',
  KEY uid (uid),
  KEY cid (cid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_memberdata;
CREATE TABLE pw_memberdata (
  uid mediumint(8) unsigned NOT NULL DEFAULT '1',
  postnum int(10) unsigned NOT NULL DEFAULT '0',
  digests smallint(6) NOT NULL DEFAULT '0',
  rvrc int(10) NOT NULL DEFAULT '0',
  money int(10) NOT NULL DEFAULT '0',
  credit int(10) NOT NULL DEFAULT '0',
  currency int(10) NOT NULL DEFAULT '0',
  lastvisit int(10) unsigned NOT NULL DEFAULT '0',
  thisvisit int(10) unsigned NOT NULL DEFAULT '0',
  lastpost int(10) unsigned NOT NULL DEFAULT '0',
  onlinetime int(10) unsigned NOT NULL DEFAULT '0',
  monoltime int(10) unsigned NOT NULL DEFAULT '0',
  todaypost smallint(6) unsigned NOT NULL DEFAULT '0',
  monthpost smallint(6) unsigned NOT NULL DEFAULT '0',
  uploadtime int(10) unsigned NOT NULL DEFAULT '0',
  uploadnum smallint(6) unsigned NOT NULL DEFAULT '0',
  onlineip varchar(30) NOT NULL DEFAULT '',
  starttime int(10) unsigned NOT NULL DEFAULT '0',
  postcheck varchar(16) NOT NULL DEFAULT '',
  pwdctime int(10) unsigned NOT NULL DEFAULT '0',
  f_num int(10) unsigned NOT NULL DEFAULT '0',
  creditpop varchar(150) NOT NULL DEFAULT '',
  PRIMARY KEY (uid),
  KEY postnum (postnum)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_memberinfo;
CREATE TABLE pw_memberinfo (
  uid mediumint(8) unsigned NOT NULL DEFAULT '1',
  adsips mediumtext NOT NULL,
  credit text NOT NULL,
  deposit int(10) NOT NULL DEFAULT '0',
  startdate int(10) NOT NULL DEFAULT '0',
  ddeposit int(10) NOT NULL DEFAULT '0',
  dstartdate int(10) NOT NULL DEFAULT '0',
  regreason varchar(255) NOT NULL DEFAULT '',
  readmsg mediumtext NOT NULL,
  delmsg mediumtext NOT NULL,
  tooltime varchar(42) NOT NULL DEFAULT '',
  replyinfo varchar(81) NOT NULL DEFAULT '',
  lasttime int(10) NOT NULL DEFAULT '0',
  digtid text NOT NULL,
  customdata text NOT NULL,
  tradeinfo text NOT NULL,
  field_1 varchar(255) NOT NULL,
  PRIMARY KEY (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_members;
CREATE TABLE pw_members (
  uid mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  username varchar(15) NOT NULL DEFAULT '',
  `password` varchar(40) NOT NULL DEFAULT '',
  safecv varchar(10) NOT NULL DEFAULT '',
  email varchar(60) NOT NULL DEFAULT '',
  groupid tinyint(3) NOT NULL DEFAULT '-1',
  memberid tinyint(3) NOT NULL DEFAULT '0',
  groups varchar(255) NOT NULL DEFAULT '',
  icon varchar(255) NOT NULL DEFAULT '',
  gender tinyint(1) NOT NULL DEFAULT '0',
  regdate int(10) unsigned NOT NULL DEFAULT '0',
  signature text NOT NULL,
  introduce text NOT NULL,
  oicq varchar(12) NOT NULL DEFAULT '',
  aliww varchar(30) NOT NULL,
  icq varchar(12) NOT NULL DEFAULT '',
  msn varchar(35) NOT NULL DEFAULT '',
  yahoo varchar(35) NOT NULL DEFAULT '',
  site varchar(75) NOT NULL DEFAULT '',
  location varchar(36) NOT NULL DEFAULT '',
  honor varchar(100) NOT NULL DEFAULT '',
  bday date NOT NULL DEFAULT '0000-00-00',
  lastaddrst varchar(255) NOT NULL DEFAULT '',
  yz int(10) NOT NULL DEFAULT '1',
  timedf varchar(5) NOT NULL DEFAULT '',
  style varchar(12) NOT NULL DEFAULT '',
  datefm varchar(15) NOT NULL DEFAULT '',
  t_num tinyint(3) unsigned NOT NULL DEFAULT '0',
  p_num tinyint(3) unsigned NOT NULL DEFAULT '0',
  attach varchar(50) NOT NULL DEFAULT '',
  hack varchar(255) NOT NULL DEFAULT '0',
  newpm smallint(6) unsigned NOT NULL DEFAULT '0',
  banpm text NOT NULL,
  msggroups varchar(255) NOT NULL DEFAULT '',
  medals varchar(255) NOT NULL DEFAULT '',
  userstatus int(10) unsigned NOT NULL DEFAULT '0',
  shortcut varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (uid),
  UNIQUE KEY username (username),
  KEY groupid (groupid),
  KEY email (email)
) ENGINE=MyISAM AUTO_INCREMENT=205 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_memo;
CREATE TABLE pw_memo (
  mid int(10) unsigned NOT NULL AUTO_INCREMENT,
  username varchar(15) NOT NULL,
  postdate int(10) NOT NULL DEFAULT '0',
  content text NOT NULL,
  isuser tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (mid),
  KEY isuser (isuser,username)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_modehot;
CREATE TABLE pw_modehot (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  parent_id int(10) unsigned DEFAULT NULL,
  sort tinyint(2) NOT NULL DEFAULT '1',
  tag varchar(20) DEFAULT NULL,
  type_name varchar(100) NOT NULL,
  filter_type text NOT NULL,
  filter_time text NOT NULL,
  display char(2) NOT NULL DEFAULT '0',
  active char(2) NOT NULL DEFAULT '0',
  remark varchar(100) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_mpageconfig;
CREATE TABLE pw_mpageconfig (
  id smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `mode` varchar(20) NOT NULL,
  scr varchar(20) NOT NULL,
  fid smallint(6) unsigned NOT NULL,
  invokes text NOT NULL,
  config text NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY `mode` (`mode`,scr,fid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_msg;
CREATE TABLE pw_msg (
  mid int(10) unsigned NOT NULL AUTO_INCREMENT,
  touid mediumint(8) unsigned NOT NULL DEFAULT '0',
  togroups varchar(80) NOT NULL DEFAULT '',
  fromuid mediumint(8) unsigned NOT NULL DEFAULT '0',
  username varchar(15) NOT NULL DEFAULT '',
  `type` enum('rebox','sebox','public') NOT NULL DEFAULT 'rebox',
  ifnew tinyint(1) NOT NULL DEFAULT '0',
  mdate int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (mid),
  KEY touid (touid),
  KEY fromuid (fromuid,mdate),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_msgc;
CREATE TABLE pw_msgc (
  mid int(10) unsigned NOT NULL,
  title varchar(130) NOT NULL,
  content text NOT NULL,
  PRIMARY KEY (mid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_msglog;
CREATE TABLE pw_msglog (
  mid int(10) unsigned NOT NULL DEFAULT '0',
  uid mediumint(8) unsigned NOT NULL DEFAULT '0',
  withuid mediumint(8) unsigned NOT NULL DEFAULT '0',
  mdate int(10) unsigned NOT NULL DEFAULT '0',
  mtype enum('send','receive') NOT NULL DEFAULT 'send',
  PRIMARY KEY (mid,uid),
  KEY uid (uid,withuid,mdate)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_nav;
CREATE TABLE pw_nav (
  nid smallint(4) NOT NULL AUTO_INCREMENT,
  nkey varchar(32) NOT NULL,
  `type` varchar(32) NOT NULL,
  title char(50) NOT NULL DEFAULT '',
  style char(50) NOT NULL DEFAULT '',
  link char(100) NOT NULL DEFAULT '',
  alt char(50) NOT NULL DEFAULT '',
  pos char(32) NOT NULL,
  target tinyint(1) NOT NULL DEFAULT '0',
  `view` smallint(4) NOT NULL DEFAULT '0',
  upid smallint(4) NOT NULL,
  isshow tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (nid)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_oboard;
CREATE TABLE pw_oboard (
  id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  uid mediumint(8) unsigned NOT NULL,
  username varchar(15) NOT NULL,
  touid mediumint(8) unsigned NOT NULL,
  title varchar(255) NOT NULL,
  postdate int(10) NOT NULL,
  c_num mediumint(8) unsigned NOT NULL DEFAULT '0',
  ifwordsfb tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (id),
  KEY touid (touid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_online;
CREATE TABLE pw_online (
  olid int(10) NOT NULL DEFAULT '0',
  username varchar(15) NOT NULL DEFAULT '',
  lastvisit int(10) NOT NULL DEFAULT '0',
  ip varchar(30) NOT NULL DEFAULT '',
  fid smallint(6) NOT NULL DEFAULT '0',
  tid mediumint(8) NOT NULL DEFAULT '0',
  groupid tinyint(3) NOT NULL DEFAULT '0',
  `action` varchar(2) NOT NULL DEFAULT '',
  ifhide tinyint(1) NOT NULL DEFAULT '0',
  uid mediumint(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (olid),
  KEY uid (uid),
  KEY ip (ip)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_ouserdata;
CREATE TABLE pw_ouserdata (
  uid int(10) unsigned NOT NULL,
  index_privacy tinyint(1) unsigned NOT NULL DEFAULT '0',
  profile_privacy tinyint(1) unsigned NOT NULL DEFAULT '0',
  info_privacy tinyint(1) unsigned NOT NULL DEFAULT '0',
  credit_privacy tinyint(1) unsigned NOT NULL DEFAULT '0',
  owrite_privacy tinyint(1) unsigned NOT NULL DEFAULT '0',
  msgboard_privacy tinyint(1) unsigned NOT NULL DEFAULT '0',
  photos_privacy tinyint(1) unsigned NOT NULL DEFAULT '0',
  diary_privacy tinyint(1) unsigned NOT NULL DEFAULT '0',
  article_isfeed tinyint(1) unsigned NOT NULL DEFAULT '1',
  write_isfeed tinyint(1) unsigned NOT NULL DEFAULT '1',
  diary_isfeed tinyint(1) unsigned NOT NULL DEFAULT '1',
  share_isfeed tinyint(1) unsigned NOT NULL DEFAULT '1',
  photos_isfeed tinyint(1) unsigned NOT NULL DEFAULT '1',
  visits int(10) unsigned NOT NULL DEFAULT '0',
  tovisits int(10) unsigned NOT NULL DEFAULT '0',
  tovisit varchar(255) NOT NULL,
  whovisit varchar(255) NOT NULL,
  diarynum int(10) unsigned NOT NULL DEFAULT '0',
  photonum int(10) unsigned NOT NULL DEFAULT '0',
  owritenum int(10) unsigned NOT NULL DEFAULT '0',
  groupnum int(10) unsigned NOT NULL DEFAULT '0',
  sharenum int(10) unsigned NOT NULL DEFAULT '0',
  diary_lastpost int(10) unsigned NOT NULL DEFAULT '0',
  photo_lastpost int(10) unsigned NOT NULL DEFAULT '0',
  owrite_lastpost int(10) unsigned NOT NULL DEFAULT '0',
  group_lastpost int(10) unsigned NOT NULL DEFAULT '0',
  share_lastpost int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_owritedata;
CREATE TABLE pw_owritedata (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  uid int(10) unsigned NOT NULL,
  touid int(10) unsigned NOT NULL,
  postdate int(10) unsigned NOT NULL,
  isshare tinyint(1) unsigned NOT NULL DEFAULT '0',
  `source` varchar(10) NOT NULL,
  content varchar(255) NOT NULL,
  c_num mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (id),
  KEY uid (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_pcfield;
CREATE TABLE pw_pcfield (
  fieldid smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  fieldname varchar(30) NOT NULL,
  pcid smallint(6) unsigned NOT NULL,
  vieworder tinyint(3) NOT NULL,
  `type` varchar(20) NOT NULL,
  rules mediumtext NOT NULL,
  ifable tinyint(1) NOT NULL DEFAULT '1',
  ifsearch tinyint(1) NOT NULL DEFAULT '0',
  ifasearch tinyint(1) NOT NULL DEFAULT '0',
  threadshow tinyint(1) NOT NULL DEFAULT '0',
  ifmust tinyint(1) NOT NULL DEFAULT '1',
  ifdel tinyint(1) NOT NULL DEFAULT '0',
  textsize tinyint(3) NOT NULL DEFAULT '0',
  descrip varchar(255) NOT NULL,
  PRIMARY KEY (fieldid),
  KEY pcid (pcid)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_pcmember;
CREATE TABLE pw_pcmember (
  pcmid mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  tid mediumint(8) unsigned NOT NULL,
  uid mediumint(8) unsigned NOT NULL,
  pcid tinyint(3) unsigned NOT NULL,
  username varchar(15) NOT NULL,
  nums tinyint(3) unsigned NOT NULL,
  totalcash int(10) NOT NULL,
  phone varchar(15) NOT NULL,
  mobile varchar(15) NOT NULL,
  address varchar(255) NOT NULL,
  extra varchar(10) NOT NULL,
  ifpay tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (pcmid),
  KEY tid (tid,uid),
  KEY uid (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_pcvalue1;
CREATE TABLE pw_pcvalue1 (
  tid mediumint(8) unsigned NOT NULL DEFAULT '0',
  fid smallint(6) unsigned NOT NULL DEFAULT '0',
  pctype tinyint(3) unsigned NOT NULL DEFAULT '0',
  begintime int(10) unsigned NOT NULL DEFAULT '0',
  endtime int(10) unsigned NOT NULL DEFAULT '0',
  limitnum int(10) unsigned NOT NULL DEFAULT '0',
  objecter tinyint(3) unsigned NOT NULL DEFAULT '0',
  price varchar(255) NOT NULL,
  deposit varchar(255) NOT NULL,
  payway tinyint(3) unsigned NOT NULL DEFAULT '0',
  contacter varchar(255) NOT NULL,
  tel varchar(255) NOT NULL,
  phone varchar(255) NOT NULL,
  mobile varchar(255) NOT NULL,
  pcattach varchar(255) NOT NULL,
  PRIMARY KEY (tid),
  KEY fid (fid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_pcvalue2;
CREATE TABLE pw_pcvalue2 (
  tid mediumint(8) unsigned NOT NULL DEFAULT '0',
  fid smallint(6) unsigned NOT NULL DEFAULT '0',
  pctype tinyint(3) unsigned NOT NULL DEFAULT '0',
  begintime int(10) unsigned NOT NULL DEFAULT '0',
  endtime int(10) unsigned NOT NULL DEFAULT '0',
  address varchar(255) NOT NULL,
  limitnum int(10) unsigned NOT NULL DEFAULT '0',
  objecter tinyint(3) unsigned NOT NULL DEFAULT '0',
  gender tinyint(3) unsigned NOT NULL DEFAULT '0',
  price varchar(255) NOT NULL,
  deposit varchar(255) NOT NULL,
  payway tinyint(3) unsigned NOT NULL DEFAULT '0',
  contacter varchar(255) NOT NULL,
  tel varchar(255) NOT NULL,
  phone varchar(255) NOT NULL,
  mobile varchar(255) NOT NULL,
  pcattach varchar(255) NOT NULL,
  PRIMARY KEY (tid),
  KEY fid (fid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_permission;
CREATE TABLE pw_permission (
  uid mediumint(8) unsigned NOT NULL,
  fid smallint(6) unsigned NOT NULL,
  gid smallint(6) unsigned NOT NULL,
  rkey varchar(20) NOT NULL,
  `type` enum('basic','special','system','systemforum') NOT NULL,
  rvalue text NOT NULL,
  PRIMARY KEY (uid,fid,gid,rkey),
  KEY rkey (rkey)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_pidtmp;
CREATE TABLE pw_pidtmp (
  pid int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (pid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_pinglog;
CREATE TABLE pw_pinglog (
  id mediumint(8) NOT NULL AUTO_INCREMENT,
  fid smallint(6) NOT NULL DEFAULT '0',
  tid mediumint(8) NOT NULL DEFAULT '0',
  pid int(10) NOT NULL DEFAULT '0',
  `name` varchar(15) NOT NULL,
  `point` varchar(10) NOT NULL,
  pinger varchar(15) NOT NULL,
  record mediumtext NOT NULL,
  pingdate int(10) NOT NULL DEFAULT '0',
  ifhide tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  KEY tid (tid),
  KEY pid (pid),
  KEY fid (fid,tid,pid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_plan;
CREATE TABLE pw_plan (
  id smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `subject` varchar(80) NOT NULL DEFAULT '',
  `month` varchar(2) NOT NULL DEFAULT '',
  `week` varchar(1) NOT NULL DEFAULT '',
  `day` varchar(2) NOT NULL DEFAULT '',
  `hour` varchar(80) NOT NULL DEFAULT '',
  usetime int(10) NOT NULL DEFAULT '0',
  nexttime int(10) NOT NULL DEFAULT '0',
  ifsave tinyint(1) NOT NULL DEFAULT '0',
  ifopen tinyint(1) NOT NULL DEFAULT '0',
  filename varchar(80) NOT NULL DEFAULT '',
  config text NOT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_polls;
CREATE TABLE pw_polls (
  pollid int(10) unsigned NOT NULL AUTO_INCREMENT,
  tid mediumint(8) unsigned NOT NULL DEFAULT '0',
  voteopts mediumtext NOT NULL,
  modifiable tinyint(1) NOT NULL DEFAULT '0',
  previewable tinyint(1) NOT NULL DEFAULT '0',
  multiple tinyint(1) unsigned NOT NULL,
  mostvotes smallint(6) unsigned NOT NULL,
  voters mediumint(8) unsigned NOT NULL,
  timelimit int(3) NOT NULL DEFAULT '0',
  leastvotes int(3) unsigned NOT NULL,
  regdatelimit int(10) unsigned NOT NULL,
  creditlimit varchar(255) NOT NULL,
  postnumlimit int(10) unsigned NOT NULL,
  PRIMARY KEY (pollid),
  KEY tid (tid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_postcate;
CREATE TABLE pw_postcate (
  pcid tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  ifable tinyint(1) NOT NULL DEFAULT '1',
  vieworder tinyint(3) NOT NULL,
  viewright varchar(255) NOT NULL,
  adminright varchar(255) NOT NULL,
  PRIMARY KEY (pcid)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_posts;
CREATE TABLE pw_posts (
  pid int(10) unsigned NOT NULL AUTO_INCREMENT,
  fid smallint(6) unsigned NOT NULL DEFAULT '0',
  tid mediumint(8) unsigned NOT NULL DEFAULT '0',
  aid smallint(6) unsigned NOT NULL DEFAULT '0',
  author varchar(15) NOT NULL DEFAULT '',
  authorid mediumint(8) unsigned NOT NULL DEFAULT '0',
  icon tinyint(2) NOT NULL DEFAULT '0',
  postdate int(10) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(100) NOT NULL DEFAULT '',
  userip varchar(15) NOT NULL DEFAULT '',
  ifsign tinyint(1) NOT NULL DEFAULT '0',
  buy text NOT NULL,
  alterinfo varchar(50) NOT NULL DEFAULT '',
  remindinfo varchar(150) NOT NULL DEFAULT '',
  leaveword varchar(255) NOT NULL DEFAULT '',
  ipfrom varchar(255) NOT NULL DEFAULT '',
  ifconvert tinyint(1) NOT NULL DEFAULT '1',
  ifwordsfb tinyint(1) NOT NULL DEFAULT '1',
  ifcheck tinyint(1) NOT NULL DEFAULT '0',
  content mediumtext NOT NULL,
  ifmark varchar(255) NOT NULL DEFAULT '',
  ifreward tinyint(1) NOT NULL DEFAULT '0',
  ifshield tinyint(1) unsigned NOT NULL DEFAULT '0',
  anonymous tinyint(1) NOT NULL DEFAULT '0',
  ifhide tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (pid),
  KEY fid (fid),
  KEY postdate (postdate),
  KEY tid (tid,postdate),
  KEY authorid (authorid),
  KEY ifcheck (ifcheck)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_postsfloor;
CREATE TABLE pw_postsfloor (
  id int(20) unsigned NOT NULL AUTO_INCREMENT,
  tid int(20) NOT NULL DEFAULT '0',
  pid int(20) NOT NULL DEFAULT '0',
  floor int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  UNIQUE KEY tid (tid,floor)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_proclock;
CREATE TABLE pw_proclock (
  uid mediumint(8) unsigned NOT NULL,
  `action` varchar(20) NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY (uid,`action`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_pushdata;
CREATE TABLE pw_pushdata (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  invokepieceid smallint(6) unsigned NOT NULL,
  fid smallint(6) unsigned NOT NULL DEFAULT '0',
  loopid smallint(6) unsigned NOT NULL DEFAULT '0',
  uid int(10) unsigned NOT NULL,
  starttime int(10) unsigned NOT NULL,
  endtime int(10) unsigned NOT NULL,
  `offset` tinyint(1) unsigned NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (id),
  KEY invokepieceid (invokepieceid,fid,loopid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_rate;
CREATE TABLE pw_rate (
  objectid int(10) NOT NULL DEFAULT '0',
  optionid smallint(6) NOT NULL DEFAULT '0',
  typeid smallint(6) NOT NULL DEFAULT '0',
  uid mediumint(8) NOT NULL DEFAULT '0',
  created_at int(10) NOT NULL DEFAULT '0',
  ip varchar(15) NOT NULL,
  KEY idx_tid_oid_uid (typeid,objectid,uid),
  KEY idx_tid_time (typeid,created_at,optionid,objectid),
  KEY idx_uid_time (uid,created_at)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_rateconfig;
CREATE TABLE pw_rateconfig (
  id int(11) NOT NULL AUTO_INCREMENT,
  title varchar(12) NOT NULL,
  icon varchar(75) NOT NULL,
  isopen tinyint(1) NOT NULL DEFAULT '1',
  isdefault tinyint(1) NOT NULL DEFAULT '0',
  typeid tinyint(1) NOT NULL DEFAULT '0',
  creditset tinyint(1) NOT NULL DEFAULT '0',
  voternum tinyint(1) NOT NULL DEFAULT '0',
  authornum tinyint(1) NOT NULL DEFAULT '0',
  creator varchar(20) DEFAULT NULL,
  created_at int(10) DEFAULT NULL,
  updater varchar(20) DEFAULT NULL,
  update_at int(10) DEFAULT NULL,
  PRIMARY KEY (id),
  KEY idx_type_id (typeid)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_rateresult;
CREATE TABLE pw_rateresult (
  id int(10) NOT NULL AUTO_INCREMENT,
  objectid int(10) NOT NULL DEFAULT '0',
  optionid smallint(6) NOT NULL DEFAULT '0',
  typeid tinyint(1) NOT NULL DEFAULT '0',
  num int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  KEY idx_oid (optionid,objectid),
  KEY idx_tid (typeid,objectid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_recycle;
CREATE TABLE pw_recycle (
  pid int(10) unsigned NOT NULL DEFAULT '0',
  tid mediumint(8) unsigned NOT NULL DEFAULT '0',
  fid smallint(6) unsigned NOT NULL DEFAULT '0',
  deltime int(10) unsigned NOT NULL DEFAULT '0',
  admin varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (pid,tid),
  KEY tid (tid),
  KEY fid (fid,pid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_report;
CREATE TABLE pw_report (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  tid mediumint(8) unsigned NOT NULL DEFAULT '0',
  pid int(10) unsigned NOT NULL DEFAULT '0',
  uid mediumint(9) NOT NULL DEFAULT '0',
  `type` varchar(50) NOT NULL DEFAULT '0',
  state tinyint(1) unsigned NOT NULL DEFAULT '0',
  reason varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_reward;
CREATE TABLE pw_reward (
  tid mediumint(8) NOT NULL,
  cbtype varchar(20) NOT NULL,
  catype varchar(20) NOT NULL,
  cbval int(10) NOT NULL,
  caval int(10) NOT NULL,
  timelimit int(10) NOT NULL,
  author varchar(30) NOT NULL,
  pid mediumint(8) NOT NULL,
  PRIMARY KEY (tid),
  KEY timelimit (timelimit)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_schcache;
CREATE TABLE pw_schcache (
  sid mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  sorderby varchar(13) NOT NULL DEFAULT '',
  schline varchar(32) NOT NULL DEFAULT '',
  schtime int(10) unsigned NOT NULL DEFAULT '0',
  total mediumint(8) unsigned NOT NULL DEFAULT '0',
  schedid text NOT NULL,
  PRIMARY KEY (sid),
  KEY schline (schline)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_setform;
CREATE TABLE pw_setform (
  id int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  ifopen tinyint(1) NOT NULL DEFAULT '0',
  `value` text NOT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_share;
CREATE TABLE pw_share (
  id mediumint(8) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL,
  uid mediumint(8) NOT NULL,
  username varchar(15) NOT NULL,
  postdate int(10) NOT NULL,
  content text NOT NULL,
  ifhidden tinyint(1) unsigned NOT NULL DEFAULT '0',
  c_num mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  KEY uid (uid,postdate)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_sharelinks;
CREATE TABLE pw_sharelinks (
  sid smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  threadorder tinyint(3) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '',
  url varchar(100) NOT NULL DEFAULT '',
  descrip varchar(200) NOT NULL DEFAULT '0',
  logo varchar(100) NOT NULL DEFAULT '',
  ifcheck tinyint(1) NOT NULL DEFAULT '0',
  username varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (sid)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_singleright;
CREATE TABLE pw_singleright (
  uid mediumint(8) unsigned NOT NULL DEFAULT '0',
  visit varchar(80) NOT NULL DEFAULT '',
  post varchar(80) NOT NULL DEFAULT '',
  reply varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_smiles;
CREATE TABLE pw_smiles (
  id smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  path varchar(20) NOT NULL DEFAULT '',
  `name` varchar(20) NOT NULL DEFAULT '',
  descipt varchar(100) NOT NULL DEFAULT '',
  vieworder tinyint(2) NOT NULL DEFAULT '0',
  `type` smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_sqlcv;
CREATE TABLE pw_sqlcv (
  id int(10) NOT NULL AUTO_INCREMENT,
  var varchar(20) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_stamp;
CREATE TABLE pw_stamp (
  sid smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  stamp varchar(30) NOT NULL,
  init smallint(6) NOT NULL,
  iflock tinyint(1) unsigned NOT NULL DEFAULT '0',
  iffid tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (sid),
  UNIQUE KEY stamp (stamp)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_stopic;
CREATE TABLE pw_stopic (
  stopic_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  title varchar(50) NOT NULL DEFAULT '',
  category_id int(10) unsigned NOT NULL DEFAULT '0',
  bg_id int(10) NOT NULL DEFAULT '0',
  copy_from int(10) unsigned NOT NULL DEFAULT '0',
  layout varchar(20) NOT NULL DEFAULT '',
  create_date int(10) unsigned NOT NULL DEFAULT '0',
  start_date int(10) unsigned NOT NULL DEFAULT '0',
  end_date int(10) unsigned NOT NULL DEFAULT '0',
  used_count mediumint(8) unsigned NOT NULL DEFAULT '0',
  view_count int(10) unsigned NOT NULL DEFAULT '0',
  banner_url varchar(100) NOT NULL DEFAULT '',
  seo_keyword varchar(255) NOT NULL DEFAULT '',
  seo_desc varchar(255) NOT NULL DEFAULT '',
  block_config text NOT NULL,
  layout_config text NOT NULL,
  nav_config text NOT NULL,
  PRIMARY KEY (stopic_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_stopicblock;
CREATE TABLE pw_stopicblock (
  block_id smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  tagcode text NOT NULL,
  `begin` text NOT NULL,
  loops text NOT NULL,
  `end` text NOT NULL,
  config varchar(255) NOT NULL,
  replacetag varchar(255) NOT NULL,
  PRIMARY KEY (block_id)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_stopiccategory;
CREATE TABLE pw_stopiccategory (
  id smallint(6) NOT NULL AUTO_INCREMENT,
  title varchar(45) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  num smallint(6) NOT NULL DEFAULT '0',
  creator varchar(20) DEFAULT NULL,
  createtime int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_stopicpictures;
CREATE TABLE pw_stopicpictures (
  id int(10) NOT NULL AUTO_INCREMENT,
  categoryid smallint(6) NOT NULL DEFAULT '0',
  title varchar(45) NOT NULL,
  path varchar(255) NOT NULL,
  num smallint(6) NOT NULL DEFAULT '0',
  creator varchar(20) DEFAULT NULL,
  createtime int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_stopicunit;
CREATE TABLE pw_stopicunit (
  unit_id int(10) unsigned NOT NULL AUTO_INCREMENT,
  stopic_id int(10) unsigned NOT NULL,
  html_id varchar(50) NOT NULL,
  block_id smallint(6) unsigned NOT NULL,
  title varchar(255) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (unit_id),
  UNIQUE KEY stopic_id (stopic_id,html_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_styles;
CREATE TABLE pw_styles (
  sid smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  uid mediumint(8) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  customname varchar(50) NOT NULL DEFAULT '',
  createtime int(10) NOT NULL,
  lastmodify int(10) NOT NULL,
  ifopen tinyint(1) NOT NULL DEFAULT '0',
  stylepath varchar(50) NOT NULL DEFAULT '',
  tplpath varchar(50) NOT NULL DEFAULT '',
  yeyestyle varchar(3) NOT NULL DEFAULT '',
  bgcolor varchar(100) NOT NULL,
  linkcolor varchar(7) NOT NULL,
  tablecolor varchar(7) NOT NULL DEFAULT '',
  tdcolor varchar(7) NOT NULL,
  tablewidth varchar(7) NOT NULL,
  mtablewidth varchar(7) NOT NULL,
  headcolor varchar(100) NOT NULL,
  headborder varchar(7) NOT NULL,
  headfontone varchar(7) NOT NULL,
  headfonttwo varchar(7) NOT NULL,
  cbgcolor varchar(100) NOT NULL,
  cbgborder varchar(7) NOT NULL,
  cbgfont varchar(7) NOT NULL,
  forumcolorone varchar(7) NOT NULL DEFAULT '',
  forumcolortwo varchar(7) NOT NULL DEFAULT '',
  extcss text NOT NULL,
  PRIMARY KEY (sid),
  KEY uid (uid)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_tagdata;
CREATE TABLE pw_tagdata (
  tagid mediumint(8) NOT NULL DEFAULT '0',
  tid mediumint(8) NOT NULL DEFAULT '0',
  KEY tagid (tagid),
  KEY tid (tid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_tags;
CREATE TABLE pw_tags (
  tagid mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  tagname varchar(15) NOT NULL DEFAULT '',
  num mediumint(8) NOT NULL DEFAULT '0',
  ifhot tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (tagid),
  KEY num (ifhot,num),
  KEY tagname (tagname)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_threads;
CREATE TABLE pw_threads (
  tid mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  fid smallint(6) unsigned NOT NULL DEFAULT '0',
  icon tinyint(2) NOT NULL DEFAULT '0',
  titlefont varchar(15) NOT NULL DEFAULT '',
  author varchar(15) NOT NULL DEFAULT '',
  authorid mediumint(8) unsigned NOT NULL DEFAULT '0',
  `subject` varchar(100) NOT NULL DEFAULT '',
  toolinfo varchar(16) NOT NULL DEFAULT '',
  toolfield varchar(21) NOT NULL DEFAULT '',
  ifcheck tinyint(1) NOT NULL DEFAULT '0',
  `type` smallint(6) NOT NULL DEFAULT '0',
  postdate int(10) unsigned NOT NULL DEFAULT '0',
  lastpost int(10) unsigned NOT NULL DEFAULT '0',
  lastposter varchar(15) NOT NULL DEFAULT '',
  hits int(10) unsigned NOT NULL DEFAULT '0',
  replies int(10) unsigned NOT NULL DEFAULT '0',
  favors int(10) NOT NULL DEFAULT '0',
  modelid smallint(6) unsigned NOT NULL,
  shares mediumint(8) unsigned NOT NULL DEFAULT '0',
  topped smallint(6) NOT NULL DEFAULT '0',
  locked tinyint(1) NOT NULL DEFAULT '0',
  digest tinyint(1) NOT NULL DEFAULT '0',
  special tinyint(1) NOT NULL DEFAULT '0',
  state tinyint(1) NOT NULL DEFAULT '0',
  ifupload tinyint(1) NOT NULL DEFAULT '0',
  ifmail tinyint(1) NOT NULL DEFAULT '0',
  ifmark smallint(6) NOT NULL DEFAULT '0',
  ifshield tinyint(1) NOT NULL DEFAULT '0',
  anonymous tinyint(1) NOT NULL DEFAULT '0',
  dig int(10) NOT NULL DEFAULT '0',
  fight int(10) NOT NULL DEFAULT '0',
  ptable tinyint(3) NOT NULL DEFAULT '0',
  ifmagic tinyint(1) NOT NULL DEFAULT '0',
  ifhide tinyint(1) NOT NULL DEFAULT '0',
  inspect varchar(30) NOT NULL DEFAULT '',
  cateid tinyint(3) unsigned NOT NULL,
  tpcstatus int(10) unsigned NOT NULL,
  PRIMARY KEY (tid),
  KEY authorid (authorid),
  KEY postdate (postdate),
  KEY digest (digest),
  KEY `type` (fid,`type`,ifcheck),
  KEY special (special),
  KEY lastpost (fid,ifcheck,topped,lastpost)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_tmsgs;
CREATE TABLE pw_tmsgs (
  tid mediumint(8) unsigned NOT NULL DEFAULT '0',
  aid smallint(6) unsigned NOT NULL DEFAULT '0',
  userip varchar(15) NOT NULL DEFAULT '',
  ifsign tinyint(1) NOT NULL DEFAULT '0',
  buy text NOT NULL,
  ipfrom varchar(255) NOT NULL DEFAULT '',
  alterinfo varchar(50) NOT NULL DEFAULT '',
  remindinfo varchar(150) NOT NULL DEFAULT '',
  tags varchar(100) NOT NULL DEFAULT '',
  ifconvert tinyint(1) NOT NULL DEFAULT '1',
  ifwordsfb tinyint(1) NOT NULL DEFAULT '1',
  content mediumtext NOT NULL,
  form varchar(30) NOT NULL DEFAULT '',
  ifmark varchar(255) NOT NULL DEFAULT '',
  c_from varchar(30) NOT NULL DEFAULT '',
  magic varchar(50) NOT NULL,
  PRIMARY KEY (tid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_toollog;
CREATE TABLE pw_toollog (
  id int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(10) NOT NULL DEFAULT '',
  nums smallint(6) NOT NULL DEFAULT '0',
  money smallint(6) NOT NULL DEFAULT '0',
  descrip varchar(255) NOT NULL DEFAULT '',
  uid mediumint(8) unsigned NOT NULL DEFAULT '0',
  username varchar(15) NOT NULL DEFAULT '',
  ip varchar(15) NOT NULL DEFAULT '',
  `time` int(10) NOT NULL DEFAULT '0',
  filename varchar(20) NOT NULL DEFAULT '',
  touid mediumint(8) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (id),
  KEY uid (uid),
  KEY touid (touid),
  KEY `type` (`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_tools;
CREATE TABLE pw_tools (
  id smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '',
  filename varchar(20) NOT NULL DEFAULT '',
  descrip varchar(255) NOT NULL DEFAULT '',
  vieworder tinyint(3) NOT NULL DEFAULT '0',
  logo varchar(100) NOT NULL DEFAULT '',
  state tinyint(1) NOT NULL DEFAULT '0',
  price varchar(255) NOT NULL DEFAULT '',
  creditype varchar(10) NOT NULL DEFAULT '',
  rmb decimal(8,2) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0',
  stock smallint(6) NOT NULL DEFAULT '0',
  conditions text NOT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_topiccate;
CREATE TABLE pw_topiccate (
  cateid tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  ifable tinyint(1) NOT NULL DEFAULT '1',
  vieworder tinyint(3) NOT NULL,
  ifdel tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (cateid)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_topicfield;
CREATE TABLE pw_topicfield (
  fieldid smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  fieldname varchar(30) NOT NULL,
  modelid smallint(6) unsigned NOT NULL,
  vieworder tinyint(3) NOT NULL,
  `type` varchar(20) NOT NULL,
  rules mediumtext NOT NULL,
  ifable tinyint(1) NOT NULL DEFAULT '1',
  ifsearch tinyint(1) NOT NULL DEFAULT '0',
  ifasearch tinyint(1) NOT NULL DEFAULT '0',
  threadshow tinyint(1) NOT NULL DEFAULT '0',
  ifmust tinyint(1) NOT NULL DEFAULT '1',
  textsize tinyint(3) NOT NULL DEFAULT '0',
  descrip varchar(255) NOT NULL,
  PRIMARY KEY (fieldid),
  KEY modelid (modelid)
) ENGINE=MyISAM AUTO_INCREMENT=129 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_topicmodel;
CREATE TABLE pw_topicmodel (
  modelid smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  cateid tinyint(3) unsigned NOT NULL,
  ifable tinyint(1) NOT NULL DEFAULT '1',
  vieworder tinyint(3) NOT NULL,
  PRIMARY KEY (modelid),
  KEY cateid (cateid)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_topictype;
CREATE TABLE pw_topictype (
  id smallint(4) unsigned NOT NULL AUTO_INCREMENT,
  fid smallint(6) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  vieworder tinyint(3) NOT NULL DEFAULT '0',
  upid smallint(4) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_topicvalue1;
CREATE TABLE pw_topicvalue1 (
  tid mediumint(8) unsigned NOT NULL,
  fid smallint(6) unsigned NOT NULL,
  field1 varchar(255) NOT NULL,
  field2 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field3 varchar(255) NOT NULL,
  field4 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field5 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field6 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field7 int(10) unsigned NOT NULL DEFAULT '0',
  field8 int(10) unsigned NOT NULL DEFAULT '0',
  field9 int(10) unsigned NOT NULL DEFAULT '0',
  field10 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field11 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field12 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field13 varchar(255) NOT NULL,
  field14 varchar(255) NOT NULL,
  field15 varchar(255) NOT NULL,
  field16 varchar(255) NOT NULL,
  field17 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field18 varchar(255) NOT NULL,
  field19 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field20 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field21 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field22 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field23 tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (tid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_topicvalue2;
CREATE TABLE pw_topicvalue2 (
  tid mediumint(8) unsigned NOT NULL,
  fid smallint(6) unsigned NOT NULL,
  field24 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field25 varchar(255) NOT NULL,
  field26 varchar(255) NOT NULL,
  field27 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field28 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field29 int(10) unsigned NOT NULL DEFAULT '0',
  field30 int(10) unsigned NOT NULL DEFAULT '0',
  field31 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field32 int(10) unsigned NOT NULL DEFAULT '0',
  field33 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field34 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field35 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field36 int(10) unsigned NOT NULL DEFAULT '0',
  field37 int(10) unsigned NOT NULL DEFAULT '0',
  field38 varchar(255) NOT NULL,
  field39 varchar(255) NOT NULL,
  field40 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field41 varchar(255) NOT NULL,
  field42 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field43 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field44 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field45 tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (tid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_topicvalue3;
CREATE TABLE pw_topicvalue3 (
  tid mediumint(8) unsigned NOT NULL,
  fid smallint(6) unsigned NOT NULL,
  field46 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field47 varchar(255) NOT NULL,
  field48 varchar(255) NOT NULL,
  field49 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field50 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field51 int(10) unsigned NOT NULL DEFAULT '0',
  field52 int(10) unsigned NOT NULL DEFAULT '0',
  field53 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field54 int(10) unsigned NOT NULL DEFAULT '0',
  field55 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field56 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field57 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field58 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field59 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field60 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field61 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field62 int(10) unsigned NOT NULL DEFAULT '0',
  field63 int(10) unsigned NOT NULL DEFAULT '0',
  field64 varchar(255) NOT NULL,
  field65 varchar(255) NOT NULL,
  field66 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field67 varchar(255) NOT NULL,
  PRIMARY KEY (tid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_topicvalue4;
CREATE TABLE pw_topicvalue4 (
  tid mediumint(8) unsigned NOT NULL,
  fid smallint(6) unsigned NOT NULL,
  field68 varchar(255) NOT NULL,
  field69 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field70 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field71 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field72 varchar(255) NOT NULL,
  field73 varchar(255) NOT NULL,
  field74 varchar(255) NOT NULL,
  field75 varchar(255) NOT NULL,
  field76 varchar(255) NOT NULL,
  field77 varchar(255) NOT NULL,
  field78 varchar(255) NOT NULL,
  field79 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field80 varchar(255) NOT NULL,
  PRIMARY KEY (tid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_topicvalue5;
CREATE TABLE pw_topicvalue5 (
  tid mediumint(8) unsigned NOT NULL,
  fid smallint(6) unsigned NOT NULL,
  field81 varchar(255) NOT NULL,
  field82 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field83 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field84 varchar(255) NOT NULL,
  field85 varchar(255) NOT NULL,
  field86 varchar(255) NOT NULL,
  field87 varchar(255) NOT NULL,
  field88 varchar(255) NOT NULL,
  field89 varchar(255) NOT NULL,
  field90 varchar(255) NOT NULL,
  field91 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field92 varchar(255) NOT NULL,
  PRIMARY KEY (tid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_topicvalue6;
CREATE TABLE pw_topicvalue6 (
  tid mediumint(8) unsigned NOT NULL,
  fid smallint(6) unsigned NOT NULL,
  field93 varchar(255) NOT NULL,
  field94 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field95 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field96 varchar(255) NOT NULL,
  field97 varchar(255) NOT NULL,
  field98 varchar(255) NOT NULL,
  field99 varchar(255) NOT NULL,
  field100 varchar(255) NOT NULL,
  field101 varchar(255) NOT NULL,
  field102 varchar(255) NOT NULL,
  field103 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field104 varchar(255) NOT NULL,
  PRIMARY KEY (tid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_topicvalue7;
CREATE TABLE pw_topicvalue7 (
  tid mediumint(8) unsigned NOT NULL,
  fid smallint(6) unsigned NOT NULL,
  field105 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field106 varchar(255) NOT NULL,
  field107 varchar(255) NOT NULL,
  field108 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field109 int(10) unsigned NOT NULL DEFAULT '0',
  field110 varchar(255) NOT NULL,
  field111 varchar(255) NOT NULL,
  field112 varchar(255) NOT NULL,
  field113 varchar(255) NOT NULL,
  field114 varchar(255) NOT NULL,
  field115 varchar(255) NOT NULL,
  PRIMARY KEY (tid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_topicvalue8;
CREATE TABLE pw_topicvalue8 (
  tid mediumint(8) unsigned NOT NULL,
  fid smallint(6) unsigned NOT NULL,
  field116 tinyint(3) unsigned NOT NULL DEFAULT '0',
  field117 varchar(255) NOT NULL,
  field118 varchar(255) NOT NULL,
  field119 varchar(255) NOT NULL,
  field120 varchar(255) NOT NULL,
  field121 varchar(255) NOT NULL,
  field122 varchar(255) NOT NULL,
  field123 varchar(255) NOT NULL,
  field124 varchar(255) NOT NULL,
  field125 varchar(255) NOT NULL,
  field126 varchar(255) NOT NULL,
  field127 varchar(255) NOT NULL,
  field128 varchar(255) NOT NULL,
  PRIMARY KEY (tid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_tpl;
CREATE TABLE pw_tpl (
  tplid smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  descrip varchar(255) NOT NULL,
  tagcode text NOT NULL,
  image varchar(255) NOT NULL,
  PRIMARY KEY (tplid),
  KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_tpltype;
CREATE TABLE pw_tpltype (
  id smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY `type` (`type`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_trade;
CREATE TABLE pw_trade (
  tid mediumint(8) unsigned NOT NULL,
  uid mediumint(8) unsigned NOT NULL,
  `name` varchar(80) NOT NULL,
  icon varchar(80) NOT NULL,
  degree tinyint(1) unsigned NOT NULL,
  `type` smallint(6) unsigned NOT NULL,
  num smallint(6) unsigned NOT NULL,
  salenum smallint(6) unsigned NOT NULL,
  price decimal(8,2) NOT NULL,
  costprice decimal(8,2) NOT NULL,
  locus varchar(30) NOT NULL,
  paymethod tinyint(3) unsigned NOT NULL,
  transport tinyint(1) unsigned NOT NULL,
  mailfee decimal(4,2) NOT NULL,
  expressfee decimal(4,2) NOT NULL,
  emsfee decimal(4,2) NOT NULL,
  deadline int(10) unsigned NOT NULL,
  PRIMARY KEY (tid),
  KEY uid (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_tradeorder;
CREATE TABLE pw_tradeorder (
  oid mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  order_no varchar(30) NOT NULL,
  tid mediumint(8) unsigned NOT NULL,
  `subject` varchar(80) NOT NULL,
  buyer mediumint(8) unsigned NOT NULL,
  seller mediumint(8) unsigned NOT NULL,
  price decimal(6,2) NOT NULL,
  quantity smallint(6) unsigned NOT NULL,
  transportfee decimal(4,2) NOT NULL,
  transport tinyint(1) unsigned NOT NULL,
  buydate int(10) unsigned NOT NULL,
  tradedate int(10) unsigned NOT NULL,
  ifpay tinyint(1) NOT NULL,
  address varchar(80) NOT NULL,
  consignee varchar(15) NOT NULL,
  tel varchar(15) NOT NULL,
  zip varchar(15) NOT NULL,
  descrip varchar(255) NOT NULL,
  payment tinyint(1) unsigned NOT NULL,
  tradeinfo varchar(255) NOT NULL,
  PRIMARY KEY (oid),
  UNIQUE KEY order_no (order_no),
  KEY tid (tid),
  KEY buyer (buyer),
  KEY seller (seller)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_ucapp;
CREATE TABLE pw_ucapp (
  id smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  siteurl varchar(50) NOT NULL,
  secretkey varchar(40) NOT NULL,
  interface varchar(30) NOT NULL,
  uc tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_ucnotify;
CREATE TABLE pw_ucnotify (
  nid mediumint(8) NOT NULL AUTO_INCREMENT,
  `action` varchar(20) NOT NULL,
  param text NOT NULL,
  `timestamp` int(10) unsigned NOT NULL,
  complete tinyint(3) unsigned NOT NULL,
  priority tinyint(3) NOT NULL,
  PRIMARY KEY (nid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_ucsyncredit;
CREATE TABLE pw_ucsyncredit (
  uid mediumint(8) unsigned NOT NULL,
  PRIMARY KEY (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_userapp;
CREATE TABLE pw_userapp (
  uid mediumint(8) unsigned NOT NULL,
  appid mediumint(8) unsigned NOT NULL,
  appname varchar(20) NOT NULL,
  allowfeed tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (uid,appid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_usercache;
CREATE TABLE pw_usercache (
  uid int(10) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  typeid int(10) unsigned NOT NULL,
  expire int(10) unsigned NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (uid,`type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_usergroups;
CREATE TABLE pw_usergroups (
  gid smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  gptype enum('default','member','system','special') NOT NULL DEFAULT 'member',
  grouptitle varchar(60) NOT NULL DEFAULT '',
  groupimg varchar(15) NOT NULL DEFAULT '',
  grouppost int(10) NOT NULL DEFAULT '0',
  ifdefault tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (gid),
  KEY gptype (gptype),
  KEY grouppost (grouppost)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_usertool;
CREATE TABLE pw_usertool (
  uid mediumint(8) unsigned NOT NULL DEFAULT '0',
  toolid smallint(6) NOT NULL DEFAULT '0',
  nums smallint(6) NOT NULL DEFAULT '0',
  sellnums smallint(6) NOT NULL DEFAULT '0',
  sellprice varchar(255) NOT NULL DEFAULT '',
  sellstatus tinyint(1) unsigned NOT NULL DEFAULT '1',
  KEY uid (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_voter;
CREATE TABLE pw_voter (
  tid mediumint(8) unsigned NOT NULL,
  uid mediumint(8) unsigned NOT NULL,
  username varchar(15) NOT NULL,
  vote tinyint(3) unsigned NOT NULL,
  `time` int(10) unsigned NOT NULL,
  KEY tid (tid),
  KEY uid (uid)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_windcode;
CREATE TABLE pw_windcode (
  id smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL DEFAULT '',
  icon varchar(30) NOT NULL DEFAULT '',
  pattern varchar(30) NOT NULL DEFAULT '',
  replacement text NOT NULL,
  param tinyint(1) NOT NULL DEFAULT '0',
  ifopen tinyint(1) NOT NULL DEFAULT '0',
  title varchar(30) NOT NULL DEFAULT '',
  descrip varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS pw_wordfb;
CREATE TABLE pw_wordfb (
  id smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  word varchar(100) NOT NULL DEFAULT '',
  wordreplace varchar(100) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO pw_actions VALUES('1','1.gif','比酷','摆了个ＰＯＳＥ道：你、你、你没我酷..');
INSERT INTO pw_actions VALUES('2','2.gif','生气','撅了撅嘴说：气死我了呀!呀!呀!');
INSERT INTO pw_actions VALUES('3','3.gif','狂笑','仰天狂笑：普天之下,竟然没有我的对手...');
INSERT INTO pw_actions VALUES('4','4.gif','痛哭','鼻子一酸,开始叭嗒叭嗒掉眼泪了');
INSERT INTO pw_actions VALUES('5','5.gif','唱歌','清清嗓子唱起歌来：东方红,太阳升');



INSERT INTO pw_administrators VALUES('1','admin','3','',';1253762723,127.0.0.1;1253765577,127.0.0.1');
INSERT INTO pw_administrators VALUES('2','maddogfyg','3','','');


INSERT INTO pw_adminset VALUES('3','a:69:{s:8:\"creathtm\";i:1;s:9:\"forumsell\";i:1;s:11:\"singleright\";i:1;s:8:\"tpccheck\";i:1;s:9:\"postcheck\";i:1;s:6:\"tagset\";i:1;s:6:\"pwcode\";i:1;s:6:\"setbwd\";i:1;s:7:\"setform\";i:1;s:9:\"topiccate\";i:1;s:8:\"postcate\";i:1;s:8:\"urlcheck\";i:1;s:10:\"attachment\";i:1;s:11:\"attachstats\";i:1;s:11:\"attachrenew\";i:1;s:10:\"app_photos\";i:1;s:9:\"app_diary\";i:1;s:10:\"app_groups\";i:1;s:9:\"app_share\";i:1;s:9:\"app_write\";i:1;s:7:\"app_hot\";i:1;s:8:\"checkreg\";i:1;s:10:\"checkemail\";i:1;s:7:\"banuser\";i:1;s:7:\"viewban\";i:1;s:12:\"customcredit\";i:1;s:5:\"level\";i:1;s:9:\"userstats\";i:1;s:7:\"upgrade\";i:1;s:6:\"uptime\";i:1;s:6:\"sethtm\";i:1;s:9:\"datastate\";i:1;s:7:\"sitemap\";i:1;s:9:\"postcache\";i:1;s:5:\"ipban\";i:1;s:8:\"ipstates\";i:1;s:8:\"ipsearch\";i:1;s:11:\"customfield\";i:1;s:11:\"updatecache\";i:1;s:9:\"creditdiy\";i:1;s:12:\"creditchange\";i:1;s:6:\"rebang\";i:1;s:7:\"pwcache\";i:1;s:6:\"report\";i:1;s:8:\"forumlog\";i:1;s:9:\"creditlog\";i:1;s:3:\"app\";i:1;s:10:\"hackcenter\";i:1;s:9:\"setstyles\";i:1;s:12:\"announcement\";i:1;s:8:\"draftset\";i:1;s:8:\"sendmail\";i:1;s:7:\"sendmsg\";i:1;s:7:\"present\";i:1;s:6:\"setads\";i:1;s:5:\"share\";i:1;s:9:\"viewtoday\";i:1;s:5:\"chmod\";i:1;s:9:\"safecheck\";i:1;s:4:\"help\";i:1;s:7:\"message\";i:1;s:8:\"guestdir\";i:1;s:7:\"recycle\";i:1;s:8:\"plantodo\";i:1;s:7:\"addplan\";i:1;s:7:\"userpay\";i:1;s:9:\"orderlist\";i:1;s:15:\"area_tplcontent\";i:1;s:10:\"o_comments\";i:1;}');
INSERT INTO pw_adminset VALUES('4','a:19:{s:8:\"tpccheck\";i:1;s:9:\"postcheck\";i:1;s:6:\"setbwd\";i:1;s:10:\"attachment\";i:1;s:11:\"attachstats\";i:1;s:11:\"attachrenew\";i:1;s:7:\"banuser\";i:1;s:7:\"viewban\";i:1;s:9:\"userstats\";i:1;s:9:\"editgroup\";i:1;s:9:\"postcache\";i:1;s:5:\"ipban\";i:1;s:8:\"ipsearch\";i:1;s:6:\"report\";i:1;s:8:\"forumlog\";i:1;s:9:\"creditlog\";i:1;s:12:\"announcement\";i:1;s:6:\"setads\";i:1;s:5:\"share\";i:1;}');
INSERT INTO pw_adminset VALUES('5','a:6:{s:7:\"banuser\";i:1;s:7:\"viewban\";i:1;s:6:\"report\";i:1;s:8:\"forumlog\";i:1;s:9:\"creditlog\";i:1;s:12:\"announcement\";i:1;}');

INSERT INTO pw_advert VALUES('1','0','0','Site.Header','0','0','1','0','头部横幅~	~显示在页面的头部，一般以图片或flash方式显示，多条广告时系统将随机选取一条显示','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('2','0','0','Site.Footer','0','0','1','0','底部横幅~	~显示在页面的底部，一般以图片或flash方式显示，多条广告时系统将随机选取一条显示','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('3','0','0','Site.NavBanner1','0','0','1','0','导航通栏[1]~	~显示在主导航的下面，一般以图片或flash方式显示，多条广告时系统将随机选取一条显示','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('4','0','0','Site.NavBanner2','0','0','1','0','导航通栏[2]~	~显示在头部通栏广告[1]位置的下面,与通栏广告[1]可一起显示,一般为图片广告','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('5','0','0','Site.PopupNotice','0','0','1','0','弹窗广告[右下]~	~在页面右下角以浮动的层弹出显示，此广告内容需要单独设置相关窗口参数','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('6','0','0','Site.FloatRand','0','0','1','0','漂浮广告[随机]~	~以各种形式在页面内随机漂浮的广告','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('7','0','0','Site.FloatLeft','0','0','1','0','漂浮广告[左]~	~以各种形式在页面左边漂浮的广告，俗称对联广告[左]','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('8','0','0','Site.FloatRight','0','0','1','0','漂浮广告[右]~	~以各种形式在页面右边漂浮的广告，俗称对联广告[右]','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('9','0','0','Mode.TextIndex','0','0','1','0','文字广告[论坛首页]~	~显示在页面的导航下面，一般以文字方式显示，每行四条广告，超过四条将换行显示','a:1:{s:7:\"display\";s:3:\"all\";}');
INSERT INTO pw_advert VALUES('10','0','0','Mode.Forum.TextRead','0','0','1','0','文字广告[帖子页]~	~显示在页面的导航下面，一般以文字方式显示，每行四条广告，超过四条将换行显示','a:1:{s:7:\"display\";s:3:\"all\";}');
INSERT INTO pw_advert VALUES('11','0','0','Mode.Forum.TextThread','0','0','1','0','文字广告[主题页]~	~显示在页面的导航下面，一般以文字方式显示，每行四条广告，超过四条将换行显示','a:1:{s:7:\"display\";s:3:\"all\";}');
INSERT INTO pw_advert VALUES('12','0','0','Mode.Forum.Layer.TidRight','0','0','1','0','楼层广告[帖子右侧]~	~出现在帖子右侧，一般以图片或文字显示，多条帖间广告时系统将随机选取一条显示','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('13','0','0','Mode.Forum.Layer.TidDown','0','0','1','0','楼层广告[帖子下方]~	~出现在帖子下方，一般以图片或文字显示，多条帖间广告时系统将随机选取一条显示','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('14','0','0','Mode.Forum.Layer.TidUp','0','0','1','0','楼层广告[帖子上方]~	~出现在帖子上方，一般以图片或文字显示，多条帖间广告时系统将随机选取一条显示','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('15','0','0','Mode.Forum.Layer.TidAmong','0','0','1','0','楼层广告[楼层中间]~	~出现在帖子楼层之间，一般以图片或文字显示，多条帖间广告时系统将随机选取一条显示','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('16','0','0','Mode.Layer.Index','0','0','1','0','论坛首页分类间~	~出现在首页分类层之间，一般以图片或文字显示，多条帖间广告时系统将随机选取一条显示','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('17','0','0','Mode.area.IndexMain','0','0','1','0','门户首页中间~	~门户首页循环广告下面的中间主要广告位,一般为图片广告','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('18','0','0','Mode.Layer.area.IndexLoop','0','0','1','0','门户首页循环~	~门户首页中间循环模块之间的广告投放，一般为图片广告','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('19','0','0','Mode.Layer.area.IndexSide','0','0','1','0','门户首页侧边~	~门户首页侧边每隔一个模块都有一个广告位显示,位置顺序对应选择的楼层数.一般为小图片广告','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('20','0','0','Mode.Forum.area.CateMain','0','0','1','0','门户频道中间~	~门户频道焦点下面的中间主要广告位,一般为图片广告','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('21','0','0','Mode.Forum.Layer.area.CateLoop','0','0','1','0','门户频道循环~	~门户频道中间循环模块之间的广告投放，一般为图片广告','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('22','0','0','Mode.Forum.Layer.area.CateSide','0','0','1','0','门户频道侧边~	~门户频道侧边每隔一个模块都有一个广告位显示,位置顺序对应选择的楼层数.一般为小图片广告','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('23','0','0','Mode.Forum.Layer.area.ThreadTop','0','0','1','0','门户帖子列表页右上~	~帖子列表页门户模式浏览时，右上方的广告位','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('24','0','0','Mode.Forum.Layer.area.ThreadBtm','0','0','1','0','门户帖子列表页右下~	~帖子列表页门户模式浏览时，右下方的广告位','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('25','0','0','Mode.Forum.Layer.area.ReadTop','0','0','1','0','门户帖子内容页右上~	~帖子内容页门户模式浏览时，右上方的广告位','a:1:{s:7:\"display\";s:4:\"rand\";}');
INSERT INTO pw_advert VALUES('26','0','0','Mode.Forum.Layer.area.ReadBtm','0','0','1','0','门户帖子内容页右下~	~帖子内容页门户模式浏览时，右下方的广告位','a:1:{s:7:\"display\";s:4:\"rand\";}');






INSERT INTO pw_bbsinfo VALUES('1','admin','1','1','1253762709','1253721600','0','0','0','0','0','0','0');

INSERT INTO pw_block VALUES('1','1','newsubject','最新主题','','1800','1');
INSERT INTO pw_block VALUES('2','1','newreply','最新回复','','600','1');
INSERT INTO pw_block VALUES('3','1','digestsubject','精华主题','','86400','1');
INSERT INTO pw_block VALUES('4','1','replysort','回复排行','','86400','1');
INSERT INTO pw_block VALUES('5','1','hitsort','人气排行','','86400','1');
INSERT INTO pw_block VALUES('6','2','usersort','金钱排行','money','3000','1');
INSERT INTO pw_block VALUES('7','2','usersort','威望排行','rvrc','3000','1');
INSERT INTO pw_block VALUES('8','3','forumsort','今日发帖','tpost','600','1');
INSERT INTO pw_block VALUES('9','3','forumsort','主题数排行','topic','86400','1');
INSERT INTO pw_block VALUES('10','3','forumsort','发帖量排行','article','86400','1');
INSERT INTO pw_block VALUES('11','4','gettags','热门标签','hot','86400','1');
INSERT INTO pw_block VALUES('12','4','gettags','最新标签','new','86400','1');
INSERT INTO pw_block VALUES('13','5','newpic','最新图片','','1700','1');
INSERT INTO pw_block VALUES('15','6','hotactive','热门活动','','86400','1');
INSERT INTO pw_block VALUES('18','2','usersort','在线时间排行','onlinetime','86400','1');
INSERT INTO pw_block VALUES('19','2','usersort','今日发帖排行','todaypost','1200','1');
INSERT INTO pw_block VALUES('20','2','usersort','月发帖排行','monthpost','40000','1');
INSERT INTO pw_block VALUES('21','2','usersort','发贴排行','postnum','40000','1');
INSERT INTO pw_block VALUES('22','2','usersort','发贴排行','monoltime','40000','1');
INSERT INTO pw_block VALUES('23','1','replysortday','今日热帖','','1800','1');
INSERT INTO pw_block VALUES('25','2','usersort','贡献值排行','credit','3000','1');
INSERT INTO pw_block VALUES('26','2','usersort','交易币排行榜','currency','3000','1');
INSERT INTO pw_block VALUES('29','1','highlightsubject','加亮主题','','50000','1');
INSERT INTO pw_block VALUES('38','6','todayactive','今日活动','','3600','1');
INSERT INTO pw_block VALUES('41','6','newactive','最新活动','','1800','1');
INSERT INTO pw_block VALUES('49','1','replysortweek','近期热贴','','86400','1');
INSERT INTO pw_block VALUES('47','1','hitsortday','今日人气','','1800','1');


INSERT INTO pw_cache VALUES('index_cache','$notice_A=array(\r\n);\r\n$sharelink=array(\r\n	\'1\' => \'<a href=\"http://www.phpwind.net\" target=\"_blank\"><img src=\"logo.gif\" alt=\"PHPwind官方论坛\" width=\"88\" height=\"31\"></a>\',\r\n);','0');
INSERT INTO pw_cache VALUES('thread_announce','$notice_A=array(\r\n);\r\n$notice_C=array(\r\n);','0');
INSERT INTO pw_cache VALUES('postcache','$faces=array(\r\n	\'default\'=>array(\r\n		\'name\'=>\'默认表情\',\r\n		\'child\'=>array(\'2\',\'14\',\'13\',\'12\',\'11\',\'10\',\'9\',\'8\',\'7\',\'6\',\'5\',\'4\',\'3\',\'15\',),\r\n	),\r\n);\r\n$face=array(\r\n	\'2\'=>array(\'default/1.gif\',\'\',\'\'),\r\n	\'14\'=>array(\'default/13.gif\',\'\',\'\'),\r\n	\'13\'=>array(\'default/12.gif\',\'\',\'\'),\r\n	\'12\'=>array(\'default/11.gif\',\'\',\'\'),\r\n	\'11\'=>array(\'default/10.gif\',\'\',\'\'),\r\n	\'10\'=>array(\'default/9.gif\',\'\',\'\'),\r\n	\'9\'=>array(\'default/8.gif\',\'\',\'\'),\r\n	\'8\'=>array(\'default/7.gif\',\'\',\'\'),\r\n	\'7\'=>array(\'default/6.gif\',\'\',\'\'),\r\n	\'6\'=>array(\'default/5.gif\',\'\',\'\'),\r\n	\'5\'=>array(\'default/4.gif\',\'\',\'\'),\r\n	\'4\'=>array(\'default/3.gif\',\'\',\'\'),\r\n	\'3\'=>array(\'default/2.gif\',\'\',\'\'),\r\n	\'15\'=>array(\'default/14.gif\',\'\',\'\'),\r\n);','0');
INSERT INTO pw_cache VALUES('medaldb','$_MEDALDB=array(\r\n	\'1\' => array(\r\n		\'id\' => \'1\',\r\n		\'name\' => \'终身成就奖\',\r\n		\'intro\' => \'谢谢您为社区发展做出的不可磨灭的贡献!!\',\r\n		\'picurl\' => \'1.gif\',\r\n	),\r\n	\'2\' => array(\r\n		\'id\' => \'2\',\r\n		\'name\' => \'优秀斑竹奖\',\r\n		\'intro\' => \'辛劳地为论坛付出劳动，收获快乐，感谢您!\',\r\n		\'picurl\' => \'2.gif\',\r\n	),\r\n	\'3\' => array(\r\n		\'id\' => \'3\',\r\n		\'name\' => \'宣传大使奖\',\r\n		\'intro\' => \'谢谢您为社区积极宣传,特颁发此奖!\',\r\n		\'picurl\' => \'3.gif\',\r\n	),\r\n	\'4\' => array(\r\n		\'id\' => \'4\',\r\n		\'name\' => \'特殊贡献奖\',\r\n		\'intro\' => \'您为论坛做出了特殊贡献,谢谢您!\',\r\n		\'picurl\' => \'4.gif\',\r\n	),\r\n	\'5\' => array(\r\n		\'id\' => \'5\',\r\n		\'name\' => \'金点子奖\',\r\n		\'intro\' => \'为社区提出建设性的建议被采纳,特颁发此奖!\',\r\n		\'picurl\' => \'5.gif\',\r\n	),\r\n	\'6\' => array(\r\n		\'id\' => \'6\',\r\n		\'name\' => \'原创先锋奖\',\r\n		\'intro\' => \'谢谢您积极发表原创作品,特颁发此奖!\',\r\n		\'picurl\' => \'6.gif\',\r\n	),\r\n	\'7\' => array(\r\n		\'id\' => \'7\',\r\n		\'name\' => \'贴图大师奖\',\r\n		\'intro\' => \'帖图高手,堪称大师!\',\r\n		\'picurl\' => \'7.gif\',\r\n	),\r\n	\'8\' => array(\r\n		\'id\' => \'8\',\r\n		\'name\' => \'灌水天才奖\',\r\n		\'intro\' => \'能够长期提供优质的社区水资源者,可得这个奖章!\',\r\n		\'picurl\' => \'8.gif\',\r\n	),\r\n	\'9\' => array(\r\n		\'id\' => \'9\',\r\n		\'name\' => \'新人进步奖\',\r\n		\'intro\' => \'新人有很大的进步可以得到这个奖章!\',\r\n		\'picurl\' => \'9.gif\',\r\n	),\r\n	\'10\' => array(\r\n		\'id\' => \'10\',\r\n		\'name\' => \'幽默大师奖\',\r\n		\'intro\' => \'您总是能给别人带来欢乐,谢谢您!\',\r\n		\'picurl\' => \'10.gif\',\r\n	),\r\n);','0');
INSERT INTO pw_cache VALUES('forum_cache','$forum=array(\r\n	\'1\' => array(\r\n		\'fid\' => \'1\',\r\n		\'fup\' => \'0\',\r\n		\'ifsub\' => \'0\',\r\n		\'childid\' => \'1\',\r\n		\'type\' => \'category\',\r\n		\'name\' => \'美食\',\r\n		\'style\' => \'0\',\r\n		\'f_type\' => \'forum\',\r\n		\'cms\' => \'0\',\r\n		\'ifhide\' => \'1\',\r\n	),\r\n	\'2\' => array(\r\n		\'fid\' => \'2\',\r\n		\'fup\' => \'1\',\r\n		\'ifsub\' => \'0\',\r\n		\'childid\' => \'0\',\r\n		\'type\' => \'forum\',\r\n		\'name\' => \'健康食品\',\r\n		\'style\' => \'0\',\r\n		\'f_type\' => \'forum\',\r\n		\'cms\' => \'0\',\r\n		\'ifhide\' => \'1\',\r\n	),\r\n	\'3\' => array(\r\n		\'fid\' => \'3\',\r\n		\'fup\' => \'0\',\r\n		\'ifsub\' => \'0\',\r\n		\'childid\' => \'1\',\r\n		\'type\' => \'category\',\r\n		\'name\' => \'糖疾\',\r\n		\'style\' => \'\',\r\n		\'f_type\' => \'forum\',\r\n		\'cms\' => \'0\',\r\n		\'ifhide\' => \'1\',\r\n	),\r\n	\'4\' => array(\r\n		\'fid\' => \'4\',\r\n		\'fup\' => \'3\',\r\n		\'ifsub\' => \'0\',\r\n		\'childid\' => \'0\',\r\n		\'type\' => \'forum\',\r\n		\'name\' => \'糖疾交流\',\r\n		\'style\' => \'0\',\r\n		\'f_type\' => \'forum\',\r\n		\'cms\' => \'0\',\r\n		\'ifhide\' => \'1\',\r\n	),\r\n	\'5\' => array(\r\n		\'fid\' => \'5\',\r\n		\'fup\' => \'0\',\r\n		\'ifsub\' => \'0\',\r\n		\'childid\' => \'1\',\r\n		\'type\' => \'category\',\r\n		\'name\' => \'其它\',\r\n		\'style\' => \'\',\r\n		\'f_type\' => \'forum\',\r\n		\'cms\' => \'0\',\r\n		\'ifhide\' => \'1\',\r\n	),\r\n	\'6\' => array(\r\n		\'fid\' => \'6\',\r\n		\'fup\' => \'5\',\r\n		\'ifsub\' => \'0\',\r\n		\'childid\' => \'0\',\r\n		\'type\' => \'forum\',\r\n		\'name\' => \'社区事务\',\r\n		\'style\' => \'0\',\r\n		\'f_type\' => \'forum\',\r\n		\'cms\' => \'0\',\r\n		\'ifhide\' => \'1\',\r\n	),\r\n);\r\n$forumcache=\'\r\n<option value=\"1\">&gt;&gt; 美食</option>\r\n<option value=\"2\"> &nbsp;|- 健康食品</option>\r\n<option value=\"3\">&gt;&gt; 糖疾</option>\r\n<option value=\"4\"> &nbsp;|- 糖疾交流</option>\r\n<option value=\"5\">&gt;&gt; 其它</option>\r\n<option value=\"6\"> &nbsp;|- 社区事务</option>\r\n\';\r\n$cmscache=\'\r\n\';\r\n$pwForumList=array(\r\n	\'1\' => array(\r\n		\'name\' => \'美食\',\r\n		\'child\' => array(\r\n			\'2\' => \'健康食品\',\r\n		),\r\n	),\r\n	\'3\' => array(\r\n		\'name\' => \'糖疾\',\r\n		\'child\' => array(\r\n			\'4\' => \'糖疾交流\',\r\n		),\r\n	),\r\n	\'5\' => array(\r\n		\'name\' => \'其它\',\r\n		\'child\' => array(\r\n			\'6\' => \'社区事务\',\r\n		),\r\n	),\r\n);\r\n$topic_type_cache=NULL;','0');
INSERT INTO pw_cache VALUES('md_config','$md_appgroups=\'\';\r\n$md_groups=\',3,\';\r\n$md_ifapply=\'1\';\r\n$md_ifmsg=\'1\';\r\n$md_ifopen=\'1\';\r\n','0');
INSERT INTO pw_cache VALUES('level','$ltitle=$lpic=$lneed=array();\r\n/**\r\n* default\r\n*/\r\n$ltitle[1]=\'default\';		$lpic[1]=\'8\';\r\n$ltitle[2]=\'游客\';		$lpic[2]=\'8\';\r\n$ltitle[6]=\'禁止发言\';		$lpic[6]=\'8\';\r\n$ltitle[7]=\'未验证会员\';		$lpic[7]=\'8\';\r\n\r\n/**\r\n* system\r\n*/\r\n$ltitle[3]=\'管理员\';		$lpic[3]=\'3\';\r\n$ltitle[4]=\'总版主\';		$lpic[4]=\'4\';\r\n$ltitle[5]=\'论坛版主\';		$lpic[5]=\'5\';\r\n$ltitle[17]=\'门户编辑\';		$lpic[17]=\'5\';\r\n\r\n/**\r\n* special\r\n*/\r\n$ltitle[16]=\'荣誉会员\';		$lpic[16]=\'5\';\r\n\r\n/**\r\n* member\r\n*/\r\n$ltitle[8]=\'散仙\';		$lpic[8]=\'8\';		$lneed[8]=\'0\';\r\n$ltitle[9]=\'赤天枢\';		$lpic[9]=\'9\';		$lneed[9]=\'1\';\r\n$ltitle[10]=\'橙天璇\';		$lpic[10]=\'10\';		$lneed[10]=\'100\';\r\n$ltitle[11]=\'金天玑\';		$lpic[11]=\'11\';		$lneed[11]=\'300\';\r\n$ltitle[12]=\'碧天权\';		$lpic[12]=\'12\';		$lneed[12]=\'1000\';\r\n$ltitle[13]=\'青玉衡\';		$lpic[13]=\'13\';		$lneed[13]=\'3000\';\r\n$ltitle[14]=\'靛开阳\';		$lpic[14]=\'14\';		$lneed[14]=\'10000\';\r\n$ltitle[15]=\'紫摇光\';		$lpic[15]=\'14\';		$lneed[15]=\'30000\';\r\n','0');
INSERT INTO pw_cache VALUES('gp_right','$gp_right=array(\r\n	\'1\' => array(\r\n		\'fontsize\' => \'\',\r\n		\'imgheight\' => \'\',\r\n		\'imgwidth\' => \'\',\r\n	),\r\n	\'2\' => array(\r\n		\'fontsize\' => \'\',\r\n		\'imgheight\' => \'\',\r\n		\'imgwidth\' => \'\',\r\n	),\r\n	\'3\' => array(\r\n		\'fontsize\' => \'\',\r\n		\'imgheight\' => \'\',\r\n		\'imgwidth\' => \'\',\r\n	),\r\n	\'4\' => array(\r\n		\'fontsize\' => \'\',\r\n		\'imgheight\' => \'\',\r\n		\'imgwidth\' => \'\',\r\n	),\r\n	\'5\' => array(\r\n		\'fontsize\' => \'\',\r\n		\'imgheight\' => \'\',\r\n		\'imgwidth\' => \'\',\r\n	),\r\n	\'6\' => array(\r\n		\'fontsize\' => \'\',\r\n		\'imgheight\' => \'\',\r\n		\'imgwidth\' => \'\',\r\n	),\r\n	\'7\' => array(\r\n		\'fontsize\' => \'\',\r\n		\'imgheight\' => \'\',\r\n		\'imgwidth\' => \'\',\r\n	),\r\n	\'8\' => array(\r\n		\'fontsize\' => \'3\',\r\n		\'imgheight\' => \'\',\r\n		\'imgwidth\' => \'\',\r\n	),\r\n	\'16\' => array(\r\n		\'fontsize\' => \'\',\r\n		\'imgheight\' => \'\',\r\n		\'imgwidth\' => \'\',\r\n	),\r\n);','0');
INSERT INTO pw_cache VALUES('customfield','$customfield=array(\r\n	\'0\' => array(\r\n		\'id\' => \'1\',\r\n		\'title\' => \'糖友类型\',\r\n		\'maxlen\' => \'0\',\r\n		\'vieworder\' => \'0\',\r\n		\'type\' => \'3\',\r\n		\'state\' => \'1\',\r\n		\'required\' => \'0\',\r\n		\'viewinread\' => \'1\',\r\n		\'editable\' => \'1\',\r\n		\'descrip\' => \'请认真填写此栏，以便于与他人深入交流，谢谢!\',\r\n		\'viewright\' => \'\',\r\n		\'options\' => \'1=暂时保密\n2=Ⅱ型糖友\n3=Ⅰ型糖友\n4=妊娠型糖友\n5=其它型糖友\n6=糖耐量异常者\n7=糖友亲朋\n8=相关业者\',\r\n	),\r\n);','0');









INSERT INTO pw_config VALUES('db_hackdb','array','a:9:{s:10:\"toolcenter\";a:3:{i:0;s:12:\"道具中心\";i:1;s:10:\"toolcenter\";i:2;i:1;}s:4:\"team\";a:3:{i:0;s:12:\"团队管理\";i:1;s:4:\"team\";i:2;i:0;}s:4:\"rate\";a:3:{i:0;s:12:\"评价管理\";i:1;s:4:\"rate\";i:2;i:0;}s:8:\"passport\";a:3:{i:0;s:9:\"通行证\";i:1;s:8:\"passport\";i:2;i:0;}s:3:\"new\";a:3:{i:0;s:18:\"首页调用管理\";i:1;s:3:\"new\";i:2;i:0;}s:5:\"medal\";a:3:{i:0;s:12:\"勋章中心\";i:1;s:5:\"medal\";i:2;i:0;}s:6:\"invite\";a:3:{i:0;s:12:\"邀请注册\";i:1;s:6:\"invite\";i:2;i:0;}s:4:\"blog\";a:3:{i:0;s:12:\"博客接口\";i:1;s:4:\"blog\";i:2;i:0;}s:4:\"bank\";a:3:{i:0;s:6:\"银行\";i:1;s:4:\"bank\";i:2;i:2;}}','');
INSERT INTO pw_config VALUES('rg_regdetail','string','0','');
INSERT INTO pw_config VALUES('rg_emailcheck','string','0','');
INSERT INTO pw_config VALUES('rg_allowsameip','string','8','');
INSERT INTO pw_config VALUES('rg_regsendemail','string','1','');
INSERT INTO pw_config VALUES('rg_whyregclose','string','管理员关闭了注册!','');
INSERT INTO pw_config VALUES('rg_welcomemsg','string','i糖友管理人员向您问好！\n\n您的注册名为:$rg_name\n\n请仔细阅读社区规章，谢谢！','');
INSERT INTO pw_config VALUES('rg_regmon','string','0','');
INSERT INTO pw_config VALUES('rg_email','string','','');
INSERT INTO pw_config VALUES('rg_npdifferf','string','1','');
INSERT INTO pw_config VALUES('rg_pwdcomplex','string','','');
INSERT INTO pw_config VALUES('rg_rgpermit','string','当您申请用户时，表示您已经同意遵守本规章。 欢迎您加入本站点参加交流和讨论，本站点为公共论坛，为维护网上公共秩序和社会稳定，请您自觉遵守以下条款： 一、不得利用本站危害国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益，不得利用本站制作、复制和传播下列信息：　 （一）煽动抗拒、破坏宪法和法律、行政法规实施的；　（二）煽动颠覆国家政权，推翻社会主义制度的；　（三）煽动分裂国家、破坏国家统一的；　（四）煽动民族仇恨、民族歧视，破坏民族团结的；　（五）捏造或者歪曲事实，散布谣言，扰乱社会秩序的；　（六）宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的；　（七）公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的；　（八）损害国家机关信誉的；　（九）其他违反宪法和法律行政法规的；　（十）进行商业广告行为的。二、互相尊重，对自己的言论和行为负责。三、禁止在申请用户时使用相关本站的词汇，或是带有侮辱、毁谤、造谣类的或是有其含义的各种语言进行注册用户，否则我们会将其删除。四、禁止以任何方式对本站进行各种破坏行为。五、如果您有违反国家相关法律法规的行为，本站概不负责，您的登录论坛信息均被记录无疑，必要时，我们会向相关的国家管理部门提供此类信息。 ','');
INSERT INTO pw_config VALUES('rg_registertype','string','0','');
INSERT INTO pw_config VALUES('rg_regweek','string','','');
INSERT INTO pw_config VALUES('rg_banname','string','版主,管理员,admin,斑竹','');
INSERT INTO pw_config VALUES('ml_mailifopen','string','1','');
INSERT INTO pw_config VALUES('db_bbsifopen','string','1','');
INSERT INTO pw_config VALUES('db_whybbsclose','string','论坛升级中... 请等候 15分钟','');
INSERT INTO pw_config VALUES('db_openpost','string','0	0	0','');
INSERT INTO pw_config VALUES('db_onlinelmt','string','0','');
INSERT INTO pw_config VALUES('db_regpopup','string','0','');
INSERT INTO pw_config VALUES('db_debug','string','0','');
INSERT INTO pw_config VALUES('db_forumdir','string','0','');
INSERT INTO pw_config VALUES('db_bbstitle','array','a:2:{s:5:\"index\";s:39:\"提升糖尿病病友的生活品质！\";s:5:\"other\";s:39:\"提升糖尿病病友的生活品质！\";}','');
INSERT INTO pw_config VALUES('db_metakeyword','string','糖尿病,病友,康复,治愈,健康,保养,保健,无糖,低糖,美食,运动','');
INSERT INTO pw_config VALUES('db_metadescrip','string','i糖友，提升糖尿病病友的生活品质。','');
INSERT INTO pw_config VALUES('db_bbsname','string','i糖友','');
INSERT INTO pw_config VALUES('db_bfn','string','index.php','');
INSERT INTO pw_config VALUES('db_bbsurl','string','http://itangyou','');
INSERT INTO pw_config VALUES('db_ceoconnect','string','http://itangyou.com/sendemail.php?username=admin','');
INSERT INTO pw_config VALUES('db_ceoemail','string','admin@itangyou.com','');
INSERT INTO pw_config VALUES('db_recycle','string','1','');
INSERT INTO pw_config VALUES('db_icp','string','','');
INSERT INTO pw_config VALUES('db_autochange','string','0','');
INSERT INTO pw_config VALUES('db_hour','string','4','');
INSERT INTO pw_config VALUES('db_http','string','N','');
INSERT INTO pw_config VALUES('db_attachurl','string','N','');
INSERT INTO pw_config VALUES('db_lp','string','0','');
INSERT INTO pw_config VALUES('db_obstart','string','9','');
INSERT INTO pw_config VALUES('db_charset','string','utf-8','');
INSERT INTO pw_config VALUES('db_forcecharset','string','0','');
INSERT INTO pw_config VALUES('db_defaultstyle','string','wind','');
INSERT INTO pw_config VALUES('db_cvtime','string','0','');
INSERT INTO pw_config VALUES('db_timedf','string','8','');
INSERT INTO pw_config VALUES('db_datefm','string','Y-m-d H:i','');
INSERT INTO pw_config VALUES('db_pingtime','string','0','');
INSERT INTO pw_config VALUES('db_columns','string','0','');
INSERT INTO pw_config VALUES('db_msgsound','string','0','');
INSERT INTO pw_config VALUES('db_shield','string','1','');
INSERT INTO pw_config VALUES('db_tcheck','string','1','');
INSERT INTO pw_config VALUES('db_adminset','string','0','');
INSERT INTO pw_config VALUES('db_ifonlinetime','string','1','');
INSERT INTO pw_config VALUES('db_threadrelated','string','1','');
INSERT INTO pw_config VALUES('db_ifjump','string','1','');
INSERT INTO pw_config VALUES('db_refreshtime','string','3','');
INSERT INTO pw_config VALUES('db_onlinetime','string','3600','');
INSERT INTO pw_config VALUES('db_maxresult','string','500','');
INSERT INTO pw_config VALUES('db_footertime','string','0','');
INSERT INTO pw_config VALUES('db_ckpath','string','/','');
INSERT INTO pw_config VALUES('db_ckdomain','string','','');
INSERT INTO pw_config VALUES('db_postallowtime','string','10','');
INSERT INTO pw_config VALUES('db_cvtimes','string','30','');
INSERT INTO pw_config VALUES('db_windpost','array','a:8:{s:3:\"pic\";i:1;s:8:\"picwidth\";i:700;s:9:\"picheight\";i:700;s:4:\"size\";i:6;s:5:\"flash\";i:1;s:4:\"mpeg\";i:1;s:6:\"iframe\";i:0;s:8:\"checkurl\";i:1;}','');
INSERT INTO pw_config VALUES('db_signheight','string','80','');
INSERT INTO pw_config VALUES('db_signwindcode','string','1','');
INSERT INTO pw_config VALUES('db_windpic','array','a:5:{s:3:\"pic\";i:1;s:8:\"picwidth\";i:700;s:9:\"picheight\";i:700;s:4:\"size\";i:5;s:5:\"flash\";i:0;}','');
INSERT INTO pw_config VALUES('db_allowupload','string','1','');
INSERT INTO pw_config VALUES('db_attachdir','string','3','');
INSERT INTO pw_config VALUES('db_attachhide','string','0','');
INSERT INTO pw_config VALUES('db_attachnum','string','5','');
INSERT INTO pw_config VALUES('db_showreplynum','string','5','');
INSERT INTO pw_config VALUES('db_selcount','string','100','');
INSERT INTO pw_config VALUES('db_replysendmail','string','0','');
INSERT INTO pw_config VALUES('db_replysitemail','string','0','');
INSERT INTO pw_config VALUES('db_pwcode','string','0','');
INSERT INTO pw_config VALUES('db_setform','string','0','');
INSERT INTO pw_config VALUES('db_titlemax','string','100','');
INSERT INTO pw_config VALUES('db_postmax','string','50000','');
INSERT INTO pw_config VALUES('db_postmin','string','10','');
INSERT INTO pw_config VALUES('db_autoimg','string','1','');
INSERT INTO pw_config VALUES('db_ntnum','string','2','');
INSERT INTO pw_config VALUES('db_ifselfshare','string','1','');
INSERT INTO pw_config VALUES('db_indexlink','string','1','');
INSERT INTO pw_config VALUES('db_indexmqshare','string','0','');
INSERT INTO pw_config VALUES('db_indexshowbirth','string','1','');
INSERT INTO pw_config VALUES('db_indexonline','string','1','');
INSERT INTO pw_config VALUES('db_adminshow','string','0','');
INSERT INTO pw_config VALUES('db_showguest','string','0','');
INSERT INTO pw_config VALUES('db_today','string','0','');
INSERT INTO pw_config VALUES('db_indexfmlogo','string','2','');
INSERT INTO pw_config VALUES('db_todaypost','string','1','');
INSERT INTO pw_config VALUES('db_newtime','string','3600','');
INSERT INTO pw_config VALUES('db_perpage','string','20','');
INSERT INTO pw_config VALUES('db_readperpage','string','10','');
INSERT INTO pw_config VALUES('db_maxpage','string','1000','');
INSERT INTO pw_config VALUES('db_maxmember','string','1000','');
INSERT INTO pw_config VALUES('db_anonymousname','string','匿名','');
INSERT INTO pw_config VALUES('db_hithour','string','0','');
INSERT INTO pw_config VALUES('db_topped','string','1','');
INSERT INTO pw_config VALUES('db_threadonline','string','1','');
INSERT INTO pw_config VALUES('db_showonline','string','1','');
INSERT INTO pw_config VALUES('db_threadshowpost','string','0','');
INSERT INTO pw_config VALUES('db_showcolony','string','0','');
INSERT INTO pw_config VALUES('db_threademotion','string','0','');
INSERT INTO pw_config VALUES('db_ipfrom','string','1','');
INSERT INTO pw_config VALUES('db_watermark','string','1','');
INSERT INTO pw_config VALUES('db_ifgif','string','2','');
INSERT INTO pw_config VALUES('db_waterwidth','string','0','');
INSERT INTO pw_config VALUES('db_waterheight','string','0','');
INSERT INTO pw_config VALUES('db_waterpos','string','1','');
INSERT INTO pw_config VALUES('db_waterimg','string','mark.gif','');
INSERT INTO pw_config VALUES('db_watertext','string','http://www.itangyou.com','');
INSERT INTO pw_config VALUES('db_waterfont','string','5','');
INSERT INTO pw_config VALUES('db_watercolor','string','#0000FF','');
INSERT INTO pw_config VALUES('db_waterpct','string','85','');
INSERT INTO pw_config VALUES('db_jpgquality','string','75','');
INSERT INTO pw_config VALUES('db_iffthumb','string','1','');
INSERT INTO pw_config VALUES('db_ifathumb','string','1','');
INSERT INTO pw_config VALUES('db_signmoney','string','0','');
INSERT INTO pw_config VALUES('db_wapifopen','string','1','');
INSERT INTO pw_config VALUES('db_wapcharset','string','0','');
INSERT INTO pw_config VALUES('db_waplimit','string','2000','');
INSERT INTO pw_config VALUES('db_jsifopen','string','0','');
INSERT INTO pw_config VALUES('db_jsper','string','900','');
INSERT INTO pw_config VALUES('db_bindurl','string','','');
INSERT INTO pw_config VALUES('db_loadavg','string','3','');
INSERT INTO pw_config VALUES('db_cc','string','1','');
INSERT INTO pw_config VALUES('db_ipcheck','string','0','');
INSERT INTO pw_config VALUES('db_ifsafecv','string','0','');
INSERT INTO pw_config VALUES('db_iplimit','string','','');
INSERT INTO pw_config VALUES('db_ifftp','string','0','');
INSERT INTO pw_config VALUES('db_ftpweb','string','','');
INSERT INTO pw_config VALUES('db_enterreason','string','0','');
INSERT INTO pw_config VALUES('db_adminreason','string','广告帖\r\n恶意灌水\r\n非法内容\r\n与版规不符\r\n重复发帖\r\n\r\n优秀文章\r\n原创内容','');
INSERT INTO pw_config VALUES('db_opensch','string','0	0	0','');
INSERT INTO pw_config VALUES('db_gdcheck','string','1','');
INSERT INTO pw_config VALUES('db_postgd','string','0','');
INSERT INTO pw_config VALUES('db_gdstyle','string','63','');
INSERT INTO pw_config VALUES('db_gdtype','string','1','');
INSERT INTO pw_config VALUES('db_gdsize','string','200	80	4','');
INSERT INTO pw_config VALUES('db_upload','string','1	150	150	20480','');
INSERT INTO pw_config VALUES('db_uploadfiletype','string','a:6:{s:3:\"gif\";i:500;s:3:\"png\";i:500;s:3:\"zip\";i:2000;s:3:\"rar\";i:2000;s:3:\"jpg\";i:500;s:3:\"txt\";i:500;}','');
INSERT INTO pw_config VALUES('db_creditset','string','a:6:{s:6:\"Digest\";a:5:{s:5:\"money\";d:7;s:4:\"rvrc\";d:0;s:6:\"credit\";d:0;s:8:\"currency\";d:0;i:1;d:0;}s:4:\"Post\";a:5:{s:5:\"money\";d:3;s:4:\"rvrc\";d:0;s:6:\"credit\";d:0;s:8:\"currency\";d:0;i:1;d:0;}s:5:\"Reply\";a:5:{s:5:\"money\";d:1;s:4:\"rvrc\";d:0;s:6:\"credit\";d:0;s:8:\"currency\";d:0;i:1;d:0;}s:8:\"Undigest\";a:5:{s:5:\"money\";d:7;s:4:\"rvrc\";d:0;s:6:\"credit\";d:0;s:8:\"currency\";d:0;i:1;d:0;}s:6:\"Delete\";a:5:{s:5:\"money\";d:3;s:4:\"rvrc\";d:0;s:6:\"credit\";d:0;s:8:\"currency\";d:0;i:1;d:0;}s:8:\"Deleterp\";a:5:{s:5:\"money\";d:1;s:4:\"rvrc\";d:0;s:6:\"credit\";d:0;s:8:\"currency\";d:0;i:1;d:0;}}','');
INSERT INTO pw_config VALUES('db_showgroup','string',',3,4,5,16,','');
INSERT INTO pw_config VALUES('db_showcustom','string',',1,','');
INSERT INTO pw_config VALUES('db_menu','string','1','');
INSERT INTO pw_config VALUES('db_fthumbsize','string','100	100','');
INSERT INTO pw_config VALUES('db_athumbsize','string','575	0','');
INSERT INTO pw_config VALUES('db_signgroup','string',',6,7,5,16,8,9,10,11,12,13,14,15,','');
INSERT INTO pw_config VALUES('db_autoban','string','0','');
INSERT INTO pw_config VALUES('db_wapfids','string','','');
INSERT INTO pw_config VALUES('db_safegroup','string','','');
INSERT INTO pw_config VALUES('db_attfg','string','1','');
INSERT INTO pw_config VALUES('rg_allowregister','string','1','');
INSERT INTO pw_config VALUES('rg_reg','string','1','');
INSERT INTO pw_config VALUES('rg_regsendmsg','string','0','');
INSERT INTO pw_config VALUES('rg_ifcheck','string','0','');
INSERT INTO pw_config VALUES('rg_rglower','string','0','');
INSERT INTO pw_config VALUES('rg_namelen','string','3	15','');
INSERT INTO pw_config VALUES('rg_pwdlen','string','6	16','');
INSERT INTO pw_config VALUES('ml_smtpauth','string','1','');
INSERT INTO pw_config VALUES('db_banby','string','0','');
INSERT INTO pw_config VALUES('db_bantype','string','0','');
INSERT INTO pw_config VALUES('db_banlimit','string','0','');
INSERT INTO pw_config VALUES('db_banmax','string','0','');
INSERT INTO pw_config VALUES('db_rmbrate','string','10','');
INSERT INTO pw_config VALUES('db_rmblest','string','5','');
INSERT INTO pw_config VALUES('cy_virement','string','0','');
INSERT INTO pw_config VALUES('cy_virerate','string','0','');
INSERT INTO pw_config VALUES('cy_virelimit','string','0','');
INSERT INTO pw_config VALUES('db_diy','string','basic,setforum,tpccheck,topiccate,setuser,level,announcement,navmode,bakout,area_tplcontent','');
INSERT INTO pw_config VALUES('db_ipban','string','','');
INSERT INTO pw_config VALUES('db_ipstates','string','1','');
INSERT INTO pw_config VALUES('db_union','string','a:0:{}	<script src=\"http://u.phpwind.com/src/nc.php\" language=\"JavaScript\"></script><br>			<script src=\"http://u.phpwind.com/src/un.php\" language=\"JavaScript\"></script><br>		0	a:0:{}	','');
INSERT INTO pw_config VALUES('fc_shownum','string','9','');
INSERT INTO pw_config VALUES('db_tlist','string','','');
INSERT INTO pw_config VALUES('db_ptable','string','','');
INSERT INTO pw_config VALUES('db_plist','string','','');
INSERT INTO pw_config VALUES('db_ads','string','1','');
INSERT INTO pw_config VALUES('db_wordsfb','string','1','');
INSERT INTO pw_config VALUES('db_htmifopen','string','1','');
INSERT INTO pw_config VALUES('db_dir','string','-itangyou-','');
INSERT INTO pw_config VALUES('db_ext','string','.html','');
INSERT INTO pw_config VALUES('db_upgrade','string','a:7:{s:7:\"postnum\";s:1:\"0\";s:7:\"digests\";s:1:\"0\";s:4:\"rvrc\";s:1:\"0\";s:5:\"money\";s:1:\"1\";s:6:\"credit\";s:1:\"0\";s:8:\"currency\";s:1:\"0\";s:10:\"onlinetime\";s:1:\"0\";}','');
INSERT INTO pw_config VALUES('ol_onlinepay','string','1','');
INSERT INTO pw_config VALUES('ol_whycolse','string','系统没有开启网上支付功能!','');
INSERT INTO pw_config VALUES('ol_payto','string','','');
INSERT INTO pw_config VALUES('ol_md5code','string','','');
INSERT INTO pw_config VALUES('ol_paypal','string','','');
INSERT INTO pw_config VALUES('ol_paypalcode','string','','');
INSERT INTO pw_config VALUES('ol_99bill','string','','');
INSERT INTO pw_config VALUES('ol_99billcode','string','','');
INSERT INTO pw_config VALUES('db_head','string','','');
INSERT INTO pw_config VALUES('db_foot','string','','');
INSERT INTO pw_config VALUES('db_pptifopen','string','0','');
INSERT INTO pw_config VALUES('db_pptkey','string','','');
INSERT INTO pw_config VALUES('db_ppttype','string','client','');
INSERT INTO pw_config VALUES('db_ppturls','string','','');
INSERT INTO pw_config VALUES('db_pptserverurl','string','','');
INSERT INTO pw_config VALUES('db_pptloginurl','string','login.php','');
INSERT INTO pw_config VALUES('db_pptloginouturl','string','login.php?action=quit','');
INSERT INTO pw_config VALUES('db_pptregurl','string','register.php','');
INSERT INTO pw_config VALUES('db_pptcredit','string','','');
INSERT INTO pw_config VALUES('db_toolifopen','string','1','');
INSERT INTO pw_config VALUES('db_allowtrade','string','1','');
INSERT INTO pw_config VALUES('db_attachname','string','attachment','');
INSERT INTO pw_config VALUES('db_picpath','string','images','');
INSERT INTO pw_config VALUES('db_htmdir','string','htm_data','');
INSERT INTO pw_config VALUES('db_guestdir','string','data/guestcache','');
INSERT INTO pw_config VALUES('ml_mailmethod','string','1','');
INSERT INTO pw_config VALUES('ml_smtphost','string','','');
INSERT INTO pw_config VALUES('ml_smtpport','string','25','');
INSERT INTO pw_config VALUES('ml_smtpfrom','string','','');
INSERT INTO pw_config VALUES('ml_smtpuser','string','','');
INSERT INTO pw_config VALUES('ml_smtphelo','string','','');
INSERT INTO pw_config VALUES('ml_smtpmxmailname','string','','');
INSERT INTO pw_config VALUES('ml_mxdns','string','','');
INSERT INTO pw_config VALUES('ml_mxdnsbak','string','','');
INSERT INTO pw_config VALUES('ftp_pass','string','','');
INSERT INTO pw_config VALUES('ftp_server','string','','');
INSERT INTO pw_config VALUES('ftp_port','string','21','');
INSERT INTO pw_config VALUES('ftp_dir','string','','');
INSERT INTO pw_config VALUES('ftp_user','string','','');
INSERT INTO pw_config VALUES('db_schwait','string','5','');
INSERT INTO pw_config VALUES('db_registerfile','string','xinyin.php','');
INSERT INTO pw_config VALUES('db_adminfile','string','yunge.php','');
INSERT INTO pw_config VALUES('db_newinfoifopen','string','0','');
INSERT INTO pw_config VALUES('db_sortnum','string','20','');
INSERT INTO pw_config VALUES('db_styledb','array','a:5:{s:4:\"wind\";a:2:{i:0;s:34:\"<font color=#3366cc>■wind</font>\";i:1;s:1:\"1\";}s:10:\"wind_green\";a:2:{i:0;s:33:\"<font color=green>■green</font>\";i:1;s:1:\"1\";}s:11:\"wind_orange\";a:2:{i:0;s:35:\"<font color=orange>■orange</font>\";i:1;s:1:\"1\";}s:11:\"wind_purple\";a:2:{i:0;s:35:\"<font color=purple>■purple</font>\";i:1;s:1:\"1\";}s:8:\"wind_red\";a:2:{i:0;s:29:\"<font color=red>■red</font>\";i:1;s:1:\"1\";}}','');
INSERT INTO pw_config VALUES('db_moneyname','string','铜币','');
INSERT INTO pw_config VALUES('db_moneyunit','string','枚','');
INSERT INTO pw_config VALUES('db_rvrcname','string','威望','');
INSERT INTO pw_config VALUES('db_rvrcunit','string','点','');
INSERT INTO pw_config VALUES('db_creditname','string','贡献值','');
INSERT INTO pw_config VALUES('db_creditunit','string','点','');
INSERT INTO pw_config VALUES('db_currencyname','string','银元','');
INSERT INTO pw_config VALUES('db_currencyunit','string','个','');
INSERT INTO pw_config VALUES('db_maxtypenum','string','5','');
INSERT INTO pw_config VALUES('db_selectgroup','string','1','');
INSERT INTO pw_config VALUES('db_ifpwcache','string','567','');
INSERT INTO pw_config VALUES('db_urlcheck','string','phpwind.net,phpwind.com','');
INSERT INTO pw_config VALUES('db_xforwardip','string','0','');
INSERT INTO pw_config VALUES('db_adminrecord','string','0','');
INSERT INTO pw_config VALUES('db_floorunit','string','楼','');
INSERT INTO pw_config VALUES('db_floorname','array','a:4:{i:0;s:6:\"楼主\";i:1;s:6:\"沙发\";i:2;s:6:\"板凳\";i:3;s:6:\"地板\";}','');
INSERT INTO pw_config VALUES('db_toolbar','string','0','');
INSERT INTO pw_config VALUES('db_creditlog','array','a:6:{s:3:\"reg\";a:1:{s:5:\"money\";i:1;}s:5:\"topic\";a:1:{s:5:\"money\";i:1;}s:6:\"credit\";a:1:{s:5:\"money\";i:1;}s:6:\"reward\";a:1:{s:5:\"money\";i:1;}s:4:\"hack\";a:1:{s:5:\"money\";i:1;}s:5:\"other\";a:1:{s:5:\"money\";i:1;}}','');
INSERT INTO pw_config VALUES('db_sitemsg','array','a:4:{s:3:\"reg\";a:2:{i:0;s:64:\"带红色*的都是必填项目，若填写不全将无法注册\";i:1;s:39:\"请添加能正常收发邮件的邮箱\";}s:5:\"login\";a:1:{i:0;s:103:\"如果您在网吧或者非个人电脑，建议设置Cookie有效期为 即时，以保证账户安全\";}s:4:\"post\";a:3:{i:0;s:66:\"如果您在写长篇帖子又不马上发表，建议存为草稿\";i:1;s:84:\"如果您提交过一次失败了，可以用”恢复数据”来恢复帖子内容\";i:2;s:51:\"批量上传需要先选择文件，再选择上传\";}s:5:\"reply\";a:3:{i:0;s:66:\"如果您在写长篇帖子又不马上发表，建议存为草稿\";i:1;s:84:\"如果您提交过一次失败了，可以用”恢复数据”来恢复帖子内容\";i:2;s:51:\"批量上传需要先选择文件，再选择上传\";}}','');
INSERT INTO pw_config VALUES('rg_timeend','string','2010','');
INSERT INTO pw_config VALUES('rg_timestart','string','1930','');
INSERT INTO pw_config VALUES('db_dopen','string','1','');
INSERT INTO pw_config VALUES('db_phopen','string','1','');
INSERT INTO pw_config VALUES('db_groups_open','string','1','');
INSERT INTO pw_config VALUES('db_share_open','string','1','');
INSERT INTO pw_config VALUES('rg_regcredit','array','a:5:{s:5:\"money\";i:0;s:4:\"rvrc\";i:0;s:6:\"credit\";i:0;s:8:\"currency\";i:0;i:1;i:0;}','');
INSERT INTO pw_config VALUES('db_waterfonts','string','en/PilsenPlakat','');
INSERT INTO pw_config VALUES('ftp_timeout','string','10','');
INSERT INTO pw_config VALUES('db_virerate','string','1','');
INSERT INTO pw_config VALUES('db_virelimit','string','10','');
INSERT INTO pw_config VALUES('db_signcurtype','string','money','');
INSERT INTO pw_config VALUES('db_bdayautohide','string','1','');
INSERT INTO pw_config VALUES('db_creditpay','array','a:1:{s:5:\"money\";a:3:{s:7:\"rmbrate\";i:10;s:7:\"rmblest\";d:10;s:8:\"virement\";i:1;}}','');
INSERT INTO pw_config VALUES('db_sellset','array','a:3:{s:4:\"type\";a:1:{i:0;s:5:\"money\";}s:5:\"price\";s:0:\"\";s:6:\"income\";s:0:\"\";}','');
INSERT INTO pw_config VALUES('db_logintype','string','5','');
INSERT INTO pw_config VALUES('db_func','string','2','');
INSERT INTO pw_config VALUES('jf_A','string','a:0:{}','');
INSERT INTO pw_config VALUES('nf_config','string','a:3:{s:8:\"position\";i:1;s:8:\"titlelen\";i:50;s:7:\"shownum\";i:9;}','');
INSERT INTO pw_config VALUES('nf_order','string','a:0:{}','');
INSERT INTO pw_config VALUES('db_iftag','string','1','');
INSERT INTO pw_config VALUES('db_readtag','string','0','');
INSERT INTO pw_config VALUES('db_tagindex','string','20','');
INSERT INTO pw_config VALUES('db_enhideset','array','a:0:{}','');
INSERT INTO pw_config VALUES('db_rategroup','string','a:12:{i:8;i:5;i:9;i:10;i:10;i:10;i:11;i:10;i:12;i:30;i:13;i:30;i:14;i:30;i:15;i:50;i:4;i:1000;i:5;i:100;i:16;i:50;i:2;i:0;}','');
INSERT INTO pw_config VALUES('db_ratepower','string','a:3:{i:1;i:0;i:2;i:0;i:3;i:0;}','');
INSERT INTO pw_config VALUES('db_hash','string','NId^#WB^Y^','');
INSERT INTO pw_config VALUES('db_windmagic','string','1','');
INSERT INTO pw_config VALUES('db_siteid','string','d6fb3d7293e1094cba44a548c958b325','');
INSERT INTO pw_config VALUES('db_siteownerid','string','43ad6aed9e1523ba169f562221480891','');
INSERT INTO pw_config VALUES('db_sitehash','string','10VVkPBFQFXldUU1BQWQhUBwlRWFxcAVYJVQdRUlEIVgk','');
INSERT INTO pw_config VALUES('db_modes','array','a:3:{s:3:\"bbs\";a:3:{s:6:\"m_name\";s:12:\"论坛模式\";s:6:\"ifopen\";i:1;s:5:\"title\";s:6:\"论坛\";}s:1:\"o\";a:3:{s:6:\"m_name\";s:12:\"圈子模式\";s:6:\"ifopen\";i:1;s:5:\"title\";s:6:\"圈子\";}s:4:\"area\";a:3:{s:6:\"m_name\";s:12:\"门户模式\";s:6:\"ifopen\";i:1;s:5:\"title\";s:6:\"门户\";}}','');
INSERT INTO pw_config VALUES('db_mode','array','area','');
INSERT INTO pw_config VALUES('db_modepages','array','a:2:{s:1:\"o\";a:2:{s:5:\"index\";a:2:{s:4:\"name\";s:6:\"首页\";s:8:\"template\";s:5:\"index\";}s:6:\"m_home\";a:2:{s:4:\"name\";s:6:\"动态\";s:8:\"template\";s:6:\"m_home\";}}s:4:\"area\";a:3:{s:5:\"index\";a:2:{s:4:\"name\";s:6:\"首页\";s:8:\"template\";s:5:\"index\";}s:4:\"cate\";a:2:{s:4:\"name\";s:9:\"频道页\";s:8:\"template\";s:4:\"cate\";}s:6:\"thread\";a:2:{s:4:\"name\";s:9:\"列表页\";s:8:\"template\";s:6:\"thread\";}}}','');
INSERT INTO pw_config VALUES('db_modelids','string','4,5,6,7,8,1,2,3','');
INSERT INTO pw_config VALUES('db_headnav','array','a:1:{s:3:\"ID4\";a:2:{s:4:\"html\";s:57:\"<a href=\"faq.php\" id=\"td_ID4\" target=\"_blank\">|帮助</a>\";s:3:\"pos\";s:8:\"bbs,area\";}}','');
INSERT INTO pw_config VALUES('db_footnav','array','a:0:{}','');
INSERT INTO pw_config VALUES('db_mainnav','array','a:3:{s:7:\"KEYarea\";a:2:{s:4:\"html\";s:53:\"<a href=\"index.php?m=area\" id=\"td_KEYarea\">门户</a>\";s:3:\"pos\";s:8:\"bbs,area\";}s:6:\"KEYbbs\";a:2:{s:4:\"html\";s:51:\"<a href=\"index.php?m=bbs\" id=\"td_KEYbbs\">论坛</a>\";s:3:\"pos\";s:8:\"bbs,area\";}s:4:\"KEYo\";a:2:{s:4:\"html\";s:63:\"<a href=\"index.php?m=o\" id=\"td_KEYo\" target=\"_blank\">圈子</a>\";s:3:\"pos\";s:8:\"bbs,area\";}}','');
INSERT INTO pw_config VALUES('db_navinfo','array','a:7:{s:6:\"KEYapp\";a:2:{s:4:\"html\";s:54:\"<a href=\"javascript:;\" id=\"td_KEYapp\">社区应用</a>\";s:5:\"child\";a:7:{s:14:\"KEYapp_article\";a:1:{s:4:\"html\";s:62:\"<a href=\"apps.php?q=article\" id=\"td_KEYapp_article\">帖子</a>\";}s:13:\"KEYapp_photos\";a:1:{s:4:\"html\";s:60:\"<a href=\"apps.php?q=photos\" id=\"td_KEYapp_photos\">相册</a>\";}s:12:\"KEYapp_diary\";a:1:{s:4:\"html\";s:58:\"<a href=\"apps.php?q=diary\" id=\"td_KEYapp_diary\">日志</a>\";}s:13:\"KEYapp_groups\";a:1:{s:4:\"html\";s:60:\"<a href=\"apps.php?q=groups\" id=\"td_KEYapp_groups\">群组</a>\";}s:10:\"KEYapp_hot\";a:1:{s:4:\"html\";s:54:\"<a href=\"apps.php?q=hot\" id=\"td_KEYapp_hot\">热榜</a>\";}s:12:\"KEYapp_share\";a:1:{s:4:\"html\";s:58:\"<a href=\"apps.php?q=share\" id=\"td_KEYapp_share\">分享</a>\";}s:12:\"KEYapp_write\";a:1:{s:4:\"html\";s:58:\"<a href=\"apps.php?q=write\" id=\"td_KEYapp_write\">记录</a>\";}}}s:11:\"KEYlastpost\";a:1:{s:4:\"html\";s:73:\"<a href=\"search.php?sch_time=newatc\" id=\"td_KEYlastpost\">最新帖子</a>\";}s:9:\"KEYdigest\";a:1:{s:4:\"html\";s:61:\"<a href=\"search.php?digest=1\" id=\"td_KEYdigest\">精华区</a>\";}s:7:\"KEYhack\";a:2:{s:4:\"html\";s:55:\"<a href=\"javascript:;\" id=\"td_KEYhack\">社区服务</a>\";s:5:\"child\";a:1:{s:18:\"KEYhack_toolcenter\";a:1:{s:4:\"html\";s:80:\"<a href=\"hack.php?H_name=toolcenter\" id=\"td_KEYhack_toolcenter\">道具中心</a>\";}}}s:9:\"KEYmember\";a:1:{s:4:\"html\";s:55:\"<a href=\"member.php\" id=\"td_KEYmember\">会员列表</a>\";}s:7:\"KEYsort\";a:2:{s:4:\"html\";s:51:\"<a href=\"sort.php\" id=\"td_KEYsort\">统计排行</a>\";s:5:\"child\";a:9:{s:13:\"KEYsort_basic\";a:1:{s:4:\"html\";s:57:\"<a href=\"sort.php\" id=\"td_KEYsort_basic\">基本信息</a>\";}s:15:\"KEYsort_ipstate\";a:1:{s:4:\"html\";s:76:\"<a href=\"sort.php?action=ipstate\" id=\"td_KEYsort_ipstate\">到访IP统计</a>\";}s:12:\"KEYsort_team\";a:1:{s:4:\"html\";s:68:\"<a href=\"sort.php?action=team\" id=\"td_KEYsort_team\">管理团队</a>\";}s:13:\"KEYsort_admin\";a:1:{s:4:\"html\";s:70:\"<a href=\"sort.php?action=admin\" id=\"td_KEYsort_admin\">管理操作</a>\";}s:14:\"KEYsort_online\";a:1:{s:4:\"html\";s:72:\"<a href=\"sort.php?action=online\" id=\"td_KEYsort_online\">在线会员</a>\";}s:14:\"KEYsort_member\";a:1:{s:4:\"html\";s:72:\"<a href=\"sort.php?action=member\" id=\"td_KEYsort_member\">会员排行</a>\";}s:13:\"KEYsort_forum\";a:1:{s:4:\"html\";s:70:\"<a href=\"sort.php?action=forum\" id=\"td_KEYsort_forum\">版块排行</a>\";}s:15:\"KEYsort_article\";a:1:{s:4:\"html\";s:74:\"<a href=\"sort.php?action=article\" id=\"td_KEYsort_article\">帖子排行</a>\";}s:15:\"KEYsort_taglist\";a:1:{s:4:\"html\";s:73:\"<a href=\"job.php?action=taglist\" id=\"td_KEYsort_taglist\">标签排行</a>\";}}}s:12:\"KEYhack_bank\";a:1:{s:4:\"html\";s:62:\"<a href=\"hack.php?H_name=bank\" id=\"td_KEYhack_bank\">银行</a>\";}}','');
INSERT INTO pw_config VALUES('PHPWind','string','a:3:{s:7:\"history\";a:1:{i:0;s:25:\"Install	1253762703		7.5,	\";}s:7:\"version\";s:3:\"7.5\";s:6:\"repair\";s:0:\"\";}','PHPWind');
INSERT INTO pw_config VALUES('db_visitopen','string','0','');
INSERT INTO pw_config VALUES('db_visitips','string','','');
INSERT INTO pw_config VALUES('db_visituser','string','','');
INSERT INTO pw_config VALUES('db_visitmsg','string','','');
INSERT INTO pw_config VALUES('db_ifcredit','string','0','');
INSERT INTO pw_config VALUES('db_txtadnum','string','0','');
INSERT INTO pw_config VALUES('db_readinfo','string','1','');
INSERT INTO pw_config VALUES('db_visitgroup','string','','');
INSERT INTO pw_config VALUES('db_ajax','string','0','');
INSERT INTO pw_config VALUES('db_online','string','0','');
INSERT INTO pw_config VALUES('db_redundancy','string','0','');
INSERT INTO pw_config VALUES('db_qcheck','string','0	0	1	0','');
INSERT INTO pw_config VALUES('db_question','array','a:0:{}','');
INSERT INTO pw_config VALUES('db_answer','array','a:0:{}','');
INSERT INTO pw_config VALUES('db_posturlnum','string','10','');



INSERT INTO pw_customfield VALUES('1','糖友类型','0','0','3','1','0','1','1','请认真填写此栏，以便于与他人深入交流，谢谢!','','1=暂时保密\n2=Ⅱ型糖友\n3=Ⅰ型糖友\n4=妊娠型糖友\n5=其它型糖友\n6=糖耐量异常者\n7=糖友亲朋\n8=相关业者');














INSERT INTO pw_forumdata VALUES('1','0','0','0','0','0','0','0','0','','');
INSERT INTO pw_forumdata VALUES('2','0','0','0','0','0','0','0','0','','');
INSERT INTO pw_forumdata VALUES('3','0','0','0','0','0','0','0','0','','');
INSERT INTO pw_forumdata VALUES('4','0','0','0','0','0','0','0','0','','');
INSERT INTO pw_forumdata VALUES('5','0','0','0','0','0','0','0','0','','');
INSERT INTO pw_forumdata VALUES('6','0','0','0','0','0','0','0','0','','');



INSERT INTO pw_forums VALUES('1','0','0','1','category','','美食','','','','0','','','0','0','0','1','1','3','0','1','','0','','','','','','','','','','forum','0','0','0','1','0','0','1','0');
INSERT INTO pw_forums VALUES('2','1','0','0','forum','','健康食品','','','','0','','','0','0','0','1','1','3','1','1','','0','','','','','','','','','','forum','0','0','0','1','0','0','1','0');
INSERT INTO pw_forums VALUES('3','0','0','1','category','','糖疾','','','','0','','','','0','0','1','1','3','0','1','','0','','','','','','','','','','forum','0','0','0','1','0','0','1','0');
INSERT INTO pw_forums VALUES('4','3','0','0','forum','','糖疾交流','','','','0','','','0','0','0','1','1','3','1','1','','0','','','','','','','','','','forum','0','0','0','1','0','0','1','0');
INSERT INTO pw_forums VALUES('5','0','0','1','category','','其它','','','','0','','','','0','0','1','1','3','0','1','','0','','','','','','','','','','forum','0','0','0','1','0','0','1','0');
INSERT INTO pw_forums VALUES('6','5','0','0','forum','','社区事务','','','','0','','','0','0','0','1','1','3','0','1','','0','','','','','','','','','','forum','0','0','0','1','0','0','1','0');


INSERT INTO pw_forumsextra VALUES('2','','a:33:{s:4:\"link\";s:0:\"\";s:4:\"lock\";i:0;s:7:\"cutnums\";i:0;s:9:\"threadnum\";i:0;s:7:\"readnum\";i:0;s:7:\"newtime\";i:0;s:8:\"orderway\";s:8:\"lastpost\";s:3:\"asc\";s:4:\"DESC\";s:11:\"allowencode\";i:0;s:9:\"anonymous\";i:0;s:4:\"rate\";i:1;s:3:\"dig\";i:0;s:7:\"inspect\";i:0;s:9:\"watermark\";i:1;s:7:\"commend\";i:0;s:11:\"autocommend\";i:0;s:11:\"commendlist\";s:0:\"\";s:10:\"commendnum\";i:0;s:13:\"commendlength\";i:0;s:11:\"commendtime\";i:0;s:10:\"addtpctype\";i:0;s:9:\"ifrelated\";i:0;s:11:\"relatednums\";i:0;s:10:\"relatedcon\";s:7:\"ownpost\";s:13:\"relatedcustom\";a:0:{}s:8:\"rvrcneed\";i:0;s:9:\"moneyneed\";i:0;s:10:\"creditneed\";i:0;s:11:\"postnumneed\";i:0;s:9:\"sellprice\";a:0:{}s:9:\"uploadset\";s:9:\"money			0\";s:8:\"rewarddb\";s:3:\"			\";s:9:\"allowtime\";s:0:\"\";}','');
INSERT INTO pw_forumsextra VALUES('4','','a:33:{s:4:\"link\";s:0:\"\";s:4:\"lock\";i:0;s:7:\"cutnums\";i:0;s:9:\"threadnum\";i:0;s:7:\"readnum\";i:0;s:7:\"newtime\";i:0;s:8:\"orderway\";s:8:\"lastpost\";s:3:\"asc\";s:4:\"DESC\";s:11:\"allowencode\";i:0;s:9:\"anonymous\";i:0;s:4:\"rate\";i:1;s:3:\"dig\";i:0;s:7:\"inspect\";i:0;s:9:\"watermark\";i:1;s:7:\"commend\";i:0;s:11:\"autocommend\";i:0;s:11:\"commendlist\";s:0:\"\";s:10:\"commendnum\";i:0;s:13:\"commendlength\";i:0;s:11:\"commendtime\";i:0;s:10:\"addtpctype\";i:0;s:9:\"ifrelated\";i:0;s:11:\"relatednums\";i:0;s:10:\"relatedcon\";s:7:\"ownpost\";s:13:\"relatedcustom\";a:0:{}s:8:\"rvrcneed\";i:0;s:9:\"moneyneed\";i:0;s:10:\"creditneed\";i:0;s:11:\"postnumneed\";i:0;s:9:\"sellprice\";a:0:{}s:9:\"uploadset\";s:9:\"money			0\";s:8:\"rewarddb\";s:3:\"			\";s:9:\"allowtime\";s:0:\"\";}','');



INSERT INTO pw_hack VALUES('bk_A','string','a:1:{s:10:\"rvrc_money\";a:6:{i:0;s:4:\"威望\";i:1;s:4:\"金钱\";i:2;s:1:\"2\";i:3;s:1:\"3\";i:4;s:1:\"1\";i:5;i:1;}}','');
INSERT INTO pw_hack VALUES('bk_ddate','string','10','');
INSERT INTO pw_hack VALUES('bk_drate','string','10','');
INSERT INTO pw_hack VALUES('bk_num','string','10','');
INSERT INTO pw_hack VALUES('bk_open','string','1','');
INSERT INTO pw_hack VALUES('bk_per','string','5','');
INSERT INTO pw_hack VALUES('bk_rate','string','5','');
INSERT INTO pw_hack VALUES('bk_timelimit','string','2','');
INSERT INTO pw_hack VALUES('bk_virelimit','string','10','');
INSERT INTO pw_hack VALUES('bk_virement','string','1','');
INSERT INTO pw_hack VALUES('bk_virerate','string','10','');
INSERT INTO pw_hack VALUES('currrate1','string','a:4:{s:4:\"rvrc\";i:100;s:5:\"money\";i:100;s:6:\"credit\";i:1;i:1;i:5;}','');
INSERT INTO pw_hack VALUES('currrate2','string','','');
INSERT INTO pw_hack VALUES('cn_open','string','1','');
INSERT INTO pw_hack VALUES('cn_remove','string','1','');
INSERT INTO pw_hack VALUES('cn_newcolony','string','1','');
INSERT INTO pw_hack VALUES('cn_createmoney','string','100','');
INSERT INTO pw_hack VALUES('cn_joinmoney','string','10','');
INSERT INTO pw_hack VALUES('cn_allowcreate','string','1','');
INSERT INTO pw_hack VALUES('cn_allowjoin','string','1','');
INSERT INTO pw_hack VALUES('cn_memberfull','string','50','');
INSERT INTO pw_hack VALUES('cn_imgsize','string','1048576','');
INSERT INTO pw_hack VALUES('cn_name','string','朋友圈','');
INSERT INTO pw_hack VALUES('cn_groups','string',',3,4,5,8,9,10,11,12,13,14,15,16,','');
INSERT INTO pw_hack VALUES('cn_imgwidth','string','200','');
INSERT INTO pw_hack VALUES('cn_imgheight','string','100','');
INSERT INTO pw_hack VALUES('cn_visittime','string','60','');
INSERT INTO pw_hack VALUES('cn_transfer','string','10','');
INSERT INTO pw_hack VALUES('inv_open','string','0','');
INSERT INTO pw_hack VALUES('inv_days','string','1','');
INSERT INTO pw_hack VALUES('inv_limitdays','string','0','');
INSERT INTO pw_hack VALUES('inv_costs','string','50','');
INSERT INTO pw_hack VALUES('inv_credit','string','currency','');
INSERT INTO pw_hack VALUES('inv_groups','string',',3,4,5,','');
INSERT INTO pw_hack VALUES('md_groups','string',',3,','');
INSERT INTO pw_hack VALUES('md_ifmsg','string','1','');
INSERT INTO pw_hack VALUES('md_ifopen','string','1','');
INSERT INTO pw_hack VALUES('o_camoney','string','0','');
INSERT INTO pw_hack VALUES('o_albumnum','string','5','');
INSERT INTO pw_hack VALUES('o_albumnum2','string','2','');
INSERT INTO pw_hack VALUES('o_maxphotonum','string','20','');
INSERT INTO pw_hack VALUES('o_mkdir','string','1','');
INSERT INTO pw_hack VALUES('o_maxfilesize','string','500','');
INSERT INTO pw_hack VALUES('o_shownum','string','500','');
INSERT INTO pw_hack VALUES('o_attachdir','string','2','');
INSERT INTO pw_hack VALUES('o_uploadsize','string','a:5:{s:3:\"jpg\";i:300;s:4:\"jpeg\";i:300;s:3:\"png\";i:400;s:3:\"gif\";i:400;s:3:\"bmp\";i:400;}','');
INSERT INTO pw_hack VALUES('o_remove','string','1','');
INSERT INTO pw_hack VALUES('o_newcolony','string','1','');
INSERT INTO pw_hack VALUES('md_ifapply','string','1','');
INSERT INTO pw_hack VALUES('md_appgroups','string','','');
INSERT INTO pw_hack VALUES('o_diary_gdcheck','string','0','');
INSERT INTO pw_hack VALUES('o_diary_qcheck','string','0','');
INSERT INTO pw_hack VALUES('o_diary_groups','string','','');
INSERT INTO pw_hack VALUES('o_diarylimit','string','0','');
INSERT INTO pw_hack VALUES('o_diarypertime','string','0','');
INSERT INTO pw_hack VALUES('o_groups_gdcheck','string','0','');
INSERT INTO pw_hack VALUES('o_groups_p_gdcheck','string','0','');
INSERT INTO pw_hack VALUES('o_groups_qcheck','string','0','');
INSERT INTO pw_hack VALUES('o_groups_p_qcheck','string','0','');
INSERT INTO pw_hack VALUES('o_share_groups','string','','');
INSERT INTO pw_hack VALUES('o_share_gdcheck','string','0','');
INSERT INTO pw_hack VALUES('o_share_qcheck','string','0','');
INSERT INTO pw_hack VALUES('o_photos_gdcheck','string','0','');
INSERT INTO pw_hack VALUES('o_photos_qcheck','string','0','');
INSERT INTO pw_hack VALUES('o_photos_groups','string','','');
INSERT INTO pw_hack VALUES('o_browseopen','string','1','');
INSERT INTO pw_hack VALUES('o_browse','string','511','');
INSERT INTO pw_hack VALUES('o_invite','string','1','');
INSERT INTO pw_hack VALUES('o_indexset','string','1023','');
INSERT INTO pw_hack VALUES('area_catetpl','string','default','');
INSERT INTO pw_hack VALUES('area_indextpl','string','default','');
INSERT INTO pw_hack VALUES('o_hot_open','string','1','');
INSERT INTO pw_hack VALUES('o_hot_groups','string',',3,4,5,16,','');
INSERT INTO pw_hack VALUES('o_classdb','string','a:1:{i:1;s:12:\"默认分类\";}','');
INSERT INTO pw_hack VALUES('area_navinfo','array','a:3:{s:4:\"KEY1\";a:1:{s:4:\"html\";s:57:\"<a href=\"cate.php?cateid=1\" id=\"td_KEY1\">默认分类</a>\";}s:4:\"KEY3\";a:1:{s:4:\"html\";s:51:\"<a href=\"cate.php?cateid=3\" id=\"td_KEY3\">糖疾</a>\";}s:4:\"KEY5\";a:1:{s:4:\"html\";s:51:\"<a href=\"cate.php?cateid=5\" id=\"td_KEY5\">其它</a>\";}}','');
INSERT INTO pw_hack VALUES('o_navinfo','array','a:5:{s:8:\"KEYindex\";a:1:{s:4:\"html\";s:57:\"<a href=\"index.php?m=o\" id=\"td_KEYindex\">圈子首页</a>\";}s:7:\"KEYhome\";a:1:{s:4:\"html\";s:55:\"<a href=\"mode.php?m=o\" id=\"td_KEYhome\">我的首页</a>\";}s:7:\"KEYuser\";a:1:{s:4:\"html\";s:62:\"<a href=\"mode.php?m=o&q=user\" id=\"td_KEYuser\">个人空间</a>\";}s:9:\"KEYfriend\";a:1:{s:4:\"html\";s:60:\"<a href=\"mode.php?m=o&q=friend\" id=\"td_KEYfriend\">朋友</a>\";}s:9:\"KEYbrowse\";a:1:{s:4:\"html\";s:66:\"<a href=\"mode.php?m=o&q=browse\" id=\"td_KEYbrowse\">随便看看</a>\";}}','');

INSERT INTO pw_help VALUES('1','0','0','','1','账户','','','0','1');
INSERT INTO pw_help VALUES('2','1','1','1','0','注册登录','','<b>如何注册成会员？</b>\nPHPWind 默认的注册方式非常简单，只需短短几秒钟的时间，即可成为站点会员。点击页面最左上角的\"注册\"，按照提示填写信息，提交即可，非常简单方便~\n正式会员将比游客享受更多的操作权限（站点设置不同，权限情况也将不同）。\n\n<b>如何登陆？</b>\n已经成为正式会员了？那么点击页面最上角的\"登录\"进入登陆页面，选择登陆方式，填写登陆信息即可完成登陆。\n保存cookie可以让网页记录用户信息，方便下次登录。公用电脑，建议不保留。','0','1');
INSERT INTO pw_help VALUES('3','1','1','1','0','忘记密码','','<b>忘记登录密码怎么办？</b>\n没有关系，在登录页面点击\"忘记密码\"，填写注册邮箱就可以找回密码了哦~找回以后，请及时更改密码。\n如果你的邮箱无效或失效，请联系站点管理员。','0','1');
INSERT INTO pw_help VALUES('4','1','1','1','0','账户设置','','<b>如何修改我的用户信息？</b>\n登录后，点击页面最左上角的\"设置\"进入用户中心，可以查看和修改你的基本信息、扩展信息等。\n\n<b>如果制定我的个性头像？</b>\n登录后，进入用户中心，点击 头像 可以设置你的个性头像。根据权限分配的不同，你或许可以使用站点自带头像，或许可以使用头像链接，或许可以使用头像上传。\n\n<b>商品信息作什么用？</b>\n用户中心-商品信息，为你发布商品帖所使用的必要信息。支付宝账号--填写支付宝账号信息，如123@163.com。完成后在商品贴中可直接链入支付宝页面；商品分类--填写待出售的商品分类。完成后，为带出售商品的可用分类选项。','0','1');
INSERT INTO pw_help VALUES('5','1','1','1','0','隐私与安全','','<b>如何保证密码安全？</b>\n1.密码要保密，并经常更改。用户中心-账号设置-密码安全，可以进行密码修改\n2.填写正确常用的邮箱为注册邮箱信息。以便密码被盗或丢失时找回\n3.密码填写要尽量复杂，不使用生日、用户名等为密码信息\n4.定期为电脑杀毒，以防止盗号木马的困扰\n\n<b>交友安全</b>\n站点的信息交互性，让我们结识了很多志同道合的朋友。但是，有时候难免遇到交友不慎的尴尬。你可以进入用户中心->隐私，修改 加好友隐私。\n\n<b>个人信息安全</b>\n进入用户中心->隐私，设置 个人空间、空间留言的访问权限。\n\n<b>如何让站点操作不显示在动态中？</b>\n进入圈子->个人空间->应用管理，设置动态显示隐私','0','1');
INSERT INTO pw_help VALUES('6','1','1','1','0','积分使用','','<b>什么是积分？</b>\n积分，是站点内用于交易流通的媒介，可以是虚拟货币，也可以是威望、贡献值等。\n\n<b>如何获取积分？</b>\n站点提供多种方式发放积分，以鼓励会员在站点的活跃性。\n1.注册成为会员可以得到一定的积分值。\n2.发表主题或对某个主题进行回复，可以得到一定的积分。\n3.对某个主题进行评价，也可以得到一定的积分。\n4.参加站点组织的活动，赢取奖励\n5.成为站点某个版块管理员，为站点做点小贡献，可以获得不菲的薪资哦~\n\n<b>如何使用积分？</b>\n积分作为站点内用于交易的媒介，可以用于购买道具、特殊组权限、帖子签名等；\n同时威望、贡献值等信息，也能提升你在站点的荣誉度与可信度。','0','1');
INSERT INTO pw_help VALUES('7','0','0','','1','主题与回复','','','0','1');
INSERT INTO pw_help VALUES('8','7','1','7','0','发表主题','','<b>如何发表主题？</b>\n在帖子列表页面和帖子阅读页面，可以看到“发表新帖”图标，点击即可进入主题帖发布页面，如果没有发帖权限，会有提示“本论坛只有特定用户组才能发表主题,请到其他版块发贴,以提高等级!”出现。\n特别地，当鼠标停在“发表新帖”图标上时，如果你在该板块有发表交易贴、悬赏帖或投票帖的权限时，就会出现一个下拉菜单，菜单项里显示：交易、悬赏、投票，点击需要的帖子类型即可进入相应的主题发表页面发布新的主题。\n你也可以在帖子列表页面底部的快速发帖框发表普通主题帖。\n\n<b>如何发表匿名帖？</b>\n在帖子列表页面和帖子阅读页面，点击“发表新帖”图标进入发帖页面，在发帖时勾选内容编辑器下面的匿名帖复选框，或者在快速发帖处勾选（如果复选框呈灰色，说明该板块不允许发布匿名贴或者您的权限不够）。','0','1');
INSERT INTO pw_help VALUES('9','0','0','','1','站点应用','','','0','1');
INSERT INTO pw_help VALUES('10','9','1','9','0','记录','','<b>什么是记录？</b>\n记录即及时记录，似tweeter的类微博，你可以随时发表感慨、晒晒心情。\n记录更可同步个人签名，显示于帖子阅读页个人头像上部，让更多的人了解和感触到你那刻的感想与心情。\n\n<b>什么是 @我的 ？</b>\n一般的记录显示在动态中，根据权限的不同，可以让好友或是站内所有人都查看阅读到。\n@我的，是记录的一种衍生。它可以单独对某个用户发起言论。只需要@+对方用户名+空格+想要对TA说的话，即可。','0','1');
INSERT INTO pw_help VALUES('12','9','1','9','0','应用组件','','<b>什么是应用组件？</b>\n应用组件是圈子中接入的第三方娱乐应用，提供了宠物、在线小游戏等多种游戏。具体规则信息等请查看对应的游戏应用。','1','1');
INSERT INTO pw_help VALUES('13','26','1','26','0','windcode','','<table><tr class=\"tr3 tr\"><td><font color=\"#5a6633\" face=\"verdana\">[quote]</font>被引用的内容，主要作用是在发帖时引用并回复具体楼层的帖子<font color=\"#5a6633\" face=\"verdana\">[/quote]</font></td><td><table cellpadding=\"5\" cellspacing=\"1\" width=\"94%\" bgcolor=\"#000000\" align=\"center\"><tr><td class=\"f_one\">被引用的帖子和您的回复内容</td></tr></table></td></tr><tr class=\"tr3 tr\"><td><font color=\"#5a6633\" face=\"verdana\">[code]</font><font color=\"#5a6633\"></font><font face=\"courier\" color=\"#333333\"><br />echo \"PHPWind 欢迎您!\"\n</font><font color=\"#5a6633\" face=\"verdana\">[/code]</font></td><th><div class=\"tpc_content\" id=\"read_553959\"><h6 class=\"quote\">Copy code</h6><blockquote id=\"code1\">echo \"PHPWind 欢迎您!\"</blockquote></div></th></tr><tr class=\"tr3 tr\"><td><font face=\"verdana\" color=\"5a6633\">[url]</font><font face=\"verdana\">http://www.phpwind.net</font><font color=\"5a6633\">[/url] </font></td><td><a href=\"http://www.phpwind.net\" target=\"_blank\"><font color=\"#000066\">http://www.phpwind.net</font></a></td></tr><tr class=\"tr3 tr\"><td><font face=\"verdana\" color=\"5a6633\">[url=http://www.phpwind.net]</font><font face=\"verdana\">PHPWind</font><font color=\"5a6633\">[/url]</font></td><td><a href=\"http://www.phpwind.net\"><font color=\"000066\">PHPWind</font></a></font></td></tr><tr class=\"tr3 tr\"><td><font face=\"verdana\" color=\"5a6633\">[email]</font><font face=\"verdana\">fengyu@163.com</font><font color=\"5a6633\">[/email]</font></td><td><a href=\"mailto:fengyu@163.com\"><font color=\"000066\">fengyu@163.com</font></a></td></tr><tr class=\"tr3 tr\"><td><font face=\"verdana\" color=\"5a6633\">[email=fengyu@163.com]</font><font face=\"verdana\">email me</font><font color=\"5a6633\">[/email]</font></td><td><a href=\"mailto:fengyu@163.com\"><font color=\"000066\">email me</font></a></td></tr><tr class=\"tr3 tr\"> <td><font face=\"verdana\" color=\"5a6633\">[b]</font><font face=\"verdana\">粗体字</font><font color=\"5a6633\" face=\"verdana\">[/b]</font> </td><td><font face=\"verdana\"><b>粗体字</b></font> </td></tr><tr class=\"tr3 tr\"><td><font face=\"verdana\" color=\"5a6633\">[i]</font><font face=\"verdana\">斜体字<font color=\"5a6633\">[/i]</font> </font></td><td><font face=\"verdana\"><i>斜体字</i></font> </td></tr><tr class=\"tr3 tr\"><td><font face=\"verdana\" color=\"5a6633\">[u]</font><font face=\"verdana\">下划线</font><font color=\"5a6633\">[/u]</font></td><td><font face=\"verdana\"><u>下划线</u></font> </td></tr><tr class=\"tr3 tr\"> <td><font face=verdana color=5a6633>[align=center(可以是向左left，向右right)]</font>位于中间<font color=\"5a6633\">[/align]</font></td><td><font face=\"verdana\"><div align=\"center\">中间对齐</div></font></td></tr><tr class=\"tr3 tr\"> <td><font face=\"verdana\" color=\"5a6633\">[size=4]</font><font face=\"verdana\">改变字体大小<font color=\"5a6633\">[/size] </font> </font></td><td><font face=\"verdana\">改变字体大小 </font></td></tr><tr class=\"tr3 tr\"> <td><font face=\"verdana\" color=\"5a6633\">[font=</font><font color=\"5a6633\">楷体_gb2312<font face=\"verdana\">]</font></font><font face=\"verdana\">改变字体<font color=\"5a6633\">[/font] </font> </font></td><td><font face=\"verdana\"><font face=楷体_gb2312>改变字体</font> </font></td></tr><tr class=\"tr3 tr\"> <td><font face=\"verdana\" color=\"5a6633\">[color=red]</font><font face=\"verdana\">改变颜色<font color=\"5a6633\">[/color] </font> </font></td><td><font face=\"verdana\" color=\"red\">改变颜色</font><font face=\"verdana\"> </font></td></tr><tr class=\"tr3 tr\"> <td><font face=\"verdana\" color=\"5a6633\">[img]</font><font face=\"verdana\">http://www.phpwind.net/logo.gif<font color=\"5a6633\">[/img]</font> </font></td><td><img src=\"logo.gif\" /></font> </td></tr><tr class=\"tr3 tr\"> <td><font face=宋体 color=\"#333333\"><font color=\"#5a6633\">[fly]</font>飞行文字特效<font color=\"#5a6633\">[/fly]</font> </font></td><td><font face=宋体&nbsp; &nbsp; color=\"#333333\"><marquee scrollamount=\"3\" behavior=\"alternate\" width=\"90%\">飞行文字特效</marquee></font></td></tr><tr class=\"tr3 tr\"> <td><font face=宋体 color=\"#333333\"><font color=\"#5a6633\">[move]</font>滚动文字特效<font color=\"#5a6633\">[/move]</font> </font></td><td><font face=宋体 color=\"#333333\"> <marquee scrollamount=\"3\" width=\"90%\">滚动文字特效</marquee></font></td></tr><tr class=\"tr3 tr\"><td><font face=宋体 color=\"#333333\"><font color=\"#5a6633\">[flash=400,300]</font>http://www.phpwind.net/wind.swf<font color=\"#5a6633\">[/flash]</font> </font></td><td><font face=宋体 color=\"#333333\">将显示flash文件</font> </td></tr><tr class=\"tr3 tr\"><td><font face=宋体 color=\"#333333\"><font color=\"#5a6633\">[iframe]</font>http://www.phpwind.net<font color=\"#5a6633\">[/iframe]</font> </font></td><td><font face=宋体 color=\"#333333\">将在帖子中粘贴网页(后台默认关闭)</font> </td></tr><tr class=\"tr3 tr\"><td><font color=#5a6633>[glow=255(宽度),red(颜色),1(边界)]</font>要产生光晕效果的文字<font color=\"#5a6633\">[/glow]</font></td><td align=\"center\"><font face=宋体 color=\"#333333\"><table width=\"255\" style=\"filter:glow(color=red, direction=1)\"><tr><td align=\"center\">要产生彩色发光效果的文字</td></tr></table></font></td></tr></table>','1','1');
INSERT INTO pw_help VALUES('16','7','1','7','0','发表回复','','<b>如何发表回复？</b>\n1.回复主题：帖子阅读页面点击“回复”按钮进入回复页面，或使用页面下方的快速发帖框即可；\n2.回复某楼层：点击该楼层中的“回复”，转到到快速回复框进行回复','0','1');
INSERT INTO pw_help VALUES('17','7','1','7','0','附件使用','','<b>如何发表附件？</b>\n在帖子编辑页面底部附带了附件上传。\n1.普通上传，表示一次上传一个文件，点击[选择文件]选择本地的文件，插入到编辑内容后，才能上传。\n2.批量上传，一次最多可上次15个文件，点击[选择文件]选择本地的文件进行上传，上传完毕后插入到编辑内容。\n\n<b>如何设置附件购买？</b>\n附件普通上传时，设置查看附件需要消耗的积分类型、积分值即可。','0','1');
INSERT INTO pw_help VALUES('24','26','1','26','0','道具使用','','<b>如何拥有道具？</b>\n1.购买。在社区->道具中心，为站点的道具交易市场。你可以在这里购买需要的道具。\n2.转让。同样在社区->道具中心，你可以让你的好友低价转让他所拥有的道具。\n\n<b>如何使用道具？</b>\n进入帖子阅读页面，在每个用户的头像下，都有个“道具”图标，点击即可选择使用你想要的道具。\n同时，在主楼（即楼主发表的主题）头部右边，有个“使用道具”，点击后，可以对楼主进行特殊对待。','0','1');
INSERT INTO pw_help VALUES('25','1','1','1','0','会员组等级','','<b>会员组等级及提升方案</b>\n会员组等级为会员在站点内的权限划分，等级越高、获得的权限也越大。站点默认以发帖数为用户提升方案。\n具体如下：\n<table><tr><td><font color=bule>头衔</font></td><td>新手上路</td><td>侠客</td><td>骑士</td><td>圣骑士</td><td>精灵王</td><td>风云使者</td><td>光明使者</td><td>天使</td></tr><tr><td><font color=bule>发帖数</font></td><td>0</td><td>100</td><td>300</td><td>600</td><td>1000</td><td>5000</td><td>10000</td><td>50000</td></tr></table>','0','1');
INSERT INTO pw_help VALUES('26','0','0','','1','常用操作','','','1','1');
INSERT INTO pw_help VALUES('27','26','1','26','0','短消息','','<b>谁可以给我发消息？</b>\n站点内的所有人都可以给你发送短信息，无论你是在线、隐私还是离线状态。\n\n<b>如何给人发消息？</b>\n1.点击用户的头像，在用户信息栏你可以看到一个短信图标，点击可直接对TA发消息；\n2.进入用户中心->短消息中心->发新短消息，根据提示填写信息即可；\n3.收到短消息后的回复，也是哦~\n4.给他人的帖子评分时，也可以进行短消息提示哦~\n\n<b>什么是消息跟踪？</b>\n消息跟踪是记录你发送出去的消息状态。如果状态为已读，表示你发的消息已经被收信人阅读了；如果状态为未读，则表示你的收信人还没有时间或兴趣来打开这条消息，那么你还有机会来更改消息的内容哦，直接点击记录后面的[编辑]即可重新编辑。','0','1');
INSERT INTO pw_help VALUES('28','9','1','9','0','日志','','<b>如何写私密日志？</b>\n你只需要在编辑完成日志时，将权限设为“仅自己可见”即可。\n\n<b>如何推荐日志给好友？</b>\n在日志列表中，可以看到[分享]按钮，点击后，在推荐栏中填写相关信息即可。','0','1');
INSERT INTO pw_help VALUES('29','9','1','9','0','群组','','<b>如何创建群组？</b>\n基础app中点击“群组”进入添加新群组，根据提示信息提交即可。\n\n<b>如何设置群管理员？</b>\n如果你是群创始人，那么你就有权利去设定该群的管理员。进入群的成员列表，选择相关的成员设置为管理员即可。\n\n<b>群组可以设置私有吗？</b>\n群组可以设置成私有。\n1.将群组加入权限设置成不允许任何人加入。\n2.将群组内容设置为不公开。\n3.将群组相册设置为不公开。\n\n<b>如何找到他人的群？</b>\n基础app->群组->所有群组，可以查看到允许查看的所有群。','0','1');
INSERT INTO pw_help VALUES('30','9','1','9','0','评价','','<b>什么是评价?</b>\n评价即是对站点内容（包括帖子、日志、相册等）给予感受的一个概括和评价。因此，不要路过吧，好歹给个点击，发表你一下意见，或许哪天它的上榜还离不开你的轻轻一点哦。','0','1');
INSERT INTO pw_help VALUES('31','26','1','26','0','帖子举报','','<b>什么是举报？</b>\n协助站长进行帖子监控、举报不良帖子推荐优秀帖子。在帖子楼层操作栏点击“举报”填写理由并提交就能实现了对当前楼层帖子举报的操作。','0','1');
INSERT INTO pw_help VALUES('32','9','1','9','0','分享','','<b>如何使用分享？</b>\n基础app->分享，填写分享信息，提交即可。\n内容阅读页，点击\"推荐\"或\"分享\"，也可以直接分享该页内容给大家哦~。\n\n<b>如何分享视频？</b>\n填写视频所在网页的网址。(不需要填写视频的真实地址)\n\n<b>如何分享音乐？</b>\n填写音乐文件的网址。(后缀需要是mp3或者wma)\n\n<b>如何分享Flash？</b>\n填写 Flash 文件的网址。(后缀需要是swf)','0','1');


INSERT INTO pw_invoke VALUES('1','首页焦点摘要','2','\r\nEOT;\r\n$pwresult = pwTplGetData(\'首页焦点摘要\',\'帖子及摘要\');\r\nprint <<<EOT\r\n\r\n\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<ul class=\"cc area-list-tree\">\r\n\r\nEOT;\r\nforeach($val[tagrelate] as $key_1=>$val_1){print <<<EOT\r\n<li><a href=\"$val_1[url]\" target=\"_blank\">$val_1[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n\r\n</ul>\r\n\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('2','首页焦点','4','\r\nEOT;\r\n$pwresult = pwTplGetData(\'首页焦点\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('26','首页社区热门','7','\r\nEOT;\r\n$pwresult = pwTplGetData(\'首页社区热门\',\'图片模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /><p>$val[title]</p></a>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('10','首页循环版块','6','\r\nEOT;\r\n$pwresult = pwTplGetData(\'首页循环版块\',\'图片模块\',$loopid);\r\nprint <<<EOT\r\n<table width=\"100%\">\r\n<tr>\r\n<th>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /><p>$val[title]</p></a>\r\nEOT;\r\n}print <<<EOT\r\n</th>\r\n<td>\r\nEOT;\r\n$pwresult = pwTplGetData(\'首页循环版块\',\'帖子排行模块\',$loopid);\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" title=\"$val[title]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>\r\n</td>\r\n</tr></table>','1','','');
INSERT INTO pw_invoke VALUES('5','首页最新图片','7','\r\nEOT;\r\n$pwresult = pwTplGetData(\'首页最新图片\',\'图片模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /><p>$val[title]</p></a>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('6','首页某版块调用1','4','\r\nEOT;\r\n$pwresult = pwTplGetData(\'首页某版块调用1\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('7','首页某版块调用2','4','\r\nEOT;\r\n$pwresult = pwTplGetData(\'首页某版块调用2\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('8','版块排行','8','\r\nEOT;\r\n$pwresult = pwTplGetData(\'版块排行\',\'版块模块\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span class=\"fr\">$val[value]</span><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('14','用户排行','12','\r\nEOT;\r\n$pwresult = pwTplGetData(\'用户排行\',\'用户模块\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span class=\"fr\">$val[value]</span><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('11','首页播放器','11','<div id=\"pwSlidePlayer\" class=\"pwSlide cc\" onmouseover=\"pwSlidePlayer(\'pause\');\" onmouseout=\"pwSlidePlayer(\'goon\');\">\r\n<!--#\r\n	$tmpCount=0;\r\n#-->\r\nEOT;\r\n$pwresult = pwTplGetData(\'首页播放器\',\'播放器\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<!--#\r\n	$tmpStyle = $tmpCount ? \'style=\"display:none;\"\' : \'\';\r\n	$tmpCount++;\r\n#-->\r\n                        <div id=\"Switch_$key\" $tmpStyle>\r\n                            <a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" />\r\n							<h1>$val[title]</h1></a>\r\n                        </div>\r\nEOT;\r\n}print <<<EOT\r\n					<div class=\"pwSlide-bg\"></div>\r\n					<ul id=\"SwitchNav\"></ul>\r\n				</div>\r\n				<div class=\"c\"></div>\r\n				<script type=\"text/javascript\" src=\"js/picplayer.js\"></script>\r\n				<script language=\"JavaScript\">pwSlidePlayer(\'play\',1,$tmpCount);</script>','0','','');
INSERT INTO pw_invoke VALUES('12','首页播放器下方','3','\r\nEOT;\r\n$pwresult = pwTplGetData(\'首页播放器下方\',\'图片模块\');\r\nprint <<<EOT\r\n<table width=\"100%\">\r\n<tr>\r\n<th>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\nEOT;\r\n}print <<<EOT\r\n</th>\r\n<td>\r\nEOT;\r\n$pwresult = pwTplGetData(\'首页播放器下方\',\'帖子排行模块\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" title=\"$val[title]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>\r\n</td>\r\n</tr></table>','0','','');
INSERT INTO pw_invoke VALUES('81','频道页中部焦点_有作者','14','\r\nEOT;\r\n$pwresult = pwTplGetData(\'频道页中部焦点_有作者\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span class=\"fr\"><a href=\"u.php?action=show&username=$val[author]\" target=\"_blank\">$val[author]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('78','频道页本版热门','13','\r\nEOT;\r\n$pwresult = pwTplGetData(\'频道页本版热门\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span><a href=\"$val[forumurl]\" target=\"_blank\">[$val[forumname]]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('79','频道页页面中部焦点','13','\r\nEOT;\r\n$pwresult = pwTplGetData(\'频道页页面中部焦点\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span><a href=\"$val[forumurl]\" target=\"_blank\">[$val[forumname]]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('80','频道页中部焦点摘要图片','5','\r\nEOT;\r\n$pwresult = pwTplGetData(\'频道页中部焦点摘要图片\',\'图文模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<div class=\"c\"></div>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('76','频道页焦点摘要','2','\r\nEOT;\r\n$pwresult = pwTplGetData(\'频道页焦点摘要\',\'帖子及摘要\');\r\nprint <<<EOT\r\n\r\n\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<ul class=\"cc area-list-tree\">\r\n\r\nEOT;\r\nforeach($val[tagrelate] as $key_1=>$val_1){print <<<EOT\r\n<li><a href=\"$val_1[url]\" target=\"_blank\">$val_1[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n\r\n</ul>\r\n\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('77','频道页焦点列表','4','\r\nEOT;\r\n$pwresult = pwTplGetData(\'频道页焦点列表\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('74','频道页播放器','11','<div id=\"pwSlidePlayer\" class=\"pwSlide cc\" onmouseover=\"pwSlidePlayer(\'pause\');\" onmouseout=\"pwSlidePlayer(\'goon\');\">\r\n<!--#\r\n	$tmpCount=0;\r\n#-->\r\nEOT;\r\n$pwresult = pwTplGetData(\'频道页播放器\',\'播放器\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<!--#\r\n	$tmpStyle = $tmpCount ? \'style=\"display:none;\"\' : \'\';\r\n	$tmpCount++;\r\n#-->\r\n                        <div id=\"Switch_$key\" $tmpStyle>\r\n                            <a href=\"$val[url]\" target=\"_blank\"><img class=\"pwSlideFilter\" src=\"$val[image]\" />\r\n							<h1>$val[title]</h1></a>\r\n                        </div>\r\nEOT;\r\n}print <<<EOT\r\n					<ul id=\"SwitchNav\"></ul>\r\n					<div class=\"pwSlide-bg\"></div>\r\n				</div>\r\n				<div class=\"c\"></div>\r\n				<script type=\"text/javascript\" src=\"js/picplayer.js\"></script>\r\n				<script language=\"JavaScript\">pwSlidePlayer(\'play\',1,$tmpCount);</script>','0','','');
INSERT INTO pw_invoke VALUES('27','fun_焦点摘要','2','\r\nEOT;\r\n$pwresult = pwTplGetData(\'fun_焦点摘要\',\'帖子及摘要\');\r\nprint <<<EOT\r\n\r\n\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<ul class=\"cc area-list-tree\">\r\n\r\nEOT;\r\nforeach($val[tagrelate] as $key_1=>$val_1){print <<<EOT\r\n<li><a href=\"$val_1[url]\" target=\"_blank\">$val_1[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n\r\n</ul>\r\n\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('28','fun_焦点列表','4','\r\nEOT;\r\n$pwresult = pwTplGetData(\'fun_焦点列表\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('29','fun_本版热门','13','\r\nEOT;\r\n$pwresult = pwTplGetData(\'fun_本版热门\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span><a href=\"$val[forumurl]\" target=\"_blank\">[$val[forumname]]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('30','fun_播放器','11','<div id=\"pwSlidePlayer\" class=\"pwSlide cc\" onmouseover=\"pwSlidePlayer(\'pause\');\" onmouseout=\"pwSlidePlayer(\'goon\');\">\r\n<!--#\r\n	$tmpCount=0;\r\n#-->\r\nEOT;\r\n$pwresult = pwTplGetData(\'fun_播放器\',\'播放器\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<!--#\r\n	$tmpStyle = $tmpCount ? \'style=\"display:none;\"\' : \'\';\r\n	$tmpCount++;\r\n#-->\r\n                        <div id=\"Switch_$key\" $tmpStyle>\r\n                            <a href=\"$val[url]\" target=\"_blank\"><img class=\"pwSlideFilter\" src=\"$val[image]\" />\r\n							<h1>$val[title]</h1></a>\r\n                        </div>\r\nEOT;\r\n}print <<<EOT\r\n					<ul id=\"SwitchNav\"></ul>\r\n					<div class=\"pwSlide-bg\"></div>\r\n				</div>\r\n				<div class=\"c\"></div>\r\n				<script type=\"text/javascript\" src=\"js/picplayer.js\"></script>\r\n				<script language=\"JavaScript\">pwSlidePlayer(\'play\',1,$tmpCount);</script>','0','','');
INSERT INTO pw_invoke VALUES('32','频道左侧站点推荐','7','\r\nEOT;\r\n$pwresult = pwTplGetData(\'频道左侧站点推荐\',\'图片模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /><p>$val[title]</p></a>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('33','fun_页面中部焦点','13','\r\nEOT;\r\n$pwresult = pwTplGetData(\'fun_页面中部焦点\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span><a href=\"$val[forumurl]\" target=\"_blank\">[$val[forumname]]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('36','fun_中部焦点摘要图片','5','\r\nEOT;\r\n$pwresult = pwTplGetData(\'fun_中部焦点摘要图片\',\'图文模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<div class=\"c\"></div>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('40','fun_中部焦点_有作者','14','\r\nEOT;\r\n$pwresult = pwTplGetData(\'fun_中部焦点_有作者\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span class=\"fr\"><a href=\"u.php?action=show&username=$val[author]\" target=\"_blank\">$val[author]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('44','auto_播放器','11','<div id=\"pwSlidePlayer\" class=\"pwSlide cc\" onmouseover=\"pwSlidePlayer(\'pause\');\" onmouseout=\"pwSlidePlayer(\'goon\');\">\r\n<!--#\r\n	$tmpCount=0;\r\n#-->\r\nEOT;\r\n$pwresult = pwTplGetData(\'auto_播放器\',\'播放器\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<!--#\r\n	$tmpStyle = $tmpCount ? \'style=\"display:none;\"\' : \'\';\r\n	$tmpCount++;\r\n#-->\r\n                        <div id=\"Switch_$key\" $tmpStyle>\r\n                            <a href=\"$val[url]\" target=\"_blank\"><img class=\"pwSlideFilter\" src=\"$val[image]\" />\r\n							<h1>$val[title]</h1></a>\r\n                        </div>\r\nEOT;\r\n}print <<<EOT\r\n					<ul id=\"SwitchNav\"></ul>\r\n					<div class=\"pwSlide-bg\"></div>\r\n				</div>\r\n				<div class=\"c\"></div>\r\n				<script type=\"text/javascript\" src=\"js/picplayer.js\"></script>\r\n				<script language=\"JavaScript\">pwSlidePlayer(\'play\',1,$tmpCount);</script>','0','','');
INSERT INTO pw_invoke VALUES('43','fun_频道页循环','15','\r\nEOT;\r\n$pwresult = pwTplGetData(\'fun_频道页循环\',\'图片模块\',$loopid);\r\nprint <<<EOT\r\n<table width=\"100%\">\r\n<tr>\r\n<th>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<div class=\"c\"></div>\r\nEOT;\r\n}print <<<EOT\r\n</th>\r\n<td>\r\nEOT;\r\n$pwresult = pwTplGetData(\'fun_频道页循环\',\'帖子排行模块\',$loopid);\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"u.php?action=show&username=$val[author]\" class=\"fr\">$val[author]</a><span><a href=\"$val[forumurl]\" target=\"_blank\">[$val[forumname]]</a></span><a href=\"$val[url]\" title=\"$val[title]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>\r\n</td>\r\n</tr></table>','1','','');
INSERT INTO pw_invoke VALUES('45','auto_焦点摘要','2','\r\nEOT;\r\n$pwresult = pwTplGetData(\'auto_焦点摘要\',\'帖子及摘要\');\r\nprint <<<EOT\r\n\r\n\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<ul class=\"cc area-list-tree\">\r\n\r\nEOT;\r\nforeach($val[tagrelate] as $key_1=>$val_1){print <<<EOT\r\n<li><a href=\"$val_1[url]\" target=\"_blank\">$val_1[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n\r\n</ul>\r\n\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('46','auto_焦点列表','4','\r\nEOT;\r\n$pwresult = pwTplGetData(\'auto_焦点列表\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('47','auto_本版热门','13','\r\nEOT;\r\n$pwresult = pwTplGetData(\'auto_本版热门\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span><a href=\"$val[forumurl]\" target=\"_blank\">[$val[forumname]]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('48','atuo_中部图片','16','\r\nEOT;\r\n$pwresult = pwTplGetData(\'atuo_中部图片\',\'图片模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('49','auto_中部焦点1','13','\r\nEOT;\r\n$pwresult = pwTplGetData(\'auto_中部焦点1\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span><a href=\"$val[forumurl]\" target=\"_blank\">[$val[forumname]]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('50','auto_中部焦点2','13','\r\nEOT;\r\n$pwresult = pwTplGetData(\'auto_中部焦点2\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span><a href=\"$val[forumurl]\" target=\"_blank\">[$val[forumname]]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('51','atuo_频道页循环','15','\r\nEOT;\r\n$pwresult = pwTplGetData(\'atuo_频道页循环\',\'图片模块\',$loopid);\r\nprint <<<EOT\r\n<table width=\"100%\">\r\n<tr>\r\n<th>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<div class=\"c\"></div>\r\nEOT;\r\n}print <<<EOT\r\n</th>\r\n<td>\r\nEOT;\r\n$pwresult = pwTplGetData(\'atuo_频道页循环\',\'帖子排行模块\',$loopid);\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"u.php?action=show&username=$val[author]\" class=\"fr\">$val[author]</a><a href=\"$val[url]\" title=\"$val[title]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>\r\n</td>\r\n</tr></table>','1','','');
INSERT INTO pw_invoke VALUES('52','children_播放器','11','<div id=\"pwSlidePlayer\" class=\"pwSlide cc\" onmouseover=\"pwSlidePlayer(\'pause\');\" onmouseout=\"pwSlidePlayer(\'goon\');\">\r\n<!--#\r\n	$tmpCount=0;\r\n#-->\r\nEOT;\r\n$pwresult = pwTplGetData(\'children_播放器\',\'播放器\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<!--#\r\n	$tmpStyle = $tmpCount ? \'style=\"display:none;\"\' : \'\';\r\n	$tmpCount++;\r\n#-->\r\n                        <div id=\"Switch_$key\" $tmpStyle>\r\n                            <a href=\"$val[url]\" target=\"_blank\"><img class=\"pwSlideFilter\" src=\"$val[image]\" />\r\n							<h1>$val[title]</h1></a>\r\n                        </div>\r\nEOT;\r\n}print <<<EOT\r\n					<ul id=\"SwitchNav\"></ul>\r\n					<div class=\"pwSlide-bg\"></div>\r\n				</div>\r\n				<div class=\"c\"></div>\r\n				<script type=\"text/javascript\" src=\"js/picplayer.js\"></script>\r\n				<script language=\"JavaScript\">pwSlidePlayer(\'play\',1,$tmpCount);</script>','0','','');
INSERT INTO pw_invoke VALUES('53','children_焦点摘要','2','\r\nEOT;\r\n$pwresult = pwTplGetData(\'children_焦点摘要\',\'帖子及摘要\');\r\nprint <<<EOT\r\n\r\n\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<ul class=\"cc area-list-tree\">\r\n\r\nEOT;\r\nforeach($val[tagrelate] as $key_1=>$val_1){print <<<EOT\r\n<li><a href=\"$val_1[url]\" target=\"_blank\">$val_1[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n\r\n</ul>\r\n\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('54','children_焦点列表','4','\r\nEOT;\r\n$pwresult = pwTplGetData(\'children_焦点列表\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('55','children_本版热门','13','\r\nEOT;\r\n$pwresult = pwTplGetData(\'children_本版热门\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span><a href=\"$val[forumurl]\" target=\"_blank\">[$val[forumname]]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('56','children_页面中部焦点','13','\r\nEOT;\r\n$pwresult = pwTplGetData(\'children_页面中部焦点\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span><a href=\"$val[forumurl]\" target=\"_blank\">[$val[forumname]]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('57','children_中部焦点摘要图片','5','\r\nEOT;\r\n$pwresult = pwTplGetData(\'children_中部焦点摘要图片\',\'图文模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<div class=\"c\"></div>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('58','children_中部焦点_有作者','14','\r\nEOT;\r\n$pwresult = pwTplGetData(\'children_中部焦点_有作者\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span class=\"fr\"><a href=\"u.php?action=show&username=$val[author]\" target=\"_blank\">$val[author]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('59','children_频道页循环','15','\r\nEOT;\r\n$pwresult = pwTplGetData(\'children_频道页循环\',\'图片模块\',$loopid);\r\nprint <<<EOT\r\n<table width=\"100%\">\r\n<tr>\r\n<th>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<div class=\"c\"></div>\r\nEOT;\r\n}print <<<EOT\r\n</th>\r\n<td>\r\nEOT;\r\n$pwresult = pwTplGetData(\'children_频道页循环\',\'帖子排行模块\',$loopid);\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"u.php?action=show&username=$val[author]\" class=\"fr\">$val[author]</a><a href=\"$val[url]\" title=\"$val[title]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>\r\n</td>\r\n</tr></table>','1','','');
INSERT INTO pw_invoke VALUES('60','jia_播放器','11','<div id=\"pwSlidePlayer\" class=\"pwSlide cc\" onmouseover=\"pwSlidePlayer(\'pause\');\" onmouseout=\"pwSlidePlayer(\'goon\');\">\r\n<!--#\r\n	$tmpCount=0;\r\n#-->\r\nEOT;\r\n$pwresult = pwTplGetData(\'jia_播放器\',\'播放器\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<!--#\r\n	$tmpStyle = $tmpCount ? \'style=\"display:none;\"\' : \'\';\r\n	$tmpCount++;\r\n#-->\r\n                        <div id=\"Switch_$key\" $tmpStyle>\r\n                            <a href=\"$val[url]\" target=\"_blank\"><img class=\"pwSlideFilter\" src=\"$val[image]\" />\r\n							<h1>$val[title]</h1></a>\r\n                        </div>\r\nEOT;\r\n}print <<<EOT\r\n					<ul id=\"SwitchNav\"></ul>\r\n					<div class=\"pwSlide-bg\"></div>\r\n				</div>\r\n				<div class=\"c\"></div>\r\n				<script type=\"text/javascript\" src=\"js/picplayer.js\"></script>\r\n				<script language=\"JavaScript\">pwSlidePlayer(\'play\',1,$tmpCount);</script>','0','','');
INSERT INTO pw_invoke VALUES('61','jia_焦点摘要','2','\r\nEOT;\r\n$pwresult = pwTplGetData(\'jia_焦点摘要\',\'帖子及摘要\');\r\nprint <<<EOT\r\n\r\n\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<ul class=\"cc area-list-tree\">\r\n\r\nEOT;\r\nforeach($val[tagrelate] as $key_1=>$val_1){print <<<EOT\r\n<li><a href=\"$val_1[url]\" target=\"_blank\">$val_1[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n\r\n</ul>\r\n\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('62','jia_页面中部焦点','13','\r\nEOT;\r\n$pwresult = pwTplGetData(\'jia_页面中部焦点\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span><a href=\"$val[forumurl]\" target=\"_blank\">[$val[forumname]]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('63','jia_中部焦点摘要图片','5','\r\nEOT;\r\n$pwresult = pwTplGetData(\'jia_中部焦点摘要图片\',\'图文模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<div class=\"c\"></div>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('64','jia_中部焦点_有作者','14','\r\nEOT;\r\n$pwresult = pwTplGetData(\'jia_中部焦点_有作者\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span class=\"fr\"><a href=\"u.php?action=show&username=$val[author]\" target=\"_blank\">$val[author]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('65','jia_频道页循环','15','\r\nEOT;\r\n$pwresult = pwTplGetData(\'jia_频道页循环\',\'图片模块\',$loopid);\r\nprint <<<EOT\r\n<table width=\"100%\">\r\n<tr>\r\n<th>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<div class=\"c\"></div>\r\nEOT;\r\n}print <<<EOT\r\n</th>\r\n<td>\r\nEOT;\r\n$pwresult = pwTplGetData(\'jia_频道页循环\',\'帖子排行模块\',$loopid);\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"u.php?action=show&username=$val[author]\" class=\"fr\">$val[author]</a><a href=\"$val[url]\" title=\"$val[title]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>\r\n</td>\r\n</tr></table>','1','','');
INSERT INTO pw_invoke VALUES('66','women_播放器','11','<div id=\"pwSlidePlayer\" class=\"pwSlide cc\" onmouseover=\"pwSlidePlayer(\'pause\');\" onmouseout=\"pwSlidePlayer(\'goon\');\">\r\n<!--#\r\n	$tmpCount=0;\r\n#-->\r\nEOT;\r\n$pwresult = pwTplGetData(\'women_播放器\',\'播放器\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<!--#\r\n	$tmpStyle = $tmpCount ? \'style=\"display:none;\"\' : \'\';\r\n	$tmpCount++;\r\n#-->\r\n                        <div id=\"Switch_$key\" $tmpStyle>\r\n                            <a href=\"$val[url]\" target=\"_blank\"><img class=\"pwSlideFilter\" src=\"$val[image]\" />\r\n							<h1>$val[title]</h1></a>\r\n                        </div>\r\nEOT;\r\n}print <<<EOT\r\n					<ul id=\"SwitchNav\"></ul>\r\n					<div class=\"pwSlide-bg\"></div>\r\n				</div>\r\n				<div class=\"c\"></div>\r\n				<script type=\"text/javascript\" src=\"js/picplayer.js\"></script>\r\n				<script language=\"JavaScript\">pwSlidePlayer(\'play\',1,$tmpCount);</script>','0','','');
INSERT INTO pw_invoke VALUES('67','women_焦点摘要','2','\r\nEOT;\r\n$pwresult = pwTplGetData(\'women_焦点摘要\',\'帖子及摘要\');\r\nprint <<<EOT\r\n\r\n\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<ul class=\"cc area-list-tree\">\r\n\r\nEOT;\r\nforeach($val[tagrelate] as $key_1=>$val_1){print <<<EOT\r\n<li><a href=\"$val_1[url]\" target=\"_blank\">$val_1[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n\r\n</ul>\r\n\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('68','women_焦点图片摘要','5','\r\nEOT;\r\n$pwresult = pwTplGetData(\'women_焦点图片摘要\',\'图文模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<div class=\"c\"></div>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('69','women_本版热门','13','\r\nEOT;\r\n$pwresult = pwTplGetData(\'women_本版热门\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span><a href=\"$val[forumurl]\" target=\"_blank\">[$val[forumname]]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('70','women_页面中部焦点','13','\r\nEOT;\r\n$pwresult = pwTplGetData(\'women_页面中部焦点\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span><a href=\"$val[forumurl]\" target=\"_blank\">[$val[forumname]]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('71','women_中部焦点摘要图片','5','\r\nEOT;\r\n$pwresult = pwTplGetData(\'women_中部焦点摘要图片\',\'图文模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<div class=\"c\"></div>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('72','women_中部焦点_有作者','14','\r\nEOT;\r\n$pwresult = pwTplGetData(\'women_中部焦点_有作者\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span class=\"fr\"><a href=\"u.php?action=show&username=$val[author]\" target=\"_blank\">$val[author]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('73','women_频道页循环','15','\r\nEOT;\r\n$pwresult = pwTplGetData(\'women_频道页循环\',\'图片模块\',$loopid);\r\nprint <<<EOT\r\n<table width=\"100%\">\r\n<tr>\r\n<th>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<div class=\"c\"></div>\r\nEOT;\r\n}print <<<EOT\r\n</th>\r\n<td>\r\nEOT;\r\n$pwresult = pwTplGetData(\'women_频道页循环\',\'帖子排行模块\',$loopid);\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"u.php?action=show&username=$val[author]\" class=\"fr\">$val[author]</a><a href=\"$val[url]\" title=\"$val[title]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>\r\n</td>\r\n</tr></table>','1','','');
INSERT INTO pw_invoke VALUES('83','频道页循环','15','\r\nEOT;\r\n$pwresult = pwTplGetData(\'频道页循环\',\'图片模块\',$loopid);\r\nprint <<<EOT\r\n<table width=\"100%\">\r\n<tr>\r\n<th>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<div class=\"c\"></div>\r\nEOT;\r\n}print <<<EOT\r\n</th>\r\n<td>\r\nEOT;\r\n$pwresult = pwTplGetData(\'频道页循环\',\'帖子排行模块\',$loopid);\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"u.php?action=show&username=$val[author]\" class=\"fr\">$val[author]</a><a href=\"$val[url]\" title=\"$val[title]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>\r\n</td>\r\n</tr></table>','1','','');
INSERT INTO pw_invoke VALUES('84','home2_首页焦点摘要','2','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home2_首页焦点摘要\',\'帖子及摘要\');\r\nprint <<<EOT\r\n\r\n\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<ul class=\"cc area-list-tree\">\r\n\r\nEOT;\r\nforeach($val[tagrelate] as $key_1=>$val_1){print <<<EOT\r\n<li><a href=\"$val_1[url]\" target=\"_blank\">$val_1[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n\r\n</ul>\r\n\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('85','home2_首页播放器','11','<div id=\"pwSlidePlayer\" class=\"pwSlide cc\" onmouseover=\"pwSlidePlayer(\'pause\');\" onmouseout=\"pwSlidePlayer(\'goon\');\">\r\n<!--#\r\n	$tmpCount=0;\r\n#-->\r\nEOT;\r\n$pwresult = pwTplGetData(\'home2_首页播放器\',\'播放器\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<!--#\r\n	$tmpStyle = $tmpCount ? \'style=\"display:none;\"\' : \'\';\r\n	$tmpCount++;\r\n#-->\r\n                        <div id=\"Switch_$key\" $tmpStyle>\r\n                            <a href=\"$val[url]\" target=\"_blank\"><img class=\"pwSlideFilter\" src=\"$val[image]\" />\r\n							<h1>$val[title]</h1></a>\r\n                        </div>\r\nEOT;\r\n}print <<<EOT\r\n					<ul id=\"SwitchNav\"></ul>\r\n					<div class=\"pwSlide-bg\"></div>\r\n				</div>\r\n				<div class=\"c\"></div>\r\n				<script type=\"text/javascript\" src=\"js/picplayer.js\"></script>\r\n				<script language=\"JavaScript\">pwSlidePlayer(\'play\',1,$tmpCount);</script>','0','','');
INSERT INTO pw_invoke VALUES('88','home2_首页焦点附说明','17','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home2_首页焦点附说明\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[forumurl]\"><span>[$val[forumname]]</span></a><a href=\"$val[url]\">$val[title]</a><span>&nbsp;$val[descrip]</span></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('89','home2_热门话题','4','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home2_热门话题\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('90','home2_中部图片','7','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home2_中部图片\',\'图片模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /><p>$val[title]</p></a>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('91','home2_中部焦点摘要','2','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home2_中部焦点摘要\',\'帖子及摘要\');\r\nprint <<<EOT\r\n\r\n\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<ul class=\"cc area-list-tree\">\r\n\r\nEOT;\r\nforeach($val[tagrelate] as $key_1=>$val_1){print <<<EOT\r\n<li><a href=\"$val_1[url]\" target=\"_blank\">$val_1[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n\r\n</ul>\r\n\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('92','home2_中部大图','16','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home2_中部大图\',\'图片模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('93','home2_中部帖子列表','4','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home2_中部帖子列表\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('94','home2_首页中部热门','4','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home2_首页中部热门\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('95','home2_首页循环版块','4','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home2_首页循环版块\',\'帖子列表\',$loopid);\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','1','a:2:{i:0;s:2:\"18\";i:1;s:2:\"39\";}','');
INSERT INTO pw_invoke VALUES('96','home1_首页焦点摘要','2','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home1_首页焦点摘要\',\'帖子及摘要\');\r\nprint <<<EOT\r\n\r\n\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<ul class=\"cc area-list-tree\">\r\n\r\nEOT;\r\nforeach($val[tagrelate] as $key_1=>$val_1){print <<<EOT\r\n<li><a href=\"$val_1[url]\" target=\"_blank\">$val_1[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n\r\n</ul>\r\n\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('98','home1_首页头部左侧焦点','18','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home1_首页头部左侧焦点\',\'图片模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\nEOT;\r\n}print <<<EOT\r\n<div class=\"c\"></div>\r\nEOT;\r\n$pwresult = pwTplGetData(\'home1_首页头部左侧焦点\',\'帖子模块\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('99','home1_首页播放器','11','<div id=\"pwSlidePlayer\" class=\"pwSlide cc\" onmouseover=\"pwSlidePlayer(\'pause\');\" onmouseout=\"pwSlidePlayer(\'goon\');\">\r\n<!--#\r\n	$tmpCount=0;\r\n#-->\r\nEOT;\r\n$pwresult = pwTplGetData(\'home1_首页播放器\',\'播放器\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<!--#\r\n	$tmpStyle = $tmpCount ? \'style=\"display:none;\"\' : \'\';\r\n	$tmpCount++;\r\n#-->\r\n                        <div id=\"Switch_$key\" $tmpStyle>\r\n                            <a href=\"$val[url]\" target=\"_blank\"><img class=\"pwSlideFilter\" src=\"$val[image]\" />\r\n							<h1>$val[title]</h1></a>\r\n                        </div>\r\nEOT;\r\n}print <<<EOT\r\n					<ul id=\"SwitchNav\"></ul>\r\n					<div class=\"pwSlide-bg\"></div>\r\n				</div>\r\n				<div class=\"c\"></div>\r\n				<script type=\"text/javascript\" src=\"js/picplayer.js\"></script>\r\n				<script language=\"JavaScript\">pwSlidePlayer(\'play\',1,$tmpCount);</script>','0','','');
INSERT INTO pw_invoke VALUES('100','home1_首页头部右侧焦点','4','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home1_首页头部右侧焦点\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('101','home1_首页中部帖子列表','4','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home1_首页中部帖子列表\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('103','home1_首页中部右侧','1','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home1_首页中部右侧\',\'图片模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\nEOT;\r\n}$pwresult = pwTplGetData(\'home1_首页中部右侧\',\'帖子排行模块\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" title=\"$val[title]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('105','home1_首页中部标签','19','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home1_首页中部标签\',\'标签模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\">$val[title]</a>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('106','home1_首页中部图片','7','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home1_首页中部图片\',\'图片模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /><p>$val[title]</p></a>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('107','home1_首页版块排行','8','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home1_首页版块排行\',\'版块模块\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span class=\"fr\">$val[value]</span><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('108','home1_首页版块循环','20','\r\nEOT;\r\n$pwresult = pwTplGetData(\'home1_首页版块循环\',\'图片模块\',$loopid);\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\nEOT;\r\n}print <<<EOT\r\n<div class=\"c\"></div>\r\nEOT;\r\n$pwresult = pwTplGetData(\'home1_首页版块循环\',\'帖子模块\',$loopid);\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','1','a:4:{i:0;s:2:\"18\";i:1;s:2:\"39\";i:2;s:1:\"2\";i:3;s:1:\"3\";}','');
INSERT INTO pw_invoke VALUES('109','category_频道页头部左侧焦点','18','\r\nEOT;\r\n$pwresult = pwTplGetData(\'category_频道页头部左侧焦点\',\'图片模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\nEOT;\r\n}print <<<EOT\r\n<div class=\"c\"></div>\r\nEOT;\r\n$pwresult = pwTplGetData(\'category_频道页头部左侧焦点\',\'帖子模块\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('110','category_频道页热门标签','19','\r\nEOT;\r\n$pwresult = pwTplGetData(\'category_频道页热门标签\',\'标签模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\">$val[title]</a>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('111','category_频道页版块排行','8','\r\nEOT;\r\n$pwresult = pwTplGetData(\'category_频道页版块排行\',\'版块模块\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span class=\"fr\">$val[value]</span><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('112','category_频道页焦点摘要','2','\r\nEOT;\r\n$pwresult = pwTplGetData(\'category_频道页焦点摘要\',\'帖子及摘要\');\r\nprint <<<EOT\r\n\r\n\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\n<ul class=\"cc area-list-tree\">\r\n\r\nEOT;\r\nforeach($val[tagrelate] as $key_1=>$val_1){print <<<EOT\r\n<li><a href=\"$val_1[url]\" target=\"_blank\">$val_1[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n\r\n</ul>\r\n\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('113','category_频道页焦点列表','4','\r\nEOT;\r\n$pwresult = pwTplGetData(\'category_频道页焦点列表\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('114','category_频道页播放器','11','<div id=\"pwSlidePlayer\" class=\"pwSlide cc\" onmouseover=\"pwSlidePlayer(\'pause\');\" onmouseout=\"pwSlidePlayer(\'goon\');\">\r\n<!--#\r\n	$tmpCount=0;\r\n#-->\r\nEOT;\r\n$pwresult = pwTplGetData(\'category_频道页播放器\',\'播放器\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<!--#\r\n	$tmpStyle = $tmpCount ? \'style=\"display:none;\"\' : \'\';\r\n	$tmpCount++;\r\n#-->\r\n                        <div id=\"Switch_$key\" $tmpStyle>\r\n                            <a href=\"$val[url]\" target=\"_blank\"><img class=\"pwSlideFilter\" src=\"$val[image]\" />\r\n							<h1>$val[title]</h1></a>\r\n                        </div>\r\nEOT;\r\n}print <<<EOT\r\n					<ul id=\"SwitchNav\"></ul>\r\n					<div class=\"pwSlide-bg\"></div>\r\n				</div>\r\n				<div class=\"c\"></div>\r\n				<script type=\"text/javascript\" src=\"js/picplayer.js\"></script>\r\n				<script language=\"JavaScript\">pwSlidePlayer(\'play\',1,$tmpCount);</script>','0','','');
INSERT INTO pw_invoke VALUES('115','category_频道页中部焦点','13','\r\nEOT;\r\n$pwresult = pwTplGetData(\'category_频道页中部焦点\',\'帖子列表\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><span><a href=\"$val[forumurl]\" target=\"_blank\">[$val[forumname]]</a></span><a href=\"$val[url]\"  target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('116','category_频道页中部右侧','1','\r\nEOT;\r\n$pwresult = pwTplGetData(\'category_频道页中部右侧\',\'图片模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\nEOT;\r\n}$pwresult = pwTplGetData(\'category_频道页中部右侧\',\'帖子排行模块\');\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" title=\"$val[title]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','0','','');
INSERT INTO pw_invoke VALUES('117','category_版块中部图片','7','\r\nEOT;\r\n$pwresult = pwTplGetData(\'category_版块中部图片\',\'图片模块\');\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /><p>$val[title]</p></a>\r\nEOT;\r\n}print <<<EOT\r\n','0','','');
INSERT INTO pw_invoke VALUES('118','category_频道页版块循环','20','\r\nEOT;\r\n$pwresult = pwTplGetData(\'category_频道页版块循环\',\'图片模块\',$loopid);\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<a href=\"$val[url]\" target=\"_blank\"><img src=\"$val[image]\" class=\"fl\" /></a>\r\n<h4><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></h4>\r\n<p>$val[descrip]</p>\r\nEOT;\r\n}print <<<EOT\r\n<div class=\"c\"></div>\r\nEOT;\r\n$pwresult = pwTplGetData(\'category_频道页版块循环\',\'帖子模块\',$loopid);\r\nprint <<<EOT\r\n<ul>\r\nEOT;\r\nforeach($pwresult as $key=>$val){print <<<EOT\r\n<li><a href=\"$val[url]\" target=\"_blank\">$val[title]</a></li>\r\nEOT;\r\n}print <<<EOT\r\n</ul>','1','a:4:{i:0;s:2:\"18\";i:1;s:2:\"39\";i:2;s:2:\"78\";i:3;s:2:\"65\";}','');

INSERT INTO pw_invokepiece VALUES('142','首页焦点摘要','帖子及摘要','subject','newsubject','3','','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"25\";s:7:\"descrip\";s:2:\"40\";s:9:\"tagrelate\";s:7:\"default\";}','1800');
INSERT INTO pw_invokepiece VALUES('2','首页焦点','帖子列表','subject','newsubject','15','','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','1800');
INSERT INTO pw_invokepiece VALUES('33','首页社区热门','图片模块','image','newpic','3','','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"20\";}','1700');
INSERT INTO pw_invokepiece VALUES('12','首页循环版块','帖子排行模块','subject','newsubject','12','0','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"45\";}','1800');
INSERT INTO pw_invokepiece VALUES('11','首页循环版块','图片模块','image','newpic','4','0','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:1:\"8\";}','1700');
INSERT INTO pw_invokepiece VALUES('6','首页最新图片','图片模块','image','newpic','6','','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"15\";}','1700');
INSERT INTO pw_invokepiece VALUES('7','首页某版块调用1','帖子列表','subject','newsubject','8','','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','1800');
INSERT INTO pw_invokepiece VALUES('8','首页某版块调用2','帖子列表','subject','newsubject','8','','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','1800');
INSERT INTO pw_invokepiece VALUES('9','版块排行','版块模块','forum','forumsort','12','topic','a:3:{s:5:\"value\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:7:\"default\";}','86400');
INSERT INTO pw_invokepiece VALUES('13','首页播放器','播放器','image','newpic','6','','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"288,200\";s:5:\"title\";s:2:\"36\";}','1700');
INSERT INTO pw_invokepiece VALUES('14','首页播放器下方','图片模块','image','newpic','2','','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";}','1700');
INSERT INTO pw_invokepiece VALUES('15','首页播放器下方','帖子排行模块','subject','newsubject','10','','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"30\";}','1800');
INSERT INTO pw_invokepiece VALUES('18','用户排行','用户模块','user','usersort','12','money','a:3:{s:5:\"value\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:7:\"default\";}','3000');
INSERT INTO pw_invokepiece VALUES('94','频道页中部焦点摘要图片','图文模块','image','newpic','1','fid','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"32\";s:7:\"descrip\";s:2:\"70\";}','9800');
INSERT INTO pw_invokepiece VALUES('93','频道页页面中部焦点','帖子列表','subject','newsubject','10','fid','a:4:{s:8:\"forumurl\";s:7:\"default\";s:9:\"forumname\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9800');
INSERT INTO pw_invokepiece VALUES('92','频道页本版热门','帖子列表','subject','newsubject','8','fid','a:4:{s:8:\"forumurl\";s:7:\"default\";s:9:\"forumname\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9800');
INSERT INTO pw_invokepiece VALUES('143','频道页焦点摘要','帖子及摘要','subject','newsubject','3','','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"25\";s:7:\"descrip\";s:2:\"40\";s:9:\"tagrelate\";s:7:\"default\";}','1800');
INSERT INTO pw_invokepiece VALUES('91','频道页焦点列表','帖子列表','subject','newsubject','5','fid','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9600');
INSERT INTO pw_invokepiece VALUES('88','频道页播放器','播放器','image','newpic','6','fid','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"288,320\";s:5:\"title\";s:2:\"36\";}','9800');
INSERT INTO pw_invokepiece VALUES('144','fun_焦点摘要','帖子及摘要','subject','newsubject','3','','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"25\";s:7:\"descrip\";s:2:\"40\";s:9:\"tagrelate\";s:7:\"default\";}','1800');
INSERT INTO pw_invokepiece VALUES('35','fun_焦点列表','帖子列表','subject','replysort','5','fid','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"50\";}','9600');
INSERT INTO pw_invokepiece VALUES('36','fun_本版热门','帖子列表','subject','hitsort','8','fid','a:4:{s:8:\"forumurl\";s:7:\"default\";s:9:\"forumname\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"30\";}','9600');
INSERT INTO pw_invokepiece VALUES('37','fun_播放器','播放器','image','newpic','6','fid','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"288,320\";s:5:\"title\";s:2:\"36\";}','1700');
INSERT INTO pw_invokepiece VALUES('39','频道左侧站点推荐','图片模块','image','newpic','5','','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"20\";}','1700');
INSERT INTO pw_invokepiece VALUES('40','fun_页面中部焦点','帖子列表','subject','newsubject','10','fid','a:4:{s:8:\"forumurl\";s:7:\"default\";s:9:\"forumname\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9000');
INSERT INTO pw_invokepiece VALUES('43','fun_中部焦点摘要图片','图文模块','image','newpic','1','fid','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"32\";s:7:\"descrip\";s:2:\"50\";}','9000');
INSERT INTO pw_invokepiece VALUES('54','auto_播放器','播放器','image','newpic','6','fid','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"288,320\";s:5:\"title\";s:2:\"36\";}','9000');
INSERT INTO pw_invokepiece VALUES('53','fun_频道页循环','帖子排行模块','subject','newsubject','10','0','a:5:{s:8:\"forumurl\";s:7:\"default\";s:9:\"forumname\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"30\";s:6:\"author\";s:7:\"default\";}','1800');
INSERT INTO pw_invokepiece VALUES('47','fun_中部焦点_有作者','帖子列表','subject','newsubject','5','fid','a:3:{s:6:\"author\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"50\";}','9000');
INSERT INTO pw_invokepiece VALUES('52','fun_频道页循环','图片模块','image','newpic','2','0','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"32\";s:7:\"descrip\";s:2:\"50\";}','9000');
INSERT INTO pw_invokepiece VALUES('145','auto_焦点摘要','帖子及摘要','subject','newsubject','3','','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"25\";s:7:\"descrip\";s:2:\"40\";s:9:\"tagrelate\";s:7:\"default\";}','1800');
INSERT INTO pw_invokepiece VALUES('56','auto_焦点列表','帖子列表','subject','newsubject','5','fid','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9000');
INSERT INTO pw_invokepiece VALUES('57','auto_本版热门','帖子列表','subject','newsubject','8','','a:4:{s:8:\"forumurl\";s:7:\"default\";s:9:\"forumname\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"30\";}','8000');
INSERT INTO pw_invokepiece VALUES('58','atuo_中部图片','图片模块','image','newpic','9','fid','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";}','9000');
INSERT INTO pw_invokepiece VALUES('59','auto_中部焦点1','帖子列表','subject','newsubject','5','fid','a:4:{s:8:\"forumurl\";s:7:\"default\";s:9:\"forumname\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9000');
INSERT INTO pw_invokepiece VALUES('60','auto_中部焦点2','帖子列表','subject','newsubject','5','','a:4:{s:8:\"forumurl\";s:7:\"default\";s:9:\"forumname\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9000');
INSERT INTO pw_invokepiece VALUES('61','atuo_频道页循环','图片模块','image','newpic','2','0','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"32\";s:7:\"descrip\";s:2:\"50\";}','9000');
INSERT INTO pw_invokepiece VALUES('62','atuo_频道页循环','帖子排行模块','subject','newsubject','10','0','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"30\";s:6:\"author\";s:7:\"default\";}','9000');
INSERT INTO pw_invokepiece VALUES('63','children_播放器','播放器','image','newpic','6','fid','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"288,320\";s:5:\"title\";s:2:\"36\";}','1700');
INSERT INTO pw_invokepiece VALUES('146','children_焦点摘要','帖子及摘要','subject','newsubject','3','','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"25\";s:7:\"descrip\";s:2:\"40\";s:9:\"tagrelate\";s:7:\"default\";}','1800');
INSERT INTO pw_invokepiece VALUES('65','children_焦点列表','帖子列表','subject','newsubject','3','fid','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9000');
INSERT INTO pw_invokepiece VALUES('66','children_本版热门','帖子列表','subject','newsubject','8','','a:4:{s:8:\"forumurl\";s:7:\"default\";s:9:\"forumname\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9000');
INSERT INTO pw_invokepiece VALUES('67','children_页面中部焦点','帖子列表','subject','newsubject','10','fid','a:4:{s:8:\"forumurl\";s:7:\"default\";s:9:\"forumname\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"50\";}','9000');
INSERT INTO pw_invokepiece VALUES('68','children_中部焦点摘要图片','图文模块','image','newpic','1','fid','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"32\";s:7:\"descrip\";s:2:\"50\";}','9000');
INSERT INTO pw_invokepiece VALUES('69','children_中部焦点_有作者','帖子列表','subject','newsubject','5','fid','a:3:{s:6:\"author\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9000');
INSERT INTO pw_invokepiece VALUES('70','children_频道页循环','图片模块','image','newpic','2','0','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"32\";s:7:\"descrip\";s:2:\"50\";}','9000');
INSERT INTO pw_invokepiece VALUES('71','children_频道页循环','帖子排行模块','subject','newsubject','10','0','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"30\";s:6:\"author\";s:7:\"default\";}','9000');
INSERT INTO pw_invokepiece VALUES('72','jia_播放器','播放器','image','newpic','6','fid','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"288,390\";s:5:\"title\";s:2:\"36\";}','9000');
INSERT INTO pw_invokepiece VALUES('147','jia_焦点摘要','帖子及摘要','subject','newsubject','3','','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"25\";s:7:\"descrip\";s:2:\"40\";s:9:\"tagrelate\";s:7:\"default\";}','1800');
INSERT INTO pw_invokepiece VALUES('74','jia_页面中部焦点','帖子列表','subject','newsubject','10','fid','a:4:{s:8:\"forumurl\";s:7:\"default\";s:9:\"forumname\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9000');
INSERT INTO pw_invokepiece VALUES('75','jia_中部焦点摘要图片','图文模块','image','newpic','1','fid','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"32\";s:7:\"descrip\";s:2:\"50\";}','9000');
INSERT INTO pw_invokepiece VALUES('76','jia_中部焦点_有作者','帖子列表','subject','newsubject','5','fid','a:3:{s:6:\"author\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9000');
INSERT INTO pw_invokepiece VALUES('77','jia_频道页循环','图片模块','image','newpic','2','0','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"32\";s:7:\"descrip\";s:2:\"50\";}','9000');
INSERT INTO pw_invokepiece VALUES('78','jia_频道页循环','帖子排行模块','subject','newsubject','10','0','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"30\";s:6:\"author\";s:7:\"default\";}','9000');
INSERT INTO pw_invokepiece VALUES('79','women_播放器','播放器','image','newpic','6','fid','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"288,256\";s:5:\"title\";s:2:\"36\";}','9000');
INSERT INTO pw_invokepiece VALUES('148','women_焦点摘要','帖子及摘要','subject','newsubject','3','','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"25\";s:7:\"descrip\";s:2:\"40\";s:9:\"tagrelate\";s:7:\"default\";}','1800');
INSERT INTO pw_invokepiece VALUES('81','women_焦点图片摘要','图文模块','image','newpic','2','fid','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"32\";s:7:\"descrip\";s:2:\"50\";}','9500');
INSERT INTO pw_invokepiece VALUES('82','women_本版热门','帖子列表','subject','newsubject','8','fid','a:4:{s:8:\"forumurl\";s:7:\"default\";s:9:\"forumname\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','8000');
INSERT INTO pw_invokepiece VALUES('83','women_页面中部焦点','帖子列表','subject','newsubject','10','fid','a:4:{s:8:\"forumurl\";s:7:\"default\";s:9:\"forumname\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','8000');
INSERT INTO pw_invokepiece VALUES('84','women_中部焦点摘要图片','图文模块','image','newpic','1','fid','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"32\";s:7:\"descrip\";s:2:\"50\";}','9600');
INSERT INTO pw_invokepiece VALUES('85','women_中部焦点_有作者','帖子列表','subject','newsubject','5','fid','a:3:{s:6:\"author\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9600');
INSERT INTO pw_invokepiece VALUES('86','women_频道页循环','图片模块','image','newpic','2','0','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"32\";s:7:\"descrip\";s:2:\"50\";}','9000');
INSERT INTO pw_invokepiece VALUES('87','women_频道页循环','帖子排行模块','subject','newsubject','10','0','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"30\";s:6:\"author\";s:7:\"default\";}','9000');
INSERT INTO pw_invokepiece VALUES('95','频道页中部焦点_有作者','帖子列表','subject','newsubject','5','fid','a:3:{s:6:\"author\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9900');
INSERT INTO pw_invokepiece VALUES('99','频道页循环','帖子排行模块','subject','newsubject','10','0','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"30\";s:6:\"author\";s:7:\"default\";}','1800');
INSERT INTO pw_invokepiece VALUES('98','频道页循环','图片模块','image','newpic','2','0','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"32\";s:7:\"descrip\";s:2:\"50\";}','1700');
INSERT INTO pw_invokepiece VALUES('149','home2_首页焦点摘要','帖子及摘要','subject','newsubject','3','','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"25\";s:7:\"descrip\";s:2:\"40\";s:9:\"tagrelate\";s:7:\"default\";}','1800');
INSERT INTO pw_invokepiece VALUES('101','home2_首页播放器','播放器','image','newpic','6','','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"280,480\";s:5:\"title\";s:2:\"36\";}','9700');
INSERT INTO pw_invokepiece VALUES('104','home2_首页焦点附说明','帖子列表','subject','digestsubject','10','','a:5:{s:8:\"forumurl\";s:7:\"default\";s:9:\"forumname\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"24\";s:7:\"descrip\";s:2:\"22\";}','9800');
INSERT INTO pw_invokepiece VALUES('105','home2_热门话题','帖子列表','subject','replysort','10','','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9000');
INSERT INTO pw_invokepiece VALUES('106','home2_中部图片','图片模块','image','newpic','8','','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"16\";}','8000');
INSERT INTO pw_invokepiece VALUES('150','home2_中部焦点摘要','帖子及摘要','subject','newsubject','3','','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"25\";s:7:\"descrip\";s:2:\"40\";s:9:\"tagrelate\";s:7:\"default\";}','1800');
INSERT INTO pw_invokepiece VALUES('108','home2_中部大图','图片模块','image','newpic','1','','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"220,235\";}','99999');
INSERT INTO pw_invokepiece VALUES('109','home2_中部帖子列表','帖子列表','subject','newsubject','10','','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9999');
INSERT INTO pw_invokepiece VALUES('110','home2_首页中部热门','帖子列表','subject','hitsort','10','','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','9800');
INSERT INTO pw_invokepiece VALUES('111','home2_首页循环版块','帖子列表','subject','newsubject','8','0','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"46\";}','9999');
INSERT INTO pw_invokepiece VALUES('151','home1_首页焦点摘要','帖子及摘要','subject','newsubject','3','','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"25\";s:7:\"descrip\";s:2:\"40\";s:9:\"tagrelate\";s:7:\"default\";}','1800');
INSERT INTO pw_invokepiece VALUES('116','home1_首页头部左侧焦点','帖子模块','subject','replysort','7','','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"26\";}','3600');
INSERT INTO pw_invokepiece VALUES('115','home1_首页头部左侧焦点','图片模块','image','newpic','1','','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"160,120\";}','1700');
INSERT INTO pw_invokepiece VALUES('117','home1_首页播放器','播放器','image','newpic','6','','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"340,338\";s:5:\"title\";s:2:\"36\";}','9800');
INSERT INTO pw_invokepiece VALUES('118','home1_首页头部右侧焦点','帖子列表','subject','replysort','8','','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','6000');
INSERT INTO pw_invokepiece VALUES('119','home1_首页中部帖子列表','帖子列表','subject','newsubject','22','','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','1800');
INSERT INTO pw_invokepiece VALUES('123','home1_首页中部右侧','帖子排行模块','subject','digestsubject','10','','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"40\";}','9400');
INSERT INTO pw_invokepiece VALUES('122','home1_首页中部右侧','图片模块','image','newpic','1','','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"160,120\";}','9800');
INSERT INTO pw_invokepiece VALUES('124','home1_首页中部标签','标签模块','tag','gettags','10','hot','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:7:\"default\";}','86400');
INSERT INTO pw_invokepiece VALUES('125','home1_首页中部图片','图片模块','image','newpic','6','','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:1:\"8\";}','1700');
INSERT INTO pw_invokepiece VALUES('126','home1_首页版块排行','版块模块','forum','forumsort','20','topic','a:3:{s:5:\"value\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:7:\"default\";}','86400');
INSERT INTO pw_invokepiece VALUES('127','home1_首页版块循环','图片模块','image','newpic','1','0','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";s:5:\"title\";s:2:\"40\";s:7:\"descrip\";s:2:\"60\";}','1700');
INSERT INTO pw_invokepiece VALUES('128','home1_首页版块循环','帖子模块','subject','newsubject','7','0','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"40\";}','1800');
INSERT INTO pw_invokepiece VALUES('129','category_频道页头部左侧焦点','图片模块','image','newpic','3','fid','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"100,100\";}','1700');
INSERT INTO pw_invokepiece VALUES('130','category_频道页头部左侧焦点','帖子模块','subject','newsubject','7','fid','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"36\";}','1800');
INSERT INTO pw_invokepiece VALUES('131','category_频道页热门标签','标签模块','tag','gettags','10','hot','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:7:\"default\";}','86400');
INSERT INTO pw_invokepiece VALUES('132','category_频道页版块排行','版块模块','forum','forumsort','20','topic','a:3:{s:5:\"value\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:7:\"default\";}','86400');
INSERT INTO pw_invokepiece VALUES('152','category_频道页焦点摘要','帖子及摘要','subject','newsubject','3','','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"25\";s:7:\"descrip\";s:2:\"40\";s:9:\"tagrelate\";s:7:\"default\";}','1800');
INSERT INTO pw_invokepiece VALUES('134','category_频道页焦点列表','帖子列表','subject','newsubject','10','fid','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','1800');
INSERT INTO pw_invokepiece VALUES('135','category_频道页播放器','播放器','image','newpic','6','fid','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"340,280\";s:5:\"title\";s:2:\"36\";}','1700');
INSERT INTO pw_invokepiece VALUES('136','category_频道页中部焦点','帖子列表','subject','newsubject','12','fid','a:4:{s:8:\"forumurl\";s:7:\"default\";s:9:\"forumname\";s:7:\"default\";s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"32\";}','1800');
INSERT INTO pw_invokepiece VALUES('137','category_频道页中部右侧','图片模块','image','newpic','1','fid','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"160,120\";}','1700');
INSERT INTO pw_invokepiece VALUES('138','category_频道页中部右侧','帖子排行模块','subject','newsubject','10','fid','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"30\";}','1800');
INSERT INTO pw_invokepiece VALUES('139','category_版块中部图片','图片模块','image','newpic','6','fid','a:3:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:7:\"118,118\";s:5:\"title\";s:2:\"16\";}','1700');
INSERT INTO pw_invokepiece VALUES('140','category_频道页版块循环','图片模块','image','newpic','1','0','a:4:{s:3:\"url\";s:7:\"default\";s:5:\"image\";s:6:\"126,92\";s:5:\"title\";s:2:\"40\";s:7:\"descrip\";s:2:\"60\";}','1700');
INSERT INTO pw_invokepiece VALUES('141','category_频道页版块循环','帖子模块','subject','newsubject','7','0','a:2:{s:3:\"url\";s:7:\"default\";s:5:\"title\";s:2:\"40\";}','1800');

INSERT INTO pw_ipstates VALUES('2009-9-24','2009-9','1');

INSERT INTO pw_medalinfo VALUES('1','终身成就奖','谢谢您为社区发展做出的不可磨灭的贡献!!','1.gif');
INSERT INTO pw_medalinfo VALUES('2','优秀斑竹奖','辛劳地为论坛付出劳动，收获快乐，感谢您!','2.gif');
INSERT INTO pw_medalinfo VALUES('3','宣传大使奖','谢谢您为社区积极宣传,特颁发此奖!','3.gif');
INSERT INTO pw_medalinfo VALUES('4','特殊贡献奖','您为论坛做出了特殊贡献,谢谢您!','4.gif');
INSERT INTO pw_medalinfo VALUES('5','金点子奖','为社区提出建设性的建议被采纳,特颁发此奖!','5.gif');
INSERT INTO pw_medalinfo VALUES('6','原创先锋奖','谢谢您积极发表原创作品,特颁发此奖!','6.gif');
INSERT INTO pw_medalinfo VALUES('7','贴图大师奖','帖图高手,堪称大师!','7.gif');
INSERT INTO pw_medalinfo VALUES('8','灌水天才奖','能够长期提供优质的社区水资源者,可得这个奖章!','8.gif');
INSERT INTO pw_medalinfo VALUES('9','新人进步奖','新人有很大的进步可以得到这个奖章!','9.gif');
INSERT INTO pw_medalinfo VALUES('10','幽默大师奖','您总是能给别人带来欢乐,谢谢您!','10.gif');




INSERT INTO pw_memberdata VALUES('1','0','0','0','0','0','0','1253762639','1253762639','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('2','0','0','0','0','0','0','1253762814','1253762814','0','0','0','0','0','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('3','0','0','0','0','0','0','1248225364','1248220303','1247623282','4420','4420','1','6','0','0','127.0.0.1|1248225364|6','0','','1248224492','0','');
INSERT INTO pw_memberdata VALUES('4','0','0','0','0','0','0','1247384170','1247733706','1247379895','3546','3546','1','2','0','0','192.168.1.104|1247379771|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('5','0','0','0','0','0','0','1247379931','1247721809','1247381095','2260','2260','1','6','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('6','0','0','0','0','0','0','1247451560','1247724449','1247304058','5340','5340','5','5','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('7','0','0','0','0','0','0','1247883449','1247883449','1247549294','608','608','1','4','1247550370','18','127.0.0.1|1247883449|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('8','0','0','0','0','0','0','1247451744','1247717190','1247380366','2032','2032','2','4','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('9','0','0','0','0','0','0','1248166336','1248160947','1247548672','3677','3677','1','3','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('10','0','0','0','0','0','0','1247884322','1247884322','1247380445','5352','5352','1','3','0','0','127.0.0.1|1247884322|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('11','0','0','0','0','0','0','1247548684','1247727888','1247549392','1345','1345','1','4','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('12','0','0','0','0','0','0','1247548736','1247727343','1247551072','212','212','1','2','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('13','0','0','0','0','0','0','1247637221','1247727226','1247637322','2428','2428','1','1','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('14','0','0','0','0','0','0','1247906634','1247906634','1247294162','2312','2312','1','1','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('15','0','0','0','0','0','0','1247551771','1247719432','1247553033','139','139','2','2','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('16','0','0','0','0','0','0','1246416389','1247727767','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('17','0','0','0','0','0','0','1247883524','1247883524','1247466913','113','113','1','1','0','0','127.0.0.1|1247722823|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('18','0','0','0','0','0','0','1247551361','1247725729','1247551831','63','63','1','1','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('19','0','0','0','0','0','0','1246416481','1246416481','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('20','0','0','0','0','0','0','1246416484','1247717434','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('21','0','0','0','0','0','0','1246416512','1246416512','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('22','0','0','0','0','0','0','1247548784','1247548784','1247548856','59','59','1','2','0','0','192.168.1.101|1247035450|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('23','0','0','0','0','0','0','1247034938','1247029768','1247035037','0','0','1','1','0','0','192.168.1.101|1247034938|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('24','0','0','0','0','0','0','1247288262','1247282905','1247288302','0','0','1','1','0','0','192.168.1.101|1247288262|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('25','0','0','0','0','0','0','1246416601','1246416601','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('26','0','0','0','0','0','0','1247625695','1247625695','1247625883','294','294','1','1','1247627213','32','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('27','0','0','0','0','0','0','1246416623','1246416623','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('28','0','0','0','0','0','0','1246416640','1246416640','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('29','0','0','0','0','0','0','1246416659','1246416659','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('30','0','0','0','0','0','0','1246416665','1246411268','0','0','0','0','0','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('31','0','0','0','0','0','0','1247551451','1247551451','1247551457','52','52','1','1','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('32','0','0','0','0','0','0','1247623218','1247623218','1247623263','863','863','1','1','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('33','0','0','0','0','0','0','1247634806','1247634806','1247633427','5','5','1','1','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('34','0','0','0','0','0','0','1247288995','1247283653','1247289049','0','0','1','1','0','0','192.168.1.101|1247288995|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('35','0','0','0','0','0','0','1247634443','1247634443','1247627366','96','96','1','2','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('36','0','0','0','0','0','0','1247551389','1247551389','0','28','28','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('37','0','0','0','0','0','0','1247621440','1247621440','1247621734','106','106','1','3','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('38','0','0','0','0','0','0','1247034660','1247029435','1247034687','0','0','1','1','0','0','192.168.1.101|1247034660|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('39','0','0','0','0','0','0','1246416805','1246416805','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('40','0','0','0','0','0','0','1247288322','1247283584','1247288892','0','0','1','1','0','0','192.168.1.101|1247288322|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('41','0','0','0','0','0','0','1247884333','1247884333','1247382418','17','17','1','1','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('42','0','0','0','0','0','0','1247381287','1247381287','1247381721','80','80','2','2','1247381763','9','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('43','0','0','0','0','0','0','1246416857','1246416857','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('44','0','0','0','0','0','0','1247466925','1247466925','0','310','310','0','0','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('45','0','0','0','0','0','0','1246416876','1246416876','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('46','0','0','0','0','0','0','1246416892','1246416892','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('47','0','0','0','0','0','0','1247466931','1247466931','0','6','6','0','0','0','0','192.168.1.101|1247293124|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('48','0','0','0','0','0','0','1247637938','1247637938','1247637974','723','723','1','2','1247384598','1','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('49','0','0','0','0','0','0','1247034863','1247029518','1247034912','0','0','1','1','0','0','192.168.1.101|1247034863|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('50','0','0','0','0','0','0','1247035187','1247029974','1247035244','0','0','1','1','0','0','192.168.1.101|1247035187|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('51','0','0','0','0','0','0','1247380612','1247380612','1247382526','13','13','1','1','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('52','0','0','0','0','0','0','1247548887','1247548887','1247551372','134','134','1','1','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('53','0','0','0','0','0','0','1246416989','1246416989','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('54','0','0','0','0','0','0','1246416989','1246416989','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('55','0','0','0','0','0','0','1246417007','1246417007','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('56','0','0','0','0','0','0','1247381098','1247381098','1247381136','37','37','1','1','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('57','0','0','0','0','0','0','1247291960','1247286627','1247291989','0','0','1','1','0','0','192.168.1.101|1247291960|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('58','0','0','0','0','0','0','1247293052','1247728059','1247293078','0','0','1','1','0','0','192.168.1.101|1247293052|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('59','0','0','0','0','0','0','1246417047','1246417047','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('60','0','0','0','0','0','0','1246417055','1246417055','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('61','0','0','0','0','0','0','1247551482','1247551482','1247556691','712','712','1','2','0','0','192.168.1.104|1247385982|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('62','0','0','0','0','0','0','1247454200','1247715689','1247387335','24','24','1','1','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('63','0','0','0','0','0','0','1247466936','1247466936','0','5','5','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('64','0','0','0','0','0','0','1246417120','1246417120','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('65','0','0','0','0','0','0','1246417139','1246417139','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('66','0','0','0','0','0','0','1247551302','1247551302','1247551351','2140','2140','1','1','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('67','0','0','0','0','0','0','1246417188','1246417188','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('68','0','0','0','0','0','0','1247381044','1247381044','1247381518','27','27','1','1','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('69','0','0','0','0','0','0','1247381207','1247381207','0','38','38','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('70','0','0','0','0','0','0','1246425377','1246420378','0','622','622','0','0','0','0','127.0.0.1|1246418182|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('71','0','0','0','0','0','0','1246417296','1246417296','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('72','0','0','0','0','0','0','1246417318','1246411923','0','0','0','0','0','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('73','0','0','0','0','0','0','1246417344','1246417344','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('74','0','0','0','0','0','0','1246417362','1246417362','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('75','0','0','0','0','0','0','1246417380','1246417380','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('76','0','0','0','0','0','0','1247621486','1247621486','0','46','46','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('77','0','0','0','0','0','0','1246417923','1246417923','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('78','0','0','0','0','0','0','1246417943','1246417943','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('79','0','0','0','0','0','0','1247380730','1247380730','1247380748','22','22','1','1','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('80','0','0','0','0','0','0','1246417991','1246417991','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('81','0','0','0','0','0','0','1247883536','1247883536','1247625686','79','79','1','1','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('82','0','0','0','0','0','0','1247289065','1247286549','1247290588','0','0','1','1','0','0','192.168.1.101|1247289065|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('83','0','0','0','0','0','0','1246418086','1246418086','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('84','0','0','0','0','0','0','1247359793','1247359793','1247346838','24','24','2','3','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('85','0','0','0','0','0','0','1246418102','1246418102','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('86','0','0','0','0','0','0','1246418121','1246418121','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('87','0','0','0','0','0','0','1246418143','1246418143','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('88','0','0','0','0','0','0','1246418160','1246418160','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('89','0','0','0','0','0','0','1247907387','1247902022','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('90','0','0','0','0','0','0','1247467007','1247467007','1247381038','91','91','1','1','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('91','0','0','0','0','0','0','1246418238','1246418238','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('92','0','0','0','0','0','0','1246418257','1246418257','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('93','0','0','0','0','0','0','1246418275','1246418275','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('94','0','0','0','0','0','0','1246418293','1246418293','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('95','0','0','0','0','0','0','1247625322','1247625322','1247625371','2052','2052','1','1','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('96','0','0','0','0','0','0','1247621371','1247621371','1247621434','33','33','1','1','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('97','0','0','0','0','0','0','1246418342','1246418342','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('98','0','0','0','0','0','0','1247552054','1247552054','1247552062','34','34','1','1','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('99','0','0','0','0','0','0','1247634533','1247634533','1247629047','841','841','2','3','1247622327','1','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('100','0','0','0','0','0','0','1248237347','1248237347','1247552121','68','68','1','2','0','0','127.0.0.1|1248225714|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('101','0','0','0','0','0','0','1247292227','1247292227','0','0','0','0','0','0','0','127.0.0.1|1247292227|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('102','0','0','0','0','0','0','1247884339','1247878969','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('103','0','0','0','0','0','0','1247623727','1247623727','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('104','0','0','0','0','0','0','1247623778','1247623778','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('105','0','0','0','0','0','0','1247623824','1247623824','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('106','0','0','0','0','0','0','1247623970','1247623970','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('107','0','0','0','0','0','0','1247624105','1247624105','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('108','0','0','0','0','0','0','1247624164','1247624164','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('109','0','0','0','0','0','0','1247624228','1247624228','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('110','0','0','0','0','0','0','1247624307','1247624307','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('111','0','0','0','0','0','0','1247624339','1247624339','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('112','0','0','0','0','0','0','1247624444','1247624444','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('151','0','0','0','0','0','0','1247639521','1247639521','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('113','0','0','0','0','0','0','1247634669','1247629479','0','0','0','0','0','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('114','0','0','0','0','0','0','1247636084','1251001615','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('115','0','0','0','0','0','0','1247636552','1247631160','0','0','0','0','0','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('116','0','0','0','0','0','0','1247636811','1247631419','0','0','0','0','0','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('117','0','0','0','0','0','0','1247637071','1247637071','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('118','0','0','0','0','0','0','1247637125','1247637125','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('119','0','0','0','0','0','0','1247637192','1247637192','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('120','0','0','0','0','0','0','1247637277','1247637277','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('121','0','0','0','0','0','0','1247637311','1247637311','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('122','0','0','0','0','0','0','1248163918','1251001433','0','0','0','0','0','0','0','127.0.0.1|1248163918|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('123','0','0','0','0','0','0','1247637415','1247637415','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('124','0','0','0','0','0','0','1247637483','1247637483','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('125','0','0','0','0','0','0','1247637520','1247637520','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('126','0','0','0','0','0','0','1247637576','1247637576','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('127','0','0','0','0','0','0','1247637605','1247637605','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('128','0','0','0','0','0','0','1247637637','1247637637','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('129','0','0','0','0','0','0','1247637718','1247637718','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('130','0','0','0','0','0','0','1247637746','1247637746','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('131','0','0','0','0','0','0','1247637831','1247637831','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('132','0','0','0','0','0','0','1247637944','1247637944','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('133','0','0','0','0','0','0','1247638036','1247638036','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('134','0','0','0','0','0','0','1247638210','1247638210','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('135','0','0','0','0','0','0','1247638263','1247901281','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('136','0','0','0','0','0','0','1247638316','1247638316','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('137','0','0','0','0','0','0','1247638597','1247638597','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('138','0','0','0','0','0','0','1247638704','1247638704','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('139','0','0','0','0','0','0','1247638820','1247638820','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('140','0','0','0','0','0','0','1247638922','1247638922','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('141','0','0','0','0','0','0','1247638975','1247638975','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('142','0','0','0','0','0','0','1247639058','1251002012','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('143','0','0','0','0','0','0','1247639135','1247639135','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('144','0','0','0','0','0','0','1247639215','1247639215','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('145','0','0','0','0','0','0','1247639243','1247717461','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('146','0','0','0','0','0','0','1247639431','1247639431','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('147','0','0','0','0','0','0','1247639451','1247639451','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('148','0','0','0','0','0','0','1247639468','1247639468','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('149','0','0','0','0','0','0','1247639485','1247639485','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('150','0','0','0','0','0','0','1247906719','1247906719','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('152','0','0','0','0','0','0','1247639537','1247639537','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('153','0','0','0','0','0','0','1247639551','1247639551','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('154','0','0','0','0','0','0','1247639565','1247639565','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('155','0','0','0','0','0','0','1247639583','1247639583','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('156','0','0','0','0','0','0','1247639603','1247639603','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('157','0','0','0','0','0','0','1247639616','1247639616','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('158','0','0','0','0','0','0','1247639629','1247639629','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('159','0','0','0','0','0','0','1247639643','1247639643','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('160','0','0','0','0','0','0','1247639656','1247639656','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('161','0','0','0','0','0','0','1247639672','1247639672','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('162','0','0','0','0','0','0','1247639686','1247639686','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('163','0','0','0','0','0','0','1247639699','1247639699','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('164','0','0','0','0','0','0','1247639713','1247639713','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('165','0','0','0','0','0','0','1247639725','1247639725','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('166','0','0','0','0','0','0','1247639747','1247639747','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('167','0','0','0','0','0','0','1247639759','1247639759','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('168','0','0','0','0','0','0','1247639773','1247639773','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('169','0','0','0','0','0','0','1247639785','1247639785','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('170','0','0','0','0','0','0','1247639799','1247639799','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('171','0','0','0','0','0','0','1247639810','1247639810','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('172','0','0','0','0','0','0','1247639823','1251001400','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('173','0','0','0','0','0','0','1247639835','1247639835','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('174','0','0','0','0','0','0','1247639851','1247639851','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('175','0','0','0','0','0','0','1247639867','1247639867','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('176','0','0','0','0','0','0','1247639881','1247639881','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('177','0','0','0','0','0','0','1247906654','1247906654','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('178','0','0','0','0','0','0','1247639913','1247715869','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('179','0','0','0','0','0','0','1247639927','1247639927','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('180','0','0','0','0','0','0','1247639945','1247639945','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('181','0','0','0','0','0','0','1247639959','1247639959','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('182','0','0','0','0','0','0','1247639972','1247639972','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('183','0','0','0','0','0','0','1247639985','1247639985','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('184','0','0','0','0','0','0','1247640001','1247640001','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('185','0','0','0','0','0','0','1247640014','1247640014','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('186','0','0','0','0','0','0','1247640029','1247640029','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('187','0','0','0','0','0','0','1247640045','1247640045','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('188','0','0','0','0','0','0','1247640060','1247640060','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('189','0','0','0','0','0','0','1247640074','1247640074','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('190','0','0','0','0','0','0','1247640087','1247640087','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('191','0','0','0','0','0','0','1247640099','1247640099','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('192','0','0','0','0','0','0','1247968347','1247963659','1247909126','0','0','1','1','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('193','0','0','0','0','0','0','1247643897','1247641499','0','21','21','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('194','0','0','0','0','0','0','1247640140','1247640140','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('195','0','0','0','0','0','0','1247906662','1247906662','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('196','0','0','0','0','0','0','1247640689','1247640689','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('197','0','0','0','0','0','0','1247640731','1247640731','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('198','0','0','0','0','0','0','1247640814','1247640814','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('199','0','0','0','0','0','0','1247640890','1247640890','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('200','0','0','0','0','0','0','1247640969','1247640969','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('201','0','0','0','0','0','0','1247641005','1247901326','0','0','0','0','0','0','0','','0','','0','0','');
INSERT INTO pw_memberdata VALUES('202','0','0','0','0','0','0','1248166367','1248161122','0','0','0','0','0','0','0','127.0.0.1|1248166367|6','0','','0','0','');
INSERT INTO pw_memberdata VALUES('203','0','0','0','0','0','0','1247721192','1247717167','0','0','0','0','0','0','0','127.0.0.1','0','','0','0','');
INSERT INTO pw_memberdata VALUES('204','0','0','0','0','0','0','1247977643','1247972327','1247977688','0','0','1','1','0','0','127.0.0.1','0','','0','0','');

INSERT INTO pw_memberinfo VALUES('2','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('3','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('4','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('5','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('6','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('7','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('8','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('9','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('10','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('11','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('12','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('13','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('14','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('15','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('16','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('17','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('18','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('19','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('20','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('21','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('22','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('23','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('24','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('25','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('26','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('27','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('28','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('29','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('30','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('31','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('32','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('33','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('34','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('35','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('36','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('37','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('38','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('39','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('40','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('41','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('42','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('43','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('44','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('45','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('46','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('47','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('48','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('49','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('50','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('51','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('52','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('53','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('54','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('55','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('56','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('57','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('58','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('59','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('60','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('61','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('62','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('63','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('64','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('65','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('66','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('67','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('68','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('69','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('70','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('71','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('72','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('73','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('74','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('75','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('76','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('77','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('78','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('79','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('80','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('81','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('82','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('83','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('84','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('85','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('86','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('87','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('88','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('89','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('90','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('91','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('92','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('93','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('94','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('95','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('96','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('97','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('98','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('99','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('100','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('101','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('102','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('103','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('104','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('105','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('106','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('107','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('108','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('109','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('110','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('111','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('112','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('113','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('114','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('115','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('116','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('117','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('118','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('119','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('120','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('121','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('122','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('123','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('124','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('125','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('126','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('127','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('128','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('129','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('130','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('131','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('132','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('133','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('134','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('135','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('136','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('137','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('138','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('139','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('140','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('141','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('142','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('143','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('144','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('145','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('146','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('147','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('148','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('149','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('150','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('151','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('152','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('153','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('154','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('155','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('156','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('157','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('158','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('159','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('160','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('161','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('162','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('163','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('164','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('165','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('166','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('167','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('168','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('169','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('170','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('171','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('172','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('173','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('174','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('175','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('176','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('177','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('178','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('179','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('180','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('181','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('182','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('183','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('184','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('185','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('186','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('187','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('188','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('189','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('190','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('191','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('192','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('193','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('194','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('195','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('196','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('197','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('198','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('199','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('200','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('201','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('203','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('202','','','0','0','0','0','','','','','','0','','','','2');
INSERT INTO pw_memberinfo VALUES('204','','','0','0','0','0','','','','','','0','','','','2');

INSERT INTO pw_members VALUES('1','admin','9b9ef33f4fb59986d75864149c436b02','','','3','8','','','0','1253762639','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','192',',article,write,diary,share,groups,photos,');
INSERT INTO pw_members VALUES('2','maddogfyg','b1957d80bd2fd39683b27f2b6acff441','','','3','0','','','0','1253762814','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('3','maddog','b1957d80bd2fd39683b27f2b6acff441','','maddog@163.com','-1','8','','none.gif|1|||','0','1240641360','','','','','','','','','','','1900-01-01','','1','','','','0','0','','0','2','','','','1024','');
INSERT INTO pw_members VALUES('4','羽飞','b1957d80bd2fd39683b27f2b6acff441','','yufei@163.com','-1','8','','','0','1244614675','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','1','','','','1024','');
INSERT INTO pw_members VALUES('5','羊羔组合','b1957d80bd2fd39683b27f2b6acff441','','yanggaozhuhe@163.com','-1','8','','','0','1241762013','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','5','','','','1024','');
INSERT INTO pw_members VALUES('6','乖乖布丁','b1957d80bd2fd39683b27f2b6acff441','','guaiguai@163.com','-1','8','','','0','1243457276','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','5','','','','1024','');
INSERT INTO pw_members VALUES('7','玉米兔子','b1957d80bd2fd39683b27f2b6acff441','','kenyumi@163.com','-1','8','','','0','1242144167','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','2','','','','1024','');
INSERT INTO pw_members VALUES('8','碧落','b1957d80bd2fd39683b27f2b6acff441','','biluo@163.com','-1','8','','','0','1245103342','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','2','','','','1024','');
INSERT INTO pw_members VALUES('9','福尔牌摩丝','b1957d80bd2fd39683b27f2b6acff441','','fuermosi@163.com','-1','8','','','0','1244805269','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','1','','','','1024','');
INSERT INTO pw_members VALUES('10','奸饼裹子','b1957d80bd2fd39683b27f2b6acff441','','jianbing@163.com','-1','8','','','0','1244675622','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','4','','','','1024','');
INSERT INTO pw_members VALUES('11','大哈无','b1957d80bd2fd39683b27f2b6acff441','','dahawu@163.com','-1','8','','','0','1240634507','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','2','','','','1024','');
INSERT INTO pw_members VALUES('12','teabag','b1957d80bd2fd39683b27f2b6acff441','','teabag@163.com','-1','8','','','0','1244870358','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','1024','');
INSERT INTO pw_members VALUES('13','wawanaonao','b1957d80bd2fd39683b27f2b6acff441','','wawanao@163.com','-1','8','','','0','1240542778','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('14','蜀山魔兽','b1957d80bd2fd39683b27f2b6acff441','','xiaoemo@163.com','-1','8','','','0','1238592969','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','1','','','','1024','');
INSERT INTO pw_members VALUES('15','haolala','b1957d80bd2fd39683b27f2b6acff441','','haolala@163.com','-1','8','','','0','1244955496','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','1','','','','0','');
INSERT INTO pw_members VALUES('16','靛蓝贝壳','b1957d80bd2fd39683b27f2b6acff441','','dianlanbeike@163.com','-1','8','','','0','1244728761','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('17','月舞','b1957d80bd2fd39683b27f2b6acff441','','yuewu@163.com','-1','8','','','0','1243455760','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('18','sunisland','b1957d80bd2fd39683b27f2b6acff441','','sunisland@163.com','-1','8','','','0','1245672222','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','1','','','','0','');
INSERT INTO pw_members VALUES('19','zixuan','b1957d80bd2fd39683b27f2b6acff441','','zixuan@163.com','-1','8','','','0','1240153743','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('20','bb0504','b1957d80bd2fd39683b27f2b6acff441','','l0001@163.com','-1','8','','','0','1243389800','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('21','jiangww','b1957d80bd2fd39683b27f2b6acff441','','l0002@163.com','-1','8','','','0','1239007917','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('22','Q361783290','b1957d80bd2fd39683b27f2b6acff441','','l0003@163.com','-1','8','','','0','1238313196','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('23','小不点','b1957d80bd2fd39683b27f2b6acff441','','l0004@163.com','-1','8','','','0','1243318638','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('24','一直等你','b1957d80bd2fd39683b27f2b6acff441','','l0005@163.com','-1','8','','','0','1243793859','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('25','zhweixiang','b1957d80bd2fd39683b27f2b6acff441','','l0006@163.com','-1','8','','','0','1238513632','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('26','anunu','b1957d80bd2fd39683b27f2b6acff441','','anunu@163.com','-1','8','','','0','1239395150','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('27','sunshine','b1957d80bd2fd39683b27f2b6acff441','','l0007@163.com','-1','8','','','0','1244279677','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('28','沉沦','b1957d80bd2fd39683b27f2b6acff441','','l0008@163.com','-1','8','','','0','1242051613','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('29','蝈蝈','b1957d80bd2fd39683b27f2b6acff441','','l0009@163.com','-1','8','','','0','1242106243','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('30','黑山小狐狸','b1957d80bd2fd39683b27f2b6acff441','','xiaohuli@163.com','-1','8','','','0','1243359482','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','1024','');
INSERT INTO pw_members VALUES('31','不同凡响','b1957d80bd2fd39683b27f2b6acff441','','l0011@163.com','-1','8','','','0','1240622798','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','1','','','','0','');
INSERT INTO pw_members VALUES('32','心中之魔鬼','b1957d80bd2fd39683b27f2b6acff441','','l0012@163.com','-1','8','','','0','1240911496','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('33','xuxingxing','b1957d80bd2fd39683b27f2b6acff441','','xuxingxing@163.com','-1','8','','','0','1243583375','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('34','小高高','b1957d80bd2fd39683b27f2b6acff441','','l0013@163.com','-1','8','','','0','1243083844','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('35','男人也怕痛','b1957d80bd2fd39683b27f2b6acff441','','nanrenpatong@163.com','-1','8','','','0','1239345807','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','1','','','','1024','');
INSERT INTO pw_members VALUES('36','土豆王子','b1957d80bd2fd39683b27f2b6acff441','','l0014@163.com','-1','8','','','0','1239165023','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('37','歪弟弟','b1957d80bd2fd39683b27f2b6acff441','','waididi@163.com','-1','8','','','0','1240360755','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','2','','','','0','');
INSERT INTO pw_members VALUES('38','243771619','b1957d80bd2fd39683b27f2b6acff441','','l0015@163.com','-1','8','','','0','1243309611','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('39','宝贝蛋儿','b1957d80bd2fd39683b27f2b6acff441','','l0016@163.com','-1','8','','','0','1246088002','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('40','偶然','b1957d80bd2fd39683b27f2b6acff441','','l0017@163.com','-1','8','','','0','1238985660','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('41','16路车站','b1957d80bd2fd39683b27f2b6acff441','','16lu@163.com','-1','8','','','0','1241804868','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('42','安全套卫士','b1957d80bd2fd39683b27f2b6acff441','','l0018@163.com','-1','8','','','0','1240542144','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','1','','','','0','');
INSERT INTO pw_members VALUES('43','秋的种子','b1957d80bd2fd39683b27f2b6acff441','','l0019@163.com','-1','8','','','0','1245675654','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('44','相奸何太急','b1957d80bd2fd39683b27f2b6acff441','','xiangjian@163.com','-1','8','','','0','1244167283','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','1024','');
INSERT INTO pw_members VALUES('45','家2009','b1957d80bd2fd39683b27f2b6acff441','','l0019@163.com','-1','8','','','0','1240954750','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('46','chinabao','b1957d80bd2fd39683b27f2b6acff441','','l0020@163.com','-1','8','','','0','1244450785','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('47','sky1986','b1957d80bd2fd39683b27f2b6acff441','','l0021@163.com','-1','8','','','0','1242715680','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('48','图朵多','b1957d80bd2fd39683b27f2b6acff441','','tuduoduo@163.com','-1','8','','','0','1238230146','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('49','蓝烟','b1957d80bd2fd39683b27f2b6acff441','','l0022@163.com','-1','8','','','0','1243942643','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('50','Xiaoqin676','b1957d80bd2fd39683b27f2b6acff441','','l0023@163.com','-1','8','','','0','1244689059','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('51','老衲人老心不老','b1957d80bd2fd39683b27f2b6acff441','','laonabulao@163.com','-1','8','','','0','1243439582','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','1024','');
INSERT INTO pw_members VALUES('52','开水无色','b1957d80bd2fd39683b27f2b6acff441','','l0024@163.com','-1','8','','','0','1244770196','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('53','天荒地老','b1957d80bd2fd39683b27f2b6acff441','','l0025@163.com','-1','8','','','0','1244821891','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('54','壹壹零玖','b1957d80bd2fd39683b27f2b6acff441','','1109@163.com','-1','8','','','0','1240577856','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('55','千寻之梦','b1957d80bd2fd39683b27f2b6acff441','','l0026@163.com','-1','8','','','0','1242383691','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('56','手机对讲机','b1957d80bd2fd39683b27f2b6acff441','','duijiangji@163.com','-1','8','','','0','1245155160','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','1024','');
INSERT INTO pw_members VALUES('57','yj520','b1957d80bd2fd39683b27f2b6acff441','','l0027@163.com','-1','8','','','0','1241792643','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('58','幸福接力','b1957d80bd2fd39683b27f2b6acff441','','l0028@163.com','-1','8','','','0','1240483003','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('59','susuchun','b1957d80bd2fd39683b27f2b6acff441','','susuchun@163.com','-1','8','','','0','1241026408','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('60','戒烟戒情人','b1957d80bd2fd39683b27f2b6acff441','','l0029@163.com','-1','8','','','0','1245718522','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('61','datou206','b1957d80bd2fd39683b27f2b6acff441','','datou206@163.com','-1','8','','','0','1245662121','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','1','','','','0','');
INSERT INTO pw_members VALUES('62','梦游此生','b1957d80bd2fd39683b27f2b6acff441','','l0030@163.com','-1','8','','','0','1243468842','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','1','','','','0','');
INSERT INTO pw_members VALUES('63','missmao','b1957d80bd2fd39683b27f2b6acff441','','missmao@163.com','-1','8','','','0','1240449654','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('64','piaopiao911','b1957d80bd2fd39683b27f2b6acff441','','piaopiao911@163.com','-1','8','','','0','1243065132','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('65','babydodo','b1957d80bd2fd39683b27f2b6acff441','','babydodo@163.com','-1','8','','','0','1240372322','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('66','瞬间的百合','b1957d80bd2fd39683b27f2b6acff441','','soonbaihe@163.com','-1','8','','','0','1241615098','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','1','','','','1024','');
INSERT INTO pw_members VALUES('67','橘子盒子','b1957d80bd2fd39683b27f2b6acff441','','juzihezi@163.com','-1','8','','','0','1244049792','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('68','国足欢迎您','b1957d80bd2fd39683b27f2b6acff441','','guozuhuanyingnin@163.com','-1','8','','','0','1242552714','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','1024','');
INSERT INTO pw_members VALUES('69','天一老太','b1957d80bd2fd39683b27f2b6acff441','','tianyilaotai@163.com','-1','8','','','0','1238744344','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('70','江南摸摸茶','b1957d80bd2fd39683b27f2b6acff441','','jnmomocai@163.com','-1','8','','','0','1243957429','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','1024','');
INSERT INTO pw_members VALUES('71','jjyy2008','b1957d80bd2fd39683b27f2b6acff441','','jjyy2008@163.com','-1','8','','','0','1243358010','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('72','放荡的烟头','b1957d80bd2fd39683b27f2b6acff441','','yantou@163.com','-1','8','','','0','1242368849','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','1024','');
INSERT INTO pw_members VALUES('73','叫花小鸭','b1957d80bd2fd39683b27f2b6acff441','','xiaoyaya@163.com','-1','8','','','0','1238319209','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('74','洋葱女','b1957d80bd2fd39683b27f2b6acff441','','yangchongnv@163.com','-1','8','','','0','1242853299','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('75','猪猡公主','b1957d80bd2fd39683b27f2b6acff441','','zhuluogongzhu@163.com','-1','8','','','0','1240355767','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('76','shaniu31','b1957d80bd2fd39683b27f2b6acff441','','shaniu31@163.com','-1','8','','','0','1241093596','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('77','飞鸟人','b1957d80bd2fd39683b27f2b6acff441','','feiniao@163.com','-1','8','','','0','1241123720','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('78','东疯破','b1957d80bd2fd39683b27f2b6acff441','','dongfengpo@163.com','-1','8','','','0','1244891083','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('79','天蝎刺客','b1957d80bd2fd39683b27f2b6acff441','','tianxiecike@163.com','-1','8','','','0','1241143378','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('80','伪装者0574','b1957d80bd2fd39683b27f2b6acff441','','weizhuang0574@163.com','-1','8','','','0','1238885998','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('81','情迷小玉','b1957d80bd2fd39683b27f2b6acff441','','miqingxiaoyu@163.com','-1','8','','','0','1243399777','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('82','土人','b1957d80bd2fd39683b27f2b6acff441','','l0031@163.com','-1','8','','','0','1238402595','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('83','风情1种','b1957d80bd2fd39683b27f2b6acff441','','l0032@163.com','-1','8','','','0','1245475831','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('84','总是被妞泡','b1957d80bd2fd39683b27f2b6acff441','','beiniupao@163.com','-1','8','','','0','1242041304','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','3','','','','1024','');
INSERT INTO pw_members VALUES('85','简约生活','b1957d80bd2fd39683b27f2b6acff441','','l0033@163.com','-1','8','','','0','1240800088','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('86','酱豆豆','b1957d80bd2fd39683b27f2b6acff441','','l0034@163.com','-1','8','','','0','1241679157','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('87','superbaby','b1957d80bd2fd39683b27f2b6acff441','','l0035@163.com','-1','8','','','0','1241016099','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('88','XX2453','b1957d80bd2fd39683b27f2b6acff441','','l0036@163.com','-1','8','','','0','1244412367','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('89','绿爸他祖宗','b1957d80bd2fd39683b27f2b6acff441','','l0037@163.com','-1','8','','','0','1243981796','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('90','逝如风','b1957d80bd2fd39683b27f2b6acff441','','l0039@163.com','-1','8','','','0','1243862144','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('91','lingling9','b1957d80bd2fd39683b27f2b6acff441','','l0040@163.com','-1','8','','','0','1243950525','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('92','xiaohuahua','b1957d80bd2fd39683b27f2b6acff441','','l0041@163.com','-1','8','','','0','1243463553','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('93','xq1980','b1957d80bd2fd39683b27f2b6acff441','','l0042@163.com','-1','8','','','0','1241150622','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('94','糖人李','b1957d80bd2fd39683b27f2b6acff441','','l0043@163.com','-1','8','','','0','1238219815','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('95','糖六郎','b1957d80bd2fd39683b27f2b6acff441','','l0044@163.com','-1','8','','','0','1240348320','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('96','2E912','b1957d80bd2fd39683b27f2b6acff441','','l0045@163.com','-1','8','','','0','1243342580','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('97','JJ1314','b1957d80bd2fd39683b27f2b6acff441','','l0056@163.com','-1','8','','','0','1241654549','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('98','追忆未来','b1957d80bd2fd39683b27f2b6acff441','','l0047@163.com','-1','8','','','0','1238217747','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('99','浅滩','b1957d80bd2fd39683b27f2b6acff441','','l0048@163.com','-1','8','','','0','1239714929','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','1','','','','0','');
INSERT INTO pw_members VALUES('100','lizil1000','b1957d80bd2fd39683b27f2b6acff441','','l0049@163.com','-1','8','','none.gif|1|||','0','1242218530','','','','','','','','','','','1900-01-01','','1','','','','0','0','','0','1','','','','0','');
INSERT INTO pw_members VALUES('101','雪魂女','b1957d80bd2fd39683b27f2b6acff441','','l0050@163.com','-1','8','','','0','1243994813','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('102','瑶琴彩月','b1957d80bd2fd39683b27f2b6acff441','','yqxy@163.com','-1','8','','','0','1244892575','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('103','寒江雪','b1957d80bd2fd39683b27f2b6acff441','','hjx@163.com','-1','8','','','0','1238407014','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('104','水云烟','b1957d80bd2fd39683b27f2b6acff441','','syy@163.com','-1','8','','','0','1244133658','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('105','花无颜','b1957d80bd2fd39683b27f2b6acff441','','hwy@163.com','-1','8','','','0','1241565510','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('106','日光光','b1957d80bd2fd39683b27f2b6acff441','','rgg@163.com','-1','8','','','0','1240582417','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('107','半点糖','b1957d80bd2fd39683b27f2b6acff441','','bdt@163.com','-1','8','','','0','1239046889','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('108','糖心疯宝','b1957d80bd2fd39683b27f2b6acff441','','txfb@163.com','-1','8','','','0','1244508867','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('109','地瓜妹','b1957d80bd2fd39683b27f2b6acff441','','dgm@163.com','-1','8','','','0','1239293136','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('110','amingming','b1957d80bd2fd39683b27f2b6acff441','','amingming@163.com','-1','8','','','0','1242009903','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('111','xiamigo','b1957d80bd2fd39683b27f2b6acff441','','xiamigo@163.com','-1','8','','','0','1245214501','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('112','弹指一生','b1957d80bd2fd39683b27f2b6acff441','','tzys@163.com','-1','8','','','0','1244512549','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('113','採姑娘的小蘑菇','b1957d80bd2fd39683b27f2b6acff441','','cgndxmg@163.com','-1','8','','','0','1242232135','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','1024','');
INSERT INTO pw_members VALUES('114','乖乖老东东','b1957d80bd2fd39683b27f2b6acff441','','ggldd@163.com','-1','8','','','0','1244509967','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('115','谈感情伤钱','b1957d80bd2fd39683b27f2b6acff441','','tgqsq@163.com','-1','8','','','0','1240373489','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','1024','');
INSERT INTO pw_members VALUES('116','万女不挡之猛','b1957d80bd2fd39683b27f2b6acff441','','wnbdzm@163.com','-1','8','','','0','1244851860','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','1024','');
INSERT INTO pw_members VALUES('117','咪咪蚊','b1957d80bd2fd39683b27f2b6acff441','','mmw@163.com','-1','8','','','0','1240008760','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('118','天空之城','b1957d80bd2fd39683b27f2b6acff441','','tkzc@163.com','-1','8','','','0','1243209224','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('119','马大牙子','b1957d80bd2fd39683b27f2b6acff441','','mdyz@163.com','-1','8','','','0','1243083862','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('120','shijigege','b1957d80bd2fd39683b27f2b6acff441','','shijigege@163.com','-1','8','','','0','1245810192','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('121','qingmi1999','b1957d80bd2fd39683b27f2b6acff441','','qingmi1999@gmail.com','-1','8','','','0','1240891004','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('122','yaoyao2009','b1957d80bd2fd39683b27f2b6acff441','','yaoyao@gmail.com','-1','8','','','0','1240854023','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('123','鹤返辽阳','b1957d80bd2fd39683b27f2b6acff441','','hefanly@gmail.com','-1','8','','','0','1243093380','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('124','20090213','b1957d80bd2fd39683b27f2b6acff441','','20090213@live.com','-1','8','','','0','1243861262','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('125','远去的子龙','b1957d80bd2fd39683b27f2b6acff441','','zilong@live.com','-1','8','','','0','1240893474','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('126','周胖猴','b1957d80bd2fd39683b27f2b6acff441','','zhoupanghou@gmail.com','-1','8','','','0','1245261337','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('127','lichenglong','b1957d80bd2fd39683b27f2b6acff441','','lichenglong@gmail.com','-1','8','','','0','1241023477','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('128','老狼','b1957d80bd2fd39683b27f2b6acff441','','laolang@live.com','-1','8','','','0','1244367660','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('129','茶泡饭','b1957d80bd2fd39683b27f2b6acff441','','chapaofan@163.com','-1','8','','','0','1245298720','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('130','只喝绿茶','b1957d80bd2fd39683b27f2b6acff441','','greentea@live.com','-1','8','','','0','1242558043','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('131','厨房魔法师','b1957d80bd2fd39683b27f2b6acff441','','cfmfs@sohu.com','-1','8','','','0','1240405826','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('132','寿司终结者','b1957d80bd2fd39683b27f2b6acff441','','sszjz@yahoo.com.cn','-1','8','','','0','1243113168','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('133','食尚达人','b1957d80bd2fd39683b27f2b6acff441','','shishangdaren@163.com','-1','8','','','0','1241270254','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('134','伏地馍','b1957d80bd2fd39683b27f2b6acff441','','fudimo@sina.com','-1','8','','','0','1240632476','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('135','糖山大熊','b1957d80bd2fd39683b27f2b6acff441','','tsdaxiong@163.com','-1','8','','','0','1241066462','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('136','叮呤铃子','b1957d80bd2fd39683b27f2b6acff441','','fenglingzi@live.com','-1','8','','','0','1244655401','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('137','只为健康','b1957d80bd2fd39683b27f2b6acff441','','zhiweijiankang@163.com','-1','8','','','0','1243034530','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('138','宁愿低血糖','b1957d80bd2fd39683b27f2b6acff441','','nydxt@gmail.com','-1','8','','','0','1241932987','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('139','长治久安','b1957d80bd2fd39683b27f2b6acff441','','changzhi@gmail.com','-1','8','','','0','1242983903','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('140','戒烟n次','b1957d80bd2fd39683b27f2b6acff441','','jieyann@live.com','-1','8','','','0','1244147302','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('141','清茶消渴','b1957d80bd2fd39683b27f2b6acff441','','qingchaxiaoke@163.com','-1','8','','','0','1245762527','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('142','糖三胀','b1957d80bd2fd39683b27f2b6acff441','','tang3zhang@gmail.com','-1','8','','','0','1242018040','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('143','水煮人生','b1957d80bd2fd39683b27f2b6acff441','','shuizhurensheng@163.com','-1','8','','','0','1242479487','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('144','明州居士','b1957d80bd2fd39683b27f2b6acff441','','mingzhoujushi@sina.com','-1','8','','','0','1241814298','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('145','落寞烟花','b1957d80bd2fd39683b27f2b6acff441','','lmyanhua@live.com','-1','8','','','0','1240347643','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('146','五月的风铃','b1957d80bd2fd39683b27f2b6acff441','','a@163.com','-1','8','','','0','1244672612','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('147','大便波','b1957d80bd2fd39683b27f2b6acff441','','a1@163.com','-1','8','','','0','1240485793','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('148','老屋的样子','b1957d80bd2fd39683b27f2b6acff441','','a2@163.com','-1','8','','','0','1242176039','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('149','胭脂糖','b1957d80bd2fd39683b27f2b6acff441','','a3@163.com','-1','8','','','0','1241701472','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('150','乌巢装修记','b1957d80bd2fd39683b27f2b6acff441','','a4@163.com','-1','8','','','0','1245389291','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('151','飞蓬老豆之天蓬','b1957d80bd2fd39683b27f2b6acff441','','a5@163.com','-1','8','','','0','1241805867','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('152','黑双喜','b1957d80bd2fd39683b27f2b6acff441','','a6@163.com','-1','8','','','0','1244412112','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('153','老虎窝','b1957d80bd2fd39683b27f2b6acff441','','a7@163.com','-1','8','','','0','1240062950','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('154','装B分子','b1957d80bd2fd39683b27f2b6acff441','','a8@163.com','-1','8','','','0','1238718883','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('155','专治美女失恋','b1957d80bd2fd39683b27f2b6acff441','','a9@163.com','-1','8','','','0','1242093010','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('156','变态金刚','b1957d80bd2fd39683b27f2b6acff441','','a10@163.com','-1','8','','','0','1242776061','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('157','早班火车','b1957d80bd2fd39683b27f2b6acff441','','a11@163.com','-1','8','','','0','1245799856','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('158','wsy911','b1957d80bd2fd39683b27f2b6acff441','','a12@163.com','-1','8','','','0','1244936123','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('159','风流怪叔叔','b1957d80bd2fd39683b27f2b6acff441','','a13@163.com','-1','8','','','0','1240963357','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('160','zw3301','b1957d80bd2fd39683b27f2b6acff441','','a14@163.com','-1','8','','','0','1244918212','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('161','ihhahj','b1957d80bd2fd39683b27f2b6acff441','','a15@163.com','-1','8','','','0','1241313802','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('162','igoalone','b1957d80bd2fd39683b27f2b6acff441','','a16@163.com','-1','8','','','0','1243188819','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('163','Euting','b1957d80bd2fd39683b27f2b6acff441','','a17@163.com','-1','8','','','0','1241851015','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('164','迷途老狼','b1957d80bd2fd39683b27f2b6acff441','','a18@163.com','-1','8','','','0','1244403692','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('165','疯情万肿','b1957d80bd2fd39683b27f2b6acff441','','a19@163.com','-1','8','','','0','1245640932','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('166','love2009','b1957d80bd2fd39683b27f2b6acff441','','a20@163.com','-1','8','','','0','1244737113','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('167','chen0515','b1957d80bd2fd39683b27f2b6acff441','','a21@163.com','-1','8','','','0','1242878729','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('168','wuming','b1957d80bd2fd39683b27f2b6acff441','','a21@163.com','-1','8','','','0','1242495097','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('169','夕阳武士','b1957d80bd2fd39683b27f2b6acff441','','a22@163.com','-1','8','','','0','1240489736','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('170','snowcat','b1957d80bd2fd39683b27f2b6acff441','','a23@163.com','-1','8','','','0','1239682267','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('171','也曾风华正茂','b1957d80bd2fd39683b27f2b6acff441','','a24@163.com','-1','8','','','0','1240462035','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('172','yaorao1314','b1957d80bd2fd39683b27f2b6acff441','','a25@163.com','-1','8','','','0','1240071898','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('173','tt开心','b1957d80bd2fd39683b27f2b6acff441','','a26@163.com','-1','8','','','0','1243519943','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('174','咣当','b1957d80bd2fd39683b27f2b6acff441','','a26@163.com','-1','8','','','0','1244761159','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('175','优哉游哉','b1957d80bd2fd39683b27f2b6acff441','','a27@163.com','-1','8','','','0','1243705833','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('176','我没有头发','b1957d80bd2fd39683b27f2b6acff441','','a28@163.com','-1','8','','','0','1245687222','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('177','小僧','b1957d80bd2fd39683b27f2b6acff441','','a29@163.com','-1','8','','','0','1243253407','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('178','千年龟仙人','b1957d80bd2fd39683b27f2b6acff441','','a30@163.com','-1','8','','','0','1246011262','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('179','88cq','b1957d80bd2fd39683b27f2b6acff441','','a31@163.com','-1','8','','','0','1241682897','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('180','abclan','b1957d80bd2fd39683b27f2b6acff441','','a32@163.com','-1','8','','','0','1238774514','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('181','心灵捕手','b1957d80bd2fd39683b27f2b6acff441','','a33@163.com','-1','8','','','0','1245220189','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('182','阿拉玛亚星球','b1957d80bd2fd39683b27f2b6acff441','','a34@163.com','-1','8','','','0','1245308400','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('183','粥猩池','b1957d80bd2fd39683b27f2b6acff441','','a34@163.com','-1','8','','','0','1245006263','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('184','mengman','b1957d80bd2fd39683b27f2b6acff441','','a35@163.com','-1','8','','','0','1239102774','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('185','得瑟','b1957d80bd2fd39683b27f2b6acff441','','a36@163.com','-1','8','','','0','1245846919','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('186','xiao7','b1957d80bd2fd39683b27f2b6acff441','','a38@163.com','-1','8','','','0','1240918908','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('187','老三','b1957d80bd2fd39683b27f2b6acff441','','a39@163.com','-1','8','','','0','1243698471','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('188','病去如抽丝','b1957d80bd2fd39683b27f2b6acff441','','a40@163.com','-1','8','','','0','1245466411','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('189','xina82','b1957d80bd2fd39683b27f2b6acff441','','a41@163.com','-1','8','','','0','1239674667','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('190','Xunnee','b1957d80bd2fd39683b27f2b6acff441','','a42@163.com','-1','8','','','0','1238481464','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('191','注定漂泊','b1957d80bd2fd39683b27f2b6acff441','','a43@163.com','-1','8','','','0','1244204258','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('192','药罐子','b1957d80bd2fd39683b27f2b6acff441','','yaoguanzi@gmail.com','-1','8','','','0','1242808105','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('193','灰太狼大大大人','b1957d80bd2fd39683b27f2b6acff441','','a45@163.com','-1','8','','','0','1243489919','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('194','zhansh','b1957d80bd2fd39683b27f2b6acff441','','a46@163.com','-1','8','','','0','1239874908','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('195','fg520','b1957d80bd2fd39683b27f2b6acff441','','a47@163.com','-1','8','','','0','1241031433','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('196','不怕不怕了','b1957d80bd2fd39683b27f2b6acff441','','bpbpl@live.com','-1','8','','','0','1242950486','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('197','雪枫','b1957d80bd2fd39683b27f2b6acff441','','xuefeng@gmail.com','-1','8','','','0','1238431657','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('198','黛琰','b1957d80bd2fd39683b27f2b6acff441','','daiyan@live.com','-1','8','','','0','1245729798','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('199','甜性涩药','b1957d80bd2fd39683b27f2b6acff441','','tianxingseyao@gmail.com','-1','8','','','0','1239265219','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('200','燕虎龟','b1957d80bd2fd39683b27f2b6acff441','','yanhugui@live.com','-1','8','','','0','1240741030','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('201','freeman','b1957d80bd2fd39683b27f2b6acff441','','freeman@163.com','-1','8','','','0','1239231701','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('202','lb0504130','b1957d80bd2fd39683b27f2b6acff441','','lb0504130@163.com','-1','8','','','0','1247716268','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','0','');
INSERT INTO pw_members VALUES('203','jjfyg','b1957d80bd2fd39683b27f2b6acff441','','jennie@yunge.cn','-1','8','','','0','1247721192','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','1024','');
INSERT INTO pw_members VALUES('204','wuliujushi','b1957d80bd2fd39683b27f2b6acff441','','wuliuju@live.com','-1','8','','','0','1247977643','','','','','','','','','','','0000-00-00','','1','','','','0','0','','0','0','','','','1024','');


INSERT INTO pw_modehot VALUES('1','0','1','memberHot','用户排行','N;','N;','1','1','');
INSERT INTO pw_modehot VALUES('2','1','1','memberOnLine','在线排行','N;','a:3:{s:7:\"current\";s:7:\"history\";s:7:\"filters\";a:4:{i:0;s:5:\"today\";i:1;s:4:\"week\";i:2;s:5:\"month\";i:3;s:7:\"history\";}s:11:\"filterItems\";a:4:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";}}','1','1','');
INSERT INTO pw_modehot VALUES('3','1','2','memberCredit','积分排行','a:3:{s:7:\"current\";s:5:\"money\";s:7:\"filters\";a:5:{i:0;s:5:\"money\";i:1;s:4:\"rvrc\";i:2;s:6:\"credit\";i:3;s:8:\"currency\";i:4;i:4;}s:11:\"filterItems\";a:5:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";i:4;s:1:\"5\";}}','N;','1','1','');
INSERT INTO pw_modehot VALUES('4','1','3','memberFriend','好友排行','N;','N;','0','1','');
INSERT INTO pw_modehot VALUES('5','1','4','memberThread','发帖排行','N;','a:3:{s:7:\"current\";s:7:\"history\";s:7:\"filters\";a:4:{i:0;s:5:\"today\";i:1;s:4:\"week\";i:2;s:5:\"month\";i:3;s:7:\"history\";}s:11:\"filterItems\";a:4:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";}}','0','1','');
INSERT INTO pw_modehot VALUES('6','1','6','memberShare','分享推荐排行','a:3:{s:7:\"current\";s:14:\"memberShareAll\";s:7:\"filters\";a:10:{i:0;s:17:\"memberShareThread\";i:1;s:16:\"memberShareDiary\";i:2;s:16:\"memberShareAlbum\";i:3;s:15:\"memberShareUser\";i:4;s:16:\"memberShareGroup\";i:5;s:14:\"memberSharePic\";i:6;s:15:\"memberShareLink\";i:7;s:16:\"memberShareVideo\";i:8;s:16:\"memberShareMusic\";i:9;s:14:\"memberShareAll\";}s:11:\"filterItems\";a:10:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";i:4;s:1:\"5\";i:5;s:1:\"5\";i:6;s:1:\"5\";i:7;s:1:\"5\";i:8;s:1:\"5\";i:9;s:1:\"5\";}}','a:3:{s:7:\"current\";s:7:\"history\";s:7:\"filters\";a:4:{i:0;s:5:\"today\";i:1;s:4:\"week\";i:2;s:5:\"month\";i:3;s:7:\"history\";}s:11:\"filterItems\";a:4:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";}}','0','1','');
INSERT INTO pw_modehot VALUES('8','0','2','threadHot','帖子排行','N;','N;','1','1','');
INSERT INTO pw_modehot VALUES('9','8','1','threadPost','回复排行','N;','a:3:{s:7:\"current\";s:7:\"history\";s:7:\"filters\";a:4:{i:0;s:5:\"today\";i:1;s:4:\"week\";i:2;s:5:\"month\";i:3;s:7:\"history\";}s:11:\"filterItems\";a:4:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";}}','1','1','');
INSERT INTO pw_modehot VALUES('10','8','2','threadRate','评价排行','a:3:{s:7:\"current\";s:12:\"rateThread_1\";s:7:\"filters\";a:7:{i:0;s:12:\"rateThread_1\";i:1;s:12:\"rateThread_2\";i:2;s:12:\"rateThread_3\";i:3;s:12:\"rateThread_4\";i:4;s:12:\"rateThread_5\";i:5;s:12:\"rateThread_6\";i:6;s:12:\"rateThread_7\";}s:11:\"filterItems\";a:7:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";i:4;s:1:\"5\";i:5;s:1:\"5\";i:6;s:1:\"5\";}}','a:3:{s:7:\"current\";s:7:\"history\";s:7:\"filters\";a:4:{i:0;s:5:\"today\";i:1;s:4:\"week\";i:2;s:5:\"month\";i:3;s:7:\"history\";}s:11:\"filterItems\";a:4:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";}}','0','1','');
INSERT INTO pw_modehot VALUES('11','8','3','threadFav','收藏排行','N;','a:3:{s:7:\"current\";s:7:\"history\";s:7:\"filters\";a:4:{i:0;s:5:\"today\";i:1;s:4:\"week\";i:2;s:5:\"month\";i:3;s:7:\"history\";}s:11:\"filterItems\";a:4:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";}}','1','1','');
INSERT INTO pw_modehot VALUES('12','8','4','threadShare','分享排行','N;','a:3:{s:7:\"current\";s:7:\"history\";s:7:\"filters\";a:4:{i:0;s:5:\"today\";i:1;s:4:\"week\";i:2;s:5:\"month\";i:3;s:7:\"history\";}s:11:\"filterItems\";a:4:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";}}','0','1','');
INSERT INTO pw_modehot VALUES('13','0','3','diaryHot','日志排行','N;','N;','1','1','');
INSERT INTO pw_modehot VALUES('14','13','1','diaryComment','评论排行','N;','a:3:{s:7:\"current\";s:7:\"history\";s:7:\"filters\";a:4:{i:0;s:5:\"today\";i:1;s:4:\"week\";i:2;s:5:\"month\";i:3;s:7:\"history\";}s:11:\"filterItems\";a:4:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";}}','1','1','');
INSERT INTO pw_modehot VALUES('15','13','2','diaryRate','评价排行','a:3:{s:7:\"current\";s:11:\"rateDiary_8\";s:7:\"filters\";a:7:{i:0;s:11:\"rateDiary_8\";i:1;s:11:\"rateDiary_9\";i:2;s:12:\"rateDiary_10\";i:3;s:12:\"rateDiary_11\";i:4;s:12:\"rateDiary_12\";i:5;s:12:\"rateDiary_13\";i:6;s:12:\"rateDiary_14\";}s:11:\"filterItems\";a:7:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";i:4;s:1:\"5\";i:5;s:1:\"5\";i:6;s:1:\"5\";}}','a:3:{s:7:\"current\";s:7:\"history\";s:7:\"filters\";a:4:{i:0;s:5:\"today\";i:1;s:4:\"week\";i:2;s:5:\"month\";i:3;s:7:\"history\";}s:11:\"filterItems\";a:4:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";}}','0','1','');
INSERT INTO pw_modehot VALUES('16','13','3','diaryFav','收藏排行','N;','a:3:{s:7:\"current\";s:7:\"history\";s:7:\"filters\";a:4:{i:0;s:5:\"today\";i:1;s:4:\"week\";i:2;s:5:\"month\";i:3;s:7:\"history\";}s:11:\"filterItems\";a:4:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";}}','0','1','');
INSERT INTO pw_modehot VALUES('17','13','4','diaryShare','分享排行','N;','a:3:{s:7:\"current\";s:7:\"history\";s:7:\"filters\";a:4:{i:0;s:5:\"today\";i:1;s:4:\"week\";i:2;s:5:\"month\";i:3;s:7:\"history\";}s:11:\"filterItems\";a:4:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";}}','0','1','');
INSERT INTO pw_modehot VALUES('18','0','4','picHot','照片排行','N;','N;','1','1','');
INSERT INTO pw_modehot VALUES('19','18','1','picComment','评论排行','N;','a:3:{s:7:\"current\";s:7:\"history\";s:7:\"filters\";a:4:{i:0;s:5:\"today\";i:1;s:4:\"week\";i:2;s:5:\"month\";i:3;s:7:\"history\";}s:11:\"filterItems\";a:4:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";}}','1','1','');
INSERT INTO pw_modehot VALUES('20','18','2','picRate','评价排行','a:3:{s:7:\"current\";s:14:\"ratePicture_15\";s:7:\"filters\";a:8:{i:0;s:14:\"ratePicture_15\";i:1;s:14:\"ratePicture_16\";i:2;s:14:\"ratePicture_17\";i:3;s:14:\"ratePicture_18\";i:4;s:14:\"ratePicture_19\";i:5;s:14:\"ratePicture_20\";i:6;s:14:\"ratePicture_21\";i:7;s:14:\"ratePicture_22\";}s:11:\"filterItems\";a:8:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";i:4;s:1:\"5\";i:5;s:1:\"5\";i:6;s:1:\"5\";i:7;s:1:\"5\";}}','a:3:{s:7:\"current\";s:7:\"history\";s:7:\"filters\";a:4:{i:0;s:5:\"today\";i:1;s:4:\"week\";i:2;s:5:\"month\";i:3;s:7:\"history\";}s:11:\"filterItems\";a:4:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";}}','0','1','');
INSERT INTO pw_modehot VALUES('21','18','3','picFav','收藏排行','N;','a:3:{s:7:\"current\";s:7:\"history\";s:7:\"filters\";a:4:{i:0;s:5:\"today\";i:1;s:4:\"week\";i:2;s:5:\"month\";i:3;s:7:\"history\";}s:11:\"filterItems\";a:4:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";}}','0','1','');
INSERT INTO pw_modehot VALUES('22','18','4','picShare','分享排行','N;','a:3:{s:7:\"current\";s:7:\"history\";s:7:\"filters\";a:4:{i:0;s:5:\"today\";i:1;s:4:\"week\";i:2;s:5:\"month\";i:3;s:7:\"history\";}s:11:\"filterItems\";a:4:{i:0;s:1:\"5\";i:1;s:1:\"5\";i:2;s:1:\"5\";i:3;s:1:\"5\";}}','0','1','');
INSERT INTO pw_modehot VALUES('23','0','5','forumHot','论坛版块排行','N;','N;','1','1','');
INSERT INTO pw_modehot VALUES('24','23','1','forumPost','今日发帖排行','N;','N;','1','1','');
INSERT INTO pw_modehot VALUES('25','23','2','forumTopic','主题排行','N;','N;','0','1','');
INSERT INTO pw_modehot VALUES('26','23','3','forumArticle','文章排行','N;','N;','0','1','');





INSERT INTO pw_nav VALUES('4','','head','|帮助','|||','faq.php','','bbs,area','1','0','0','1');
INSERT INTO pw_nav VALUES('5','app','bbs_navinfo','社区应用','','','','','0','0','0','1');
INSERT INTO pw_nav VALUES('6','lastpost','bbs_navinfo','最新帖子','','search.php?sch_time=newatc','','','0','1','0','1');
INSERT INTO pw_nav VALUES('7','digest','bbs_navinfo','精华区','','search.php?digest=1','','','0','2','0','1');
INSERT INTO pw_nav VALUES('8','hack','bbs_navinfo','社区服务','','','','','0','3','0','1');
INSERT INTO pw_nav VALUES('9','member','bbs_navinfo','会员列表','','member.php','','','0','4','0','1');
INSERT INTO pw_nav VALUES('10','sort','bbs_navinfo','统计排行','','sort.php','','','0','5','0','1');
INSERT INTO pw_nav VALUES('11','search','bbs_navinfo','搜索','','search.php','','','0','6','0','0');
INSERT INTO pw_nav VALUES('12','faq','bbs_navinfo','帮助','','faq.php','','','0','7','0','0');
INSERT INTO pw_nav VALUES('13','sort_basic','bbs_navinfo','基本信息','','sort.php','','','0','8','10','1');
INSERT INTO pw_nav VALUES('14','sort_ipstate','bbs_navinfo','到访IP统计','','sort.php?action=ipstate','','','0','9','10','1');
INSERT INTO pw_nav VALUES('15','sort_team','bbs_navinfo','管理团队','','sort.php?action=team','','','0','10','10','1');
INSERT INTO pw_nav VALUES('16','sort_admin','bbs_navinfo','管理操作','','sort.php?action=admin','','','0','11','10','1');
INSERT INTO pw_nav VALUES('17','sort_online','bbs_navinfo','在线会员','','sort.php?action=online','','','0','12','10','1');
INSERT INTO pw_nav VALUES('18','sort_member','bbs_navinfo','会员排行','','sort.php?action=member','','','0','13','10','1');
INSERT INTO pw_nav VALUES('19','sort_forum','bbs_navinfo','版块排行','','sort.php?action=forum','','','0','14','10','1');
INSERT INTO pw_nav VALUES('20','sort_article','bbs_navinfo','帖子排行','','sort.php?action=article','','','0','15','10','1');
INSERT INTO pw_nav VALUES('21','sort_taglist','bbs_navinfo','标签排行','','job.php?action=taglist','','','0','16','10','1');
INSERT INTO pw_nav VALUES('22','index','o_navinfo','圈子首页','','index.php?m=o','','o','0','0','0','1');
INSERT INTO pw_nav VALUES('23','home','o_navinfo','我的首页','','mode.php?m=o','','o','0','1','0','1');
INSERT INTO pw_nav VALUES('24','user','o_navinfo','个人空间','','mode.php?m=o&q=user','','o','0','2','0','1');
INSERT INTO pw_nav VALUES('25','friend','o_navinfo','朋友','','mode.php?m=o&q=friend','','o','0','3','0','1');
INSERT INTO pw_nav VALUES('26','browse','o_navinfo','随便看看','','mode.php?m=o&q=browse','','o','0','4','0','1');
INSERT INTO pw_nav VALUES('27','app_article','bbs_navinfo','帖子','','apps.php?q=article','','','0','1','5','1');
INSERT INTO pw_nav VALUES('28','app_photos','bbs_navinfo','相册','','apps.php?q=photos','','','0','2','5','1');
INSERT INTO pw_nav VALUES('29','app_diary','bbs_navinfo','日志','','apps.php?q=diary','','','0','3','5','1');
INSERT INTO pw_nav VALUES('30','app_groups','bbs_navinfo','群组','','apps.php?q=groups','','','0','4','5','1');
INSERT INTO pw_nav VALUES('31','app_hot','bbs_navinfo','热榜','','apps.php?q=hot','','','0','5','5','1');
INSERT INTO pw_nav VALUES('32','app_share','bbs_navinfo','分享','','apps.php?q=share','','','0','6','5','1');
INSERT INTO pw_nav VALUES('33','app_write','bbs_navinfo','记录','','apps.php?q=write','','','0','7','5','1');
INSERT INTO pw_nav VALUES('34','bbs','main','论坛','','index.php?m=bbs','','bbs,area','0','2','0','1');
INSERT INTO pw_nav VALUES('35','o','main','圈子','','index.php?m=o','','bbs,area','1','3','0','1');
INSERT INTO pw_nav VALUES('36','area','main','门户','','index.php?m=area','','bbs,area','0','1','0','1');
INSERT INTO pw_nav VALUES('37','hack_toolcenter','bbs_navinfo','道具中心','','hack.php?H_name=toolcenter','','bbs','0','50','8','1');
INSERT INTO pw_nav VALUES('38','hack_rate','bbs_navinfo','评价管理','','hack.php?H_name=rate','','bbs','0','51','8','0');
INSERT INTO pw_nav VALUES('39','hack_medal','bbs_navinfo','勋章中心','','hack.php?H_name=medal','','bbs','0','52','8','0');
INSERT INTO pw_nav VALUES('40','hack_invite','bbs_navinfo','邀请注册','','hack.php?H_name=invite','','bbs','0','53','8','0');
INSERT INTO pw_nav VALUES('41','hack_blog','bbs_navinfo','博客接口','','hack.php?H_name=blog','','bbs','0','54','8','0');
INSERT INTO pw_nav VALUES('42','hack_bank','bbs_navinfo','银行','','hack.php?H_name=bank','','bbs','0','55','0','1');
INSERT INTO pw_nav VALUES('43','1','area_navinfo','默认分类','','cate.php?cateid=1','','area','0','0','0','1');
INSERT INTO pw_nav VALUES('44','3','area_navinfo','糖疾','','cate.php?cateid=3','','area','0','0','0','1');
INSERT INTO pw_nav VALUES('45','5','area_navinfo','其它','','cate.php?cateid=5','','area','0','0','0','1');



INSERT INTO pw_ouserdata VALUES('1','0','0','0','0','0','0','0','0','1','1','1','1','1','0','0','','','0','0','0','0','0','0','0','0','0','0');


INSERT INTO pw_pcfield VALUES('1','类别','pctype','1','1','radio','a:8:{i:0;s:11:\"1=婚庆类\";i:1;s:11:\"2=房产类\";i:2;s:11:\"3=汽车类\";i:3;s:11:\"4=家电类\";i:4;s:11:\"5=家装类\";i:5;s:14:\"6=生产原料\";i:6;s:11:\"7=食品类\";i:7;s:8:\"8=其他\";}','1','1','1','1','0','1','0','');
INSERT INTO pw_pcfield VALUES('2','发起时间','begintime','1','2','calendar','','1','1','1','0','1','1','0','');
INSERT INTO pw_pcfield VALUES('3','截止时间','endtime','1','3','calendar','','1','1','1','1','1','1','0','');
INSERT INTO pw_pcfield VALUES('4','人数限制','limitnum','1','4','number','a:2:{s:6:\"minnum\";s:1:\"1\";s:6:\"maxnum\";s:3:\"100\";}','1','0','0','1','0','1','0','人（不限制，请留空）');
INSERT INTO pw_pcfield VALUES('5','报名限制','objecter','1','5','radio','a:2:{i:0;s:14:\"1=所有用户\";i:1;s:11:\"2=仅好友\";}','1','0','1','0','0','1','0','');
INSERT INTO pw_pcfield VALUES('6','价格','price','1','6','text','','1','0','0','0','0','1','0','');
INSERT INTO pw_pcfield VALUES('7','押金','deposit','1','7','text','','1','0','0','0','0','1','0','（留空则无需支付押金）');
INSERT INTO pw_pcfield VALUES('8','支付方式','payway','1','8','radio','a:2:{i:0;s:17:\"1=支付宝支付\";i:1;s:14:\"2=现金支付\";}','1','0','1','0','0','1','0','');
INSERT INTO pw_pcfield VALUES('9','联系人','contacter','1','9','text','','1','1','0','0','1','1','0','');
INSERT INTO pw_pcfield VALUES('10','电话','tel','1','10','text','','1','0','0','0','0','1','4','');
INSERT INTO pw_pcfield VALUES('11','-','phone','1','10','text','','1','0','0','0','0','1','14','例如：0571-12345678');
INSERT INTO pw_pcfield VALUES('12','手机','mobile','1','11','text','','1','0','0','0','1','1','0','');
INSERT INTO pw_pcfield VALUES('13','图片上传','pcattach','1','13','upload','','1','0','0','0','0','1','0','');
INSERT INTO pw_pcfield VALUES('14','类别','pctype','2','1','radio','a:6:{i:0;s:8:\"1=出游\";i:1;s:9:\"2=聚餐 \";i:2;s:8:\"3=舞会\";i:3;s:8:\"4=户外\";i:4;s:8:\"5=烧烤\";i:5;s:8:\"6=其他\";}','1','1','1','1','0','1','0','');
INSERT INTO pw_pcfield VALUES('15','发起时间','begintime','2','2','calendar','','1','1','1','0','1','1','0','');
INSERT INTO pw_pcfield VALUES('16','过期时间','endtime','2','3','calendar','','1','1','1','1','1','1','0','');
INSERT INTO pw_pcfield VALUES('17','活动地点','address','2','4','text','','1','0','1','1','0','1','0','');
INSERT INTO pw_pcfield VALUES('18','人数限制','limitnum','2','5','number','a:2:{s:6:\"minnum\";s:1:\"1\";s:6:\"maxnum\";s:3:\"100\";}','1','0','0','0','0','1','0','人（不限制，请留空）');
INSERT INTO pw_pcfield VALUES('19','报名限制','objecter','2','6','radio','a:2:{i:0;s:14:\"1=所有用户\";i:1;s:11:\"2=仅好友\";}','1','0','1','0','0','1','0','');
INSERT INTO pw_pcfield VALUES('20','性别限制','gender','2','7','radio','a:3:{i:0;s:8:\"1=全部\";i:1;s:11:\"2=仅男生\";i:2;s:11:\"3=仅女生\";}','1','0','1','0','0','1','0','');
INSERT INTO pw_pcfield VALUES('21','活动经费','price','2','8','text','','1','0','0','0','0','1','0','元/人');
INSERT INTO pw_pcfield VALUES('22','支付方式','payway','2','9','radio','a:2:{i:0;s:17:\"1=支付宝支付\";i:1;s:14:\"2=现金支付\";}','1','0','1','0','0','1','0','');
INSERT INTO pw_pcfield VALUES('23','联系人','contacter','2','10','text','','1','0','0','0','1','1','0','');
INSERT INTO pw_pcfield VALUES('24','电话','tel','2','11','text','','1','0','0','0','0','1','4','');
INSERT INTO pw_pcfield VALUES('25','-','phone','2','11','text','','1','0','0','0','0','1','14','例如：0571-123456778');
INSERT INTO pw_pcfield VALUES('26','手机','mobile','2','12','text','','1','0','0','0','1','1','0','');
INSERT INTO pw_pcfield VALUES('27','图片上传','pcattach','2','13','upload','','1','0','0','0','0','1','0','');




INSERT INTO pw_permission VALUES('0','0','1','maxmsg','basic','30');
INSERT INTO pw_permission VALUES('0','0','1','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','1','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowportait','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','upload','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowrp','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowhonor','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowdelatc','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowpost','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allownewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowactive','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','1','allowhidden','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowencode','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowsell','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowsearch','basic','2');
INSERT INTO pw_permission VALUES('0','0','1','allowmember','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowreport','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowmessege','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowsort','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','alloworder','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowupload','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowdownload','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allownum','basic','50');
INSERT INTO pw_permission VALUES('0','0','1','edittime','basic','0');
INSERT INTO pw_permission VALUES('0','0','1','postpertime','basic','3');
INSERT INTO pw_permission VALUES('0','0','1','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','1','signnum','basic','100');
INSERT INTO pw_permission VALUES('0','0','1','show','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','viewipfrom','basic','0');
INSERT INTO pw_permission VALUES('0','0','1','imgwidth','basic','');
INSERT INTO pw_permission VALUES('0','0','1','imgheight','basic','');
INSERT INTO pw_permission VALUES('0','0','1','msggroup','basic','0');
INSERT INTO pw_permission VALUES('0','0','1','maxfavor','basic','100');
INSERT INTO pw_permission VALUES('0','0','1','viewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','1','atccheck','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','markable','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','postlimit','basic','');
INSERT INTO pw_permission VALUES('0','0','1','uploadtype','basic','');
INSERT INTO pw_permission VALUES('0','0','1','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','1','ifmemo','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','atclog','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','modifyvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowreward','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowgoods','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','allowdebate','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','anonymous','basic','0');
INSERT INTO pw_permission VALUES('0','0','1','dig','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','leaveword','basic','1');
INSERT INTO pw_permission VALUES('0','0','1','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','1','fontsize','basic','');
INSERT INTO pw_permission VALUES('0','0','1','maxsendmsg','basic','');
INSERT INTO pw_permission VALUES('0','0','1','pergroup','basic','member');
INSERT INTO pw_permission VALUES('0','0','1','maxgraft','basic','5');
INSERT INTO pw_permission VALUES('0','0','1','pwdlimitime','basic','');
INSERT INTO pw_permission VALUES('0','0','1','maxcstyles','basic','');
INSERT INTO pw_permission VALUES('0','0','1','media','basic','');
INSERT INTO pw_permission VALUES('0','0','1','markset','basic','a:5:{s:5:\"money\";a:4:{s:9:\"markctype\";s:5:\"money\";s:9:\"maxcredit\";s:1:\"5\";s:9:\"marklimit\";a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','2','maxmsg','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','2','allowportait','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','upload','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowrp','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowhonor','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowdelatc','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowpost','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allownewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowactive','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowhidden','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowencode','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowsell','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowsearch','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowmember','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','2','allowreport','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowmessege','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowsort','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','alloworder','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowupload','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowdownload','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allownum','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','edittime','basic','1');
INSERT INTO pw_permission VALUES('0','0','2','postpertime','basic','10');
INSERT INTO pw_permission VALUES('0','0','2','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','2','signnum','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','show','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','viewipfrom','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','imgwidth','basic','');
INSERT INTO pw_permission VALUES('0','0','2','imgheight','basic','');
INSERT INTO pw_permission VALUES('0','0','2','fontsize','basic','');
INSERT INTO pw_permission VALUES('0','0','2','msggroup','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','maxfavor','basic','100');
INSERT INTO pw_permission VALUES('0','0','2','viewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','atccheck','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','markable','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','postlimit','basic','');
INSERT INTO pw_permission VALUES('0','0','2','uploadtype','basic','');
INSERT INTO pw_permission VALUES('0','0','2','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','2','ifmemo','basic','1');
INSERT INTO pw_permission VALUES('0','0','2','atclog','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','2','modifyvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowreward','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowgoods','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','allowdebate','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','anonymous','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','dig','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','leaveword','basic','0');
INSERT INTO pw_permission VALUES('0','0','2','markset','basic','a:5:{s:5:\"money\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','3','maxmsg','basic','50');
INSERT INTO pw_permission VALUES('0','0','3','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','3','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowportait','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','upload','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowrp','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowhonor','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowdelatc','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowpost','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allownewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowactive','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','htmlcode','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowhidden','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowencode','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowsell','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowsearch','basic','2');
INSERT INTO pw_permission VALUES('0','0','3','allowmember','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowreport','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowmessege','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowsort','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','alloworder','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowupload','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowdownload','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allownum','basic','200');
INSERT INTO pw_permission VALUES('0','0','3','edittime','basic','0');
INSERT INTO pw_permission VALUES('0','0','3','postpertime','basic','3');
INSERT INTO pw_permission VALUES('0','0','3','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','3','signnum','basic','200');
INSERT INTO pw_permission VALUES('0','0','3','show','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','viewipfrom','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','imgwidth','basic','');
INSERT INTO pw_permission VALUES('0','0','3','imgheight','basic','');
INSERT INTO pw_permission VALUES('0','0','3','fontsize','basic','');
INSERT INTO pw_permission VALUES('0','0','3','msggroup','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','maxfavor','basic','100');
INSERT INTO pw_permission VALUES('0','0','3','viewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','atccheck','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','markable','basic','2');
INSERT INTO pw_permission VALUES('0','0','3','postlimit','basic','');
INSERT INTO pw_permission VALUES('0','0','3','uploadtype','basic','');
INSERT INTO pw_permission VALUES('0','0','3','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','3','anonymous','basic','0');
INSERT INTO pw_permission VALUES('0','0','3','leaveword','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowadmincp','system','1');
INSERT INTO pw_permission VALUES('0','0','3','delatc','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','moveatc','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','copyatc','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','digestadmin','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','lockadmin','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','pushadmin','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','coloradmin','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','downadmin','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','viewcheck','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','viewclose','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','delattach','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','viewip','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','banuser','systemforum','2');
INSERT INTO pw_permission VALUES('0','0','3','bantype','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','banmax','systemforum','30');
INSERT INTO pw_permission VALUES('0','0','3','posthide','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','sellhide','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','encodehide','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','anonyhide','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','postpers','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','replylock','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','modother','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','deltpcs','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','topped','systemforum','3');
INSERT INTO pw_permission VALUES('0','0','3','tpctype','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','tpccheck','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','allowtime','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','superright','system','1');
INSERT INTO pw_permission VALUES('0','0','3','ifmemo','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','markset','basic','a:5:{s:5:\"money\";a:4:{s:9:\"markctype\";s:5:\"money\";s:9:\"maxcredit\";s:3:\"100\";s:9:\"marklimit\";a:2:{i:0;s:2:\"-2\";i:1;s:1:\"5\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','3','atclog','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','3','maxsendmsg','basic','');
INSERT INTO pw_permission VALUES('0','0','3','pergroup','basic','member,system,special');
INSERT INTO pw_permission VALUES('0','0','3','maxgraft','basic','10');
INSERT INTO pw_permission VALUES('0','0','3','pwdlimitime','basic','');
INSERT INTO pw_permission VALUES('0','0','3','maxcstyles','basic','');
INSERT INTO pw_permission VALUES('0','0','3','modifyvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowreward','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowgoods','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','allowdebate','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','media','basic','');
INSERT INTO pw_permission VALUES('0','0','3','dig','basic','1');
INSERT INTO pw_permission VALUES('0','0','3','shield','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','unite','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','remind','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','pingcp','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','inspect','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','areapush','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','3','areapush','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','maxmsg','basic','50');
INSERT INTO pw_permission VALUES('0','0','4','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','4','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowportait','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','upload','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowrp','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowhonor','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowdelatc','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowpost','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allownewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowactive','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','4','allowhidden','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowencode','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowsell','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowsearch','basic','2');
INSERT INTO pw_permission VALUES('0','0','4','allowmember','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowreport','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowmessege','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowsort','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','alloworder','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowupload','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowdownload','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allownum','basic','80');
INSERT INTO pw_permission VALUES('0','0','4','edittime','basic','0');
INSERT INTO pw_permission VALUES('0','0','4','postpertime','basic','3');
INSERT INTO pw_permission VALUES('0','0','4','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','4','signnum','basic','200');
INSERT INTO pw_permission VALUES('0','0','4','show','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','viewipfrom','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','imgwidth','basic','');
INSERT INTO pw_permission VALUES('0','0','4','imgheight','basic','');
INSERT INTO pw_permission VALUES('0','0','4','fontsize','basic','');
INSERT INTO pw_permission VALUES('0','0','4','msggroup','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','maxfavor','basic','100');
INSERT INTO pw_permission VALUES('0','0','4','viewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','atccheck','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','markable','basic','2');
INSERT INTO pw_permission VALUES('0','0','4','postlimit','basic','');
INSERT INTO pw_permission VALUES('0','0','4','uploadtype','basic','');
INSERT INTO pw_permission VALUES('0','0','4','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','4','anonymous','basic','0');
INSERT INTO pw_permission VALUES('0','0','4','leaveword','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowadmincp','system','1');
INSERT INTO pw_permission VALUES('0','0','4','delatc','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','moveatc','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','copyatc','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','digestadmin','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','lockadmin','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','pushadmin','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','coloradmin','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','downadmin','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','viewcheck','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','viewclose','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','delattach','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','viewip','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','banuser','systemforum','2');
INSERT INTO pw_permission VALUES('0','0','4','bantype','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','banmax','systemforum','20');
INSERT INTO pw_permission VALUES('0','0','4','posthide','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','sellhide','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','encodehide','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','anonyhide','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','postpers','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','replylock','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','modother','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','deltpcs','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','topped','systemforum','3');
INSERT INTO pw_permission VALUES('0','0','4','tpctype','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','tpccheck','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','allowtime','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','superright','system','1');
INSERT INTO pw_permission VALUES('0','0','4','ifmemo','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','markset','basic','a:5:{s:5:\"money\";a:4:{s:9:\"markctype\";s:5:\"money\";s:9:\"maxcredit\";s:2:\"80\";s:9:\"marklimit\";a:2:{i:0;s:2:\"-1\";i:1;s:1:\"3\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','4','atclog','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','4','maxsendmsg','basic','');
INSERT INTO pw_permission VALUES('0','0','4','pergroup','basic','member,system');
INSERT INTO pw_permission VALUES('0','0','4','maxgraft','basic','10');
INSERT INTO pw_permission VALUES('0','0','4','pwdlimitime','basic','');
INSERT INTO pw_permission VALUES('0','0','4','maxcstyles','basic','');
INSERT INTO pw_permission VALUES('0','0','4','modifyvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowreward','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowgoods','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','allowdebate','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','media','basic','');
INSERT INTO pw_permission VALUES('0','0','4','dig','basic','1');
INSERT INTO pw_permission VALUES('0','0','4','shield','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','unite','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','remind','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','pingcp','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','4','inspect','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','maxmsg','basic','50');
INSERT INTO pw_permission VALUES('0','0','5','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','5','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowportait','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','upload','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowrp','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowhonor','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowdelatc','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowpost','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allownewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowactive','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','5','allowhidden','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowencode','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowsell','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowsearch','basic','2');
INSERT INTO pw_permission VALUES('0','0','5','allowmember','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowreport','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowmessege','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowsort','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','alloworder','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowupload','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowdownload','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allownum','basic','80');
INSERT INTO pw_permission VALUES('0','0','5','edittime','basic','0');
INSERT INTO pw_permission VALUES('0','0','5','postpertime','basic','3');
INSERT INTO pw_permission VALUES('0','0','5','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','5','signnum','basic','200');
INSERT INTO pw_permission VALUES('0','0','5','show','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','viewipfrom','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','imgwidth','basic','');
INSERT INTO pw_permission VALUES('0','0','5','imgheight','basic','');
INSERT INTO pw_permission VALUES('0','0','5','fontsize','basic','');
INSERT INTO pw_permission VALUES('0','0','5','msggroup','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','maxfavor','basic','100');
INSERT INTO pw_permission VALUES('0','0','5','viewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','atccheck','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','markable','basic','2');
INSERT INTO pw_permission VALUES('0','0','5','postlimit','basic','');
INSERT INTO pw_permission VALUES('0','0','5','uploadtype','basic','');
INSERT INTO pw_permission VALUES('0','0','5','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','5','anonymous','basic','0');
INSERT INTO pw_permission VALUES('0','0','5','leaveword','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowadmincp','system','1');
INSERT INTO pw_permission VALUES('0','0','5','delatc','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','moveatc','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','copyatc','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','digestadmin','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','lockadmin','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','pushadmin','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','coloradmin','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','downadmin','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','viewcheck','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','viewclose','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','delattach','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','viewip','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','banuser','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','bantype','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','5','banmax','systemforum','10');
INSERT INTO pw_permission VALUES('0','0','5','posthide','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','5','sellhide','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','5','encodehide','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','5','anonyhide','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','5','postpers','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','5','replylock','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','modother','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','remind','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','shield','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','topped','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','tpccheck','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','tpctype','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','unite','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','deltpcs','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','allowtime','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','superright','system','0');
INSERT INTO pw_permission VALUES('0','0','5','ifmemo','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','markset','basic','a:5:{s:5:\"money\";a:4:{s:9:\"markctype\";s:5:\"money\";s:9:\"maxcredit\";s:2:\"80\";s:9:\"marklimit\";a:2:{i:0;s:2:\"-1\";i:1;s:1:\"3\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','5','atclog','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','5','modifyvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowreward','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowgoods','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','allowdebate','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','dig','basic','1');
INSERT INTO pw_permission VALUES('0','0','5','pingcp','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','inspect','systemforum','1');
INSERT INTO pw_permission VALUES('0','0','5','maxsendmsg','basic','');
INSERT INTO pw_permission VALUES('0','0','5','pergroup','basic','member,system,special');
INSERT INTO pw_permission VALUES('0','0','5','maxgraft','basic','10');
INSERT INTO pw_permission VALUES('0','0','5','pwdlimitime','basic','');
INSERT INTO pw_permission VALUES('0','0','5','maxcstyles','basic','');
INSERT INTO pw_permission VALUES('0','0','5','media','basic','');
INSERT INTO pw_permission VALUES('0','0','6','maxmsg','basic','10');
INSERT INTO pw_permission VALUES('0','0','6','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','6','allowportait','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','upload','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowrp','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowhonor','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowdelatc','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowpost','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allownewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowactive','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowhidden','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowencode','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowsell','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowsearch','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowmember','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','6','allowreport','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowmessege','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowsort','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','alloworder','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowupload','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowdownload','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allownum','basic','50');
INSERT INTO pw_permission VALUES('0','0','6','edittime','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','postpertime','basic','15');
INSERT INTO pw_permission VALUES('0','0','6','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','6','signnum','basic','100');
INSERT INTO pw_permission VALUES('0','0','6','show','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','viewipfrom','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','imgwidth','basic','');
INSERT INTO pw_permission VALUES('0','0','6','imgheight','basic','');
INSERT INTO pw_permission VALUES('0','0','6','fontsize','basic','');
INSERT INTO pw_permission VALUES('0','0','6','msggroup','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','maxfavor','basic','100');
INSERT INTO pw_permission VALUES('0','0','6','viewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','atccheck','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','markable','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','postlimit','basic','');
INSERT INTO pw_permission VALUES('0','0','6','uploadtype','basic','');
INSERT INTO pw_permission VALUES('0','0','6','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','6','ifmemo','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','atclog','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','6','modifyvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowreward','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowgoods','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','allowdebate','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','anonymous','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','dig','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','leaveword','basic','0');
INSERT INTO pw_permission VALUES('0','0','6','markset','basic','a:5:{s:5:\"money\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','7','maxmsg','basic','10');
INSERT INTO pw_permission VALUES('0','0','7','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','7','allowportait','basic','1');
INSERT INTO pw_permission VALUES('0','0','7','upload','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','allowrp','basic','1');
INSERT INTO pw_permission VALUES('0','0','7','allowhonor','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','allowdelatc','basic','1');
INSERT INTO pw_permission VALUES('0','0','7','allowpost','basic','1');
INSERT INTO pw_permission VALUES('0','0','7','allownewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','7','allowvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','7','allowactive','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','allowhidden','basic','1');
INSERT INTO pw_permission VALUES('0','0','7','allowencode','basic','1');
INSERT INTO pw_permission VALUES('0','0','7','allowsell','basic','1');
INSERT INTO pw_permission VALUES('0','0','7','allowsearch','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','allowmember','basic','1');
INSERT INTO pw_permission VALUES('0','0','7','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','7','allowreport','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','allowmessege','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','allowsort','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','alloworder','basic','1');
INSERT INTO pw_permission VALUES('0','0','7','allowupload','basic','1');
INSERT INTO pw_permission VALUES('0','0','7','allowdownload','basic','1');
INSERT INTO pw_permission VALUES('0','0','7','allownum','basic','50');
INSERT INTO pw_permission VALUES('0','0','7','edittime','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','postpertime','basic','15');
INSERT INTO pw_permission VALUES('0','0','7','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','7','signnum','basic','100');
INSERT INTO pw_permission VALUES('0','0','7','show','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','viewipfrom','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','imgwidth','basic','');
INSERT INTO pw_permission VALUES('0','0','7','imgheight','basic','');
INSERT INTO pw_permission VALUES('0','0','7','fontsize','basic','');
INSERT INTO pw_permission VALUES('0','0','7','msggroup','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','maxfavor','basic','100');
INSERT INTO pw_permission VALUES('0','0','7','viewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','atccheck','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','markable','basic','0');
INSERT INTO pw_permission VALUES('0','0','7','postlimit','basic','');
INSERT INTO pw_permission VALUES('0','0','7','uploadtype','basic','');
INSERT INTO pw_permission VALUES('0','0','7','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','7','ifmemo','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','maxmsg','basic','10');
INSERT INTO pw_permission VALUES('0','0','8','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','allowportait','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','upload','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','allowrp','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','allowhonor','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','allowdelatc','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','allowpost','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','allownewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','allowvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','allowactive','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','allowhidden','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','allowencode','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','allowsell','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','allowsearch','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','allowmember','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','allowreport','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','allowmessege','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','allowsort','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','alloworder','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','allowupload','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','allowdownload','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','allownum','basic','50');
INSERT INTO pw_permission VALUES('0','0','8','edittime','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','postpertime','basic','5');
INSERT INTO pw_permission VALUES('0','0','8','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','8','signnum','basic','30');
INSERT INTO pw_permission VALUES('0','0','8','show','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','viewipfrom','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','imgwidth','basic','');
INSERT INTO pw_permission VALUES('0','0','8','imgheight','basic','');
INSERT INTO pw_permission VALUES('0','0','8','fontsize','basic','3');
INSERT INTO pw_permission VALUES('0','0','8','msggroup','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','maxfavor','basic','50');
INSERT INTO pw_permission VALUES('0','0','8','viewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','atccheck','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','markable','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','postlimit','basic','');
INSERT INTO pw_permission VALUES('0','0','8','uploadtype','basic','');
INSERT INTO pw_permission VALUES('0','0','8','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','8','anonymous','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','leaveword','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','ifmemo','basic','1');
INSERT INTO pw_permission VALUES('0','0','8','atclog','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','8','modifyvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','allowreward','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','allowgoods','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','allowdebate','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','dig','basic','0');
INSERT INTO pw_permission VALUES('0','0','8','pergroup','basic','member');
INSERT INTO pw_permission VALUES('0','0','8','markset','basic','a:5:{s:5:\"money\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','8','maxgraft','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','maxmsg','basic','10');
INSERT INTO pw_permission VALUES('0','0','9','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','9','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowportait','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','upload','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowrp','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowhonor','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowdelatc','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowpost','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allownewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowactive','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','9','allowhidden','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowencode','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowsell','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowsearch','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowmember','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowreport','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowmessege','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowsort','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','alloworder','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowupload','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowdownload','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allownum','basic','50');
INSERT INTO pw_permission VALUES('0','0','9','edittime','basic','0');
INSERT INTO pw_permission VALUES('0','0','9','postpertime','basic','5');
INSERT INTO pw_permission VALUES('0','0','9','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','9','signnum','basic','50');
INSERT INTO pw_permission VALUES('0','0','9','markable','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','maxfavor','basic','100');
INSERT INTO pw_permission VALUES('0','0','9','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','9','atccheck','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','anonymous','basic','0');
INSERT INTO pw_permission VALUES('0','0','9','leaveword','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','ifmemo','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','markset','basic','a:5:{s:5:\"money\";a:4:{s:9:\"markctype\";s:5:\"money\";s:9:\"maxcredit\";s:1:\"5\";s:9:\"marklimit\";a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','9','atclog','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','show','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','viewipfrom','basic','0');
INSERT INTO pw_permission VALUES('0','0','9','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','9','msggroup','basic','0');
INSERT INTO pw_permission VALUES('0','0','9','modifyvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','viewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','9','allowreward','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowgoods','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','allowdebate','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','dig','basic','1');
INSERT INTO pw_permission VALUES('0','0','9','maxgraft','basic','2');
INSERT INTO pw_permission VALUES('0','0','9','pergroup','basic','member');
INSERT INTO pw_permission VALUES('0','0','10','pergroup','basic','member');
INSERT INTO pw_permission VALUES('0','0','11','pergroup','basic','member');
INSERT INTO pw_permission VALUES('0','0','12','pergroup','basic','member');
INSERT INTO pw_permission VALUES('0','0','13','pergroup','basic','member');
INSERT INTO pw_permission VALUES('0','0','14','pergroup','basic','member');
INSERT INTO pw_permission VALUES('0','0','15','pergroup','basic','member');
INSERT INTO pw_permission VALUES('0','0','10','maxmsg','basic','30');
INSERT INTO pw_permission VALUES('0','0','10','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','10','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowportait','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','upload','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowrp','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowhonor','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowdelatc','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowpost','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allownewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowactive','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','10','allowhidden','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowencode','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowsell','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowsearch','basic','2');
INSERT INTO pw_permission VALUES('0','0','10','allowmember','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowreport','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowmessege','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowsort','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','alloworder','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowupload','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowdownload','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allownum','basic','50');
INSERT INTO pw_permission VALUES('0','0','10','edittime','basic','0');
INSERT INTO pw_permission VALUES('0','0','10','postpertime','basic','3');
INSERT INTO pw_permission VALUES('0','0','10','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','10','signnum','basic','100');
INSERT INTO pw_permission VALUES('0','0','10','markable','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','maxfavor','basic','100');
INSERT INTO pw_permission VALUES('0','0','10','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','10','atccheck','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','anonymous','basic','0');
INSERT INTO pw_permission VALUES('0','0','10','leaveword','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','ifmemo','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','markset','basic','a:5:{s:5:\"money\";a:4:{s:9:\"markctype\";s:5:\"money\";s:9:\"maxcredit\";s:1:\"5\";s:9:\"marklimit\";a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','10','atclog','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','show','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','modifyvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowreward','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowgoods','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','allowdebate','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','dig','basic','1');
INSERT INTO pw_permission VALUES('0','0','10','viewipfrom','basic','0');
INSERT INTO pw_permission VALUES('0','0','10','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','10','msggroup','basic','0');
INSERT INTO pw_permission VALUES('0','0','10','viewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','10','maxgraft','basic','5');
INSERT INTO pw_permission VALUES('0','0','11','maxmsg','basic','30');
INSERT INTO pw_permission VALUES('0','0','11','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','11','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowportait','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','upload','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowrp','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowhonor','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowdelatc','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowpost','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allownewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowactive','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','11','allowhidden','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowencode','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowsell','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowsearch','basic','2');
INSERT INTO pw_permission VALUES('0','0','11','allowmember','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowreport','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowmessege','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowsort','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','alloworder','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowupload','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowdownload','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allownum','basic','50');
INSERT INTO pw_permission VALUES('0','0','11','edittime','basic','0');
INSERT INTO pw_permission VALUES('0','0','11','postpertime','basic','3');
INSERT INTO pw_permission VALUES('0','0','11','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','11','signnum','basic','150');
INSERT INTO pw_permission VALUES('0','0','11','markable','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','maxfavor','basic','100');
INSERT INTO pw_permission VALUES('0','0','11','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','11','atccheck','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','anonymous','basic','0');
INSERT INTO pw_permission VALUES('0','0','11','leaveword','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','ifmemo','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','markset','basic','a:5:{s:5:\"money\";a:4:{s:9:\"markctype\";s:5:\"money\";s:9:\"maxcredit\";s:2:\"10\";s:9:\"marklimit\";a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','11','atclog','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','show','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','viewipfrom','basic','0');
INSERT INTO pw_permission VALUES('0','0','11','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','11','msggroup','basic','0');
INSERT INTO pw_permission VALUES('0','0','11','modifyvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','viewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','11','allowreward','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowgoods','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','allowdebate','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','dig','basic','1');
INSERT INTO pw_permission VALUES('0','0','11','maxgraft','basic','5');
INSERT INTO pw_permission VALUES('0','0','12','maxmsg','basic','30');
INSERT INTO pw_permission VALUES('0','0','12','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','12','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowportait','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','upload','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowrp','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowhonor','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowdelatc','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowpost','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allownewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowactive','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','12','allowhidden','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowencode','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowsell','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowsearch','basic','2');
INSERT INTO pw_permission VALUES('0','0','12','allowmember','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowreport','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowmessege','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowsort','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','alloworder','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowupload','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowdownload','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allownum','basic','50');
INSERT INTO pw_permission VALUES('0','0','12','edittime','basic','0');
INSERT INTO pw_permission VALUES('0','0','12','postpertime','basic','3');
INSERT INTO pw_permission VALUES('0','0','12','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','12','signnum','basic','200');
INSERT INTO pw_permission VALUES('0','0','12','markable','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','maxfavor','basic','100');
INSERT INTO pw_permission VALUES('0','0','12','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','12','atccheck','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','anonymous','basic','0');
INSERT INTO pw_permission VALUES('0','0','12','leaveword','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','ifmemo','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','markset','basic','a:5:{s:5:\"money\";a:4:{s:9:\"markctype\";s:5:\"money\";s:9:\"maxcredit\";s:2:\"20\";s:9:\"marklimit\";a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','12','atclog','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','show','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','modifyvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowreward','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowgoods','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','allowdebate','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','dig','basic','1');
INSERT INTO pw_permission VALUES('0','0','12','viewipfrom','basic','0');
INSERT INTO pw_permission VALUES('0','0','12','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','12','msggroup','basic','0');
INSERT INTO pw_permission VALUES('0','0','12','viewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','12','maxgraft','basic','5');
INSERT INTO pw_permission VALUES('0','0','13','maxmsg','basic','50');
INSERT INTO pw_permission VALUES('0','0','13','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','13','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowportait','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','upload','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowrp','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowhonor','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowdelatc','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowpost','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allownewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowactive','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','13','allowhidden','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowencode','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowsell','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowsearch','basic','2');
INSERT INTO pw_permission VALUES('0','0','13','allowmember','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowreport','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowmessege','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowsort','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','alloworder','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowupload','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowdownload','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allownum','basic','50');
INSERT INTO pw_permission VALUES('0','0','13','edittime','basic','0');
INSERT INTO pw_permission VALUES('0','0','13','postpertime','basic','3');
INSERT INTO pw_permission VALUES('0','0','13','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','13','signnum','basic','200');
INSERT INTO pw_permission VALUES('0','0','13','markable','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','maxfavor','basic','100');
INSERT INTO pw_permission VALUES('0','0','13','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','13','atccheck','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','anonymous','basic','0');
INSERT INTO pw_permission VALUES('0','0','13','leaveword','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','ifmemo','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','markset','basic','a:5:{s:5:\"money\";a:4:{s:9:\"markctype\";s:5:\"money\";s:9:\"maxcredit\";s:2:\"50\";s:9:\"marklimit\";a:2:{i:0;s:1:\"0\";i:1;s:1:\"2\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','13','atclog','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','show','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','modifyvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowreward','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowgoods','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','allowdebate','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','dig','basic','1');
INSERT INTO pw_permission VALUES('0','0','13','viewipfrom','basic','0');
INSERT INTO pw_permission VALUES('0','0','13','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','13','msggroup','basic','0');
INSERT INTO pw_permission VALUES('0','0','13','viewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','13','maxgraft','basic','5');
INSERT INTO pw_permission VALUES('0','0','14','maxmsg','basic','50');
INSERT INTO pw_permission VALUES('0','0','14','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','14','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowportait','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','upload','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowrp','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowhonor','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowdelatc','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowpost','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allownewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowactive','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','14','allowhidden','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowencode','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowsell','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowsearch','basic','2');
INSERT INTO pw_permission VALUES('0','0','14','allowmember','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowreport','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowmessege','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowsort','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','alloworder','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowupload','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowdownload','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allownum','basic','80');
INSERT INTO pw_permission VALUES('0','0','14','edittime','basic','0');
INSERT INTO pw_permission VALUES('0','0','14','postpertime','basic','3');
INSERT INTO pw_permission VALUES('0','0','14','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','14','signnum','basic','200');
INSERT INTO pw_permission VALUES('0','0','14','markable','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','maxfavor','basic','100');
INSERT INTO pw_permission VALUES('0','0','14','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','14','atccheck','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','anonymous','basic','0');
INSERT INTO pw_permission VALUES('0','0','14','leaveword','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','ifmemo','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','markset','basic','a:5:{s:5:\"money\";a:4:{s:9:\"markctype\";s:5:\"money\";s:9:\"maxcredit\";s:2:\"80\";s:9:\"marklimit\";a:2:{i:0;s:2:\"-1\";i:1;s:1:\"3\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','14','atclog','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','show','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','modifyvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowreward','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowgoods','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','allowdebate','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','dig','basic','1');
INSERT INTO pw_permission VALUES('0','0','14','viewipfrom','basic','0');
INSERT INTO pw_permission VALUES('0','0','14','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','14','msggroup','basic','0');
INSERT INTO pw_permission VALUES('0','0','14','viewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','14','maxgraft','basic','5');
INSERT INTO pw_permission VALUES('0','0','15','maxmsg','basic','50');
INSERT INTO pw_permission VALUES('0','0','15','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','15','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowportait','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','upload','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowrp','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowhonor','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowdelatc','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowpost','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allownewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowactive','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','15','allowhidden','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowencode','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowsell','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowsearch','basic','2');
INSERT INTO pw_permission VALUES('0','0','15','allowmember','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowreport','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowmessege','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowsort','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','alloworder','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowupload','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowdownload','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allownum','basic','100');
INSERT INTO pw_permission VALUES('0','0','15','edittime','basic','0');
INSERT INTO pw_permission VALUES('0','0','15','postpertime','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','15','signnum','basic','200');
INSERT INTO pw_permission VALUES('0','0','15','markable','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','maxfavor','basic','100');
INSERT INTO pw_permission VALUES('0','0','15','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','15','atccheck','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','anonymous','basic','0');
INSERT INTO pw_permission VALUES('0','0','15','leaveword','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','ifmemo','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','markset','basic','a:5:{s:5:\"money\";a:4:{s:9:\"markctype\";s:5:\"money\";s:9:\"maxcredit\";s:3:\"100\";s:9:\"marklimit\";a:2:{i:0;s:2:\"-2\";i:1;s:1:\"5\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','15','atclog','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','show','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','viewipfrom','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','15','msggroup','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','modifyvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','viewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','15','allowreward','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowgoods','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','allowdebate','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','dig','basic','1');
INSERT INTO pw_permission VALUES('0','0','15','maxgraft','basic','10');
INSERT INTO pw_permission VALUES('0','0','16','maxmsg','basic','30');
INSERT INTO pw_permission VALUES('0','0','16','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','16','allowread','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowportait','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','upload','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowrp','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowhonor','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowdelatc','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowpost','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allownewvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowactive','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','16','allowhidden','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowencode','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowsell','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowsearch','basic','2');
INSERT INTO pw_permission VALUES('0','0','16','allowmember','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowprofile','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowreport','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowmessege','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowsort','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','alloworder','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowupload','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowdownload','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allownum','basic','50');
INSERT INTO pw_permission VALUES('0','0','16','edittime','basic','0');
INSERT INTO pw_permission VALUES('0','0','16','postpertime','basic','3');
INSERT INTO pw_permission VALUES('0','0','16','searchtime','basic','10');
INSERT INTO pw_permission VALUES('0','0','16','signnum','basic','100');
INSERT INTO pw_permission VALUES('0','0','16','show','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','viewipfrom','basic','0');
INSERT INTO pw_permission VALUES('0','0','16','imgwidth','basic','');
INSERT INTO pw_permission VALUES('0','0','16','imgheight','basic','');
INSERT INTO pw_permission VALUES('0','0','16','fontsize','basic','');
INSERT INTO pw_permission VALUES('0','0','16','msggroup','basic','0');
INSERT INTO pw_permission VALUES('0','0','16','maxfavor','basic','100');
INSERT INTO pw_permission VALUES('0','0','16','viewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','16','atccheck','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','markable','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','postlimit','basic','');
INSERT INTO pw_permission VALUES('0','0','16','uploadtype','basic','');
INSERT INTO pw_permission VALUES('0','0','16','markdt','basic','');
INSERT INTO pw_permission VALUES('0','0','16','anonymous','basic','0');
INSERT INTO pw_permission VALUES('0','0','16','leaveword','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowadmincp','system','0');
INSERT INTO pw_permission VALUES('0','0','16','delatc','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','moveatc','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','copyatc','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','digestadmin','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','lockadmin','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','pushadmin','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','coloradmin','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','downadmin','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','viewcheck','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','viewclose','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','delattach','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','viewip','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','banuser','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','bantype','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','banmax','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','posthide','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','sellhide','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','encodehide','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','anonyhide','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','postpers','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','replylock','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','modother','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','deltpcs','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','topped','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','tpctype','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','tpccheck','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','allowtime','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','16','superright','system','1');
INSERT INTO pw_permission VALUES('0','0','16','ifmemo','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','markset','basic','a:5:{s:5:\"money\";a:4:{s:9:\"markctype\";s:5:\"money\";s:9:\"maxcredit\";s:1:\"5\";s:9:\"marklimit\";a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','16','atclog','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','16','maxsendmsg','basic','');
INSERT INTO pw_permission VALUES('0','0','16','pergroup','basic','member,special');
INSERT INTO pw_permission VALUES('0','0','16','maxgraft','basic','2');
INSERT INTO pw_permission VALUES('0','0','16','pwdlimitime','basic','');
INSERT INTO pw_permission VALUES('0','0','16','maxcstyles','basic','');
INSERT INTO pw_permission VALUES('0','0','16','modifyvote','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowreward','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowgoods','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','allowdebate','basic','1');
INSERT INTO pw_permission VALUES('0','0','16','media','basic','');
INSERT INTO pw_permission VALUES('0','0','16','dig','basic','1');
INSERT INTO pw_permission VALUES('0','0','17','allowhide','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowread','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowsearch','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowmember','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowprofile','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','atclog','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','show','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowreport','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','upload','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowportait','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowhonor','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowmessege','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowsort','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','alloworder','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','viewipfrom','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','schtime','basic','7776000');
INSERT INTO pw_permission VALUES('0','0','17','msggroup','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','ifmemo','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowpost','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowrp','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allownewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','modifyvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','viewvote','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowactive','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowreward','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowgoods','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowdebate','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','htmlcode','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowhidden','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowsell','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowencode','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','anonymous','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','dig','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','leaveword','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowdelatc','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','atccheck','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','markable','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','markset','basic','a:5:{s:5:\"money\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:4:\"rvrc\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:6:\"credit\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}s:8:\"currency\";a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}i:1;a:3:{s:9:\"maxcredit\";s:0:\"\";s:9:\"marklimit\";a:2:{i:0;s:0:\"\";i:1;s:0:\"\";}s:6:\"markdt\";s:1:\"0\";}}');
INSERT INTO pw_permission VALUES('0','0','17','allowupload','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowdownload','basic','0');
INSERT INTO pw_permission VALUES('0','0','17','allowadmincp','system','0');
INSERT INTO pw_permission VALUES('0','0','17','superright','system','0');
INSERT INTO pw_permission VALUES('0','0','17','posthide','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','sellhide','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','encodehide','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','anonyhide','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','postpers','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','replylock','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','viewip','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','topped','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','digestadmin','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','lockadmin','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','pushadmin','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','coloradmin','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','downadmin','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','tpctype','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','tpccheck','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','delatc','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','moveatc','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','copyatc','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','modother','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','deltpcs','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','viewcheck','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','viewclose','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','delattach','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','shield','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','unite','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','remind','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','pingcp','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','inspect','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','allowtime','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','banuser','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','bantype','systemforum','0');
INSERT INTO pw_permission VALUES('0','0','17','areapush','systemforum','1');



INSERT INTO pw_plan VALUES('1','定时清理群发消息','*','6','1','*','0','0','1','0','cleardata','');
INSERT INTO pw_plan VALUES('2','自动解除禁言','*','*','20','30','0','0','0','0','freeban','');
INSERT INTO pw_plan VALUES('3','发送生日短消息','*','*','0','*','0','0','1','0','birthday','');
INSERT INTO pw_plan VALUES('4','悬赏帖到期通知','*','1','12','30','0','0','1','0','rewardmsg','');
INSERT INTO pw_plan VALUES('5','管理团队工资发放','15','*','2','*','0','0','0','0','team','a:3:{s:10:\"credittype\";s:6:\"credit\";s:6:\"credit\";a:3:{i:3;s:3:\"100\";i:4;s:2:\"60\";i:5;s:2:\"50\";}s:6:\"groups\";s:5:\"3,4,5\";}');
INSERT INTO pw_plan VALUES('6','勋章自动回收','16','*','18','30','0','0','0','0','medal','');
INSERT INTO pw_plan VALUES('7','限期头衔自动回收','*','*','22','*','0','0','0','0','extragroup','');


INSERT INTO pw_postcate VALUES('1','团购','1','0','','');
INSERT INTO pw_postcate VALUES('2','活动','1','0','','');






INSERT INTO pw_rateconfig VALUES('1','精彩','01.gif','1','1','1','-1','1','1','system','1251030975','admin','1252394328');
INSERT INTO pw_rateconfig VALUES('2','感动','02.gif','1','1','1','-1','1','1','system','1251030975','admin','1252394328');
INSERT INTO pw_rateconfig VALUES('3','搞笑','03.gif','1','1','1','-1','1','1','system','1251030975','admin','1252394328');
INSERT INTO pw_rateconfig VALUES('4','开心','04.gif','1','1','1','-1','1','1','system','1251030975','admin','1252394328');
INSERT INTO pw_rateconfig VALUES('5','愤怒','05.gif','1','1','1','-1','1','1','system','1251030975','admin','1252394328');
INSERT INTO pw_rateconfig VALUES('6','无聊','06.gif','1','1','1','-1','1','0','system','1251030975','admin','1252394328');
INSERT INTO pw_rateconfig VALUES('7','灌水','07.gif','1','1','1','-1','1','-2','system','1251030975','admin','1252394328');
INSERT INTO pw_rateconfig VALUES('8','精彩','01.gif','1','1','2','-1','1','1','system','1251030975','admin','1252394398');
INSERT INTO pw_rateconfig VALUES('9','感动','02.gif','1','1','2','-1','1','1','system','1251030975','admin','1252394398');
INSERT INTO pw_rateconfig VALUES('10','搞笑','03.gif','1','1','2','-1','1','1','system','1251030975','admin','1252394398');
INSERT INTO pw_rateconfig VALUES('11','开心','04.gif','1','1','2','-1','1','1','system','1251030975','admin','1252394398');
INSERT INTO pw_rateconfig VALUES('12','愤怒','05.gif','1','1','2','-1','1','1','system','1251030975','admin','1252394398');
INSERT INTO pw_rateconfig VALUES('13','无聊','06.gif','1','1','2','-1','1','0','system','1251030975','admin','1252394398');
INSERT INTO pw_rateconfig VALUES('14','灌水','07.gif','1','1','2','-1','1','-1','system','1251030975','admin','1252394398');
INSERT INTO pw_rateconfig VALUES('15','精彩','01.gif','1','1','3','-1','1','1','system','1251030975','admin','1252394438');
INSERT INTO pw_rateconfig VALUES('16','唯美','02.gif','1','1','3','-1','1','1','system','1251030975','admin','1252394438');
INSERT INTO pw_rateconfig VALUES('17','有趣','03.gif','1','1','3','-1','1','1','system','1251030975','admin','1252394438');
INSERT INTO pw_rateconfig VALUES('18','震惊','04.gif','1','1','3','-1','1','1','system','1251030975','admin','1252394438');
INSERT INTO pw_rateconfig VALUES('19','原创','05.gif','1','1','3','-1','1','1','system','1251030975','admin','1252394438');
INSERT INTO pw_rateconfig VALUES('20','专业','06.gif','1','1','3','-1','1','1','system','1251030975','admin','1252394438');
INSERT INTO pw_rateconfig VALUES('21','无聊','07.gif','1','1','3','-1','1','0','system','1251030975','admin','1252394438');
INSERT INTO pw_rateconfig VALUES('22','劣质','08.gif','1','1','3','-1','1','-2','system','1251030975','admin','1252394438');






INSERT INTO pw_setform VALUES('1','出租信息','1','<table cellspacing=\"1\" cellpadding=\"1\" align=\"left\" width=\"100%\" style=\"background:#D4EFF7;text-align:left\"><tr><td width=\"30%\" align=\"center\" style=\"background:#fff;height:25px;\"><b>联  系 人:</b></td><td style=\"background:#fff;padding-left:5px\"><p contentEditable=true></p></td></tr><tr><td width=\"30%\" align=\"center\" style=\"background:#fff;height:25px;\"><b>联系方式:</b></td><td style=\"background:#fff;padding-left:5px\"><p contentEditable=true></p></td></tr><tr><td width=\"30%\" align=\"center\" style=\"background:#fff;height:25px;\"><b>房屋类型:</b></td><td style=\"background:#fff;padding-left:5px\"><p contentEditable=true></p></td></tr><tr><td width=\"30%\" align=\"center\" style=\"background:#fff;height:25px;\"><b>房屋位置:</b></td><td style=\"background:#fff;padding-left:5px\"><p contentEditable=true></p></td></tr><tr><td width=\"30%\" align=\"center\" style=\"background:#fff;height:25px;\"><b><font color=\"#ff3300\">出租</font>价格:</b></td><td style=\"background:#fff;padding-left:5px\"><p contentEditable=true></p></td></tr><tr><td width=\"30%\" align=\"center\" style=\"background:#fff;height:25px;\"><b>房屋层次:</b></td><td style=\"background:#fff;padding-left:5px\"><p contentEditable=true></p></td></tr><tr><td width=\"30%\" align=\"center\" style=\"background:#fff;height:25px;\"><b>房屋面积:</b></td><td style=\"background:#fff;padding-left:5px\"><p contentEditable=true></p></td></tr><tr><td width=\"30%\" align=\"center\" style=\"background:#fff;height:25px;\"><b>建造年份:</b></td><td style=\"background:#fff;padding-left:5px\"><p contentEditable=true></p></td></tr><tr><td width=\"30%\" align=\"center\" style=\"background:#fff;height:25px;\"><b>简单情况:</b></td><td style=\"background:#fff;padding-left:5px\"><p contentEditable=true></p></td></tr></table>');


INSERT INTO pw_sharelinks VALUES('1','0','PHPWind Board','http://www.phpwind.net','PHPwind官方论坛','logo.gif','1','');


INSERT INTO pw_smiles VALUES('1','default','默认表情','','1','0');
INSERT INTO pw_smiles VALUES('2','1.gif','','','0','1');
INSERT INTO pw_smiles VALUES('3','2.gif','','','0','1');
INSERT INTO pw_smiles VALUES('4','3.gif','','','0','1');
INSERT INTO pw_smiles VALUES('5','4.gif','','','0','1');
INSERT INTO pw_smiles VALUES('6','5.gif','','','0','1');
INSERT INTO pw_smiles VALUES('7','6.gif','','','0','1');
INSERT INTO pw_smiles VALUES('8','7.gif','','','0','1');
INSERT INTO pw_smiles VALUES('9','8.gif','','','0','1');
INSERT INTO pw_smiles VALUES('10','9.gif','','','0','1');
INSERT INTO pw_smiles VALUES('11','10.gif','','','0','1');
INSERT INTO pw_smiles VALUES('12','11.gif','','','0','1');
INSERT INTO pw_smiles VALUES('13','12.gif','','','0','1');
INSERT INTO pw_smiles VALUES('14','13.gif','','','0','1');
INSERT INTO pw_smiles VALUES('15','14.gif','','','0','1');


INSERT INTO pw_stamp VALUES('1','贴子排行','subject','1','1','1');
INSERT INTO pw_stamp VALUES('2','用户排行','user','6','1','0');
INSERT INTO pw_stamp VALUES('3','版块排行','forum','9','1','0');
INSERT INTO pw_stamp VALUES('4','标签排行','tag','11','1','0');
INSERT INTO pw_stamp VALUES('5','图片','image','13','1','1');
INSERT INTO pw_stamp VALUES('6','活动','active','41','1','1');


INSERT INTO pw_stopicblock VALUES('1','帖子列表','<ul>\r\n<loop>\r\n<li><a href=\"{url}\" target=\"_blank\">{title}</a></li>\r\n</loop>\r\n</ul>','','','','','');
INSERT INTO pw_stopicblock VALUES('2','帖子及摘要','<loop>\r\n<h2><a href=\"{url}\" target=\"_blank\">{title}</a></h2>\r\n<p>{descrip}</p>\r\n</loop>','','','','','');
INSERT INTO pw_stopicblock VALUES('3','图片','<ul class=\"list-img-a\">\r\n<loop>\r\n<li><a href=\"{url}\" target=\"_blank\"><img src=\"{image}\" /></a></li>\r\n</loop>\r\n</ul>','','','','','');
INSERT INTO pw_stopicblock VALUES('4','图片标题','<ul class=\"list-img-a\">\r\n<loop>\r\n<li><a href=\"{url}\" target=\"_blank\"><img src=\"{image}\" /></a><p><a href=\"{url}\" target=\"_blank\">{title}</a></p></li>\r\n</loop>\r\n</ul>','','','','','');
INSERT INTO pw_stopicblock VALUES('5','图文','<table width=\"100%\">\r\n<loop>\r\n<tr>\r\n<th><div><a href=\"{url}\" target=\"_blank\"><img src=\"{image}\" /></a></div></th>\r\n<td><h4><a href=\"{url}\" target=\"_blank\">{title}</a></h4>\r\n<p>{descrip}</p></td>\r\n</tr>\r\n</loop>\r\n</table>','','','','','');
INSERT INTO pw_stopicblock VALUES('6','自定义html','<loop>\r\n{html}\r\n</loop>','','','','','');
INSERT INTO pw_stopicblock VALUES('7','图片播放器','<style type=\"text/css\">\r\n.pwSlide {background:#fff;position:relative;width:100%;height:240px;overflow:hidden;text-align:left;}\r\n.pwSlide a:hover{text-decoration:none;}\r\n.pwSlide .bg {position:absolute;left:0;bottom:0;width:100%;height:40px;background:#333333;filter:alpha(opacity=39);-moz-opacity:0.39;opacity:0.39;}\r\n.pwSlide h4 {position:absolute;left:10px;bottom:15px;_bottom:1px;width:95%;height:20px;line-height:16px;z-index:2;color:#fff;}\r\n.pwSlide ul {margin:0;padding:0;position:absolute;right:5px;bottom:5px;_bottom:2px;z-index:2;}\r\n.pwSlide ul li {list-style:none;float:left;width:18px;height:13px;line-height:15px;text-align:center;margin-left:1px;}\r\n.pwSlide ul li a {display:block;width:18px;height:13px;line-height:13px;font-size:10px;font-family:Tahoma;color:#000;background:#f7f7f7;}\r\n.pwSlide ul li a:hover, .pwSlide ul li a.sel {color:#fff;text-decoration:none;background:#ff6600;color:#fff;}\r\n</style>\r\n<div id=\"pwSlidePlayer\" class=\"pwSlide\">\r\n<loop>\r\n<div class=\"tac\" style=\"display:none;\">\r\n<a href=\"{url}\" target=\"_blank\"><img class=\"pwSlideFilter\" src=\"{image}\" title=\"{title}\" height=\"240\" width=\"100%\" />\r\n<h4 class=\"fn f12 tal\">{title}</h4></a>\r\n</div>\r\n</loop>\r\n<ul id=\"SwitchNav\"></ul>\r\n<div class=\"bg\"></div>\r\n</div>\r\n<script language=\"JavaScript\" src=\"js/picplayer.js\"></script>\r\n<script language=\"JavaScript\">pwSlidePlayer(\"play\",1);</script>','','','','','');

INSERT INTO pw_stopiccategory VALUES('1','房产','1','0','PHPWind','1250759842');
INSERT INTO pw_stopiccategory VALUES('2','汽车','1','0','PHPWind','1250759842');
INSERT INTO pw_stopiccategory VALUES('3','婚庆','1','0','PHPWind','1250759842');
INSERT INTO pw_stopiccategory VALUES('4','母婴','1','0','PHPWind','1250759842');
INSERT INTO pw_stopiccategory VALUES('5','团购','1','0','PHPWind','1250759842');



INSERT INTO pw_styles VALUES('1','0','wind','<font color=#3366cc>■wind</font>','0','0','1','wind','wind','0','#fcfcf3','#333333','#9fb7e7','#d5e6ed','98%','98%','#e8f5fb','#abc8ea','#3366cc','#3366cc','#ffffff','#c5d8e8','#888888','#ffffff','#f3f9fb','');
INSERT INTO pw_styles VALUES('2','0','wind_green','<font color=green>■green</font>','0','0','1','wind_green','wind','0','#eff5e8','#333333','#b8db7e','#ebfad3','960px','960px','#e8f5fb','#b8db7e','#659b05','#659b05','#ffffff','#ebfad3','#888888','#ffffff','#f4ffe8','');
INSERT INTO pw_styles VALUES('3','0','wind_orange','<font color=orange>■orange</font>','0','0','1','wind_orange','wind','0','#f8fcf3','#333333','#f6cb84','#ffe6bc','960px','960px','#e8f5fb','#f6cb85','#e67b1b','#e67b1b','#ffffff','#ffe6bc','#888888','#ffffff','#fef8eb','');
INSERT INTO pw_styles VALUES('4','0','wind_purple','<font color=purple>■purple</font>','0','0','1','wind_purple','wind','0','#f7f2ff','#333333','#d9c0fc','#f3eafe','960px','960px','#ede3fb','#d9c0fc','#a04fec','#a04fec','#ffffff','#f3eafe','#888888','#ffffff','#fbf8ff','');
INSERT INTO pw_styles VALUES('5','0','wind_red','<font color=red>■red</font>','0','0','1','wind_red','wind','0','#FBF6EB','#333333','#f4c6ca','#ffe6e8','960px','960px','#e8f5fb','#f4c6ca','#db3228','#d75353','#ffffff','#ffe4e6','#888888','#ffffff','#fdf8f8','');






INSERT INTO pw_tools VALUES('1','威望工具','reputation','可将自已负威望清零','1','1.gif','1','100','money','10.00','2','100','a:1:{s:6:\"credit\";a:6:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;}}');
INSERT INTO pw_tools VALUES('2','清零卡','credit','可将自已所有负分清零,包括金钱,威望,贡献值,积分。','2','2.gif','1','100','money','10.00','2','100','a:1:{s:6:\"credit\";a:6:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;}}');
INSERT INTO pw_tools VALUES('3','醒目卡','colortitle','可以将自己的帖子标题加亮显示','3','3.gif','1','200','money','20.00','1','100','a:1:{s:6:\"credit\";a:6:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;}}');
INSERT INTO pw_tools VALUES('4','置顶I','top','可将自己发表的帖子在版块中置顶，置顶时间为6小时。','4','4.gif','1','200','money','20.00','1','100','a:1:{s:6:\"credit\";a:6:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;}}');
INSERT INTO pw_tools VALUES('5','置顶II','top2','可将自己发表的帖子在分类中置顶，置顶时间为6小时。','5','5.gif','1','500','money','50.00','1','100','a:1:{s:6:\"credit\";a:6:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;}}');
INSERT INTO pw_tools VALUES('6','置顶III','top3','可将自己发表的帖子在整个论坛中置顶，置顶时间为6小时。','6','6.gif','1','1000','money','100.00','1','100','a:1:{s:6:\"credit\";a:6:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;}}');
INSERT INTO pw_tools VALUES('7','提前帖子','upread','可以把自己发表的帖子提前到帖子所在版块的第一页','7','7.gif','1','100','money','10.00','1','100','a:1:{s:6:\"credit\";a:6:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;}}');
INSERT INTO pw_tools VALUES('8','改名卡','changename','可更改自已在论坛的用户名','8','8.gif','1','1000','money','100.00','2','100','a:1:{s:6:\"credit\";a:6:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;}}');
INSERT INTO pw_tools VALUES('9','精华I','digest','可以将自己的帖子加为精华I','9','9.gif','0','100','currency','0.00','1','100','a:1:{s:6:\"credit\";a:7:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;i:2;i:0;}}');
INSERT INTO pw_tools VALUES('10','精华II','digest2','可以将自己的帖子加为精华II','10','10.gif','0','200','currency','0.00','1','100','a:1:{s:6:\"credit\";a:7:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;i:2;i:0;}}');
INSERT INTO pw_tools VALUES('11','锁定帖子','lock','可以将自己发表的帖子锁定，不让其他会员回复此帖。','11','11.gif','0','100','currency','0.00','1','100','a:1:{s:6:\"credit\";a:7:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;i:2;i:0;}}');
INSERT INTO pw_tools VALUES('12','解除锁定','unlock','可以解除自己被帖子锁定，让其他会员可以回复此帖。','12','12.gif','0','100','currency','0.00','1','100','a:1:{s:6:\"credit\";a:7:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;i:2;i:0;}}');
INSERT INTO pw_tools VALUES('13','鲜花','flower','可以给帖子增加推荐数','13','13.gif','1','10','money','1.00','1','1000','a:1:{s:6:\"credit\";a:6:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;}}');
INSERT INTO pw_tools VALUES('14','鸡蛋','egg','可以给帖子减少推荐数','14','14.gif','1','10','money','1.00','1','1000','a:1:{s:6:\"credit\";a:6:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;}}');
INSERT INTO pw_tools VALUES('15','运气卡','luck','使用后随机加减交易币(-100,100)。','15','','0','10','currency','0.00','2','100','a:2:{s:4:\"luck\";a:3:{s:6:\"range1\";s:4:\"-100\";s:6:\"range2\";s:3:\"100\";s:8:\"lucktype\";s:8:\"currency\";}s:6:\"credit\";a:7:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;i:1;i:0;}}');
INSERT INTO pw_tools VALUES('16','生日卡','birth','以短消息方式发送给好友，祝好友生日快乐！','16','','1','50','money','5.00','2','100','a:1:{s:6:\"credit\";a:6:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;}}');
INSERT INTO pw_tools VALUES('17','沉淀卡','backdown','帖子中使用，每用一次让帖子丢到12小时前．','17','','0','10','currency','0.00','1','100','a:1:{s:6:\"credit\";a:7:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;i:2;i:0;}}');
INSERT INTO pw_tools VALUES('18','猪头术','pig','使用后让对方头像变为猪头，此效果持续24小时或到对方使用清洗卡为止','18','','1','200','money','20.00','2','100','a:1:{s:6:\"credit\";a:6:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;}}');
INSERT INTO pw_tools VALUES('19','还原卡','clear','清除猪头卡的效果','19','','1','200','money','20.00','2','100','a:1:{s:6:\"credit\";a:6:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;}}');
INSERT INTO pw_tools VALUES('20','透视镜','mirror','对用户使用 查看用户IP','20','','0','10','currency','0.00','2','100','a:1:{s:6:\"credit\";a:7:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;i:2;i:0;}}');
INSERT INTO pw_tools VALUES('21','护身符','defend','使用后，不能对该用户实现猪头术效果，48小时内有效。','21','','1','100','money','10.00','2','100','a:1:{s:6:\"credit\";a:6:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;}}');
INSERT INTO pw_tools VALUES('22','时空卡','backup','帖子中使用，让帖子发布到12小时后。','22','','0','10','currency','0.00','1','100','a:1:{s:6:\"credit\";a:7:{s:7:\"postnum\";i:0;s:7:\"digests\";i:0;s:4:\"rvrc\";i:0;s:5:\"money\";i:0;s:6:\"credit\";i:0;i:1;i:0;i:2;i:0;}}');

INSERT INTO pw_topiccate VALUES('1','房屋交易','1','4','1');
INSERT INTO pw_topiccate VALUES('2','美食分类','1','2','1');
INSERT INTO pw_topiccate VALUES('3','婚庆婚介','1','3','1');
INSERT INTO pw_topiccate VALUES('4','母婴分类','1','1','1');
INSERT INTO pw_topiccate VALUES('5','汽车交易','1','5','1');

INSERT INTO pw_topicfield VALUES('1','楼盘名称','field1','1','1','text','b:0;','1','1','1','1','1','50','');
INSERT INTO pw_topicfield VALUES('2','区域','field2','1','4','select','a:7:{i:0;s:8:\"1=杭州\";i:1;s:11:\"2=西湖区\";i:2;s:11:\"3=拱墅区\";i:3;s:11:\"4=下城区\";i:4;s:11:\"5=上城区\";i:5;s:11:\"6=下沙区\";i:6;s:11:\"7=滨江区\";}','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('3','价格','field3','1','3','text','a:2:{s:6:\"minnum\";s:1:\"1\";s:6:\"maxnum\";s:9:\"100000000\";}','1','0','0','1','1','10','元（人民币）');
INSERT INTO pw_topicfield VALUES('4','房屋类型','field4','1','2','radio','a:5:{i:0;s:8:\"1=住宅\";i:1;s:8:\"2=民房\";i:2;s:8:\"3=别墅\";i:3;s:8:\"4=商铺\";i:4;s:17:\"5=经济适用房\";}','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('5','租赁类型','field5','1','5','select','a:4:{i:0;s:8:\"1=全部\";i:1;s:8:\"2=整租\";i:2;s:8:\"3=合租\";i:3;s:8:\"4=短租\";}','1','0','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('6','来源','field6','1','6','radio','a:2:{i:0;s:8:\"1=个人\";i:1;s:8:\"2=中介\";}','1','0','1','0','1','0','');
INSERT INTO pw_topicfield VALUES('7','楼层','field7','1','7','number','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('8','/','field8','1','7','number','b:0;','1','0','0','0','0','0','例如：2/6，表示第2层，总共6层。');
INSERT INTO pw_topicfield VALUES('9','建筑面积','field9','1','8','number','a:2:{s:6:\"minnum\";s:1:\"1\";s:6:\"maxnum\";s:5:\"10000\";}','1','0','0','0','0','0','平方米');
INSERT INTO pw_topicfield VALUES('10','建筑年代','field10','1','9','select','a:19:{i:0;s:6:\"1=1991\";i:1;s:6:\"2=1992\";i:2;s:6:\"3=1993\";i:3;s:6:\"4=1994\";i:4;s:6:\"5=1995\";i:5;s:6:\"6=1996\";i:6;s:6:\"7=1997\";i:7;s:6:\"8=1998\";i:8;s:6:\"9=1999\";i:9;s:7:\"10=2000\";i:10;s:7:\"11=2001\";i:11;s:7:\"12=2002\";i:12;s:7:\"13=2003\";i:13;s:7:\"14=2004\";i:14;s:7:\"15=2005\";i:15;s:7:\"16=2006\";i:16;s:7:\"17=2007\";i:17;s:7:\"18=2008\";i:18;s:7:\"19=2009\";}','1','0','1','0','0','0','年');
INSERT INTO pw_topicfield VALUES('11','特色房屋','field11','1','11','radio','a:8:{i:0;s:11:\"1=地铁房\";i:1;s:11:\"2=学区房\";i:2;s:8:\"3=婚房\";i:3;s:11:\"4=海景房\";i:4;s:11:\"5=湖景房\";i:5;s:11:\"6=江景房\";i:6;s:11:\"7=赡老房\";i:7;s:8:\"8=其他\";}','1','0','1','0','0','0','');
INSERT INTO pw_topicfield VALUES('12','装修情况','field12','1','12','radio','a:5:{i:0;s:8:\"1=全部\";i:1;s:8:\"2=毛胚\";i:2;s:8:\"3=简装\";i:3;s:8:\"4=中装\";i:4;s:8:\"5=精装\";}','1','1','1','0','0','0','');
INSERT INTO pw_topicfield VALUES('13','电话','field13','1','14','text','b:0;','1','0','0','0','0','10','');
INSERT INTO pw_topicfield VALUES('14','-','field14','1','14','text','b:0;','1','0','0','0','0','20','例如：0571-12345678');
INSERT INTO pw_topicfield VALUES('15','手机','field15','1','15','text','b:0;','1','0','0','0','0','0','例如：13812345678');
INSERT INTO pw_topicfield VALUES('16','地址','field16','1','16','text','b:0;','1','0','0','0','0','50','');
INSERT INTO pw_topicfield VALUES('17','有效期','field17','1','17','select','a:7:{i:0;s:11:\"1=一星期\";i:1;s:11:\"2=半个月\";i:2;s:11:\"3=一个月\";i:3;s:11:\"4=三个月\";i:4;s:8:\"5=半年\";i:5;s:8:\"6=一年\";i:6;s:8:\"7=长期\";}','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('18','房屋图片','field18','1','18','upload','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('19','最短租期','field19','1','10','select','a:5:{i:0;s:8:\"1=一月\";i:1;s:8:\"2=二月\";i:2;s:8:\"3=三月\";i:3;s:8:\"4=半年\";i:4;s:8:\"5=一年\";}','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('20','户型{#}室','field20','1','13','select','a:7:{i:0;s:3:\"1=0\";i:1;s:3:\"2=1\";i:2;s:3:\"3=2\";i:3;s:3:\"4=3\";i:4;s:3:\"5=4\";i:5;s:3:\"6=5\";i:6;s:3:\"7=6\";}','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('21','{#}厅','field21','1','13','select','a:7:{i:0;s:3:\"1=0\";i:1;s:3:\"2=1\";i:2;s:3:\"3=2\";i:3;s:3:\"4=3\";i:4;s:3:\"5=4\";i:5;s:3:\"6=5\";i:6;s:3:\"7=6\";}','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('22','{#}卫','field22','1','13','select','a:7:{i:0;s:3:\"1=0\";i:1;s:3:\"2=1\";i:2;s:3:\"3=2\";i:3;s:3:\"4=3\";i:4;s:3:\"5=4\";i:5;s:3:\"6=5\";i:6;s:3:\"7=6\";}','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('23','{#}阳台','field23','1','13','select','a:7:{i:0;s:3:\"1=0\";i:1;s:3:\"2=1\";i:2;s:3:\"3=2\";i:3;s:3:\"4=3\";i:4;s:3:\"5=4\";i:5;s:3:\"6=5\";i:6;s:3:\"7=6\";}','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('24','区域','field24','2','2','select','a:7:{i:0;s:8:\"1=杭州\";i:1;s:11:\"2=西湖区\";i:2;s:11:\"3=拱墅区\";i:3;s:11:\"4=下城区\";i:4;s:11:\"5=上城区\";i:5;s:11:\"6=下沙区\";i:6;s:11:\"7=滨江区\";}','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('25','楼盘名称','field25','2','1','text','b:0;','1','0','1','1','1','50','');
INSERT INTO pw_topicfield VALUES('26','价格','field26','2','3','text','a:2:{s:6:\"minnum\";s:1:\"1\";s:6:\"maxnum\";s:9:\"100000000\";}','1','0','0','1','1','0','元（人民币）');
INSERT INTO pw_topicfield VALUES('27','房屋类型','field27','2','4','radio','a:5:{i:0;s:8:\"1=住宅\";i:1;s:8:\"2=民房\";i:2;s:8:\"3=别墅\";i:3;s:8:\"4=商铺\";i:4;s:17:\"5=经济适用房\";}','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('28','来源','field28','2','6','radio','a:2:{i:0;s:8:\"1=个人\";i:1;s:8:\"2=中介\";}','1','0','1','0','1','0','');
INSERT INTO pw_topicfield VALUES('29','楼层','field29','2','7','number','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('30','/','field30','2','7','number','b:0;','1','0','0','0','0','0','例如：2/6，表示第2层，总共6层。');
INSERT INTO pw_topicfield VALUES('31','房屋状态','field31','2','5','select','a:3:{i:0;s:8:\"1=现房\";i:1;s:8:\"2=期房\";i:2;s:8:\"3=尾房\";}','1','1','1','0','0','0','');
INSERT INTO pw_topicfield VALUES('32','建筑面积','field32','2','8','number','a:2:{s:6:\"minnum\";s:1:\"1\";s:6:\"maxnum\";s:5:\"10000\";}','1','0','0','0','1','0','平方米');
INSERT INTO pw_topicfield VALUES('33','建筑年代','field33','2','9','select','a:19:{i:0;s:6:\"1=1991\";i:1;s:6:\"2=1992\";i:2;s:6:\"3=1993\";i:3;s:6:\"4=1994\";i:4;s:6:\"5=1995\";i:5;s:6:\"6=1996\";i:6;s:6:\"7=1997\";i:7;s:6:\"8=1998\";i:8;s:6:\"9=1999\";i:9;s:7:\"10=2000\";i:10;s:7:\"11=2001\";i:11;s:7:\"12=2002\";i:12;s:7:\"13=2003\";i:13;s:7:\"14=2004\";i:14;s:7:\"15=2005\";i:15;s:7:\"16=2006\";i:16;s:7:\"17=2007\";i:17;s:7:\"18=2008\";i:18;s:7:\"19=2009\";}','1','0','0','0','0','0','年');
INSERT INTO pw_topicfield VALUES('34','特色房屋','field34','2','10','radio','a:8:{i:0;s:11:\"1=地铁房\";i:1;s:11:\"2=学区房\";i:2;s:8:\"3=婚房\";i:3;s:11:\"4=海景房\";i:4;s:11:\"5=湖景房\";i:5;s:11:\"6=江景房\";i:6;s:11:\"7=赡老房\";i:7;s:8:\"8=其他\";}','1','0','1','0','0','0','');
INSERT INTO pw_topicfield VALUES('35','装修情况','field35','2','11','radio','a:5:{i:0;s:8:\"1=全部\";i:1;s:8:\"2=毛胚\";i:2;s:8:\"3=简装\";i:3;s:8:\"4=中装\";i:4;s:8:\"5=精装\";}','1','1','1','0','0','0','');
INSERT INTO pw_topicfield VALUES('36','电话','field36','2','13','number','b:0;','1','0','0','0','0','10','');
INSERT INTO pw_topicfield VALUES('37','-','field37','2','13','number','b:0;','1','0','0','0','0','20','例如：0571-12345678');
INSERT INTO pw_topicfield VALUES('38','手机','field38','2','14','text','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('39','地址','field39','2','15','text','b:0;','1','0','0','0','0','50','');
INSERT INTO pw_topicfield VALUES('40','有效期','field40','2','16','select','a:7:{i:0;s:11:\"1=一星期\";i:1;s:11:\"2=半个月\";i:2;s:11:\"3=一个月\";i:3;s:11:\"4=三个月\";i:4;s:8:\"5=半年\";i:5;s:8:\"6=一年\";i:6;s:8:\"7=长期\";}','1','0','1','0','0','0','');
INSERT INTO pw_topicfield VALUES('41','房屋图片','field41','2','17','upload','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('42','户型{#}室','field42','2','12','select','a:7:{i:0;s:3:\"1=0\";i:1;s:3:\"2=1\";i:2;s:3:\"3=2\";i:3;s:3:\"4=3\";i:4;s:3:\"5=4\";i:5;s:3:\"6=5\";i:6;s:3:\"7=6\";}','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('43','{#}厅','field43','2','12','select','a:7:{i:0;s:3:\"1=0\";i:1;s:3:\"2=1\";i:2;s:3:\"3=2\";i:3;s:3:\"4=3\";i:4;s:3:\"5=4\";i:5;s:3:\"6=5\";i:6;s:3:\"7=6\";}','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('44','{#}卫','field44','2','12','select','a:7:{i:0;s:3:\"1=0\";i:1;s:3:\"2=1\";i:2;s:3:\"3=2\";i:3;s:3:\"4=3\";i:4;s:3:\"5=4\";i:5;s:3:\"6=5\";i:6;s:3:\"7=6\";}','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('45','{#}阳台','field45','2','12','select','a:7:{i:0;s:3:\"1=0\";i:1;s:3:\"2=1\";i:2;s:3:\"3=2\";i:3;s:3:\"4=3\";i:4;s:3:\"5=4\";i:5;s:3:\"6=5\";i:6;s:3:\"7=6\";}','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('46','区域','field46','3','2','select','a:7:{i:0;s:8:\"1=杭州\";i:1;s:11:\"2=西湖区\";i:2;s:11:\"3=拱墅区\";i:3;s:11:\"4=下城区\";i:4;s:11:\"5=上城区\";i:5;s:11:\"6=下沙区\";i:6;s:11:\"7=滨江区\";}','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('47','楼盘名称','field47','3','1','text','b:0;','1','1','1','1','1','50','');
INSERT INTO pw_topicfield VALUES('48','价格','field48','3','3','text','a:2:{s:6:\"minnum\";s:1:\"1\";s:6:\"maxnum\";s:9:\"100000000\";}','1','0','0','1','1','0','元（人民币）');
INSERT INTO pw_topicfield VALUES('49','房屋类型','field49','3','4','radio','a:5:{i:0;s:8:\"1=住宅\";i:1;s:8:\"2=民房\";i:2;s:8:\"3=别墅\";i:3;s:8:\"4=商铺\";i:4;s:17:\"5=经济适用房\";}','1','1','1','0','1','0','');
INSERT INTO pw_topicfield VALUES('50','来源','field50','3','6','radio','a:2:{i:0;s:8:\"1=个人\";i:1;s:8:\"2=中介\";}','1','0','1','0','0','0','');
INSERT INTO pw_topicfield VALUES('51','楼层','field51','3','7','number','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('52','/','field52','3','7','number','b:0;','1','0','0','0','0','0','例如：2/6，表示第2层，总共6层。');
INSERT INTO pw_topicfield VALUES('53','房屋状态','field53','3','5','select','a:3:{i:0;s:8:\"1=现房\";i:1;s:8:\"2=期房\";i:2;s:8:\"3=尾房\";}','1','1','1','0','0','0','');
INSERT INTO pw_topicfield VALUES('54','建筑面积','field54','3','8','number','a:2:{s:6:\"minnum\";s:1:\"1\";s:6:\"maxnum\";s:5:\"10000\";}','1','0','0','1','1','0','平方米');
INSERT INTO pw_topicfield VALUES('55','建筑年代','field55','3','9','select','a:19:{i:0;s:6:\"1=1991\";i:1;s:6:\"2=1992\";i:2;s:6:\"3=1993\";i:3;s:6:\"4=1994\";i:4;s:6:\"5=1995\";i:5;s:6:\"6=1996\";i:6;s:6:\"7=1997\";i:7;s:6:\"8=1998\";i:8;s:6:\"9=1999\";i:9;s:7:\"10=2000\";i:10;s:7:\"11=2001\";i:11;s:7:\"12=2002\";i:12;s:7:\"13=2003\";i:13;s:7:\"14=2004\";i:14;s:7:\"15=2005\";i:15;s:7:\"16=2006\";i:16;s:7:\"17=2007\";i:17;s:7:\"18=2008\";i:18;s:7:\"19=2009\";}','1','0','1','0','0','0','年');
INSERT INTO pw_topicfield VALUES('56','特色房屋','field56','3','10','radio','a:8:{i:0;s:11:\"1=地铁房\";i:1;s:11:\"2=学区房\";i:2;s:8:\"3=婚房\";i:3;s:11:\"4=海景房\";i:4;s:11:\"5=湖景房\";i:5;s:11:\"6=江景房\";i:6;s:11:\"7=赡老房\";i:7;s:8:\"8=其他\";}','1','0','1','0','0','0','');
INSERT INTO pw_topicfield VALUES('57','装修情况','field57','3','11','radio','a:5:{i:0;s:8:\"1=全部\";i:1;s:8:\"2=毛胚\";i:2;s:8:\"3=简装\";i:3;s:8:\"4=中装\";i:4;s:8:\"5=精装\";}','1','0','1','0','0','0','');
INSERT INTO pw_topicfield VALUES('58','户型{#}室','field58','3','12','select','a:7:{i:0;s:3:\"1=0\";i:1;s:3:\"2=1\";i:2;s:3:\"3=2\";i:3;s:3:\"4=3\";i:4;s:3:\"5=4\";i:5;s:3:\"6=5\";i:6;s:3:\"7=6\";}','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('59','{#}厅','field59','3','12','select','a:7:{i:0;s:3:\"1=0\";i:1;s:3:\"2=1\";i:2;s:3:\"3=2\";i:3;s:3:\"4=3\";i:4;s:3:\"5=4\";i:5;s:3:\"6=5\";i:6;s:3:\"7=6\";}','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('60','{#}卫','field60','3','12','select','a:7:{i:0;s:3:\"1=0\";i:1;s:3:\"2=1\";i:2;s:3:\"3=2\";i:3;s:3:\"4=3\";i:4;s:3:\"5=4\";i:5;s:3:\"6=5\";i:6;s:3:\"7=6\";}','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('61','{#}阳台','field61','3','12','select','a:7:{i:0;s:3:\"1=0\";i:1;s:3:\"2=1\";i:2;s:3:\"3=2\";i:3;s:3:\"4=3\";i:4;s:3:\"5=4\";i:5;s:3:\"6=5\";i:6;s:3:\"7=6\";}','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('62','电话','field62','3','13','number','b:0;','1','0','0','0','0','10','');
INSERT INTO pw_topicfield VALUES('63','-','field63','3','13','number','b:0;','1','0','0','0','0','20','例如：0571-12345678');
INSERT INTO pw_topicfield VALUES('64','手机','field64','3','14','text','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('65','地址','field65','3','15','text','b:0;','1','0','0','0','0','50','');
INSERT INTO pw_topicfield VALUES('66','有效期','field66','3','16','select','a:7:{i:0;s:11:\"1=一星期\";i:1;s:11:\"2=半个月\";i:2;s:11:\"3=一个月\";i:3;s:11:\"4=三个月\";i:4;s:8:\"5=半年\";i:5;s:8:\"6=一年\";i:6;s:8:\"7=长期\";}','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('67','房屋图片','field67','3','17','upload','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('68','店名','field68','4','1','text','b:0;','1','1','1','1','1','50','');
INSERT INTO pw_topicfield VALUES('69','经营性质','field69','4','2','radio','a:5:{i:0;s:9:\"1=中餐o\";i:1;s:9:\"2=西餐o\";i:2;s:9:\"3=快餐o\";i:3;s:9:\"4=小吃o\";i:4;s:9:\"5=其它o\";}','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('70','美食分类','field70','4','3','radio','a:16:{i:0;s:12:\"1=江浙菜o\";i:1;s:9:\"2=川菜o\";i:2;s:9:\"3=湘菜o\";i:3;s:9:\"4=粤菜o\";i:4;s:12:\"5=东北菜o\";i:5;s:12:\"6=日韩菜o\";i:6;s:12:\"7=特色菜o\";i:7;s:9:\"8=西餐o\";i:8;s:9:\"9=快餐o\";i:9;s:10:\"10=海鲜o\";i:10;s:10:\"11=烧烤o\";i:11;s:10:\"12=火锅o\";i:12;s:10:\"13=清真o\";i:13;s:10:\"14=小吃o\";i:14;s:16:\"15=蛋糕面包o\";i:15;s:16:\"16=甜点饮料o\";}','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('71','区域','field71','4','4','select','a:7:{i:0;s:8:\"1=杭州\";i:1;s:11:\"2=西湖区\";i:2;s:11:\"3=拱墅区\";i:3;s:11:\"4=下城区\";i:4;s:11:\"5=上城区\";i:5;s:11:\"6=下沙区\";i:6;s:11:\"7=滨江区\";}','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('72','电话','field72','4','5','text','b:0;','1','0','0','0','0','10','');
INSERT INTO pw_topicfield VALUES('73','-','field73','4','5','text','b:0;','1','0','0','0','0','20','例如：0571-12345678');
INSERT INTO pw_topicfield VALUES('74','地址','field74','4','7','text','b:0;','1','0','1','0','0','50','');
INSERT INTO pw_topicfield VALUES('75','公交','field75','4','8','text','b:0;','1','0','0','0','0','50','');
INSERT INTO pw_topicfield VALUES('76','车位','field76','4','9','text','b:0;','1','0','0','0','0','50','');
INSERT INTO pw_topicfield VALUES('77','营业时间','field77','4','10','text','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('78','-','field78','4','10','text','b:0;','1','0','0','0','0','0','例如：上午9点-晚上10点');
INSERT INTO pw_topicfield VALUES('79','营业状态','field79','4','12','radio','a:2:{i:0;s:11:\"1=营业中\";i:1;s:11:\"2=已歇业\";}','1','0','1','0','1','0','');
INSERT INTO pw_topicfield VALUES('80','图片上传','field80','4','13','upload','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('81','店名','field81','5','1','text','b:0;','1','1','1','1','1','50','');
INSERT INTO pw_topicfield VALUES('82','经营性质','field82','5','2','radio','a:2:{i:0;s:14:\"1=婚介交友\";i:1;s:14:\"2=婚庆服务\";}','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('83','区域','field83','5','3','select','a:7:{i:0;s:8:\"1=杭州\";i:1;s:11:\"2=西湖区\";i:2;s:11:\"3=拱墅区\";i:3;s:11:\"4=下城区\";i:4;s:11:\"5=上城区\";i:5;s:11:\"6=下沙区\";i:6;s:11:\"7=滨江区\";}','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('84','电话','field84','5','4','text','b:0;','1','0','0','0','0','10','');
INSERT INTO pw_topicfield VALUES('85','-','field85','5','4','text','b:0;','1','0','0','0','0','20','例如，0571-12345678');
INSERT INTO pw_topicfield VALUES('86','地址','field86','5','6','text','b:0;','1','0','1','0','0','50','');
INSERT INTO pw_topicfield VALUES('87','公交','field87','5','7','text','b:0;','1','0','0','0','0','50','');
INSERT INTO pw_topicfield VALUES('88','车位','field88','5','8','text','b:0;','1','0','0','0','0','50','');
INSERT INTO pw_topicfield VALUES('89','营业时间','field89','5','9','text','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('90','-','field90','5','9','text','b:0;','1','0','0','0','0','0','例如：上午9点-晚上10点');
INSERT INTO pw_topicfield VALUES('91','营业状态','field91','5','11','radio','a:2:{i:0;s:11:\"1=营业中\";i:1;s:11:\"2=已歇业\";}','1','0','1','0','0','0','');
INSERT INTO pw_topicfield VALUES('92','图片上传','field92','5','12','upload','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('93','店名','field93','6','1','text','b:0;','1','1','1','1','1','50','');
INSERT INTO pw_topicfield VALUES('94','经营性质','field94','6','2','radio','a:7:{i:0;s:14:\"1=母婴产品\";i:1;s:14:\"2=儿童服装\";i:2;s:14:\"3=美容美体\";i:3;s:14:\"4=早教机构\";i:4;s:14:\"5=出行游乐\";i:5;s:14:\"6=婴儿摄影\";i:6;s:14:\"7=家政月嫂\";}','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('95','区域','field95','6','3','select','a:7:{i:0;s:8:\"1=杭州\";i:1;s:11:\"2=西湖区\";i:2;s:11:\"3=拱墅区\";i:3;s:11:\"4=下城区\";i:4;s:11:\"5=上城区\";i:5;s:11:\"6=下沙区\";i:6;s:11:\"7=滨江区\";}','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('96','电话','field96','6','4','text','b:0;','1','0','0','0','0','10','');
INSERT INTO pw_topicfield VALUES('97','-','field97','6','4','text','b:0;','1','0','0','0','0','20','例如，0571-12345678');
INSERT INTO pw_topicfield VALUES('98','地址','field98','6','6','text','b:0;','1','0','1','0','0','50','');
INSERT INTO pw_topicfield VALUES('99','公交','field99','6','7','text','b:0;','1','0','0','0','0','50','');
INSERT INTO pw_topicfield VALUES('100','车位','field100','6','8','text','b:0;','1','0','0','0','0','50','');
INSERT INTO pw_topicfield VALUES('101','营业时间','field101','6','9','text','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('102','-','field102','6','9','text','b:0;','1','0','0','0','0','0','例如：上午9点-晚上10点');
INSERT INTO pw_topicfield VALUES('103','营业状态','field103','6','11','radio','a:2:{i:0;s:11:\"1=营业中\";i:1;s:11:\"2=已歇业\";}','1','0','1','0','0','0','');
INSERT INTO pw_topicfield VALUES('104','图片上传','field104','6','12','upload','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('105','卖家身份','field105','7','1','radio','a:2:{i:0;s:8:\"1=个人\";i:1;s:14:\"2=出租公司\";}','1','1','1','0','1','0','');
INSERT INTO pw_topicfield VALUES('106','车辆类型','field106','7','2','checkbox','a:15:{i:0;s:11:\"1=微型车\";i:1;s:14:\"2=小型轿车\";i:2;s:17:\"3=紧凑型轿车\";i:3;s:14:\"4=中型轿车\";i:4;s:17:\"5=豪华型轿车\";i:5;s:11:\"6=面包车\";i:6;s:11:\"7=越野车\";i:7;s:8:\"8=跑车\";i:8;s:9:\"9=SUV/SRV\";i:9;s:6:\"10=MPV\";i:10;s:16:\"11=客车/中巴\";i:11;s:16:\"12=货车/皮卡\";i:12;s:15:\"13=厢式货车\";i:13;s:15:\"14=工程车辆\";i:14;s:9:\"15=其他\";}','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('107','车辆型号','field107','7','3','text','b:0;','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('108','新旧程度','field108','7','4','select','a:7:{i:0;s:8:\"1=全新\";i:1;s:6:\"2=9成\";i:2;s:6:\"3=8成\";i:3;s:6:\"4=7成\";i:4;s:6:\"5=6成\";i:5;s:6:\"6=5成\";i:6;s:12:\"7=5成以下\";}','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('109','预售价位','field109','7','5','number','a:2:{s:6:\"minnum\";s:1:\"1\";s:6:\"maxnum\";s:8:\"10000000\";}','1','0','0','0','1','0','元');
INSERT INTO pw_topicfield VALUES('110','电话','field110','7','6','text','b:0;','1','0','0','0','0','10','');
INSERT INTO pw_topicfield VALUES('111','-','field111','7','6','text','b:0;','1','0','0','0','0','20','例如：0571-12345678');
INSERT INTO pw_topicfield VALUES('112','手机','field112','7','7','text','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('113','地址','field113','7','8','text','b:0;','1','0','0','0','0','50','');
INSERT INTO pw_topicfield VALUES('114','联系人','field114','7','9','text','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('115','车辆图片','field115','7','10','upload','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('116','出租者身份','field116','8','1','radio','a:2:{i:0;s:8:\"1=个人\";i:1;s:14:\"2=出租公司\";}','1','1','1','0','1','0','');
INSERT INTO pw_topicfield VALUES('117','车辆类型','field117','8','2','checkbox','a:15:{i:0;s:11:\"1=微型车\";i:1;s:14:\"2=小型轿车\";i:2;s:17:\"3=紧凑型轿车\";i:3;s:14:\"4=中型轿车\";i:4;s:17:\"5=豪华型轿车\";i:5;s:11:\"6=面包车\";i:6;s:11:\"7=越野车\";i:7;s:8:\"8=跑车\";i:8;s:9:\"9=SUV/SRV\";i:9;s:6:\"10=MPV\";i:10;s:16:\"11=客车/中巴\";i:11;s:16:\"12=货车/皮卡\";i:12;s:15:\"13=厢式货车\";i:13;s:15:\"14=工程车辆\";i:14;s:9:\"15=其他\";}','1','1','1','0','1','0','');
INSERT INTO pw_topicfield VALUES('118','车辆型号','field118','8','3','text','b:0;','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('119','出租价格','field119','8','5','text','a:2:{s:6:\"minnum\";s:1:\"1\";s:6:\"maxnum\";s:8:\"10000000\";}','1','0','0','1','1','0','元/天');
INSERT INTO pw_topicfield VALUES('120','电话','field120','8','8','text','b:0;','1','0','0','0','0','10','');
INSERT INTO pw_topicfield VALUES('121','-','field121','8','8','text','b:0;','1','0','0','0','0','20','例如，0571-12345678');
INSERT INTO pw_topicfield VALUES('122','手机','field122','8','9','text','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('123','地址','field123','8','10','text','b:0;','1','0','0','0','0','50','');
INSERT INTO pw_topicfield VALUES('124','联系人','field124','8','11','text','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('125','车辆图片','field125','8','12','upload','b:0;','1','0','0','0','0','0','');
INSERT INTO pw_topicfield VALUES('126','服务内容','field126','8','4','checkbox','a:7:{i:0;s:14:\"1=班车接送\";i:1;s:26:\"2=个人单位长租短包\";i:2;s:14:\"3=会展服务\";i:3;s:14:\"4=婚庆服务\";i:4;s:14:\"5=机场接送\";i:5;s:14:\"6=商务旅游\";i:6;s:8:\"7=其他\";}','1','1','1','1','1','0','');
INSERT INTO pw_topicfield VALUES('127','押金','field127','8','6','text','b:0;','1','0','0','0','0','0','元');
INSERT INTO pw_topicfield VALUES('128','里程限制','field128','8','7','text','b:0;','1','0','0','0','0','0','公里');

INSERT INTO pw_topicmodel VALUES('1','出租','1','1','1');
INSERT INTO pw_topicmodel VALUES('2','出售','1','1','2');
INSERT INTO pw_topicmodel VALUES('3','求购','1','1','4');
INSERT INTO pw_topicmodel VALUES('4','美食','2','1','0');
INSERT INTO pw_topicmodel VALUES('5','婚庆婚介','3','1','0');
INSERT INTO pw_topicmodel VALUES('6','母婴','4','1','0');
INSERT INTO pw_topicmodel VALUES('7','出售','5','1','0');
INSERT INTO pw_topicmodel VALUES('8','出租','5','1','0');










INSERT INTO pw_tpl VALUES('1','subject','帖子列表1','由一张图片和若干帖子列表组成','<list action=\"image\" num=\"1\" title=\"图片模块\" />\r\n<loop>\r\n<a href=\"{url}\" target=\"_blank\"><img src=\"{image,100,100}\" class=\"fl\" /></a>\r\n</loop>\r\n<list action=\"subject\" num=\"10\" title=\"帖子排行模块\" />\r\n<ul>\r\n<loop>\r\n<li><a href=\"{url}\" title=\"{title}\" target=\"_blank\">{title,30}</a></li>\r\n</loop>\r\n</ul>','1.jpg');
INSERT INTO pw_tpl VALUES('2','subject','帖子列表2','由标题和摘要组成','<list action=\"subject\" num=\"3\" title=\"帖子及摘要\" />\r\n<loop>\r\n<h4><a href=\"{url}\" target=\"_blank\">{title,25}</a></h4>\r\n<p>{descrip,40}</p>\r\n<ul class=\"cc area-list-tree\">\r\n{tagrelate}\r\n</ul>\r\n</loop>','2.jpg');
INSERT INTO pw_tpl VALUES('3','subject','帖子列表3','由若干图片和若干帖子列表组成，图片在帖子列表的左侧','<list action=\"image\" num=\"2\" title=\"图片模块\" />\r\n<table width=\"100%\">\r\n<tr>\r\n<th>\r\n<loop>\r\n<a href=\"{url}\" target=\"_blank\"><img src=\"{image,100,100}\" class=\"fl\" /></a>\r\n</loop>\r\n</th>\r\n<td>\r\n<list action=\"subject\" num=\"10\" title=\"帖子排行模块\" />\r\n<ul>\r\n<loop>\r\n<li><a href=\"{url}\" title=\"{title}\" target=\"_blank\">{title,30}</a></li>\r\n</loop>\r\n</ul>\r\n</td>\r\n</tr></table>','3.jpg');
INSERT INTO pw_tpl VALUES('4','subject','帖子列表4','只由帖子列表组成','<list action=\"subject\" num=\"8\" title=\"帖子列表\" />\r\n<ul>\r\n<loop>\r\n<li><a href=\"{url}\" target=\"_blank\">{title,32}</a></li>\r\n</loop>\r\n</ul>','4.jpg');
INSERT INTO pw_tpl VALUES('5','image','图文混合','由图片和帖子列表，及摘早组成','<list action=\"image\" num=\"3\" title=\"图文模块\" />\r\n<loop>\r\n<a href=\"{url}\" target=\"_blank\"><img src=\"{image,100,100}\" class=\"fl\" /></a>\r\n<h4><a href=\"{url}\" target=\"_blank\">{title,32}</a></h4>\r\n<p>{descrip,50}</p>\r\n<div class=\"c\"></div>\r\n</loop>','5.jpg');
INSERT INTO pw_tpl VALUES('6','subject','帖子列表6','由若干图片和若干帖子列表组成，图片在帖子列表的左侧,且图片带有标题','<list action=\"image\" num=\"4\" title=\"图片模块\" />\r\n<table width=\"100%\">\r\n<tr>\r\n<th>\r\n<loop>\r\n<a href=\"{url}\" target=\"_blank\"><img src=\"{image,100,100}\" class=\"fl\" /><p>{title,8}</p></a>\r\n</loop>\r\n</th>\r\n<td>\r\n<list action=\"subject\" num=\"12\" title=\"帖子排行模块\" />\r\n<ul>\r\n<loop>\r\n<li><a href=\"{url}\" title=\"{title}\" target=\"_blank\">{title,30}</a></li>\r\n</loop>\r\n</ul>\r\n</td>\r\n</tr></table>','6.jpg');
INSERT INTO pw_tpl VALUES('7','image','最新图片','包括图片，和图片所在的帖子名称','<list action=\"image\" num=\"6\" title=\"图片模块\" />\r\n<loop>\r\n<a href=\"{url}\" target=\"_blank\"><img src=\"{image,100,100}\" class=\"fl\" /><p>{title,8}</p></a>\r\n</loop>','7.jpg');
INSERT INTO pw_tpl VALUES('8','forum','版块排行','版块排行列表','<list action=\"forum\" num=\"12\" title=\"版块模块\" />\r\n<ul>\r\n<loop>\r\n<li><span class=\"fr\">{value}</span><a href=\"{url}\" target=\"_blank\">{title}</a></li>\r\n</loop>\r\n</ul>','8.jpg');
INSERT INTO pw_tpl VALUES('9','user','用户排行','版块排行列表','<list action=\"user\" num=\"12\" title=\"用户模块\" />\r\n<ul>\r\n<loop>\r\n<li><span>{value}</span><img src=\"{image,40,40}\" align=\"absmiddle\" /> <a href=\"{url}\" target=\"_blank\">{title}</a></li>\r\n</loop>\r\n</ul>','9.jpg');
INSERT INTO pw_tpl VALUES('11','player','播放器1','播放器','<div id=\"pwSlidePlayer\" class=\"pwSlide cc\" onmouseover=\"pwSlidePlayer(\'pause\');\" onmouseout=\"pwSlidePlayer(\'goon\');\">\r\n<!--#\r\n	$tmpCount=0;\r\n#-->\r\n					<list action=\"image\" num=\"6\" title=\"播放器\" />\r\n					<loop>\r\n<!--#\r\n	$tmpStyle = $tmpCount ? \'style=\"display:none;\"\' : \'\';\r\n	$tmpCount++;\r\n#-->\r\n                        <div id=\"Switch_$key\" $tmpStyle>\r\n                            <a href=\"{url}\" target=\"_blank\"><img class=\"pwSlideFilter\" src=\"{image,288,198}\" />\r\n							<h1>{title,36}</h1></a>\r\n                        </div>\r\n                        </loop>\r\n					<ul id=\"SwitchNav\"></ul>\r\n					<div class=\"pwSlide-bg\"></div>\r\n				</div>\r\n				<div class=\"c\"></div>\r\n				<script type=\"text/javascript\" src=\"js/picplayer.js\"></script>\r\n				<script language=\"JavaScript\">pwSlidePlayer(\'play\',1,$tmpCount);</script>','10.jpg');
INSERT INTO pw_tpl VALUES('12','user','用户排行2','不包括头像','<list action=\"user\" num=\"12\" title=\"用户模块\" />\r\n<ul>\r\n<loop>\r\n<li><span class=\"fr\">{value}</span><a href=\"{url}\" target=\"_blank\">{title}</a></li>\r\n</loop>\r\n</ul>','11.jpg');
INSERT INTO pw_tpl VALUES('13','subject','帖子列表5','包括帖子所在的版块','<list action=\"subject\" num=\"12\" title=\"帖子列表\" />\r\n<ul>\r\n<loop>\r\n<li><span><a href=\"{forumurl}\" target=\"_blank\">[{forumname}]</a></span><a href=\"{url}\"  target=\"_blank\">{title,32}</a></li>\r\n</loop>\r\n</ul>','12.jpg');
INSERT INTO pw_tpl VALUES('14','subject','帖子列表7','包括帖子标题和作者','<list action=\"subject\" num=\"12\" title=\"帖子列表\" />\r\n<ul>\r\n<loop>\r\n<li><span class=\"fr\"><a href=\"u.php?action=show&username={author}\" target=\"_blank\">{author}</a></span><a href=\"{url}\"  target=\"_blank\">{title,32}</a></li>\r\n</loop>\r\n</ul>','13.jpg');
INSERT INTO pw_tpl VALUES('15','subject','帖子图片复合','由一个图片有标题模块和帖子模块组成','<list action=\"image\" num=\"2\" title=\"图片模块\" />\r\n<table width=\"100%\">\r\n<tr>\r\n<th>\r\n<loop>\r\n<a href=\"{url}\" target=\"_blank\"><img src=\"{image,100,100}\" class=\"fl\" /></a>\r\n<h4><a href=\"{url}\" target=\"_blank\">{title,32}</a></h4>\r\n<p>{descrip,50}</p>\r\n<div class=\"c\"></div>\r\n</loop>\r\n</th>\r\n<td>\r\n<list action=\"subject\" num=\"10\" title=\"帖子排行模块\" />\r\n<ul>\r\n<loop>\r\n<li><a href=\"u.php?action=show&username={author}\" class=\"fr\">{author}</a><a href=\"{url}\" title=\"{title}\" target=\"_blank\">{title,30}</a></li>\r\n</loop>\r\n</ul>\r\n</td>\r\n</tr></table>','14.jpg');
INSERT INTO pw_tpl VALUES('16','image','图片列表','只包括图片','<list action=\"image\" num=\"6\" title=\"图片模块\" />\r\n<loop>\r\n<a href=\"{url}\" target=\"_blank\"><img src=\"{image,100,100}\" class=\"fl\" /></a>\r\n</loop>','15.jpg');
INSERT INTO pw_tpl VALUES('17','subject','帖子列表及说明','包括版块名称帖子及摘要说明','<list action=\"subject\" num=\"10\" title=\"帖子列表\" />\r\n<ul>\r\n<loop>\r\n<li><a href=\"{forumurl}\"><span>[{forumname}]</span></a><a href=\"{url}\" target=\"_blank\">{title,28}</a><span>&nbsp;{descrip,22}</span></li>\r\n</loop>\r\n</ul>','16.jpg');
INSERT INTO pw_tpl VALUES('18','subject','帖子及图片复合','由图片模块和帖子模块组成','<list action=\"image\" num=\"3\" title=\"图片模块\" />\r\n<loop>\r\n<a href=\"{url}\" target=\"_blank\"><img src=\"{image,100,100}\" class=\"fl\" /></a>\r\n</loop>\r\n<div class=\"c\"></div>\r\n<list action=\"subject\" num=\"7\" title=\"帖子模块\" />\r\n<ul>\r\n<loop>\r\n<li><a href=\"{url}\" target=\"_blank\">{title,36}</a></li>\r\n</loop>\r\n</ul>','17.jpg');
INSERT INTO pw_tpl VALUES('19','tag','标签模块','标签列表','<list action=\"tag\" num=\"10\" title=\"标签模块\" />\r\n<loop>\r\n<a href=\"{url}\" target=\"_blank\">{title}</a>\r\n</loop>','18.jpg');
INSERT INTO pw_tpl VALUES('20','subject','帖子及图片复合2','由图片模块和帖子模块组成','<list action=\"image\" num=\"1\" title=\"图片模块\" />\r\n<loop>\r\n<a href=\"{url}\" target=\"_blank\"><img src=\"{image,100,100}\" class=\"fl\" /></a>\r\n<h4><a href=\"{url}\" target=\"_blank\">{title,40}</a></h4>\r\n<p>{descrip,60}</p>\r\n</loop>\r\n<div class=\"c\"></div>\r\n<list action=\"subject\" num=\"7\" title=\"帖子模块\" />\r\n<ul>\r\n<loop>\r\n<li><a href=\"{url}\" target=\"_blank\">{title,40}</a></li>\r\n</loop>\r\n</ul>','19.jpg');

INSERT INTO pw_tpltype VALUES('1','subject','贴子类');
INSERT INTO pw_tpltype VALUES('2','image','图片类');
INSERT INTO pw_tpltype VALUES('3','forum','版块类');
INSERT INTO pw_tpltype VALUES('4','user','用户类');
INSERT INTO pw_tpltype VALUES('5','tag','标签类');
INSERT INTO pw_tpltype VALUES('6','player','播放器');








INSERT INTO pw_usergroups VALUES('1','default','default','8','0','1');
INSERT INTO pw_usergroups VALUES('2','default','游客','8','0','0');
INSERT INTO pw_usergroups VALUES('3','system','管理员','3','0','0');
INSERT INTO pw_usergroups VALUES('4','system','总版主','4','0','0');
INSERT INTO pw_usergroups VALUES('5','system','论坛版主','5','0','0');
INSERT INTO pw_usergroups VALUES('6','default','禁止发言','8','0','0');
INSERT INTO pw_usergroups VALUES('7','default','未验证会员','8','0','0');
INSERT INTO pw_usergroups VALUES('8','member','散仙','8','0','0');
INSERT INTO pw_usergroups VALUES('9','member','赤天枢','9','1','0');
INSERT INTO pw_usergroups VALUES('10','member','橙天璇','10','100','0');
INSERT INTO pw_usergroups VALUES('11','member','金天玑','11','300','0');
INSERT INTO pw_usergroups VALUES('12','member','碧天权','12','1000','0');
INSERT INTO pw_usergroups VALUES('13','member','青玉衡','13','3000','0');
INSERT INTO pw_usergroups VALUES('14','member','靛开阳','14','10000','0');
INSERT INTO pw_usergroups VALUES('15','member','紫摇光','14','30000','0');
INSERT INTO pw_usergroups VALUES('16','special','荣誉会员','5','0','0');
INSERT INTO pw_usergroups VALUES('17','system','门户编辑','5','0','0');





