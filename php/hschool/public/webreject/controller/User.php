<?phpclass User{    public function login( $params )	{	    $ret['s'] = 'OK';		$ret['request'] = $params;		$ret['m'] = 'login';		return $ret;	}		public function find( $params )	{	    $ret['s'] = 'OK';		$ret['request'] = $params;		$ret['m'] = 'find';		return $ret;	}}