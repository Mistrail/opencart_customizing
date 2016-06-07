<?
require_once("hasher.php");
/*
switch ($_SERVER['HTTP_ORIGIN']) {
    case 'http://banzai-sushi.ru':
    header('Access-Control-Allow-Origin: '.$_SERVER['HTTP_ORIGIN']);
    header('Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS');
    header('Access-Control-Max-Age: 1000');
    header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');
    break;
    case 'https://banzai-sushi.ru':
    header('Access-Control-Allow-Origin: '.$_SERVER['HTTP_ORIGIN']);
    header('Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS');
    header('Access-Control-Max-Age: 1000');
    header('Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With');
    break; 
    default:
    echo json_encode(array('status'=>'fail', 'message'=>'Oo'));
    die();
}
/* banzai_promo
*  rGquQuty
*
 * action - required
 * phone - on generate and disable events
 * code - on check and disable events
 * status - on disable events
*/

$user='banzai_promo';
$pass='rGquQuty';


try {
    $pdo = new PDO('mysql:host=localhost;dbname=banzai_promo', $user, $pass);
} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}

switch ($_REQUEST['action']) {
    case 'getCode':
        //generate promo code
        $h36 = new Hash36();

        if (isset($_REQUEST['phone']) && !empty($_REQUEST['phone']) && is_numeric($_REQUEST['phone']))
        {
            $phone=(int)$_REQUEST['phone'];
        }
        else
        {
            echo json_encode(array('status'=>'fail','message'=>'wrong number'));
            die();
        }

        $pCode = $h36->encode($phone);
        //$orPhone = $h36->decode($pCode);

        $sql = "INSERT INTO users(
            phone,
            code,
            status,
            timeCreated) VALUES (
            :Phone,
            :Code,
            :Status,
            FROM_UNIXTIME(:timeCr) )";

        $phone=intval($phone);
        $stmt = $pdo->prepare($sql);
        $stmt->bindParam(':Phone', $phone, PDO::PARAM_INT);
        $stmt->bindValue(':Status', 0, PDO::PARAM_INT);
        $stmt->bindParam(':Code', $pCode, PDO::PARAM_STR);
        $stmt->bindParam(':timeCr', time());
// use PARAM_STR although a number

        $stmt->execute();
        echo json_encode(array('status'=>'success','message'=>$pCode));
        die();
        break;
    case 'checkCode':
        if (isset($_REQUEST['code']) && !empty($_REQUEST['code']))
        {
            $code=$_REQUEST['code'];
        }
        else
        {
            echo json_encode(array('status'=>'fail','message'=>'wrong code'));
            die();
        }

        $sql = 'SELECT * FROM users WHERE code = :Code and status = 0';

        $query=$pdo->prepare($sql);
        // bind parameters - avoids SQL injection
        $query->bindValue(':Code', $code);

        $query->execute();

        $rows = $query->fetchAll(PDO::FETCH_ASSOC);
        foreach ($rows as $row)
        {
            $res[]=array('phone' => $row['phone'],'time' => $row['timeCreated'], 'status' => $row['status']);
        }
        if (!isset($res)) $res=array('status' => 'fail', 'message' => 'There is no users with this code.');
        echo json_encode($res);
        die();
    case 'disableCode':
        if (!isset($_REQUEST['phone']) || empty($_REQUEST['phone']) || !is_numeric($_REQUEST['phone']))
        {
            echo json_encode(array('status'=>'fail','message'=>'wrong phone'));
            die();
        }
        if (!isset($_REQUEST['code']) || empty($_REQUEST['code']))
        {
            echo json_encode(array('status'=>'fail','message'=>'wrong code'));
            die();
        }
        $sql1 = "UPDATE `users` SET `status` = :setStatus
            WHERE (`phone` = :phone AND `code` = :code AND `status` = :curStatus)";
        $stmt1 = $pdo->prepare($sql1);
        $stmt1->bindParam(':phone', intval($_REQUEST['phone']), PDO::PARAM_INT);
        $stmt1->bindParam(':code', $_REQUEST['code'], PDO::PARAM_STR);
        $stmt1->bindValue(':curStatus', 0);
        $stmt1->bindValue(':setStatus', 1);
        try {
            $stmt1->execute();
            $res=$stmt1->fetchAll();
        } catch(Exception $e) {
            echo json_encode(array('status' => 'fail', 'message' => $e));
            die();
        }
        echo json_encode(array('status' => 'success', 'message' => 'code disabled'));
        die();
    default:
        echo json_encode(array('status'=>'fail','message'=>'unknown action'));
        die();
}



?>
