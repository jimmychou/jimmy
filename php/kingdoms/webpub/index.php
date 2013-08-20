<?php
    require_once dirname(__FILE__).'/base.php';
/*
	print_r( $_POST );
	print_r( $_GET );
*/	
    $name = $_GET['name'];
    $data = Generals::getGeneralByName( $name );
	if( $data ){
        foreach( $data as $k=>$v ){
	    ?>
	        <div>
	    <?php
	        echo "$k    ";
		    echo "     $v \n";
	    ?>
	        </div>
	    <?php
	    }
	}
	
	$num = $_GET['num'];
	$data = Generals::getGeneralByNumber( $num );
	if( $data ){
	    foreach( $data as $k=>$v ){
	    ?>
	        <div>
	    <?php
	        echo "$k    ";
		    echo "     $v \n";
	    ?>
	        </div>
	    <?php
	    }
	}
	
	$all = $_GET['all'];
	$start = $_GET['start'];
	for( $i = $start;$i < $start + $all;$i++ ){
	    $data = Generals::getGeneralByNumber( $i );
		if( $all ){
	        foreach( $data as $k=>$v ){
	        ?>
	            <div>
	        <?php
	            echo "$k    ";
		        echo "     $v \n";
	        ?>
	            </div>
	        <?php
	        }
		}
	}
	
$post_names = $_POST['name'];
$names = explode( "，",$post_names );
/*
if( !$names ){
$names = explode( ",",$post_names );
}
*/
/*
echo "post_names = $post_names\n and names as follow\n";
print_r( $names );
*/
foreach( $names as $name ){
//    $name = $_POST['name'];
    $data = Generals::getGeneralByName( $name );
	if( $data ){
        foreach( $data as $k=>$v ){
	    ?>
	        <div>
	    <?php
	        echo "$k    ";
		    echo "     $v \n";
	    ?>
	        </div>
	    <?php
	    }
	}
}	
	$num = $_POST['num'];
	$data = Generals::getGeneralByNumber( $num );
	if( $data ){
	    foreach( $data as $k=>$v ){
	    ?>
	        <div>
	    <?php
	        echo "$k    ";
		    echo "     $v \n";
	    ?>
	        </div>
	    <?php
	    }
	}
	
	$all = $_POST['all'];
	$start = $_POST['start'];
	for( $i = $start;$i < $start + $all;$i++ ){
	    $data = Generals::getGeneralByNumber( $i );
		if( $all ){
	        foreach( $data as $k=>$v ){
	        ?>
	            <div>
	        <?php
	            echo "$k    ";
		        echo "     $v \n";
	        ?>
	            </div>
	        <?php
	        }
		}
	}	
	