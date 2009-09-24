<?php
! function_exists ( 'adminmsg' ) && exit ( 'Forbidden' );
include_once (R_P . "require/postindex.php");
$repliesArray = array ('1000', '5000', '10000', '20000');
$postIndexDB = new PostIndexDB ( );
$postIndexDB->setPerpage ( 5 );
InitGP(array('sub'),'G');
if (empty($sub)) {
	InitGP ( array ('replies', 'page'), 'GP' ); 
	if (empty($action) || $action == "search") {
		$threads = $postIndexDB->getALLIndexedThreads($page);
	}elseif ($action == "reset") {
		InitGP ( array ('tid' ), 'G' );
		if ($tid) {
			$postIndexDB->resetPostIndex ( $tid );
		} else {
			$basename = "$basename&action=search&page=$page";
			adminmsg ( "operate_error" );
		}
		$basename = "$basename&action=search&page=$page";
		adminmsg ( "operate_success" );
	}elseif ($action == "delete") {
		InitGP ( array ('tids' ), 'GP' );
		foreach ( $tids as $key => $value ) {
			$postIndexDB->deletePostIndex ( $value );
		}
		adminmsg ( "operate_success" );
	} 
}else{
	InitGP ( array ('replies', 'page', 'tid' ), 'GP' );
	if ($action == "search") {
		if ($tid) {
			$threads = $postIndexDB->getThreadsById($tid);
		}else{
			$threads = $postIndexDB->getThreadsByReplies ( $replies, $page );
		}
	} elseif ($action == "update") {
		InitGP ( array ('threads' ), 'GP' );
		$opendThreads = explode ( ",", $opendThreads );
		foreach ( $threads as $key => $value ) {
			$postIndexDB->addPostIndex ( $value );
		}
		if ($tid) {
			$basename = "$basename&sub=y&action=search";
		}else{
			$basename = "$basename&sub=y&action=search&replies=$replies&page=$page";
		}
		adminmsg ( "operate_success" );
	} 
}
include PrintEot ( 'postindex' );
exit ();
?>