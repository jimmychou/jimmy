<?php
class JsonServerExecption extends Exception
{
};

class JsonServer{

	protected  $_req     = array() ;/*struct req*/
	protected  $_raw_req ; 
	protected  $_do_auth = false;

	protected  $_use_deflate = false;
    static public     $test_data_dir = false; 

	static $exist_methods;

	static $log_NOK_methods=array(
//        'User'=>'login',
        );

	static $nolog_methods=array(
//        'User'=>'login',
			);

    //these method must run one by one
	static $locked_methods=array(
//        'User'=>'login',
			);

	/**
	 * 
	 * @param $method
	 * @param $obj
	 * @param $shortm
	 * @return unknown_type
	 */
	static function register($method,&$obj,$shortm){
		self::$exist_methods[$method] = array($obj,$shortm);
	}

	/**
	 * 
	 */
	protected function auth($key)
	{
		if($this->_do_auth==false || $this->_debug )
			return true;
		static $secret='hschool';
		return md5($key.$secret)==$auth;
	}

	/**
	 * @param $m
	 * @param $params
	 * @return unknown_type
	 */
	public  function doRequest($m,&$params)
	{
	/*
		$this->_debug = true;
		$this->_req['m']=$m;
		$this->_req['p']=$params;
		$ret = $this->_handle($this->_req);
        //统计日志
        self::process_stat($this->_req,$ret);
        return $ret;
		*/
	}

	/*
	 *http post
	 * 
	 * method
	 * auth, 
	 * params,�
	 */
	public function getRequest()
	{
		if($this->_req)
			return $this->_req;
        $this->_raw_req = json_encode( $_REQUEST );
		$this->_req = $_REQUEST;;
		if( !$this->_req || !isset( $this->_req['m'] ) || !isset( $this->_req['a'] ) ){
//			throw new JsonServerExecption( 'params error no method:'.$jsonstr);
            throw new JsonServerExecption( 'params error no method' );
		}		
		return $this->_req;
	}

	/*
	 * 
	 *
	 */
	public function handle($req=null)
	{
		try{
			if(!$req)
				$req= & $this->getRequest();
			if(!$req){
				$r['s']='norequest';
				return  json_encode($r);
			}
			/*
			if(!$this->auth($req['k'])){
				$r['s']='auth';
				return  json_encode($r);
			}
			*/
			$r=$this->_handle($req);
		}
		catch (Exception $e){
			$r['s']='exc';
			$r['msg']=$e->getMessage();
			$r['exce']=$e->getTrace();
			return  json_encode($r);
		}
        //统计日志
//        self::process_stat($req,$r);
        $r['_t']=$_SERVER['REQUEST_TIME'];
		if($this->_use_deflate) 
			return gzdeflate(json_encode($r));
		return json_encode($r);
	}


	/*
	 * controller,we don't make more check
	 * the controller must has the class name save as file name
	 *
	 */
	protected function _handle(&$req)
	{
		//just add method map here
		$tm = $_SERVER['REQUEST_TIME'];
		/*
		$log_nok = false;
		if(array_key_exists($method,self::$log_NOK_methods)){
			$log_nok = true;
		}
        */
//		$req['p']['_cid'] = $req['cid'];
//		$u = $req['p']['u'];
        /*
            if( !$log_nok){
                if(check_dup($u,$req['cid'],$ret)){
                    deal_record(array('s'=>'dup','m'=>$method,'tm'=>$tm,'u'=>$u,'p'=>$this->_raw_req));
                    return $ret;
                }	
            }
        */
		/*
        if($u){
            if(array_key_exists($method,self::$locked_methods))
                $locked = true;
            if($locked){//for lock
                $tu = new TTUser($u);
                if(!$tu->lock()){
                    $ret['s']='lock';
                    $tu->unlock();
                    return $ret;	
                }
            }
        }
		*/

        //dispatch
		/*
        if(isset(self::$exist_methods[$method])){
            $caller= &self::$exist_methods[$method];
            $c=&$caller[0];
            $m=$caller[1];

        }
	   else{
		*/
            $cn = $req['m'];
			$m = $req['a'];
            $file = CONTROLLER_ROOT."$cn.php";
            if(!file_exists($file )){
                $ret['s']='KO';
                $ret['msg']="method $method file not exist:(".CONTROLLER_ROOT."$cn.php)";
                return $ret;
            }
            require_once $file;
            $c=new $cn;
            if(!method_exists($c,$m)){
                $ret['s']='KO';
                $ret['s']="$cn don't has callable method $m";
				/*
                if($locked){
                    $tu->unlock();
                }
				*/
                return $ret;
            }
		session_start();
        if( !isset( $_SESSION['user']['user_id'] ) ){
//		    if( $cn = 'User' && $m = 'login' ){     //太悲剧了！！
			if( $cn == 'User' && $m == 'login' ){
			    $u = $_SESSION['user']['user_id'] = 111;   // todo: 需要查询数据库
			}
			else{
                return array( 'status'=>'fail','statusinfo'=>-11 );			
			}
		}
		else{
		    $u = $_SESSION['user']['user_id'];
		}
		$p = $req;
		unset( $p['m'] );
		unset( $p['a'] );
			
 //       }

        //excute
        try{
//            $ret=$c->$m($req['p']);
            $ret = $c->$m( $p );
            if(!$u){
                $u = $ret['u'];
            }
            if(!$u){//todo: normal impossible
                $u = 'nouser';
            }
        }
		catch(Exception $e){
            $r['s']='exc';
            $r['msg']=$e->getMessage();
            $r['exce']=$e->getTrace();
            if($locked){
                $tu->unlock();
            }
            return $r;
        }
        if(!$ret){
            $ret['s']= "null";
            $ret['msg']= "$cn::$m return null";
        }
/*
        if($locked){
            $tu->unlock();
        }
*/
        return $ret;
    }

    /**
        记录统计代码,添加统计的代码
    */
    public static function process_stat(&$req,&$res)
    {
/*
        $m = $req['m'];
        if(self::$test_data_dir){
           //file_put_contents(self::$test_data_dir."$m.req",serialize($req)); 
           //file_put_contents(self::$test_data_dir."$m.res",serialize($res)); 
        }
        $p = &$req['p'];
        $u = $p['u'];
        if(!$u){
            $u = $res['u'];
        }
        if(!$u){
            //record error 
            return ;
	}

	    $s['u']=$u;
        $s['m']=$m;
        $s['s']=$res['s'];
        $s['tm']=$_SERVER['REQUEST_TIME'];
        try{
            switch ($m){
            case 'User.login':
                break;
            }
        }
	    catch(Exception $e){
		}
		*/
    }
}
