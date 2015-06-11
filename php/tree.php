<?php
class Node
{
//	private $data;
//	private $lchild;
//	private $rchild;
	public $data;
	public $lchild;
	public $rchild;
	
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
		foreach($this->init as $var_name=>$data){
			$$var_name = new Node();
			$$var_name->data = $data['data'];
			if($data['lchild']===null){
				$$var_name->lchild = $data['lchild'];
			}
			else{
				$$var_name->lchild = &$$data['lchild'];
			}
			if($data['rchild']===null){
				$$var_name->rchild = $data['rchild'];
			}
			else{
				$$var_name->rchild = &$$data['rchild'];
			}
			print_r($$var_name);
		}
	}
}

$tree = new Tree();
