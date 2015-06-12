<?php
class Node
{
	public $data=null;
	public $lchild=null;
	public $rchild=null;
	
	public function __set($name,$value)
	{
		$this->$name = $value;
	}

	public function set_lchild()
	{
	}
}

class Tree
{
	public $root = null;
	private $init = array(
				'node7'=>array('data'=>7,'lchild'=>null,'rchild'=>null)
				,'node6'=>array('data'=>6,'lchild'=>null,'rchild'=>null)
				,'node5'=>array('data'=>5,'lchild'=>null,'rchild'=>null)
				,'node4'=>array('data'=>4,'lchild'=>null,'rchild'=>null)
				,'node3'=>array('data'=>3,'lchild'=>'node6','rchild'=>'node7')
				,'node2'=>array('data'=>2,'lchild'=>'node4','rchild'=>'node5')
				,'node1'=>array('data'=>1,'lchild'=>'node2','rchild'=>'node3')
			);
	public function __construct()
	{
		//	有一处硬编码是	root	结点始终为	node1
		foreach($this->init as $var_name=>$data){
			$$var_name = new Node();
			$this->$var_name = new stdClass();
			foreach($data as $key=>$value){
				$this->$var_name->$key = $value;
			}
			/*
			$$var_name->data = $data['data'];
			if($data['lchild']===null){
				$this->$var_name = $$var_name->lchild = $data['lchild'];
			}
			else{
//				$$var_name->lchild = &$$data['lchild'];
				$this->$var_name = $$var_name->lchild = &$$data['lchild'];
			}
			if($data['rchild']===null){
				$this->$var_name = $$var_name->rchild = $data['rchild'];
			}
			else{
//				$$var_name->rchild = &$$data['rchild'];
				$this->$var_name = $$var_name->rchild = &$$data['rchild'];
			}
//			print_r($$var_name);
			*/
		}
		$this->root = $this->node1;	//	硬编码
	}

	public function visit($value)
	{
		if($value){
			file_put_contents('/tmp/tree.txt',$value."\n",FILE_APPEND);
			return 1;
		}
		return 0;
	}

	public function InOrderTravel(&$root)
	{
		$stack = array();
//		array_push($stack,$root);	//	不需要，会重复
		file_put_contents('/tmp/tree.txt',__FUNCTION__." begin \n",FILE_APPEND);
//		$p = array_pop($stack);
		$p = $root;
		while($p||!empty($stack)){
			echo "the p out begin is \n";
			print_r($p);
			echo "the stack out begin is \n";
			print_r($stack);
			echo "\n";
			if($p!==null){
				array_push($stack,$p);
				$var_name = $p->lchild;
				if($var_name===null){
					$p = $var_name;
				}
				else{
					$p = $this->$var_name;
				}
				echo "the p if end is \n";
				print_r($p);
				echo "the stack if end is \n";
				print_r($stack);
				echo "\n";
			}
			else{
				//	没有else分支会陷入死循环
				$p = array_pop($stack);
				if(!$this->visit($p->data)){
					return 0;
				}
				$var_name = $p->rchild;
				if($var_name===null){
					$p = $var_name;
				}
				else{
					$p = $this->$var_name;
				}
				echo "the p else end is \n";
				print_r($p);
				echo "the stack else end is \n";
				print_r($stack);
				echo "\n";
			}
		}
		file_put_contents('/tmp/tree.txt',__FUNCTION__." end \n",FILE_APPEND);
	}
	
	public function PreOrderTravel(&$root)
	{
		$stack = array();
//		array_push($stack,$root);	//	不需要，会重复
		file_put_contents('/tmp/tree.txt',__FUNCTION__." begin \n",FILE_APPEND);
//		$p = array_pop($stack);
		$p = $root;
		while($p||!empty($stack)){
			if($p!==null){
				array_push($stack,$p);
				$var_name = $p->lchild;
				if($var_name===null){
					$p = $var_name;
				}
				else{
					$p = $this->$var_name;
				}
			}
			else{
				//	没有else分支会陷入死循环
				$p = array_pop($stack);
				if(!$this->visit($p->data)){
					return 0;
				}
				$var_name = $p->rchild;
				if($var_name===null){
					$p = $var_name;
				}
				else{
					$p = $this->$var_name;
				}
			}
		}
		file_put_contents('/tmp/tree.txt',__FUNCTION__." end \n",FILE_APPEND);
	}
	
	public function PostOrderTravel(&$root)
	{
		$stack = array();
//		array_push($stack,$root);	//	不需要，会重复
		file_put_contents('/tmp/tree.txt',__FUNCTION__." begin \n",FILE_APPEND);
//		$p = array_pop($stack);
		$p = $pl = $pr = $root;
		while($p||!empty($stack)){
print_r($stack);
			if($p!==null){
				array_push($stack,$p);
				$var_name = $p->rchild;
				if($var_name===null){
					$pr = $var_name;
				}
				else{
					$pr = $this->$var_name;
					array_push($stack,$pr);
				}
				$var_name = $p->lchild;
				if($var_name===null){
					$pl = $var_name;
					$p = $pr;
				}
				else{
					$pl = $this->$var_name;
					$p = $pl;
//					array_push($stack,$pl);	//	这里放开会重复入栈
				}
			}
			else{
				//	没有else分支会陷入死循环
//				if($pr!==null){
//					$p = $pr;
//					$pl = $pr = $p;
//					continue;
//				}
				$p = array_pop($stack);
				if(!$this->visit($p->data)){
					return 0;
				}
				$last = $p;
				/*
				$var_name = $p->rchild;
				if($var_name===null){
					$pr = $var_name;
				}
				else{
					$pr = $this->$var_name;
				}
				$var_name = $p->lchild;
				if($var_name===null){
					$pl = $var_name;
				}
				else{
					$pl = $this->$var_name;
				}
				*/
			}
		}
		file_put_contents('/tmp/tree.txt',__FUNCTION__." end \n",FILE_APPEND);
	}
}
$tree = new Tree();
//$tree->InOrderTravel($tree->root);
//$tree->PreOrderTravel($tree->root);
$tree->PostOrderTravel($tree->root);
